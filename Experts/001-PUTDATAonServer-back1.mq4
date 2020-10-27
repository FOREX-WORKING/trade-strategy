//+------------------------------------------------------------------+
//|                                               001-PUTDATAonServer|
//|                   Copyright 2005-2014, MetaQuotes Software Corp. |
//|                                              http://www.mql4.com |
//+------------------------------------------------------------------+
#property copyright   "2005-2014, MetaQuotes Software Corp."
#property link        "http://www.mql4.com"

 


input double TakeProfit    =50;
input double Lots          =0.1;
input double TrailingStop  =30;
input double MACDOpenLevel =3;
input double MACDCloseLevel=2;
input int    MATrendPeriod =26;
 


string TIMEFRAME   = "";
string   SYMBOL      = Symbol();

double OPEN, LOW, CLOSE, HIGH = 0.0;


datetime DateTIME = iTime(Symbol(),Period(),0);
datetime TIME_VAL = iTime(Symbol(),Period(),1);



void OnTick(void)
  {
     if(DateTIME!=iTime(Symbol(),Period(),0))
     {
     
     int hh = TimeGMT() - TimeLocal();
                  
                   DateTIME   =iTime(Symbol(),Period(),0); 
                   TIME_VAL   = iTime(Symbol(),Period(),1);
                   OPEN       = Open[1];
                   LOW        = Low[1];
                   CLOSE      = Close[1];
                   HIGH       = High[1];
                     
      
                  string cookie=NULL,headers;
                  char post[],result[];
                  int res;
                  string SENDURL="http://127.0.0.1/crud/add?";
                  SENDURL += "TIMEFRAME=" + TIMEFRAME           + "&";
                  SENDURL += "SYMBOL="    + SYMBOL              + "&";
                  SENDURL += "TIME_VAL="  + TimeToStr(TIME_VAL) + "&";
                  SENDURL += "OPEN="      + OPEN                + "&";
                  SENDURL += "LOW="       + LOW                 + "&";
                  SENDURL += "CLOSE="     + CLOSE               + "&";
                  SENDURL += "HIGH="      + HIGH                + "&";
                  
                  //--- SENDURL += "=EUR/USD&TIME_VAL=2020:12:04 22:01&OPEN=1.425&LOW=1.2212&=4.25&=8.23";
                  ResetLastError(); 
                  
                  res=WebRequest("GET",SENDURL,NULL,NULL,500,post,0,result,headers);
                  if(res==-1)
                    {
                     Print("Error in WebRequest. Error code  =",GetLastError());
                     MessageBox("Add the address '"+SENDURL+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION);
                    }
                  else
                    {
                     PrintFormat("The file has been successfully loaded, File size =%d bytes.",ArraySize(result));
                     int filehandle=FileOpen("GoogleFinance.htm",FILE_WRITE|FILE_BIN);
                     if(filehandle!=INVALID_HANDLE)
                       {
                        FileWriteArray(filehandle,result,0,ArraySize(result));
                        FileClose(filehandle);
                       }
                     else Print("Error in FileOpen. Error code=",GetLastError());
                    }
                     
                     
      
      
     
       
      }
  
 
  }
//+------------------------------------------------------------------+


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
   
//---
   return(INIT_SUCCEEDED);
  }