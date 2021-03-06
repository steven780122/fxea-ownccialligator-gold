#include <EagerFx\\Transformers\\enums\\EntryType.mqh>
#include <FNO1\\enums\\EntryWay.mqh>
#include <FNO1\\enums\\EntryWayCht.mqh>
input string SepLineTMA = "---------";            //---< 均線 >---
input ENUM_ENTRY_TYPE MaEntryType=1;              //採用模式
input ENUM_TIMEFRAMES MaTf=PERIOD_CURRENT;        //時區
input int MaPeriodF=10;                           //時間週期(短)
input int MaPeriodS=20;                           //時間週期(長)
input int MaShiftF=0;                             //平移(短)
input int MaShiftS=0;                             //平移(長)
input ENUM_MA_METHOD MaMethod=MODE_SMA;           //移動平均
input ENUM_APPLIED_PRICE MaAppPrice=PRICE_CLOSE;  //應用於(價額)

ENUM_ENTRY_WAY  MaEntryWay=ENTRY_WAY_NOT_DEFINE;  //進場模式-進入方向(SELL單與BUY相反)
int MaKFr=1;                                      //進場模式-採用K棒數(起)
input int MaKTo=1;                                //進場模式-採用K棒數(在多少根K內發生都算)
bool MaPreK=false;                                //濾網模式-與前K的MA比對
input bool MaOdOpp=false;                         //結果反向