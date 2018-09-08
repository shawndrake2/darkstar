#ifndef _AHBOT_H_
#define _AHBOT_H_

struct Sql_t;

struct ahSaleItem
{
    int AuctionId = 0; // Default of 0 is fine for inserting
    int ItemID;
    std::string Name;
    int Category;
    int Stack;
    int Seller;
    std::string SellerName;
    time_t AuctionDateTS;
    int Price;
    std::string BuyerName;
    int Sold;
    time_t SellDateTS;
};

class AHBot
{
public:

    AHBot();
    ~AHBot();

    void BuyRandomAHItems();
    void StockAHBotItems();

private:

    Sql_t* SqlHandle;
    int treasuryBalance = NULL;
    int itemsBought = 0;
    int itemsPutOnAuction = 0;
    std::vector<int> armorItems;
    std::vector<int> furnishingItems;
    std::vector<int> useableItems;
    std::vector<int> weaponItems;

    void                     AddToAuction(ahSaleItem* ahSaleItem);
    void                     BuyBackFromAuction(ahSaleItem* ahSaleItem);
    std::vector<ahSaleItem*> GetCurrentAuctionItems();
    int                      GetNumberOfCurrentAuctionItemsById(int itemId);
    int                      GetHighLow(int price, time_t auctionTime);
    std::vector<int>         GetItemCategoryIds(std::string tableName, std::string field);
    std::vector<int>         GetItemIds();
    std::vector<ahSaleItem*> GetRandomItemsToAuction();
    std::vector<ahSaleItem*> GetRandomItemsToBuy();
    int                      GetSellPrice(ahSaleItem* item);
    int                      GetTreasuryBalance();
    bool                     IsArmor(int itemId);
    bool                     IsFurnishing(int itemId);
    bool                     IsUseable(int itemId);
    bool                     IsWeapon(int itemId);
    bool                     SellStack(int StackSize, time_t auctionTime);
    void                     UpdateTreasuryBalance(int balance);
};

# endif