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
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

datetime DateTIME = iTime(Symbol(),Period(),0);


void OnTick(void)
  {
   double MacdCurrent,MacdPrevious;
   double SignalCurrent,SignalPrevious;
   double MaCurrent,MaPrevious;
   int    cnt,ticket,total;
 
   
     if(DateTIME!=iTime(Symbol(),Period(),0))
     {
                  string cookie=NULL,headers;
                  char post[],result[];
                  int res;
                  //--- string google_url="https://www.google.com/finance";
                  string google_url="http://127.0.0.1/crud/add";
                  ResetLastError();
                  int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection
                  res=WebRequest("GET",google_url,cookie,NULL,timeout,post,0,result,headers);
                  if(res==-1)
                    {
                     Print("Error in WebRequest. Error code  =",GetLastError());
                     //--- Perhaps the URL is not listed, display a message about the necessity to add the address
                     MessageBox("Add the address '"+google_url+"' in the list of allowed URLs on tab 'Expert Advisors'","Error",MB_ICONINFORMATION);
                    }
                  else
                    {
                     PrintFormat("The file has been successfully loaded, File size =%d bytes.",ArraySize(result));
                     int filehandle=FileOpen("GoogleFinance.htm",FILE_WRITE|FILE_BIN);
                     //--- Checking errors
                     if(filehandle!=INVALID_HANDLE)
                       {
                        //--- Save the contents of the result[] array to a file
                        FileWriteArray(filehandle,result,0,ArraySize(result));
                        //--- Close the file
                        FileClose(filehandle);
                       }
                     else Print("Error in FileOpen. Error code=",GetLastError());
                    }
                     
                     
      
      
      DateTIME=iTime(Symbol(),Period(),0);  
      }

   if(Bars<100)
     {
      Print("bars less than 100");
      return;
     }
   if(TakeProfit<10)
     {
      Print("TakeProfit less than 10");
      return;
     }
//--- to simplify the coding and speed up access data are put into internal variables
   MacdCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,0);
   MacdPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,1);
   SignalCurrent=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,0);
   SignalPrevious=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_SIGNAL,1);
   MaCurrent=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,0);
   MaPrevious=iMA(NULL,0,MATrendPeriod,0,MODE_EMA,PRICE_CLOSE,1);

   total=OrdersTotal();
   if(total<1)
     {
      //--- no opened orders identified
      if(AccountFreeMargin()<(1000*Lots))
        {
         Print("We have no money. Free Margin = ",AccountFreeMargin());
         return;
        }
      //--- check for long position (BUY) possibility
      if(MacdCurrent<0 && MacdCurrent>SignalCurrent && MacdPrevious<SignalPrevious && 
         MathAbs(MacdCurrent)>(MACDOpenLevel*Point) && MaCurrent>MaPrevious)
        {
         ticket=OrderSend(Symbol(),OP_BUY,Lots,Ask,3,0,Ask+TakeProfit*Point,"macd sample",16384,0,Green);
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               Print("BUY order opened : ",OrderOpenPrice());
           }
         else
            Print("Error opening BUY order : ",GetLastError());
         return;
        }
      //--- check for short position (SELL) possibility
      if(MacdCurrent>0 && MacdCurrent<SignalCurrent && MacdPrevious>SignalPrevious && 
         MacdCurrent>(MACDOpenLevel*Point) && MaCurrent<MaPrevious)
        {
         ticket=OrderSend(Symbol(),OP_SELL,Lots,Bid,3,0,Bid-TakeProfit*Point,"macd sample",16384,0,Red);
         if(ticket>0)
           {
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES))
               Print("SELL order opened : ",OrderOpenPrice());
           }
         else
            Print("Error opening SELL order : ",GetLastError());
        }
      //--- exit from the "no opened orders" block
      return;
     }
//--- it is important to enter the market correctly, but it is more important to exit it correctly...   
   for(cnt=0;cnt<total;cnt++)
     {
      if(!OrderSelect(cnt,SELECT_BY_POS,MODE_TRADES))
         continue;
      if(OrderType()<=OP_SELL &&   // check for opened position 
         OrderSymbol()==Symbol())  // check for symbol
        {
         //--- long position is opened
         if(OrderType()==OP_BUY)
           {
            //--- should it be closed?
            if(MacdCurrent>0 && MacdCurrent<SignalCurrent && MacdPrevious>SignalPrevious && 
               MacdCurrent>(MACDCloseLevel*Point))
              {
               //--- close order and exit
               if(!OrderClose(OrderTicket(),OrderLots(),Bid,3,Violet))
                  Print("OrderClose error ",GetLastError());
               return;
              }
            //--- check for trailing stop
            if(TrailingStop>0)
              {
               if(Bid-OrderOpenPrice()>Point*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-Point*TrailingStop)
                    {
                     //--- modify order and exit
                     if(!OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*TrailingStop,OrderTakeProfit(),0,Green))
                        Print("OrderModify error ",GetLastError());
                     return;
                    }
                 }
              }
           }
         else // go to short position
           {
            //--- should it be closed?
            if(MacdCurrent<0 && MacdCurrent>SignalCurrent && 
               MacdPrevious<SignalPrevious && MathAbs(MacdCurrent)>(MACDCloseLevel*Point))
              {
               //--- close order and exit
               if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,Violet))
                  Print("OrderClose error ",GetLastError());
               return;
              }
            //--- check for trailing stop
            if(TrailingStop>0)
              {
               if((OrderOpenPrice()-Ask)>(Point*TrailingStop))
                 {
                  if((OrderStopLoss()>(Ask+Point*TrailingStop)) || (OrderStopLoss()==0))
                    {
                     //--- modify order and exit
                     if(!OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,OrderTakeProfit(),0,Red))
                        Print("OrderModify error ",GetLastError());
                     return;
                    }
                 }
              }
           }
        }
     }
//---
  }
//+------------------------------------------------------------------+
