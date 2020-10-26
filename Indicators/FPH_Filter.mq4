#property copyright "Copyright © 2013, ForexMT4Systems."
#property link      "http://www.forexmt4systems.com"

#property indicator_separate_window
#property indicator_buffers    5
#property indicator_color1     Green
#property indicator_color2     Gold
#property indicator_color3     Red
#property indicator_color4     DimGray
#property indicator_color5     Lime
#property indicator_width1     2
#property indicator_width2     2
#property indicator_width3     2
#property indicator_width4     2
#property indicator_width5     2
#property indicator_levelcolor Gold
#property indicator_level1     0

//
//
//
//
//

extern int    SF             = 5;
extern int    MomentumLength = 14;
extern int    Price          = PRICE_CLOSE;
extern double SmoothLength   = 5.0;
extern double SmoothPhase    = 0.0;
extern bool   SmoothDouble   = false;
extern double WP             = 3.00;

//
//
//
//
//

extern bool alertsOn              = true;
extern bool alertsSignalLineCross = true;
extern bool alertsOnCurrent       = false;
extern bool alertsMessage         = true;
extern bool alertsSound           = true;
extern bool alertsEmail           = false;

//
//
//
//
//

double buffer1[];
double buffer2[];
double Trend[];
double HistoU[];
double HistoM[];
double HistoD[];
double work[][6];

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

   IndicatorBuffers(6);
   SetIndexBuffer(0,HistoU); SetIndexStyle(0,DRAW_HISTOGRAM); SetIndexLabel(0, "FPH");
   SetIndexBuffer(1,HistoM); SetIndexStyle(1,DRAW_HISTOGRAM); SetIndexLabel(1, "FPH trend");
   SetIndexBuffer(2,HistoD); SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexBuffer(3,buffer1);SetIndexDrawBegin(3,MomentumLength);
   SetIndexBuffer(4,Trend);
   SetIndexBuffer(5,buffer2); 
   
   
   MomentumLength = MathMax(MomentumLength,1);
 
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

#define iEma 0
#define iEmm 1
#define iQqe 2
#define iPcm 3
#define tQqe 4
#define tQqs 5

//
//
//
//
//

int start()
{
   int counted_bars=IndicatorCounted();
   int i,r,limit;
   
   if(counted_bars < 0) return(-1);
   if(counted_bars > 0) counted_bars--;
           limit = MathMin(Bars-counted_bars,Bars-1);
           if (ArrayRange(work,0) != Bars) ArrayResize(work,Bars); 

   //
   //
   //
   //
   //

   double alpha1 = 2.0/(SF+1.0);
   double alpha2 = 2.0/(MomentumLength*2.0);
      
   for (i=limit, r=Bars-i-1; i>=0; i--,r++)
   {  
   
      buffer2[i] = iMA(NULL,0,1,0,MODE_SMA,Price,i);
      
      double sumMom = 0;
      double sumWgh = 0;
      for (int k=0; (i+k)<Bars && k<MomentumLength; k++)
      {
         double weight = MathSqrt(k+1);
               sumMom += (buffer2[i]-buffer2[i+k+1])/weight;
               sumWgh += weight;
      }
      if (sumWgh != 0)         
            buffer1[i] = iDSmooth(sumMom/sumWgh,SmoothLength,SmoothPhase,SmoothDouble,i,0);
         
      else  buffer1[i] = iDSmooth(0,            SmoothLength,SmoothPhase,SmoothDouble,i,0);
      
      work[r][iPcm] = work[r-1][iPcm] + alpha1* (buffer1[i]                            - work[r-1][iPcm]);
      work[r][iEma] = work[r-1][iEma] + alpha2*(MathAbs(work[r-1][iPcm]-work[r][iPcm]) - work[r-1][iEma]);
      work[r][iEmm] = work[r-1][iEmm] + alpha2*(work[r][iEma] - work[r-1][iEmm]);

      //
      //
      //
      //
      //

         double pcm0 = work[r  ][iPcm];
         double pcm1 = work[r-1][iPcm];
         double dar  = work[r  ][iEmm]*WP;
         double tr   = work[r-1][iQqe];
         double dv   = tr;
   
            if (pcm0 < tr) { tr = pcm0 + dar; if ((pcm1 < dv) && (tr > dv)) tr = dv; }
            if (pcm0 > tr) { tr = pcm0 - dar; if ((pcm1 > dv) && (tr < dv)) tr = dv; }
         
      //
      //
      //
      //
      //
         
         work[r][iQqe] = tr;
         work[r][tQqe] = work[r-1][tQqe];
         work[r][tQqs] = work[r-1][tQqs];
         buffer1[i]    = work[r][iPcm];
         Trend[i]      = tr;
         HistoU[i]     =  EMPTY_VALUE;
         HistoM[i]     =  EMPTY_VALUE;
         HistoD[i]     =  EMPTY_VALUE;
   
         if (buffer1[i] > 0)                                       HistoU[i] = buffer1[i];
         if (buffer1[i] < 0)                                       HistoD[i] = buffer1[i];
         if (HistoU[i] == EMPTY_VALUE && HistoD[i] == EMPTY_VALUE) HistoM[i] = buffer1[i];

      //
      //
      //
      //
      //
               
         if (buffer1[i] > 0)        work[r][tQqe] =  1;
         if (buffer1[i] < 0)        work[r][tQqe] = -1;
         if (buffer1[i] > Trend[i]) work[r][tQqs] =  1;
         if (buffer1[i] < Trend[i]) work[r][tQqs] = -1;
   }    
   
   //
   //
   //
   //
   //
   
   if (alertsOn)
   {
      if (alertsOnCurrent)
           int whichBar = Bars-1;
      else     whichBar = Bars-2;

      //
      //
      //
      //
      //
         
      if (alertsSignalLineCross)
      {
         if (work[whichBar][tQqs] != work[whichBar-1][tQqs])
         {
            if (work[whichBar][tQqs] ==  1) doAlert(" FPH line crossed signal line UP");
            if (work[whichBar][tQqs] == -1) doAlert(" FPH line crossed signal line DOWN");
         }         
      }
      else
      {
         if (work[whichBar][tQqe] != work[whichBar-1][tQqe])
         {
            if (work[whichBar][tQqe] ==  1) doAlert(" FPH line crossed 0 line UP");
            if (work[whichBar][tQqe] == -1) doAlert(" FPH line crossed 0 line DOWN");
         }         
      }
   }
   
   //
   //
   //
   //
   //
   
   return(0);
}

