datetime getNextWeekDay(datetime baseDateTime)
{

   datetime nextTime=(datetime)(StringToTime(TimeToString(baseDateTime,TIME_DATE))
                   +86400*(8-TimeDayOfWeek(baseDateTime)+MathMod(MathRand(),5))
                   +(6*60*60)
                   +MathMod(MathRand(),2*60*60) ); 
                   
   /* 
      下周一：86400*(8-TimeDayOfWeek(baseDateTime)
      MathMod(MathRand(),5))->0~4
      1+(0~4)=1~5其中一天
      
      (6*60*60)->6:00~8:00
      
   */
   return(nextTime);
}