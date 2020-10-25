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



//--- #include "Jason-Include/pushdatatoapi.mqh"
//---

#include "Jason-Include/hash.mqh"
#include "Jason-Include/json.mqh"


   
string s = "{ \"firstName\": \"John\", \"lastName\": \"Smith\", \"age\": 25, "+
"\"address\": { \"streetAddress\": \"21 2nd Street\", \"city\": \"New York\", \"state\": \"NY\", \"postalCode\": \"10021\" },"+
" \"phoneNumber\": [ { \"type\": \"home\", \"number\": \"212 555-1234\" }, { \"type\": \"fax\", \"number\": \"646 555-4567\" } ],"+
" \"gender\":{ \"type\":\"male\" }  }";

   JSONParser *parser = new JSONParser();

    JSONValue *jv = parser.parse(s);



string   TIMEFRAME   = "";
string   SYMBOL      = Symbol();

double OPEN, LOW, CLOSE, HIGH = 0.0;


datetime DateTIME = iTime(Symbol(),Period(),0);
datetime TIME_VAL = iTime(Symbol(),Period(),1);
 
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
  
   
    
     //---     Print("PARSED:"+jv.toString());
     
     

     
  
  
  
  
  
  
  
  
  
  
  
  
      if(DateTIME!=iTime(Symbol(),Period(),0))
     {
      
      
      
      DateTIME=iTime(Symbol(),Period(),0);   
      TIME_VAL = iTime(Symbol(),Period(),1);
      OPEN     = open[1];
      LOW      = low[1];
      CLOSE    = close[1];
      HIGH     = high[1];
      
      
   //---   Print(" TimeFRAME ", TIMEFRAME,
   //---         " SYMBOL ", SYMBOL,
   //---         " DateTIME ", DateTIME
   //---                );
                   
   //---   Print(" HIGH1 ", high[1],
   //---         " SYMBOL ", SYMBOL,
   //---         " DateTIME ", DateTIME
   //---                );
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