int orderTypeByRSI_DIFF1AND2
(
   string fSymbol,
   ENUM_TIMEFRAMES fTf,
   int fPeriod,
   ENUM_APPLIED_PRICE fAp,
   int fShift,
   int Base,
   int Diff1,
   int Diff2,
   bool PreK, 
   bool fOdOpp=false,
)
{
   int fOdType=-1;
   double RSI0,RSI1;
#ifdef __MQL4__
   RSI0 = iRSI(fSymbol,fTf,fPeriod,fAp,fShift);
   RSI1 = iRSI(fSymbol,fTf,fPeriod,fAp,fShift+1);
#endif 
#ifdef __MQL5__
   RSI0 = iRSIMQL4(fSymbol,fTf,fPeriod,fAp,fShift);
   RSI1 = iRSIMQL4(fSymbol,fTf,fPeriod,fAp,fShift+1);
#endif 

   if( Diff1 != 0 )
   {
      if(RsiDiff1no)
         Diff1=MathAbs(Diff1);
      else
         Diff1=-1*MathAbs(Diff1);
   }   
        if( (Diff1==0 && RSI0>=Base) || (Diff1!=0 && RSI0>=Base+MathAbs(Diff1))  )fOdType=ORDER_TYPE_BUY;
   else if( (Diff1==0 && RSI0<Base ) || (Diff1!=0 && RSI0< Base-MathAbs(Diff1))  )fOdType=ORDER_TYPE_SELL;
   else if( Diff1<0 && RSI0>=Base-MathAbs(Diff1)  && RSI0< Base+MathAbs(Diff1) )
   {
      //如果設定負值 BUY:RSI>=45(50-5),SELL:RSI<55 50+5
      //在45~55間 需要判斷是從上方進入(SELL)還是下方進入(BUY)
      double preRSI=0;
      int rsicnt=1;
      while(1)
      {
         #ifdef __MQL4__
            preRSI = iRSI(fSymbol,fTf,fPeriod,fAp,fShift+rsicnt);
         #endif 
         #ifdef __MQL5__
            preRSI = iRSIMQL4(fSymbol,fTf,fPeriod,fAp,fShift+rsicnt);
         #endif 
         if( preRSI<Base-MathAbs(Diff1) ) 
         { fOdType=ORDER_TYPE_BUY;break; }
         else
         if( preRSI>Base+MathAbs(Diff1) )
         { fOdType=ORDER_TYPE_SELL;break; }  
         rsicnt++;    
      }
   }
   else fOdType=-1;


        if( fOdType==ORDER_TYPE_BUY  && (Diff2==0 || RSI0<=Base+Diff2) && ( !PreK || RSI0>RSI1 ) )fOdType=ORDER_TYPE_BUY;  //穿出雲帶上方
   else if( fOdType==ORDER_TYPE_SELL && (Diff2==0 || RSI0>=Base-Diff2) && ( !PreK || RSI0<RSI1 ) )fOdType=ORDER_TYPE_SELL; //穿出雲帶下方
   else fOdType=-1;
   
   
   #ifdef EA_51AREA
      Logger(LOG_DEBUG,__FUNCTION__+": RSI OdType="+(string)fOdType+",RSI0="+DoubleToStr(RSI0,Digits)+",RSI1="+DoubleToStr(RSI1,Digits));
   #endif
   
   if( fOdOpp && fOdType>=0 )return(GetRevOpType(fOdType));
   return(fOdType);
}