//+------------------------------------------------------------------+
//|                       Copyright 2014, 英雄哥外匯贏家 Hero Forex. |
//|                                            http://www.HeroFx.biz |
//|                                          Editor:Volvo 2014.08.19 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, 英雄哥外匯贏家 Hero Forex."
#property link      "http://www.HeroFx.biz"
#property version   "1.00"
#property description "==[ 刪除全部箭頭 ]=="
#property strict
//#property script_show_inputs
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
 { 
  for(int i=ObjectsTotal()-1;i>=0;i--)
   if(ObjectType(ObjectName(i))==OBJ_ARROW)ObjectDelete(ObjectName(i));
 }
//+------------------------------------------------------------------+
