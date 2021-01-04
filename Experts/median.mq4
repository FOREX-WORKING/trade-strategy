//+------------------------------------------------------------------+
//|                                                       median.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link "https://www.mql5.com"
#property version "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

input int period1 = 11;
input int period2 = 51;
input int period3 = 101;
input int period4 = 201;
input int period5 = 301;

double vbid    = MarketInfo( Symbol(),MODE_BID);
double vask    = MarketInfo( Symbol(),MODE_ASK);
double vpoint  = MarketInfo( Symbol(),MODE_POINT);
int    vdigits = (int)MarketInfo( Symbol(),MODE_DIGITS);
int    vspread = (int)MarketInfo( Symbol(),MODE_SPREAD);

#include <Jason-Include\Read_Median.mqh>

int OnInit()
{
  //---

  //---
  return (INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
  //---
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
  double sorttt[];
  long   colorrr[];
  ArrayResize(colorrr,6);
  colorrr[0] = clrBlue;
  colorrr[1] = clrMagenta;
  colorrr[2] = clrYellow;
  colorrr[3] = clrOrange;
  colorrr[4] = clrLime;
  colorrr[5] = clrRed;
  string uniqueTime =  TimeToStr( iTime(Symbol(), Period(), 0));
  ArrayResize(sorttt,6);
  double ReadMedian1 = NormalizeDouble ( ReadMedian(period1, 0) ,vdigits ) ;
  double ReadMedian2 = NormalizeDouble ( ReadMedian(period2, 0) ,vdigits ) ;
  double ReadMedian3 = NormalizeDouble ( ReadMedian(period3, 0) ,vdigits ) ;
  double ReadMedian4 = NormalizeDouble ( ReadMedian(period4, 0) ,vdigits ) ;
  double ReadMedian5 = NormalizeDouble ( ReadMedian(period5, 0) ,vdigits ) ;
  sorttt[0] = ReadMedian1;
  sorttt[1] = ReadMedian2;
  sorttt[2] = ReadMedian3;
  sorttt[3] = ReadMedian4;
  sorttt[4] = ReadMedian5;
  sorttt[5] = NormalizeDouble ( ( ReadMedian1 + ReadMedian2 + ReadMedian3 + ReadMedian4 + ReadMedian5) /5 ,vdigits ) ;
  string message = "";
  ArraySort(sorttt);
  int size = ArraySize( sorttt );
  for( int i = 0; i < size; i++ ){
    message += string(i)  +  ": " + string(sorttt[i]) + ", ";
    ObjectCreate(0,uniqueTime + string(i),OBJ_TREND,0,TimeCurrent() ,sorttt[i],TimeCurrent()+ Period() * 60,sorttt[i]);
    ObjectSetInteger(0,uniqueTime + string(i),OBJPROP_RAY_LEFT,false);
    ObjectSetInteger(0,uniqueTime + string(i),OBJPROP_RAY_RIGHT,false);
    ObjectSetInteger(0,uniqueTime + string(i),OBJPROP_STYLE,STYLE_SOLID);
    ObjectSetInteger(0,uniqueTime + string(i),OBJPROP_WIDTH,2);
    ObjectSetInteger(0,uniqueTime + string(i),OBJPROP_COLOR,colorrr[i]);
  }
  
  Print(  uniqueTime);
}
