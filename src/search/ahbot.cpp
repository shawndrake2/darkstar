#include "../common/mmo.h"
#include "../common/showmsg.h"
#include "../common/sql.h"

#include <algorithm>

#include "ahbot.h"
#include "search.h"

AHBot::AHBot()
{
    SqlHandle = Sql_Malloc();

    if (Sql_Connect(SqlHandle, search_config.mysql_login.c_str(),
        search_config.mysql_password.c_str(),
        search_config.mysql_host.c_str(),
        search_config.mysql_port,
        search_config.mysql_database.c_str()) == SQL_ERROR)
    {
        ShowError("cant connect\n");
    }
}

AHBot::~AHBot()
{
    Sql_Free(SqlHandle);
}


/************************************************************************
*                                                                       *
*  Stock Random AH Items                                                *
*                                                                       *
************************************************************************/

void AHBot::StockAHBotItems()
{
    ShowMessage(CL_GREEN"AH BOT stocking items\n");

    // Initialize items sold just in case
    this->itemsPutOnAuction = 0;

    std::vector<ahSaleItem*> randomSellList = this->GetRandomItemsToAuction();

    for (unsigned int i = 0; i < randomSellList.size(); i++) {
        this->AddToAuction(randomSellList.at(i));
    }
    ShowMessage(CL_GREEN"Done stocking items: %u items put on auction by AHBot\n", this->itemsPutOnAuction);
}

/************************************************************************
*                                                                       *
*  Buying Random AH Items                                               *
*                                                                       *
************************************************************************/

void AHBot::BuyRandomAHItems()
{
    ShowMessage(CL_GREEN"AH BOT buying back random items\n");

    // Initialize items bought just in case
    this->itemsBought = 0;

    std::vector<ahSaleItem*> randomBuyList = this->GetRandomItemsToBuy();

    for (unsigned int i = 0; i < randomBuyList.size(); i++) {
        if (this->itemsBought < search_config.ah_bot_buy_limit) {
            this->BuyBackFromAuction(randomBuyList.at(i));
        }
        else
        {
            break;
        }
    }
    ShowMessage(CL_GREEN"Done buying items: %u items bought from AH by AHBot\n", this->itemsBought);
}

void AHBot::AddToAuction(ahSaleItem* ahSaleItem)
{
    int itemId = ahSaleItem->ItemID;

    // Set item limit for AHBot
    int itemLimit = search_config.normalItemAhLimit;
    if (this->IsUseable(itemId)) {
        itemLimit = search_config.useableItemAhLimit;
    } else if (this->IsWeapon(itemId)) {
        itemLimit = search_config.weaponItemAhLimit;
    } else if (this->IsArmor(itemId)) {
        itemLimit = search_config.armorItemAhLimit;
    } else if (this->IsFurnishing(itemId)) {
        itemLimit = search_config.furnishingItemAhLimit;
    }

    int numOnAuction = this->GetNumberOfCurrentAuctionItemsById(itemId);

    if (numOnAuction < itemLimit) {
        const char* fmtQuery = "INSERT INTO auction_house(itemid, stack, seller, seller_name, date, price) VALUES(%u,%u,%u,'%s',%u,%u)";

        if (Sql_Query(SqlHandle,
            fmtQuery,
            ahSaleItem->ItemID,
            ahSaleItem->Stack,
            ahSaleItem->Seller,
            ahSaleItem->SellerName,
            ahSaleItem->AuctionDateTS,
            ahSaleItem->Price) == SQL_ERROR)
        {
            ShowError(CL_RED"SmallPacket0x04E::AuctionHouse: Cannot insert item %s to database\n" CL_RESET, ahSaleItem->Name);
            return;
        }
        else
        {
            this->itemsPutOnAuction++;
        }
    }
}

void AHBot::BuyBackFromAuction(ahSaleItem* ahSaleItem)
{
    uint32 treasuryBalance = this->GetTreasuryBalance();
    if ((int) ahSaleItem->Seller == 0 || treasuryBalance > 0) {
        const char* fmtQuery = "UPDATE auction_house SET buyer_name='%s', sale=%u, sell_date=%u WHERE id = %u";

        if (Sql_Query(SqlHandle,
            fmtQuery,
            search_config.ah_bot_name,
            ahSaleItem->Price,
            time(NULL),
            ahSaleItem->AuctionId) == SQL_ERROR)
        {
            ShowError(CL_RED"SmallPacket0x04E::AuctionHouse: Cannot update item %s in database\n" CL_RESET, ahSaleItem->AuctionId);
            return;
        }
        this->itemsBought++;
        if (ahSaleItem->Seller != 0) {
            this->treasuryBalance = treasuryBalance - ahSaleItem->Price;
            ShowMessage(CL_GREEN"DEBUG: User %u should be sent %u gil\n", ahSaleItem->Seller, ahSaleItem->Price);
            // @TODO Send gil to seller

            // Update treasury balance after transactions completed
            this->UpdateTreasuryBalance(this->treasuryBalance);
        }
    }
    else
    {
        ShowError(CL_RED"SmallPacket0x04E::AuctionHouse: Treasury Balance has been exhausted\n" CL_RESET);
        return;
    }
}

