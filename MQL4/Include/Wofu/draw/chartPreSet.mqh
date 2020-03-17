void chartPreSet() export
{
   //DeleteAllObject(0,EA_NAME_E);
   ChartSetInteger(0,CHART_SHOW_GRID,false);       //網格拿掉
   ChartSetInteger(0,CHART_SHOW_PERIOD_SEP,true); 
   ChartSetInteger(0,CHART_MODE,CHART_CANDLES);    
   ChartSetInteger(0,CHART_AUTOSCROLL,true);
   ChartSetInteger(0,CHART_SCALE,3);
   ChartSetInteger(0,CHART_SHIFT,true);
   ChartSetDouble(0,CHART_SHIFT_SIZE,15);
   #ifdef CHART_SHIFT_PIXELS
      ChartSetDouble(0,CHART_SHIFT_SIZE,(int)MathRound(CHART_SHIFT_PIXELS*100/ChartGetInteger(0,CHART_WIDTH_IN_PIXELS))+1);
   #else 
      ChartSetDouble(0,CHART_SHIFT_SIZE,(int)MathRound(300*100/ChartGetInteger(0,CHART_WIDTH_IN_PIXELS))+1);
   #endif 
   
         

   //RectLabelCreate(0,EA_NAME_E+"RTopRect",0,0,115,400,115,clrBlack,BORDER_FLAT,CORNER_RIGHT_UPPER,clrBlack,STYLE_SOLID,0);
   //RectLabelCreate(0,EA_NAME_E+"LTopRect",0,0,0,400,115,clrBlack,BORDER_FLAT,CORNER_LEFT_UPPER ,clrBlack,STYLE_SOLID,0);

} 


#ifdef OLD_ALIAS
   void ChartPreSet0() export
   {  chartPreSet(); }
#endif 