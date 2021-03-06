//取得平倉後單數
#include <Wofu\\trade\\omsIsMyOrder.mqh>
int getHistoryOrdersCnt(string fSymbol,int fOdType,int fMagicNumber) export
 {
  int fGetOpPosCnt=0; 
  for(int i=0;i<OrdersHistoryTotal();i++)
   { if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) && omsIsMyOrder(fSymbol,(MIXED_ORDER_TYPE)fOdType,fMagicNumber) ) fGetOpPosCnt++; } 
  return(fGetOpPosCnt);
 }
 
 
int getHistoryOrdersCnt
(
   string fSymbol,int fMagicNumber,
   int& outBuyCnts,int& outSellCnts,
   int& outBuyStopCnts,int& outSellStopCnts,
   int& outBuyLimitCnts,int& outSellLimitCnts,
) export
 {
   outBuyCnts=0;
   outSellCnts=0;
   outBuyStopCnts=0;
   outSellStopCnts=0;
   outBuyLimitCnts=0;
   outSellLimitCnts=0;
      
     for(int i=0;i<OrdersHistoryTotal();i++)
      if( OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) && omsIsMyOrder(fSymbol,MIXED_ODTYPE_ALL,fMagicNumber) )
      { 
         switch(OrderType())
         {
            case ORDER_TYPE_BUY:
               outBuyCnts++;
               break;
            case ORDER_TYPE_SELL:
               outSellCnts++;
               break;
            case ORDER_TYPE_BUY_STOP:
               outBuyStopCnts++;
               break;
            case ORDER_TYPE_SELL_STOP:
               outSellStopCnts++;
               break;
            case ORDER_TYPE_BUY_LIMIT:
               outBuyLimitCnts++;
               break;
            case ORDER_TYPE_SELL_LIMIT:
               outSellLimitCnts++;
               break;               
            default:
               break;
         }      
      }
     return(outBuyCnts+outSellCnts+outBuyStopCnts+outSellStopCnts+outBuyLimitCnts+outSellLimitCnts);
 }
 
 
 
 int getHistoryOrdersCnt
(
   string fSymbol,int fMagicNumber,
   int& outBuyCnts,int& outSellCnts,
   int& outBuyStopLimitCnts,int& outSellStopLimitCnts,
) export
 {
   outBuyCnts=0;
   outSellCnts=0;
   outBuyStopLimitCnts=0;
   outSellStopLimitCnts=0;
      
     for(int i=0;i<OrdersHistoryTotal();i++)
      if( OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) && omsIsMyOrder(fSymbol,MIXED_ODTYPE_ALL,fMagicNumber) )
      { 
         switch(OrderType())
         {
            case ORDER_TYPE_BUY:
               outBuyCnts++;
               break;
            case ORDER_TYPE_SELL:
               outSellCnts++;
               break;
            case ORDER_TYPE_BUY_STOP:
               outBuyStopLimitCnts++;
               break;
            case ORDER_TYPE_SELL_STOP:
               outSellStopLimitCnts++;
               break;
            case ORDER_TYPE_BUY_LIMIT:
               outBuyStopLimitCnts++;
               break;
            case ORDER_TYPE_SELL_LIMIT:
               outSellStopLimitCnts++;
               break;               
            default:
               break;
         }      
      }
     return(outBuyCnts+outSellCnts+outBuyStopLimitCnts+outSellStopLimitCnts);
 }