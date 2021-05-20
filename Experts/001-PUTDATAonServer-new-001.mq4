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
      string SENDURL = "http://001-metatrader-express.forex.jasonjafari.com/EURUSD/add?";

      DateTIME = iTime(Symbol(), Period(), 0);
      TIME_VAL = iTime(Symbol(), Period(), 1);
      OPEN = Open[1];
      LOW = Low[1];
      CLOSE = Close[1];
      HIGH = High[1];
      AVRAGE = (OPEN + LOW * 2 + HIGH * 2 + CLOSE * 3) / 8;

      //---  Print(MA50_SIMPLE_HLCC);

      SENDURL += "TIMEFRAME=" + TIMEFRAME + "&";
      SENDURL += "SYMBOL=" + SYMBOL + "&";
      SENDURL += "TIME_VAL=" + TimeToStr(TIME_VAL) + "&";
      SENDURL += "OPEN=" + OPEN + "&";
      SENDURL += "LOW=" + LOW + "&";
      SENDURL += "CLOSE=" + CLOSE + "&";
      SENDURL += "HIGH=" + HIGH + "&";
      SENDURL += "AVRAGE=" + AVRAGE + "&";

      ResetLastError();

     
     
      // res = WebRequest(
      //    "GET", //     const string method,   // HTTP method
      //    SENDURL,//     const string url,      // URL
      //    NULL,//     const string cookie,   // cookie
      //    NULL,  //     const string referer,  // referer
      //    500, //     int timeout,           // timeout
      //    post, //     const char &data[],    // the array of the HTTP message body
      //    0, //     int data_size,         // data[] array size in bytes
      //    result, //     char &result[],        // an array containing server response data
      //    headers //     string &result_headers // headers of server response
      // );
      
      
      char message_data[], result[];
      string   RequestMethod     =  "POST";
      string   headers           =  "Content-Type: application/x-www-form-urlencoded" + "\r\n";
               headers           += "Authorization: Bearer xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" + "\r\n";
               headers           += "akbar: akbar asdasd" + "\r\n";
      int      timeout           =  10000;
      string   result_headers    =  NULL;
      string   message_text      = "message=";
               message_text      += "sadasdasd";
      StringToCharArray(message_text,message_data,0, StringLen(message_text));
      
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