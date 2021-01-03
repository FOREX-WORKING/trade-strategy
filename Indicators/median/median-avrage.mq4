//+------------------------------------------------------------------+
//|                                                median-avrage.mq4 |
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

//--- input parameters
input int      period1=11;
input int      period2=51;
input int      period3=101;
input int      period4=201;
input int      period5=301;

// indicator buffers
double Median_MEAN[];


int init()
{

  IndicatorBuffers(1);
  SetIndexStyle(0,DRAW_LINE, EMPTY, 4);
  SetIndexBuffer(0,Median_MEAN);
  SetIndexLabel(0,"Median_MEAN ");
  return(0); 
}

 int deinit()
{
   return(0); 
}


int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   int limit=500 + period5 *2 +1;
   runmedian(limit);
   return(rates_total); 
}



void runmedian(int limit) {
  double tab[];
  int cursor;
  for (cursor=limit;cursor>=0;cursor--) {
      Median_MEAN[cursor]= (  iCustom(0, 0,"Jason-Indicator/median/RunMedian-jason",period1, 0, cursor) + 
                              iCustom(0, 0,"Jason-Indicator/median/RunMedian-jason",period2, 0, cursor) +
                              iCustom(0, 0,"Jason-Indicator/median/RunMedian-jason",period3, 0, cursor) +
                              iCustom(0, 0,"Jason-Indicator/median/RunMedian-jason",period4, 0, cursor) +
                              iCustom(0, 0,"Jason-Indicator/median/RunMedian-jason",period5, 0, cursor)  ) /5     ;
   
  }
}