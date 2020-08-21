#property copyright "Copyright © 2013, ForexMT4Systems."
#property link      "http://www.forexmt4systems.com"

#property indicator_separate_window
#property indicator_buffers 6
#property indicator_color1  DeepSkyBlue
#property indicator_color2  PaleVioletRed
#property indicator_color3  Gold
#property indicator_color4  Gold
#property indicator_color5  DimGray
#property indicator_color6  DimGray
#property indicator_width1  2
#property indicator_width2  2
#property indicator_width3  2
#property indicator_width4  2
#property indicator_width5  2
#property indicator_width6  2

//
//
//
//
//

extern int    shortPeriod      =  5;
extern int    longPeriod       = 35;
extern string linesIdentifier  = "elliotWaveLines";
extern color  linesColor       = Black;
extern int    linesStyle       = STYLE_DOT;
extern int    levelsShiftRight = 10;
extern int    levelsLength     = 20;
extern color  levelsColor      = Silver;
extern int    levelsStyle      = STYLE_SOLID;

extern bool   alertsOn         = false;
extern bool   alertsOnCurrent  = true;
extern bool   alertsMessage    = true;
extern bool   alertsSound      = false;
extern bool   alertsEmail      = false;

//
//
//
//
//

double ellBuffer[];
double ellUBuffer[];
double ellDBuffer[];
double mauBuffer[];
double madBuffer[];
double peakUp[];
double peakDn[];
double trend[];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

int init()
{
   IndicatorBuffers(8);
   SetIndexBuffer(0,ellUBuffer); SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,ellDBuffer); SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(2,peakUp);     SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexBuffer(3,peakDn);     SetIndexStyle(3,DRAW_HISTOGRAM);
   SetIndexBuffer(4,mauBuffer);
   SetIndexBuffer(5,madBuffer);
   SetIndexBuffer(6,trend);
   SetIndexBuffer(7,ellBuffer); 
   IndicatorShortName("FPH_Oscillator ( "+shortPeriod+","+longPeriod+")");
   return(0);
}
int deinit() { deleteLines(); return(0); }

//
//
//
//
//

