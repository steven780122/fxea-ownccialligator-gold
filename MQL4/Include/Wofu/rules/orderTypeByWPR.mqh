/*
#include <Wofu\\rules\\orderTypeByWPR.mqh>
#include <Wofu\\userparms\\sample\\orderTypeByWPR.mqh>

double  iWPR(
   string       symbol,           // symbol -->fSymbol
   int          timeframe,        // timeframe -->fTf
   int          period,           // period -->fPeriod
   int          shift             // shift
   );
RSI在-100~0之間震盪

由最靠近的K棒(fKFr)開始往前找到前K根(fKTo) ,0:當根,1:前1根

fEntryType==0 濾網模式
   當 自訂BUY基準值 > 自訂SELL基準值
      BUY :WPR> 自訂BUY基準值 
      SELL:WPR< 自訂SELL基準值
      落在自訂BUY基準值~自訂SELL基準值則無方向

   當 自訂BUY基準值 <= 自訂SELL基準值
      BUY :WPR> 自訂SELL基準值 或 
      SELL:WPR< 自訂BUY基準值 或
      落在 自訂BUY基準值~自訂SELL基準值則
      找到是從哪一邊進入 區間(自訂BUY基準值~自訂SELL基準值)
         BUY :由下而上穿過 自訂BUY 基準值
         SELL:由上而下穿過 自訂SELL基準值
   fEntryWay不影響結果

fEntryType==1 進場模式
   當fEntryWay==往上進BUY(0)
      BUY :由下而上穿過 自訂BUY 基準值
      SELL:由上而下穿過 自訂SELL基準值
   當fEntryWay==往下進BUY(1)
      BUY :由上而下穿過 自訂BUY 基準值
      SELL:由下而上穿過 自訂SELL基準值

*/
 
#include <Wofu\\enums\\MarketOrderType.mqh>
#include <Wofu\\enums\\EntryWay.mqh>
#include <Wofu\\Common\\getOppMaketOrderType.mqh>
#include <Wofu\\Common\\logger.mqh>

MARKET_ORDER_TYPE orderTypeByWPR
(
   //--[ 內建指標參數 ]----------------------
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fPeriod,
   //--[ 自有參數-常用 ]----------------------
   int fEntryType,            //採用模式
   ENUM_ENTRY_WAY fEntryWay,  //進場模式-進入方向(SELL單與BUY相反)
   int fKFr,                  //採用K棒數-起
   int fKTo,                  //採用K棒數-迄
   bool fPreK,                //與前K的值比對
   bool fOdOpp,               //結果反向
   bool fLogger,              //是否寫出紀錄
   //--[ 自有參數-特殊 ]----------------------
   double fBaseBB,            //BUY 基準值 下限
   double fBaseBE,            //BUY 基準值 上限(fEntryType=0才會用到)
   double fBaseSB,            //SELL基準值 上限
   double fBaseSE,            //SELL基準值 下限(fEntryType=0才會用到)
)
{
   MARKET_ORDER_TYPE fOdType=OD_NA;
   double FLine0=0,FLine1=0;
   int    SymDigits=(int)SymbolInfoInteger(fSymbol,SYMBOL_DIGITS);
   //濾網模式
   if( fEntryType==0 )fKTo=fKFr;

   
   for(int i=fKFr;i<=fKTo;i++)
   {
      #ifdef __MQL4__
         FLine0 = iWPR(fSymbol,fTf,fPeriod,i);
         FLine1 = iWPR(fSymbol,fTf,fPeriod,i+1);
      #endif 
      #ifdef __MQL5__
         FLine0 = iWPRMQL4(fSymbol,fTf,fPeriod,i);
         FLine1 = iWPRMQL4(fSymbol,fTf,fPeriod,i+1);
      #endif 

      if( fEntryType==0 )  
      {
      
            if ( FLine0 > MathMax(fBaseBB,fBaseSB) && FLine0 <= fBaseBE )fOdType=OD_BUY;
            else
            if ( FLine0 < MathMin(fBaseBB,fBaseSB) && FLine0 >= fBaseSE )fOdType=OD_SELL;
            else
            if ( FLine0 <= MathMax(fBaseBB,fBaseSB) && FLine0 >= MathMin(fBaseBB,fBaseSB) )
            {   
               //處理落在fBaseB~fBaseS中間
               if ( fBaseBB >= fBaseSB )
                  fOdType=OD_NA; //落在fBaseB~fBaseS中間則無方向
               else
               {
                  double FLinePre=0;
                  int cntPre=1;
                  while(1)
                  {
                     #ifdef __MQL4__
                        FLinePre =    iWPR(fSymbol,fTf,fPeriod,i+cntPre);
                     #endif 
                     #ifdef __MQL5__
                        FLinePre = iWPRMQL4(fSymbol,fTf,fPeriod,i+cntPre);
                     #endif 
   
                     if( FLinePre < fBaseBB )fOdType=OD_BUY;  
                     else
                     if( FLinePre > fBaseSB )fOdType=OD_SELL;
                     
                     if( fOdType > 0 )break;
                     cntPre++;    
                  } 
               
               }
            }
            else
               fOdType=OD_NA;
               
            //與前K比較處理
            if( fPreK )
            {
               if( fOdType==OD_BUY  && FLine0 <= FLine1 )fOdType=OD_NA;
               if( fOdType==OD_SELL && FLine0 >= FLine1 )fOdType=OD_NA;
            }

      }
      else 
      if( fEntryType==1 )  
      {
         if (fEntryWay==ENTRY_BUY_CROSSUP) //往上進BUY
         {
            if ( FLine0 > fBaseBB && FLine1<= fBaseBB )fOdType=OD_BUY;  
            else
            if ( FLine0 < fBaseSB && FLine1>= fBaseSB )fOdType=OD_SELL;
         }
         else
         if (fEntryWay==ENTRY_BUY_CROSSDOWN) //往下進BUY
         {
            if ( FLine0 < fBaseBB && FLine1>= fBaseBB )fOdType=OD_BUY;  
            else
            if ( FLine0 > fBaseSB && FLine1<= fBaseSB )fOdType=OD_SELL;
         }
      }
      else
         return(OD_ERROR);
      
      if( fOdType==OD_BUY || fOdType==OD_SELL ) break;
   } //EOF for
   
   if(fLogger)logger(LOG_INFO,__FUNCTION__+": 判斷結果="+EnumToString(fOdType)+",WPR[0]="+DoubleToStr(FLine0,SymDigits)+",WPR[1]="+DoubleToStr(FLine1,SymDigits));
   if( fOdOpp && fOdType>=0 )return(getOppMaketOrderType(fOdType));
   return(fOdType);
    
}
