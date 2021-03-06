#include <Wofu\\trade\\closeAllOrders.mqh>
#include <Wofu\\enums\\CloseOrdersMode.mqh>



bool closeOrdersByTime
(
   string fSymbol,
   MIXED_ORDER_TYPE fOdType,
   int fMagicNumber,
   int fSlPage,   
   ENUM_CLOSE_ORDERS_MODE fRM_CtMode,
   datetime fRM_CtTime,
   string fRM_CtWkNo="0123456",
   bool   fTpPipsEn=false,
   int    fTpPips=0,
   bool   fSlPipsEn=false,
   int    fSlPips=0,
   int    fRM_CtCont=10,   
)
{
  //enum   RM_EM_CT_MODE  { 關閉定時平倉=0,單次平倉=10,每日平倉=20,每週平倉=70,每月平倉=90 };

  //判斷週
  string fNowWk=IntegerToString(TimeDayOfWeek(TimeLocal()));
  if( StringFind(fRM_CtWkNo,fNowWk,0)<0 )return(false);
  
   int TimeInteval=0;
        if(fRM_CtMode==0 )return(false);
   else if(fRM_CtMode==20)TimeInteval=86400;
   else if(fRM_CtMode==70)TimeInteval=604800;
   else if(fRM_CtMode==90)
   {
   
      MqlDateTime fRM_CtDateTime;
      TimeToStruct(fRM_CtTime,fRM_CtDateTime);
      while( fRM_CtTime < TimeLocal() )
      {
         if(fRM_CtDateTime.mon==12)
            {fRM_CtDateTime.mon=1;fRM_CtDateTime.year++;}
         else
            {fRM_CtDateTime.mon++;}
         fRM_CtTime=StructToTime(fRM_CtDateTime);
         
      }
   }
   

   if(TimeInteval > 0 )
      while( fRM_CtTime < TimeLocal() )
         fRM_CtTime=fRM_CtTime+TimeInteval;

   
   //RM_logger(LOGLEVEL_DEBUG,"fRM_CtTime="+(string)fRM_CtTime);
   if( TimeLocal() >= fRM_CtTime && TimeLocal() < fRM_CtTime+fRM_CtCont)
   {
      closeAllOrders(fSymbol,fOdType,fMagicNumber,fSlPage,fTpPipsEn,fTpPips,fSlPipsEn,fSlPips);
      return(true);
   }
   return(false);

}