//+-------------------------------------------------------------------
//|                                                                  
//+-------------------------------------------------------------------
//
//
//
//
//

void doAlert(string doWhat)
{
   static string   previousAlert="nothing";
   static datetime previousTime;
   string message;
   
   if (previousAlert != doWhat || previousTime != Time[0]) {
       previousAlert  = doWhat;
       previousTime   = Time[0];

       //
       //
       //
       //
       //

       message =  StringConcatenate(Symbol()," at ",TimeToStr(TimeLocal(),TIME_SECONDS)," FPH - ",doWhat);
          if (alertsMessage) Alert(message);
          if (alertsEmail)   SendMail(StringConcatenate(Symbol(),"FPH"),message);
          if (alertsSound)   PlaySound("alert2.wav");
   }
}

//+------------------------------------------------------------------
//|                                                                  
//+------------------------------------------------------------------
//
//
//
//
//

double wrk[][20];

#define bsmax  5
#define bsmin  6
#define volty  7
#define vsum   8
#define avolty 9

//
//
//
//
//

double iDSmooth(double price, double length, double phase, bool isDouble, int i, int s=0)
{
   if (isDouble)
         return (iSmooth(iSmooth(price,MathSqrt(length),phase,i,s),MathSqrt(length),phase,i,s+10));
   else  return (iSmooth(price,length,phase,i,s));
}

//
//
//
//
//

double iSmooth(double price, double length, double phase, int i, int s=0)
{
   if (length <=1) return(price);
   if (ArrayRange(wrk,0) != Bars) ArrayResize(wrk,Bars);
   
   int r = Bars-i-1; 
      if (r==0) { for(int k=0; k<7; k++) wrk[r][k+s]=price; for(; k<10; k++) wrk[r][k+s]=0; return(price); }

   //
   //
   //
   //
   //
   
      double len1   = MathMax(MathLog(MathSqrt(0.5*(length-1)))/MathLog(2.0)+2.0,0);
      double pow1   = MathMax(len1-2.0,0.5);
      double del1   = price - wrk[r-1][bsmax+s];
      double del2   = price - wrk[r-1][bsmin+s];
      double div    = 1.0/(10.0+10.0*(MathMin(MathMax(length-10,0),100))/100);
      int    forBar = MathMin(r,10);
	
         wrk[r][volty+s] = 0;
               if(MathAbs(del1) > MathAbs(del2)) wrk[r][volty+s] = MathAbs(del1); 
               if(MathAbs(del1) < MathAbs(del2)) wrk[r][volty+s] = MathAbs(del2); 
         wrk[r][vsum+s] =	wrk[r-1][vsum+s] + (wrk[r][volty+s]-wrk[r-forBar][volty+s])*div;
         
         //
         //
         //
         //
         //
   
         wrk[r][avolty+s] = wrk[r-1][avolty+s]+(2.0/(MathMax(4.0*length,30)+1.0))*(wrk[r][vsum+s]-wrk[r-1][avolty+s]);
            if (wrk[r][avolty+s] > 0)
               double dVolty = wrk[r][volty+s]/wrk[r][avolty+s]; else dVolty = 0;   
	               if (dVolty > MathPow(len1,1.0/pow1)) dVolty = MathPow(len1,1.0/pow1);
                  if (dVolty < 1)                      dVolty = 1.0;

      //
      //
      //
      //
      //
	        
   	double pow2 = MathPow(dVolty, pow1);
      double len2 = MathSqrt(0.5*(length-1))*len1;
      double Kv   = MathPow(len2/(len2+1), MathSqrt(pow2));

         if (del1 > 0) wrk[r][bsmax+s] = price; else wrk[r][bsmax+s] = price - Kv*del1;
         if (del2 < 0) wrk[r][bsmin+s] = price; else wrk[r][bsmin+s] = price - Kv*del2;
	
   //
   //
   //
   //
   //
      
      double R     = MathMax(MathMin(phase,100),-100)/100.0 + 1.5;
      double beta  = 0.45*(length-1)/(0.45*(length-1)+2);
      double alpha = MathPow(beta,pow2);

         wrk[r][0+s] = price + alpha*(wrk[r-1][0+s]-price);
         wrk[r][1+s] = (price - wrk[r][0+s])*(1-beta) + beta*wrk[r-1][1+s];
         wrk[r][2+s] = (wrk[r][0+s] + R*wrk[r][1+s]);
         wrk[r][3+s] = (wrk[r][2+s] - wrk[r-1][4+s])*MathPow((1-alpha),2) + MathPow(alpha,2)*wrk[r-1][3+s];
         wrk[r][4+s] = (wrk[r-1][4+s] + wrk[r][3+s]); 

   //
   //
   //
   //
   //

   return(wrk[r][4+s]);
}