int start()
{
   double alpha     = 2.0/(1.0+longPeriod+MathCeil(shortPeriod/2.0));
   int counted_bars = IndicatorCounted();
   int limit,i,k;

   if(counted_bars < 0) return(-1);
   if(counted_bars > 0) counted_bars--;
           limit = MathMin(Bars-counted_bars,Bars-longPeriod);
        
   //
   //
   //
   //
   //

      int      count         = 0;
      int      direction     = 0;   
      int      startFrom     = 0;
      double   lastPeakPrice = 0;
      datetime lastPeakTime  = 0;
           for (;limit<(Bars-longPeriod); limit++)
               {
                  if (peakDn[limit]!=EMPTY_VALUE) { if (count==0) { count ++; continue; } direction=-1; startFrom = limit; break; }
                  if (peakUp[limit]!=EMPTY_VALUE) { if (count==0) { count ++; continue; } direction= 1; startFrom = limit; break; }
               }

   //
   //
   //
   //
   //
   
   for(i = limit; i >= 0; i--)
   {
      ellBuffer[i]  = iMA(NULL,0,shortPeriod,0,MODE_SMA,PRICE_MEDIAN,i)-iMA(NULL,0,longPeriod,0,MODE_SMA,PRICE_MEDIAN,i);
      ellUBuffer[i] = EMPTY_VALUE;
      ellDBuffer[i] = EMPTY_VALUE;

         if (mauBuffer[i+1]==EMPTY_VALUE) if (ellBuffer[i]>0) mauBuffer[i+1] = ellBuffer[i]; else  mauBuffer[i+1] = 0;
         if (madBuffer[i+1]==EMPTY_VALUE) if (ellBuffer[i]<0) madBuffer[i+1] = ellBuffer[i]; else  madBuffer[i+1] = 0;
            
      madBuffer[i] = madBuffer[i+1];
      mauBuffer[i] = mauBuffer[i+1];
      trend[i]     = trend[i+1];
      peakUp[i]    = EMPTY_VALUE;
      peakDn[i]    = EMPTY_VALUE;
         
      //
      //
      //
      //
      //
         
      if (ellBuffer[i] < 0) { madBuffer[i] = madBuffer[i+1]+alpha*(ellBuffer[i]-madBuffer[i+1]); ellDBuffer[i] = ellBuffer[i]; }
      if (ellBuffer[i] > 0) { mauBuffer[i] = mauBuffer[i+1]+alpha*(ellBuffer[i]-mauBuffer[i+1]); ellUBuffer[i] = ellBuffer[i]; }
         deleteLine(i);
         
         //
         //
         //
         //
         //
         
         if (ellBuffer[i] > 0 && ellBuffer[i]>mauBuffer[i])
         {
            if (direction < 0) { markLow(i,startFrom,lastPeakPrice,lastPeakTime); startFrom = i; k++; }
                direction = 1; trend[i] = 1;
         }
         if (ellBuffer[i] < 0 && ellBuffer[i]<madBuffer[i])
         {
            if (direction > 0) { markHigh(i,startFrom,lastPeakPrice,lastPeakTime); startFrom = i; k++; }
                direction = -1;  trend[i] = -1;
         }
   }
   if (direction > 0) markHigh(0,startFrom,lastPeakPrice,lastPeakTime); 
   if (direction < 0) markLow (0,startFrom,lastPeakPrice,lastPeakTime); 
   if (alertsOn)
   {
      if (alertsOnCurrent)
           int whichBar = 0;
      else     whichBar = 1;
      if (trend[whichBar] != trend[whichBar+1])
      {
         if (trend[whichBar] == 1) doAlert(whichBar,DoubleToStr(mauBuffer[whichBar],5)+" crossed up");
         if (trend[whichBar] ==-1) doAlert(whichBar,DoubleToStr(madBuffer[whichBar],5)+" crossed down");
      }         
   }      
      
   //
   //
   //
   //
   //
   
   return(0);      
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//
//
//
//
//

void markLow(int start, int end, double& lastPeakPrice, datetime& lastPeakTime)
{
   while (ellBuffer[start+1]>0 && start<Bars) start++;
   while (ellBuffer[end+1]  <0 && end  <Bars) end++;
   int peakAt = ArrayMinimum(Low,end-start+1,start); peakDn[peakAt] = ellBuffer[peakAt];
   
   //
   //
   //
   //
   //
   
   if (lastPeakPrice!=0) drawLine(lastPeakPrice,lastPeakTime,Low[peakAt],Time[peakAt]);
       lastPeakPrice = Low[peakAt];
       lastPeakTime  = Time[peakAt];
}
void markHigh(int start, int end, double& lastPeakPrice, datetime& lastPeakTime)
{
   while (ellBuffer[start+1]<0 && start<Bars) start++;
   while (ellBuffer[end+1]  >0 && end  <Bars) end++;
   int peakAt = ArrayMaximum(High,end-start+1,start); peakUp[peakAt] = ellBuffer[peakAt];
   
   //
   //
   //
   //
   //
   
   if (lastPeakPrice!=0) drawLine(lastPeakPrice,lastPeakTime,High[peakAt],Time[peakAt]);
       lastPeakPrice = High[peakAt];
       lastPeakTime  = Time[peakAt];
}

//
//
//
//
//

void drawLine(double startPrice, datetime startTime, double endPrice, datetime endTime)
{
   string name = linesIdentifier+":"+startTime;
      ObjectCreate(name,OBJ_TREND,0,startTime,startPrice,endTime,endPrice);
         ObjectSet(name,OBJPROP_STYLE,linesStyle);
         ObjectSet(name,OBJPROP_COLOR,linesColor);
         ObjectSet(name,OBJPROP_RAY,false);
}
void deleteLine(int i)
{
   ObjectDelete(linesIdentifier+":"+Time[i]);
}
void deleteLines()
{
   string lookFor = linesIdentifier+":";
   for (int i=ObjectsTotal(); i>=0; i--)
      {
         string name = ObjectName(i);
         if (StringFind(name,lookFor)==0) ObjectDelete(name);
      }
}

//+-------------------------------------------------------------------
//|                                                                  
//+-------------------------------------------------------------------
//
//
//
//
//

void doAlert(int forBar, string doWhat)
{
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;
   
   if (previousAlert != doWhat || previousTime != Time[forBar]) {
       previousAlert  = doWhat;
       previousTime   = Time[forBar];

       //
       //
       //
       //
       //

       message =  StringConcatenate(Symbol()," at ",TimeToStr(TimeLocal(),TIME_SECONDS)," Elliot oscillator level ",doWhat);
          if (alertsMessage) Alert(message);
          if (alertsEmail)   SendMail(StringConcatenate(Symbol(),"Elliot oscillator "),message);
          if (alertsSound)   PlaySound("alert2.wav");
   }
}

