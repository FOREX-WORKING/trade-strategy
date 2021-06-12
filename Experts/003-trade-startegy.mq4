//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Jason Jafari"
#property link "http://www.mql4.com"
#property description "Jason Jafari Expert"

#define MAGICMA 20131111
//--- Inputs
input double Lots = 0.1;
input double MaximumRisk = 0.02;
input double DecreaseFactor = 3;
input int MovingPeriod = 12;
input int MovingShift = 6;

#include "Jason-Include/trade-strategy/checkForHistoryAndTrading.mq4"


//--- Indicaror1
double Indicator01Resistance0;
double Indicator01Resistance1;
double Indicator01Mean0;
double Indicator01Mean1;
double Indicator01Support0;
double Indicator01Support1;
#include "Jason-Include/trade-strategy/readIndicator01.mq4"

//--- Indicaror2
double Indicator02_01 = EMPTY_VALUE;
string Indicator02_01_type = "";
int    Indicator02_01_candleNumber = 0;
double Indicator02_02 = EMPTY_VALUE;
string Indicator02_02_type = "";
int    Indicator02_02_candleNumber = 0;
double Indicator02_03 = EMPTY_VALUE;
string Indicator02_03_type = "";
int    Indicator02_03_candleNumber = 0;
#include "Jason-Include/trade-strategy/readIndicator02.mq4"



 
void OnTick()
{
    //--- check for history and trading
    if (!checkForHistoryAndTrading()){
        return;
    }

    readIndicator01();
    readIndicator02();
    // Print(Indicator01Support1);
        
 
}
//+------------------------------------------------------------------+
