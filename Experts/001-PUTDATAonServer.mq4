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

double OPEN, LOW, CLOSE, HIGH, MA20_SIMPLE_HLCC, MA50_SIMPLE_HLCC = 0.0;

double Stochastic_Oscillator_K20_D3_S7_CC_HLCC_MAIN,Stochastic_Oscillator_K20_D3_S7_CC_HLCC_SIGNAL = 0.0 ;

double X_CCI_TREND1, X_CCI_TREND2, X_CCI_TREND3, X_CCI_TREND4,X_CCI_TREND = 0.0;

double FPH_Oscilator1,FPH_Oscilator2,FPH_Oscilator,FPH_Oscilator_up, FPH_Oscilator_down   = 0.0;

double FPH_Filter1, FPH_Filter2, FPH_Filter,FPH_Filter_line    = 0.0;

double Forex_Stryder_Signals2_6_1, Forex_Stryder_Signals2_6_2, Forex_Stryder_Signals2_6 = 0.0;

double Forex_VCrush_Signal_20_1, Forex_VCrush_Signal_20_2 , Forex_VCrush_Signal_20 = 0.0;

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
                   
                   MA20_SIMPLE_HLCC = iMA(SYMBOL, Period(), 20, 0, MODE_SMA, PRICE_WEIGHTED, 1);
                   MA50_SIMPLE_HLCC = iMA(SYMBOL, Period(), 50, 0, MODE_SMA, PRICE_WEIGHTED, 1);
                   
                   Forex_Stryder_Signals2_6_1 = iCustom(SYMBOL, Period(),"Jason-Indicator/Forex-Stryder-Signals", Period(), 2, 6, 0,1);
                   Forex_Stryder_Signals2_6_2 = iCustom(SYMBOL, Period(),"Jason-Indicator/Forex-Stryder-Signals", Period(), 2, 6, 1,1);
                   if (!(Forex_Stryder_Signals2_6_1 < 100000 && Forex_Stryder_Signals2_6_1 > -100000)){ Forex_Stryder_Signals2_6_1 = 0; }
                   if (!(Forex_Stryder_Signals2_6_2 < 100000 && Forex_Stryder_Signals2_6_2 > -100000)){ Forex_Stryder_Signals2_6_2 = 0; }
                   Forex_Stryder_Signals2_6 = Forex_Stryder_Signals2_6_1 - Forex_Stryder_Signals2_6_2;
                   
                   Forex_VCrush_Signal_20_1 = iCustom(SYMBOL, Period(),"Jason-Indicator/Forex-VCrush-Signal", Period(), 20 , 0,1);
                   Forex_VCrush_Signal_20_2 = iCustom(SYMBOL, Period(),"Jason-Indicator/Forex-VCrush-Signal", Period(), 20 , 1,1);
                   if (!(Forex_VCrush_Signal_20_1 < 100000 && Forex_VCrush_Signal_20_1 > -100000)){ Forex_VCrush_Signal_20_1 = 0; }
                   if (!(Forex_VCrush_Signal_20_2 < 100000 && Forex_VCrush_Signal_20_2 > -100000)){ Forex_VCrush_Signal_20_2 = 0; }
                   Forex_VCrush_Signal_20 = Forex_VCrush_Signal_20_1 - Forex_VCrush_Signal_20_2;
                   
                   Print("jason", Forex_VCrush_Signal_20);
                                      
                   Stochastic_Oscillator_K20_D3_S7_CC_HLCC_MAIN   = iStochastic(SYMBOL, Period(), 20 , 3, 7, MODE_SMA, 1, MODE_MAIN,   1); 
                   Stochastic_Oscillator_K20_D3_S7_CC_HLCC_SIGNAL = iStochastic(SYMBOL, Period(), 20 , 3, 7, MODE_SMA, 1, MODE_SIGNAL, 1);
                   
                   X_CCI_TREND1=iCustom(SYMBOL, Period(),"Jason-Indicator/!!!-MT4 X-CCI-TREND-03",0,1);
                   X_CCI_TREND2=iCustom(SYMBOL, Period(),"Jason-Indicator/!!!-MT4 X-CCI-TREND-03",1,1);
                   X_CCI_TREND3=iCustom(SYMBOL, Period(),"Jason-Indicator/!!!-MT4 X-CCI-TREND-03",2,1);
                   X_CCI_TREND4=iCustom(SYMBOL, Period(),"Jason-Indicator/!!!-MT4 X-CCI-TREND-03",3,1);
                   X_CCI_TREND = X_CCI_TREND1 + X_CCI_TREND2 + X_CCI_TREND3+ X_CCI_TREND4;
                   
                   
                   FPH_Oscilator1 = iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Oscilator", 5, 35, "elliotWaveLines", "Black", 2, 10, 20, "Silver", 0 , 0,1);
                   FPH_Oscilator2 = iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Oscilator", 5, 35, "elliotWaveLines", "Black", 2, 10, 20, "Silver", 0 , 1,1);                                                        
                   if (!(FPH_Oscilator1 < 1000 && FPH_Oscilator1 > -1000)){ FPH_Oscilator1 = 0; }
                   if (!(FPH_Oscilator2 < 1000 && FPH_Oscilator2 > -1000)){ FPH_Oscilator2 = 0; }
                   FPH_Oscilator = FPH_Oscilator1 + FPH_Oscilator2;
                                      
                   FPH_Oscilator_up   = iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Oscilator", 5, 35, "elliotWaveLines", "Black", 2, 10, 20, "Silver", 0 , 4,1);
                   FPH_Oscilator_down = iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Oscilator", 5, 35, "elliotWaveLines", "Black", 2, 10, 20, "Silver", 0 , 5,1);
                   
                   FPH_Filter1 = X_CCI_TREND1=iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Filter", 5, 14, 0, 5.0, 0.0, false, 3, false, false, false, false, false, false, 0,1);
                   FPH_Filter2 = X_CCI_TREND1=iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Filter", 5, 14, 0, 5.0, 0.0, false, 3, false, false, false, false, false, false, 2,1);
                   if (!(FPH_Filter1 < 1000 && FPH_Filter1 > -1000)){ FPH_Filter1 = 0; }
                   if (!(FPH_Filter2 < 1000 && FPH_Filter2 > -1000)){ FPH_Filter2 = 0; }
                   FPH_Filter = FPH_Filter1 + FPH_Filter2;
                                     
                   FPH_Filter_line = iCustom(SYMBOL, Period(),"Jason-Indicator/FPH_Filter", 5, 14, 0, 5.0, 0.0, false, 3, false, false, false, false, false, false, 4,1);
                   
                   
                  
                   
                   
                   
                   
                   //---  Print(MA50_SIMPLE_HLCC);  
      
                  string cookie=NULL,headers;
                  char post[],result[];
                  int res;
                  string SENDURL="http://001-crud.forex.jasonjafari.com/crud/add?";
                  SENDURL += "TIMEFRAME="             + TIMEFRAME                + "&";
                  SENDURL += "SYMBOL="                + SYMBOL                   + "&";
                  SENDURL += "TIME_VAL="              + TimeToStr(TIME_VAL)      + "&";
                  SENDURL += "OPEN="                  + OPEN                     + "&";
                  SENDURL += "LOW="                   + LOW                      + "&";
                  SENDURL += "CLOSE="                 + CLOSE                    + "&";
                  SENDURL += "HIGH="                  + HIGH                     + "&";
                  SENDURL += "MA50_SIMPLE_HLCC="      + MA50_SIMPLE_HLCC         + "&";
                  SENDURL += "MA20_SIMPLE_HLCC="      + MA20_SIMPLE_HLCC         + "&";
                  
                  SENDURL += "X_CCI_TREND="           + X_CCI_TREND              + "&";
                  
                  SENDURL += "FPH_Oscilator="         + FPH_Oscilator            + "&";
                  SENDURL += "FPH_Oscilator_up="      + FPH_Oscilator_up         + "&";
                  SENDURL += "FPH_Oscilator_down="    + FPH_Oscilator_down       + "&";
                  
                  SENDURL += "FPH_Filter="            + FPH_Filter               + "&";
                  SENDURL += "FPH_Filter_line="       + FPH_Filter_line          + "&";
                  
                  
                  
                  
                  
                  SENDURL += "Forex_Stryder_Signals2_6="                         + Forex_Stryder_Signals2_6                               + "&";
                  SENDURL += "Forex_VCrush_Signal_20="                           + Forex_VCrush_Signal_20                                 + "&";
                  
                  
                  
                  
                  
                  SENDURL += "Stochastic_Oscillator_K20_D3_S7_CC_HLCC_MAIN="     + Stochastic_Oscillator_K20_D3_S7_CC_HLCC_MAIN           + "&";
                  SENDURL += "Stochastic_Oscillator_K20_D3_S7_CC_HLCC_SIGNAL="   + Stochastic_Oscillator_K20_D3_S7_CC_HLCC_SIGNAL         + "&";
                  
                  
                  
                  
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