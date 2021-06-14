//+------------------------------------------------------------------+
//|                                               Moving Average.mq4 |
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "Jason Jafari"
#property link "http://www.mql4.com"
#property description "Jason Jafari Expert"

input  int MAGIC_NU = 2121;


extern int marketStatus = 0;


extern int InitialRespectPip = 150;
int respectPip = InitialRespectPip;


extern double firstLotSize = 0.01;
double orderLotSize = firstLotSize;


input double lossLotPoint = 0.0;
input int numberOfLostOrder = 0;

int numberOfOpenTrade = 0;
int arrayOfTrade[500];

#include "Jason-Include/trade-strategy/functions.mq4"
#include "Jason-Include/trade-strategy/checkForHistoryAndTrading.mq4"


#include "Jason-Include/trade-strategy/indicatorReader.mq4"
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



#include "Jason-Include/trade-strategy/findTrend.mq4"



#include "Jason-Include/trade-strategy/OrdersAsistance.mq4"


#include "Jason-Include/trade-strategy/trader.mq4"
 
void OnTick()
{
    //--- check for history and trading
    if (!checkForHistoryAndTrading()){
        return;
    }

    readIndicator01();
    readIndicator02();

    findTrend();

    OrdersAsistance();
    trader();
        
 
}
//+------------------------------------------------------------------+
