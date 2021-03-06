//#include <Wofu\\common\\getOdMultiplier.mqh>
#include <Wofu\\common\\logTradeError.mqh>
//只拉營利
void omsSetSlByTrailingStop(int fTicket,int fSlPips,int fStPips,int fSlGapPips,int fSpPips)
{
   if( fStPips<0 || fSlGapPips<0 || fTicket<0 )return;
   if( fSpPips<=0 )fSpPips=0;
   
   
   double SymPoint=SymbolInfoDouble(OrderSymbol(),SYMBOL_POINT);
   int    SymDigits=(int)SymbolInfoInteger(OrderSymbol(),SYMBOL_DIGITS);
   
   double DiffPrice=0;  //與現價差 
   double SlPriceNew=0,SlPriceOldSP=0;    //要設定的停損價格
   

   //追蹤止損 營利超過幾點之後再開始拉
   if( OrderType()==ORDER_TYPE_BUY  )
   {
      DiffPrice=NormalizeDouble(SymbolInfoDouble(OrderSymbol(), SYMBOL_BID)-OrderOpenPrice(),SymDigits);
      if( DiffPrice>=fStPips*SymPoint || fStPips==0 )
      {
         SlPriceNew=NormalizeDouble(SymbolInfoDouble(OrderSymbol(), SYMBOL_BID)-fSlGapPips*SymPoint,SymDigits);
         SlPriceOldSP=NormalizeDouble(OrderStopLoss()+fSpPips*SymPoint,SymDigits);
         if( SlPriceNew>SlPriceOldSP || OrderStopLoss()==0 )
            if(!OrderModify(OrderTicket(),OrderOpenPrice(),SlPriceNew,OrderTakeProfit(),0,clrGreen))
               logTradeError(__FUNCTION__,fTicket,GetLastError(),"Trailing Stop Error,SlPriceNew="+(string)SlPriceNew);
      }
      else 
      if( fSlPips >= 0 )
      {
         SlPriceNew=(fSlPips==0)?0:NormalizeDouble(OrderOpenPrice()-fSlPips*SymPoint,SymDigits);
         SlPriceOldSP=NormalizeDouble(OrderStopLoss(),SymDigits);
         if( SlPriceNew!=SlPriceOldSP || OrderStopLoss()==0 )
            if(!OrderModify(OrderTicket(),OrderOpenPrice(),SlPriceNew,OrderTakeProfit(),0,clrGreen))
               logTradeError(__FUNCTION__,fTicket,GetLastError(),"Trailing Stop Error,SlPriceNew="+(string)SlPriceNew);

      }
   }
   else 
   if( OrderType()==ORDER_TYPE_SELL )
   {
      DiffPrice=NormalizeDouble(OrderOpenPrice()-SymbolInfoDouble(OrderSymbol(), SYMBOL_ASK),SymDigits);
      if( DiffPrice>=fStPips*SymPoint || fStPips==0 )
      {
         SlPriceNew=NormalizeDouble(SymbolInfoDouble(OrderSymbol(), SYMBOL_ASK)+SymPoint*fSlGapPips,SymDigits);
         SlPriceOldSP=NormalizeDouble(OrderStopLoss()-fSpPips*SymPoint,SymDigits);
         if( SlPriceNew<SlPriceOldSP || OrderStopLoss()==0 )
            if(!OrderModify(OrderTicket(),OrderOpenPrice(),SlPriceNew,OrderTakeProfit(),0,clrGreen))
               logTradeError(__FUNCTION__,fTicket,GetLastError(),"Trailing Stop Error,SlPriceNew="+(string)SlPriceNew);
      }
      else 
      if( fSlPips >= 0 )
      {
         SlPriceNew=(fSlPips==0)?0:NormalizeDouble(OrderOpenPrice()+SymPoint*fSlPips,SymDigits);
         SlPriceOldSP=NormalizeDouble(OrderStopLoss(),SymDigits);
         if( SlPriceNew!=SlPriceOldSP || OrderStopLoss()==0 )
            if(!OrderModify(OrderTicket(),OrderOpenPrice(),SlPriceNew,OrderTakeProfit(),0,clrGreen))
               logTradeError(__FUNCTION__,fTicket,GetLastError(),"Trailing Stop Error,SlPriceNew="+(string)SlPriceNew);
      }
   }
   
}