std::vector<ahSaleItem*> AHBot::GetCurrentAuctionItems()
{
    std::vector<ahSaleItem*> ItemList;

    const char* currentAuctionsQuery = "SELECT * FROM auction_house WHERE sell_date = 0;";

    int32 ret = Sql_Query(SqlHandle, currentAuctionsQuery);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ahSaleItem* AHItem = new ahSaleItem;
            AHItem->AuctionId = Sql_GetIntData(SqlHandle, 0);
            AHItem->ItemID = Sql_GetIntData(SqlHandle, 1);
            AHItem->Stack = Sql_GetIntData(SqlHandle, 2);
            AHItem->Seller = Sql_GetIntData(SqlHandle, 3);
            AHItem->SellerName = Sql_GetStringData(SqlHandle, 4);
            AHItem->AuctionDateTS = Sql_GetIntData(SqlHandle, 5);
            AHItem->Price = Sql_GetIntData(SqlHandle, 6);

            ItemList.push_back(AHItem);
        }
    }

    return ItemList;
}

int AHBot::GetNumberOfCurrentAuctionItemsById(int itemId)
{
    int count = 0;
    const char* currentAuctionsQuery = "SELECT count(itemid) FROM auction_house WHERE sell_date = 0 AND itemid = %u;";

    int32 ret = Sql_Query(SqlHandle, currentAuctionsQuery, itemId);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            count = Sql_GetIntData(SqlHandle, 0);
        }
    }

    return count;
}

int AHBot::GetHighLow(int price, time_t auctionTime)
{
    int highlow = auctionTime % 3;
    int markup = price * (rand() % 9) / 100;
    if (highlow == 2) {
        // Mark UP
        price = price + markup;
    }
    else if (highlow == 0) {
        // Mark DOWN
        price = price - markup;
    }
    // Don't change price if highlow is 1
    return price;
}

std::vector<int> AHBot::GetItemCategoryIds(std::string tableName, std::string field)
{
    std::vector<int> ItemList;

    const char* itemIdsQuery = "SELECT %s FROM %s;";

    int32 ret = Sql_Query(SqlHandle, itemIdsQuery, field, tableName);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            int AHItem = Sql_GetIntData(SqlHandle, 0);

            ItemList.push_back(AHItem);
        }
    }

    return ItemList;
}

std::vector<int> AHBot::GetItemIds()
{
    std::vector<int> ItemList;

    const char* itemIdsQuery = "SELECT * FROM item_basic WHERE aH <> 0;";

    int32 ret = Sql_Query(SqlHandle, itemIdsQuery);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            int AHItem = Sql_GetIntData(SqlHandle, 0);

            ItemList.push_back(AHItem);
        }
    }

    return ItemList;
}

std::vector<ahSaleItem*> AHBot::GetRandomItemsToAuction()
{
    std::vector<int> randomItemsList;
    std::string randomIdsString = "";
    std::vector<int> itemIds = this->GetItemIds();

    int count = 0;
    int min = itemIds.at(0);
    int max = itemIds.at(itemIds.size() - 1);
    srand(clock());

    while (count < (int) search_config.ah_bot_sell_limit) {
        int randomId = rand() % max + min;
        std::vector<int>::iterator randomItemFound;

        randomItemFound = std::find(randomItemsList.begin(), randomItemsList.end(), randomId);
        if (randomItemFound == randomItemsList.end()) {
            randomItemsList.push_back(randomId);
            if (randomIdsString != "") {
                randomIdsString += ",";
            }
            randomIdsString += std::to_string(randomId);
        }
        count++;
    }

    std::vector<ahSaleItem*> ItemList;

    Sql_FreeResult(SqlHandle);
    const char* itemIdsQuery = "SELECT itemid, name, stackSize, aH, BaseSell FROM item_basic WHERE aH <> 0 AND itemid IN (%s);";

    int32 ret = Sql_Query(SqlHandle, itemIdsQuery, randomIdsString);

    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            ahSaleItem* AHSaleItem = new ahSaleItem;
            AHSaleItem->ItemID = Sql_GetIntData(SqlHandle, 0);
            AHSaleItem->Name = Sql_GetStringData(SqlHandle, 1);
            AHSaleItem->Category = Sql_GetIntData(SqlHandle, 3);
            int StackSize = Sql_GetIntData(SqlHandle, 2);
            AHSaleItem->AuctionDateTS = time(NULL);
            AHSaleItem->Stack = this->SellStack(StackSize, AHSaleItem->AuctionDateTS);
            AHSaleItem->Seller = search_config.ah_bot_id;
            AHSaleItem->SellerName = search_config.ah_bot_name;
            int BaseSellPrice = Sql_GetIntData(SqlHandle, 4);
            AHSaleItem->Price = BaseSellPrice;

            ItemList.push_back(AHSaleItem);
        }
    }

    // get price point for each item
    for (int i = 0; i < (int)ItemList.size(); i++)
    {
        ahSaleItem* item = ItemList.at(i);
        item->Price = this->GetSellPrice(item);
    }

    return ItemList;
}

