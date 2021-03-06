//#include <Wofu\\trade\\getHistoryLastTicketNo.mqh>
//返回歷史訂單中，在fOrderCloseTimeMax之前的最後一張平倉單號，沒有找到則返回-1
#include <Wofu\\trade\\omsIsMyOrder.mqh>
int getHistoryLastTicketNo
(
   string fSymbol,
   ENUM_MIXED_ORDER_TYPE fOdType,
   int fMagicNumber,
   datetime fOrderOpenTimeMin =D'2000.01.01 00:00:00',
   datetime fOrderOpenTimeMax =D'2999.12.31 23:59:59',
   datetime fOrderCloseTimeMin=D'2000.01.01 00:00:00',
   datetime fOrderCloseTimeMax=D'2999.12.31 23:59:59'
    
) export
 {
  int fLtNo=-1;
  datetime fOrderCloseTime=StringToTime("2000.1.1");
  for(int i=0;i<OrdersHistoryTotal();i++)
   { if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) && 
         omsIsMyOrder(fSymbol,fOdType,fMagicNumber) && 
         OrderCloseTime() > fOrderCloseTime && 
         OrderOpenTime()  >= fOrderOpenTimeMin &&
         OrderOpenTime()  <= fOrderOpenTimeMax &&
         OrderCloseTime() >= fOrderCloseTimeMin &&
         OrderCloseTime() <= fOrderCloseTimeMax 
       ) 
      { 
       fOrderCloseTime=OrderCloseTime(); 
       fLtNo=OrderTicket();
      }
   } //EOF for 
   return(fLtNo);
 }
 
 
/*
可刪除 
int getHistoryLastTicketNo(string fSymbol,MIXED_ORDER_TYPE fOdType,int fMagicNumber) export
 {
  int fLtNo=-1;
  datetime fOrderCloseTime=StrToTime("2000.1.1");
  for(int i=0;i<OrdersHistoryTotal();i++)
   { if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY) && omsIsMyOrder(fSymbol,fOdType,fMagicNumber) && OrderCloseTime() > fOrderCloseTime) 
      { 
       fOrderCloseTime=OrderCloseTime(); 
       fLtNo=OrderTicket();
      }
   } //EOF for 
   return(fLtNo);
 }

*/
