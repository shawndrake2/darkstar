#ifndef _AHBOT_H_
#define _AHBOT_H_

struct Sql_t;

struct ahSaleItem
{
    uint32 AuctionId = 0; // Default of 0 is fine for inserting
    uint16 ItemID;
    int8* Name;
    uint16 Category;
    uint8 Stack;
    uint8 Seller;
    std::string SellerName;
    time_t AuctionDateTS;
    uint32 Price;
    std::string BuyerName;
    uint8 Sold;
    time_t SellDateTS;
};

class AHBot
{
public:

    AHBot();
    ~AHBot();

    void                     StockAHBotItems();

private:

    Sql_t* SqlHandle;
    int treasuryBalance = NULL;

    void                     AddToAuction(ahSaleItem* ahSaleItem);
    std::vector<int>         GetCurrentAuctionItems();
    int                      GetHighLow(int price, time_t auctionTime);
    std::vector<int>         GetItemIds();
    std::vector<ahSaleItem*> GetRandomItemsToAuction();
    int                      GetSellPrice(ahSaleItem* item);
    int                      GetTreasuryBalance();
    bool                     SellStack(int StackSize, time_t auctionTime);
    void                     UpdateTreasuryBalance(int balance);
};

# endif