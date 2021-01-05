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
input int magicnumber = 1;

input double lotPipProfit = 0;
input int profitCount = 0;

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
  int ticket=OrderSend(
                        Symbol(),         // string   symbol,              // symbol
                        OP_BUY,           // int      cmd,                 // operation
                        0.01,                // double   volume,              // volume
                        Ask,              // double   price,               // price
                        0,                // int      slippage,            // slippage
                        0,                // double   stoploss,            // stop loss
                        0,                // double   takeprofit,          // take profit
                        "My order",       // string   comment=NULL,        // comment
                        magicnumber,      // int      magic=0,             // magic number
                        0,                // datetime expiration=0,        // pending order expiration
                        clrGreen          // color    arrow_color=clrNONE  // color
                        );




  ObjectDelete(0,"lotPipProfit");
  ObjectCreate("lotPipProfit", OBJ_LABEL, 0, 0, 0);// Creating obj.
  ObjectSet("lotPipProfit", OBJPROP_CORNER, 1);    // Reference corner
  ObjectSet("lotPipProfit", OBJPROP_XDISTANCE, 10);// X coordinate
  ObjectSet("lotPipProfit", OBJPROP_YDISTANCE, 15);// Y coordinate
  ObjectSetInteger(0, "lotPipProfit", OBJPROP_CORNER, CORNER_LEFT_UPPER);
  ObjectSetInteger(0, "lotPipProfit", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
  ObjectSetText(
  "lotPipProfit",                       // object name
  "LOT PIP PROFIT: " + string(lotPipProfit),   
  20,                                   // font size
  "Times New Roman" ,                   // font name
  clrYellow                              // text color
  );

  ObjectDelete(0,"profitCount");
  ObjectCreate("profitCount", OBJ_LABEL, 0, 0, 0);// Creating obj.
  ObjectSet("profitCount", OBJPROP_CORNER, 1);    // Reference corner
  ObjectSet("profitCount", OBJPROP_XDISTANCE, 10);// X coordinate
  ObjectSet("profitCount", OBJPROP_YDISTANCE, 40);// Y coordinate
  ObjectSetInteger(0, "profitCount", OBJPROP_CORNER, CORNER_LEFT_UPPER);
  ObjectSetInteger(0, "profitCount", OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
  ObjectSetText(
  "profitCount",                       // object name
  "Profit Count: " + string(profitCount),   
  20,                                   // font size
  "Times New Roman" ,                   // font name
  clrOrange                              // text color
  );

  






}