std::vector<ahSaleItem*> AHBot::GetRandomItemsToBuy()
{
    std::vector<ahSaleItem*> randomItemsList;
    std::vector<ahSaleItem*> itemsOnAuction = this->GetCurrentAuctionItems();

    int count = 0;
    int min = 0;
    int max = itemsOnAuction.size() - 1;
    srand(clock());

    while (count < (int) search_config.ah_bot_buy_limit) {
        int randomId = rand() % max + min;
        std::vector<ahSaleItem*>::iterator randomItemFound;

        ahSaleItem* itemToBuy = itemsOnAuction.at(randomId);
        randomItemFound = std::find(randomItemsList.begin(), randomItemsList.end(), itemToBuy);
        if (randomItemFound == randomItemsList.end()) {
            randomItemsList.push_back(itemToBuy);
        }
        count++;
    }

    return randomItemsList;
}

int AHBot::GetSellPrice(ahSaleItem* item)
{
    const char* averageSellPriceQuery = "SELECT price FROM auction_house WHERE itemid = %u;";

    int32 ret = Sql_Query(SqlHandle, averageSellPriceQuery, item->ItemID);

    uint16 avgSellPrice = item->Price;
    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
    {
        int countResults = (int)Sql_NumRows(SqlHandle);
        int sumPrice = 0;
        while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
        {
            sumPrice = sumPrice + Sql_GetIntData(SqlHandle, 0);
        }
        if (sumPrice > 0) {
            avgSellPrice = sumPrice / countResults;
        }
//        Sql_FreeResult(SqlHandle);
    }

    int price = this->GetHighLow(avgSellPrice, item->AuctionDateTS);
    if (price == 0) {
        // if price is still 0, pick a random number between 100 - 2000 gil
        price = rand() % 2000 + 100;
    }
    return price;
}

int AHBot::GetTreasuryBalance()
{
    if (!this->treasuryBalance) {
        const char* treasuryBalanceQuery = "SELECT value FROM server_variables WHERE name = 'treasury_balance';";

        int32 ret = Sql_Query(SqlHandle, treasuryBalanceQuery);

        // Treasury Balance configured in millions
        this->treasuryBalance = search_config.server_treasury * 1000000;

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                this->treasuryBalance = Sql_GetIntData(SqlHandle, 0);
            }
        }
        else {
            this->UpdateTreasuryBalance(this->treasuryBalance);
        }
    }
    return this->treasuryBalance;
}

bool AHBot::IsArmor(int itemId)
{
    if (this->armorItems.empty()) {
        this->armorItems = this->GetItemCategoryIds("item_armor", "itemId");
    }
    std::vector<int>::iterator value = std::find(this->armorItems.begin(), this->armorItems.end(), itemId);
    if (value != this->armorItems.end()) {
        return true;
    }
    return false;
}

bool AHBot::IsFurnishing(int itemId)
{
    if (this->furnishingItems.empty()) {
        this->furnishingItems = this->GetItemCategoryIds("item_furnishing", "itemid");
    }
    std::vector<int>::iterator value = std::find(this->furnishingItems.begin(), this->furnishingItems.end(), itemId);
    if (value != this->furnishingItems.end()) {
        return true;
    }
    return false;
}

bool AHBot::IsUseable(int itemId)
{
    if (this->useableItems.empty()) {
        this->useableItems = this->GetItemCategoryIds("item_usable", "itemid");
    }
    std::vector<int>::iterator value = std::find(this->useableItems.begin(), this->useableItems.end(), itemId);
    if (value != this->useableItems.end()) {
        return true;
    }
    return false;
}

bool AHBot::IsWeapon(int itemId)
{
    if (this->weaponItems.empty()) {
        this->weaponItems = this->GetItemCategoryIds("item_weapon", "itemId");
    }
    std::vector<int>::iterator value = std::find(this->weaponItems.begin(), this->weaponItems.end(), itemId);
    if (value != this->weaponItems.end()) {
        return true;
    }
    return false;
}

bool AHBot::SellStack(int StackSize, time_t auctionTime)
{
    if (StackSize <= 1) {
        return 0;
    }
    return (auctionTime % 2) == 1 ? 1 : 0;
}

void AHBot::UpdateTreasuryBalance(int balance)
{
    const char* updateTreasuryBalanceQuery = "INSERT INTO server_variables (name, value) VALUES ('treasury_balance', %u) ON DUPLICATE KEY UPDATE value = %u;";

    if (Sql_Query(SqlHandle, updateTreasuryBalanceQuery, balance, balance) == SQL_ERROR)
    {
        ShowError(CL_RED"SmallPacket0x04E::AuctionHouse: Cannot update treasury balance\n" CL_RESET);
        return;
    }
    else
    {
        ShowMessage(CL_WHITE"   : Treasury balance updated to %u\n", balance);
    }
}

