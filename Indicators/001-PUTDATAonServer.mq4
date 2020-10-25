//+------------------------------------------------------------------+
//|                                          001-PUTDATAonServer.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

string   TIMEFRAME   = "";
string   SYMBOL      = Symbol();


datetime DateTIME = iTime(Symbol(),Period(),0);
 
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
      if(DateTIME!=iTime(Symbol(),Period(),0)) // new candle on D1
     {
      //Do Something...
      DateTIME=iTime(Symbol(),Period(),0);    // overwrite old with new value
      Print(" TimeFRAME ", TIMEFRAME,
            " SYMBOL ", SYMBOL,
            " DateTIME ", DateTIME
            
              );
     }
     return(rates_total);
  }

 
 
 
 
 //functions 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 int OnInit()
  {
         if( Period() == PERIOD_M1 )
         {
            TIMEFRAME ="M1";
         } else if (Period() == PERIOD_M5 )
         {
            TIMEFRAME ="M5";
         } else if (Period() == PERIOD_M15 )
         {
            TIMEFRAME ="M15";
         } else if (Period() == PERIOD_M30 )
         {
            TIMEFRAME ="M30";
         } else if (Period() == PERIOD_H1 )
         {
            TIMEFRAME ="H1";
         } else if (Period() == PERIOD_H4 )
         {
            TIMEFRAME ="H4";
         } else if (Period() == PERIOD_D1 )
         {
            TIMEFRAME ="D1";
         } else if (Period() == PERIOD_W1 )
         {
            TIMEFRAME ="W1";
         } else if (Period() == PERIOD_MN1 )
         {
            TIMEFRAME ="MN1";
         }
         
         
         return(INIT_SUCCEEDED);
  }