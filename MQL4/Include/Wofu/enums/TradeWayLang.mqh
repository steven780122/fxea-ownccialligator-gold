#include <Wofu\\enums\\TradeWay.mqh>

enum ENUM_TRADE_WAY_CHT 
{
   只進多單=TRADE_WAY_ONLY_LONG,
   只進空單=TRADE_WAY_ONLY_SHORT,
   多空皆進=TRADE_WAY_ONLY_LONG_AND_SHORT,
};
enum ENUM_TRADE_WAY_ENG 
{
   ONLY_LONG=TRADE_WAY_ONLY_LONG,
   ONLY_SHORT=TRADE_WAY_ONLY_SHORT,
   LONG_AND_SHORT=TRADE_WAY_ONLY_LONG_AND_SHORT,
};