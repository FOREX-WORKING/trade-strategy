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
     
                  
                   DateTIME   =iTime(Symbol(),Period(),0); 
                   TIME_VAL   = iTime(Symbol(),Period(),1);
                   OPEN       = Open[1];
                   LOW        = Low[1];
                   CLOSE      = Close[1];
                   HIGH       = High[1];
                     
      
                  string cookie=NULL,headers;
                  char post[],result[];
                  int res;
                  string google_url="http://127.0.0.1/crud/add";
                  ResetLastError();
                  int timeout=5000; 
                  res=WebRequest("GET",google_url,cookie,NULL,timeout,post,0,result,headers);
                  if(res==-1)
                    {
                     Print("Error in WebRequest. Error code  =",GetLastError());
                     MessageBox("Add the address '"+google_url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION);
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
