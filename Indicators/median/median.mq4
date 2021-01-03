//+------------------------------------------------------------------+
//|                                                       median.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window

#include <stdlib.mqh>
// indicator settings
#property indicator_buffers 1
#property indicator_color1 Red

extern int period=13;

// indicator buffers
double Median[];


int init()
{

  if (MathMod(period,2)==0) period=period+1;

  IndicatorBuffers(1);
  SetIndexStyle(0,DRAW_LINE);
  SetIndexBuffer(0,Median);
  SetIndexLabel(0,"Median ("+DoubleToStr(period,0)+")");
 
  return(0); 
}

int deinit()
{
   return(0); 
}

int start()
{
   int counted_bars=IndicatorCounted();
   if(counted_bars>0) counted_bars--;
   int limit=Bars-counted_bars;
   if(counted_bars==0) limit--;
   runmedian(limit);
   
   return(0);   

}














void runmedian(int limit) {

  double tab[];
  int i,cursor,count,oldpos,sortedpos;
  double value, oldvalue;
  ArrayResize(tab,period);
  count=0;
  for (cursor=limit;cursor>=0;cursor--) {
    value=(High[cursor]+Low[cursor])/2;
    if (count<period) {
      tab[count]=value;
      if (count==(period-1)) {
        ArraySort(tab);
        Median[cursor]=tab[(period-1)/2];
      }
    }
    else {
          oldpos=cursor+period;
	        oldvalue=(High[oldpos]+Low[oldpos])/2;
	        sortedpos=ArrayBsearch(tab,oldvalue);
          for (i=sortedpos;i<(period-1);i++) tab[i]=tab[i+1];
          tab[period-1]=EMPTY_VALUE;
	        sortedpos=ArrayBsearch(tab,value);
	        if (tab[sortedpos]<value) sortedpos++;
           for (i=period-1;i>sortedpos;i--) tab[i]=tab[i-1];
           tab[sortedpos]=value;
           Median[cursor]=tab[(period-1)/2];        
    }
    count++;
  }
}