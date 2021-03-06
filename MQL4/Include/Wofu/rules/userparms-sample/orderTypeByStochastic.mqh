input string SepLineTKd = "---------";            //---< KD黃金交叉 >---
input ENUM_ENTRY_TYPE KdEntryType=1;              //採用模式
input ENUM_TIMEFRAMES KdTf=PERIOD_CURRENT;        //時區
input int KdPeriodK=5;                            //%K週期
input int KdPeriodD=3;                            //%D週期
input int KdSlowing=3;                            //慢速
input ENUM_MA_METHOD KdMethod=MODE_SMA;           //移動平均
input ENUM_STO_PRICE KdAppPrice=0;                //價額字段

ENUM_ENTRY_WAY  KdEntryWay=ENTRY_WAY_NOT_DEFINE;  //進場模式-進入方向(SELL單與BUY相反)
 int KdKFr=1;                                     //進場模式-採用K棒數(起)
input int KdKTo=1;                                //進場模式-採用K棒數(在多少根K內發生都算)
bool KdPreK=false;                                //濾網模式-與前K的XXX比對
input bool  KdOdOpp=false;                        //結果反向