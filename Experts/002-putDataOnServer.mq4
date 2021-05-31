//+------------------------------------------------------------------+
//|                                               001-PUTDATAonServer|
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "2005-2014, MetaQuotes Software Corp."
#property link "http://www.mql4.com"

input int GMT_OFFSET_SECCONDS = 10800;
input string MAIN_URL = "http://001-metatrader-express.forex.jasonjafari.com/METATRADER";
input string API_KEY = "9hprxGPuNKXtuNJd";

string SENDURL = MAIN_URL + "/add";

string TIMEFRAME = "";
string SYMBOL = Symbol();

double OPEN, LOW, CLOSE, HIGH, AVRAGE = 0.0;
datetime DateTIME = iTime(Symbol(), Period(), 0);
datetime TIME_VAL = iTime(Symbol(), Period(), 1);

int tedadCandleGhablForZigZag = 100;

int counter = 0;

void OnTick(void)
{
   if (DateTIME != iTime(Symbol(), Period(), 0))
   {

      int hh = TimeGMT() - TimeLocal();

      // string cookie = NULL, headers;
      // char post[], result[];

      DateTIME = iTime(Symbol(), Period(), 0);
      TIME_VAL = iTime(Symbol(), Period(), 1);
      OPEN = Open[1];
      LOW = Low[1];
      CLOSE = Close[1];
      HIGH = High[1];

      double MA25_MODE_LWMA_PRICE_WEIGHTED = iMA(SYMBOL, Period(), 25, 0, MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA50_MODE_LWMA_PRICE_WEIGHTED = iMA(SYMBOL, Period(), 50, 0, MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA100_MODE_LWMA_PRICE_WEIGHTED = iMA(SYMBOL, Period(), 100, 0, MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA200_MODE_LWMA_PRICE_WEIGHTED = iMA(SYMBOL, Period(), 200, 0, MODE_LWMA, PRICE_WEIGHTED, 1);

      double MA_AVRAGE = (MA25_MODE_LWMA_PRICE_WEIGHTED + MA50_MODE_LWMA_PRICE_WEIGHTED * 2 + MA100_MODE_LWMA_PRICE_WEIGHTED * 3 + MA200_MODE_LWMA_PRICE_WEIGHTED * 4) / 10;
      AVRAGE = (OPEN + LOW * 2 + HIGH * 2 + CLOSE * 3) / 8;

      double DIFF_AVRAGE = (AVRAGE - MA_AVRAGE) * 100000;

      double MA25_DIFF_LAST = MA25_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 25, 0, MODE_LWMA, PRICE_WEIGHTED, 2);
      MA25_DIFF_LAST = MA25_DIFF_LAST * 100000;
      double MA50_DIFF_LAST = MA50_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 50, 0, MODE_LWMA, PRICE_WEIGHTED, 2);
      MA50_DIFF_LAST = MA50_DIFF_LAST * 100000;
      double MA100_DIFF_LAST = MA100_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 100, 0, MODE_LWMA, PRICE_WEIGHTED, 2);
      MA100_DIFF_LAST = MA100_DIFF_LAST * 100000;
      double MA200_DIFF_LAST = MA200_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 200, 0, MODE_LWMA, PRICE_WEIGHTED, 2);
      MA200_DIFF_LAST = MA200_DIFF_LAST * 100000;

      char message_data[], result[];
      string RequestMethod = "POST";
      string headersMain = "Content-Type: application/x-www-form-urlencoded" + "\r\n";
      headersMain += "express_api_key: " + API_KEY + "\r\n";

      headersMain += "TIMEFRAME: " + TIMEFRAME + "\r\n";
      headersMain += "SYMBOL: " + SYMBOL + "\r\n";
      headersMain += "GMT_OFFSET_SECCONDS: " + GMT_OFFSET_SECCONDS + "\r\n";
      headersMain += "Account_Company: " + AccountCompany() + "\r\n";

      string headersAddData = headersMain;
      headersAddData += "TIME_VAL: " + TimeToStr(TIME_VAL) + "\r\n";
      headersAddData += "FLOAT_OPEN: " + OPEN + "\r\n";
      headersAddData += "FLOAT_LOW: " + LOW + "\r\n";
      headersAddData += "FLOAT_CLOSE: " + CLOSE + "\r\n";
      headersAddData += "FLOAT_HIGH: " + HIGH + "\r\n";
      headersAddData += "FLOAT_AVRAGE: " + AVRAGE + "\r\n";
      headersAddData += "FLOAT_DIFF_AVRAGE: " + DIFF_AVRAGE + "\r\n";
      headersAddData += "FLOAT_MA25_MODE_LWMA_PRICE_WEIGHTED: " + MA25_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headersAddData += "FLOAT_MA50_MODE_LWMA_PRICE_WEIGHTED: " + MA50_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headersAddData += "FLOAT_MA100_MODE_LWMA_PRICE_WEIGHTED: " + MA100_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headersAddData += "FLOAT_MA200_MODE_LWMA_PRICE_WEIGHTED: " + MA200_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headersAddData += "FLOAT_MA_AVRAGE: " + MA_AVRAGE + "\r\n";
      headersAddData += "FLOAT_MA25_DIFF_LAST: " + MA25_DIFF_LAST + "\r\n";
      headersAddData += "FLOAT_MA50_DIFF_LAST: " + MA50_DIFF_LAST + "\r\n";
      headersAddData += "FLOAT_MA100_DIFF_LAST: " + MA100_DIFF_LAST + "\r\n";
      headersAddData += "FLOAT_MA200_DIFF_LAST: " + MA200_DIFF_LAST + "\r\n";

      int timeout = 10000;
      string result_headers = NULL;

      int res = WebRequest(RequestMethod, SENDURL, headersAddData, timeout, message_data, result, result_headers);


      double support = iCustom(SYMBOL, Period(), "Jason-Indicator/Wave_Arrows", Period(), 6, tedadCandleGhablForZigZag);
      double resistance = iCustom(SYMBOL, Period(), "Jason-Indicator/Wave_Arrows", Period(), 7, tedadCandleGhablForZigZag);

      if (support != 0 || resistance != 0)
      {
         string headersSupportResistance = headersMain;

         string SEND_SUPPORT_RES_URL = MAIN_URL + "/addSupportResistance";
        
         headersSupportResistance += "TIME_VAL_UPDATE: " + TimeToStr( iTime(Symbol(), Period(), tedadCandleGhablForZigZag)) + "\r\n";


         if (support != 0)
         {
            headersSupportResistance += "FLOAT_SUPPORT: " + support + "\r\n";
         }

         if (resistance != 0)
         {
            headersSupportResistance += "FLOAT_RESISTANCE: " + resistance + "\r\n";
         }

         int resSupportResistance = WebRequest(RequestMethod, SEND_SUPPORT_RES_URL, headersSupportResistance, timeout, message_data, result, result_headers);
      }

      counter += 1;
   }
}
//+------------------------------------------------------------------+

int OnInit()
{

   if (Period() == PERIOD_M1)
   {
      TIMEFRAME = "M1";
   }
   else if (Period() == PERIOD_M5)
   {
      TIMEFRAME = "M5";
   }
   else if (Period() == PERIOD_M15)
   {
      TIMEFRAME = "M15";
   }
   else if (Period() == PERIOD_M30)
   {
      TIMEFRAME = "M30";
   }
   else if (Period() == PERIOD_H1)
   {
      TIMEFRAME = "H1";
   }
   else if (Period() == PERIOD_H4)
   {
      TIMEFRAME = "H4";
   }
   else if (Period() == PERIOD_D1)
   {
      TIMEFRAME = "D1";
   }
   else if (Period() == PERIOD_W1)
   {
      TIMEFRAME = "W1";
   }
   else if (Period() == PERIOD_MN1)
   {
      TIMEFRAME = "MN1";
   }

   //---
   return (INIT_SUCCEEDED);
}