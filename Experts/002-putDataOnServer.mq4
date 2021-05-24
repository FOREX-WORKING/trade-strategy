//+------------------------------------------------------------------+
//|                                               001-PUTDATAonServer|
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright "2005-2014, MetaQuotes Software Corp."
#property link "http://www.mql4.com"

input double TakeProfit = 50;
input double Lots = 0.1;
input double TrailingStop = 30;
input double MACDOpenLevel = 3;
input double MACDCloseLevel = 2;
input int MATrendPeriod = 26;
input int GMT_OFFSET_SECCONDS = 10800;
input string SENDURL = "http://001-metatrader-express.forex.jasonjafari.com/METATRADER/add";
input string API_KEY = "9hprxGPuNKXtuNJd";


string TIMEFRAME = "";
string SYMBOL = Symbol();


double OPEN, LOW, CLOSE, HIGH, AVRAGE = 0.0;
datetime DateTIME = iTime(Symbol(), Period(), 0);
datetime TIME_VAL = iTime(Symbol(), Period(), 1);

void OnTick(void)
{
   if (DateTIME != iTime(Symbol(), Period(), 0))
   {

      int hh = TimeGMT() - TimeLocal();

      // string cookie = NULL, headers;
      // char post[], result[];
      int res;
      
      DateTIME = iTime(Symbol(), Period(), 0);
      TIME_VAL = iTime(Symbol(), Period(), 1);
      OPEN = Open[1];
      LOW = Low[1];
      CLOSE = Close[1];
      HIGH = High[1];
     

      double MA25_MODE_LWMA_PRICE_WEIGHTED   = iMA(SYMBOL, Period(), 25, 0,  MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA50_MODE_LWMA_PRICE_WEIGHTED   = iMA(SYMBOL, Period(), 50, 0,  MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA100_MODE_LWMA_PRICE_WEIGHTED   = iMA(SYMBOL, Period(), 100, 0,  MODE_LWMA, PRICE_WEIGHTED, 1);
      double MA200_MODE_LWMA_PRICE_WEIGHTED   = iMA(SYMBOL, Period(), 200, 0,  MODE_LWMA, PRICE_WEIGHTED, 1);

      double MA_AVRAGE = (MA25_MODE_LWMA_PRICE_WEIGHTED + MA50_MODE_LWMA_PRICE_WEIGHTED * 2 + MA100_MODE_LWMA_PRICE_WEIGHTED * 3 + MA200_MODE_LWMA_PRICE_WEIGHTED *4 ) / 10 ;
      AVRAGE = (OPEN + LOW * 2 + HIGH * 2 + CLOSE * 3) / 8;

      double DIFF_AVRAGE = (AVRAGE - MA_AVRAGE) * 100000;

      double MA25_DIFF_LAST   =  MA25_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 25, 0,  MODE_LWMA, PRICE_WEIGHTED, 2);
      MA25_DIFF_LAST = MA25_DIFF_LAST * 100000;
      double MA50_DIFF_LAST   =  MA50_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 50, 0,  MODE_LWMA, PRICE_WEIGHTED, 2);
      MA50_DIFF_LAST = MA50_DIFF_LAST * 100000;
      double MA100_DIFF_LAST   =  MA100_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 100, 0,  MODE_LWMA, PRICE_WEIGHTED, 2);
      MA100_DIFF_LAST = MA100_DIFF_LAST * 100000;
      double MA200_DIFF_LAST   =  MA200_MODE_LWMA_PRICE_WEIGHTED - iMA(SYMBOL, Period(), 200, 0,  MODE_LWMA, PRICE_WEIGHTED, 2);
      MA200_DIFF_LAST = MA200_DIFF_LAST * 100000;

      

      //---  Print(MA50_SIMPLE_HLCC);

      char message_data[], result[];
      string RequestMethod = "POST";
      string headers = "Content-Type: application/x-www-form-urlencoded" + "\r\n";
      headers += "express_api_key: " + API_KEY + "\r\n";

      headers += "TIMEFRAME: " + TIMEFRAME + "\r\n";
      headers += "SYMBOL: " + SYMBOL + "\r\n";
      headers += "TIME_VAL: " + TimeToStr(TIME_VAL) + "\r\n";
      headers += "FLOAT_OPEN: " + OPEN + "\r\n";
      headers += "FLOAT_LOW: " + LOW + "\r\n";
      headers += "FLOAT_CLOSE: " + CLOSE + "\r\n";
      headers += "FLOAT_HIGH: " + HIGH + "\r\n";
      headers += "FLOAT_AVRAGE: " + AVRAGE + "\r\n";
      headers += "FLOAT_DIFF_AVRAGE: " + DIFF_AVRAGE + "\r\n";
      headers += "FLOAT_MA25_MODE_LWMA_PRICE_WEIGHTED: "  + MA25_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headers += "FLOAT_MA50_MODE_LWMA_PRICE_WEIGHTED: "  + MA50_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headers += "FLOAT_MA100_MODE_LWMA_PRICE_WEIGHTED: " + MA100_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headers += "FLOAT_MA200_MODE_LWMA_PRICE_WEIGHTED: " + MA200_MODE_LWMA_PRICE_WEIGHTED + "\r\n";
      headers += "FLOAT_MA_AVRAGE: " + MA_AVRAGE + "\r\n";
      headers += "FLOAT_MA25_DIFF_LAST: " + MA25_DIFF_LAST + "\r\n";
      headers += "FLOAT_MA50_DIFF_LAST: " + MA50_DIFF_LAST + "\r\n";
      headers += "FLOAT_MA100_DIFF_LAST: " + MA100_DIFF_LAST + "\r\n";
      headers += "FLOAT_MA200_DIFF_LAST: " + MA200_DIFF_LAST + "\r\n";
      headers += "Account_Company: " +  AccountCompany() + "\r\n"; 
      headers += "GMT_OFFSET_SECCONDS: " +  GMT_OFFSET_SECCONDS + "\r\n"; 


      int timeout = 10000;
      string result_headers = NULL;
      string message_text = "";

      StringToCharArray(message_text, message_data, 0, StringLen(message_text));

      res = WebRequest(RequestMethod, SENDURL, headers, timeout, message_data, result, result_headers);

      if (res == -1)
      {
         Print("Error in WebRequest. Error code  =", GetLastError());
         MessageBox("Add the address '" + SENDURL + "' in the list of allowed URLs on tab 'Expert Advisors'", "Error", MB_ICONINFORMATION);
      }
      else
      {
         Print(res);
         PrintFormat("The file has been successfully loaded, File size =%d bytes.", ArraySize(result));
         int filehandle = FileOpen("GoogleFinance.htm", FILE_WRITE | FILE_BIN);
         if (filehandle != INVALID_HANDLE)
         {
            FileWriteArray(filehandle, result, 0, ArraySize(result));
            FileClose(filehandle);
         }
         else
            Print("Error in FileOpen. Error code=", GetLastError());
      }
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