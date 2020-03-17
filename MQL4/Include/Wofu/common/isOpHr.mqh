//檢查是否為執行時間
bool isOpHr(string fOpWkNo,int fOpHrFr,int fOpHrTo,int fNowTimeQuick) export
 {
  datetime NowTime=TimeLocal()+fNowTimeQuick;
  int fOpNowHr=TimeHour(NowTime);
  string fNowWk=IntegerToString(TimeDayOfWeek(NowTime));
  bool fResult=false;
  if ( StringFind(fOpWkNo,fNowWk,0)>=0 && fOpHrTo >= fOpHrFr && fOpNowHr >= fOpHrFr && fOpNowHr <=  fOpHrTo ) fResult=true;
  else if ( StringFind(fOpWkNo,fNowWk,0)>=0 && fOpHrTo <  fOpHrFr && ( ( fOpNowHr >= fOpHrFr && fOpNowHr <=24 ) || ( fOpNowHr >= 0 && fOpNowHr <=fOpHrTo ) )) fResult=true;
  else
   fResult=false;
   
  //printf("IsOpHr="+(string)fResult+",NowTime="+TimeToString(NowTime,TIME_DATE|TIME_SECONDS)+",NowHr="+(string)fOpNowHr+",NowWk="+(string)fNowWk+",OpWkNo="+(string)fOpWkNo+",OpHrFr="+(string)fOpHrFr+",OpHrTo="+(string)fOpHrTo);
  
  return(fResult);
 }