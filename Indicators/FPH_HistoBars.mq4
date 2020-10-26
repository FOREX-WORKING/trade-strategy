#property copyright "Copyright © 2013, ForexMT4Systems."
#property link      "http://www.forexmt4systems.com"

#property indicator_separate_window
#property indicator_buffers 3
#property indicator_color1 Green
#property indicator_color2 Green
#property indicator_color3 Red

extern bool soundAlerts = TRUE;
extern bool emailAlerts = FALSE;
int g_period_84 = 38;
double g_ibuf_88[];
double g_ibuf_92[];
double g_ibuf_96[];

int init() {
   if (ObjectType("lbl") != 23) ObjectDelete("lbl");
   if (ObjectFind("lbl") == -1) ObjectCreate("lbl", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSet("lbl", OBJPROP_XDISTANCE, 20);
   ObjectSet("lbl", OBJPROP_YDISTANCE, 20);
   SetIndexStyle(0, DRAW_HISTOGRAM);
   SetIndexBuffer(0, g_ibuf_88);
   SetIndexStyle(1, DRAW_HISTOGRAM);
   SetIndexBuffer(1, g_ibuf_92);
   SetIndexStyle(2, DRAW_HISTOGRAM);
   SetIndexBuffer(2, g_ibuf_96);
   return (0);
}

int deinit() {
   ObjectDelete("lbl");
   return (0);
}

int start() {
   double ld_16;
   if (ObjectType("lbl") != 23) ObjectDelete("lbl");
   if (ObjectFind("lbl") == -1) ObjectCreate("lbl", OBJ_LABEL, 0, Time[5], Close[5]);
   ObjectSet("lbl", OBJPROP_XDISTANCE, 20);
   ObjectSet("lbl", OBJPROP_YDISTANCE, 20);
   double l_iatr_0 = iATR(Symbol(), 0, 50, 1);
   double ld_8 = 0;
   for (int li_24 = 0; li_24 < Bars; li_24++) {
      ld_8 = iMA(Symbol(), 0, g_period_84, 0, MODE_SMA, PRICE_CLOSE, li_24) - iMA(Symbol(), 0, g_period_84, 0, MODE_SMA, PRICE_CLOSE, li_24 + 1);
      ld_8 += iMA(Symbol(), 0, g_period_84, 0, MODE_SMA, PRICE_CLOSE, li_24 + 1) - iMA(Symbol(), 0, g_period_84, 0, MODE_SMA, PRICE_CLOSE, li_24 + 2);
      ld_8 /= 2.0;
      g_ibuf_88[li_24] = ld_8;
      g_ibuf_92[li_24] = EMPTY_VALUE;
      g_ibuf_96[li_24] = EMPTY_VALUE;
   }
   for (li_24 = 0; li_24 < Bars; li_24++) {
      if (g_ibuf_88[li_24] > 0.0) g_ibuf_92[li_24] = g_ibuf_88[li_24];
      else g_ibuf_96[li_24] = g_ibuf_88[li_24];
   }
   if (g_ibuf_92[1] != EMPTY_VALUE && g_ibuf_92[2] == EMPTY_VALUE && High[0] == Low[0] && High[0] == Close[0] && High[0] == Low[0]) {
      ld_16 = Low[1] - l_iatr_0;
      if (soundAlerts) Alert("Long trade at " + Symbol() + "! Stop Loss at " + ld_16);
      if (emailAlerts) SendMail("Long trade at " + Symbol() + "!", "Long trade at " + Symbol() + "! Stop Loss at " + ld_16);
   }
   if (g_ibuf_96[1] != EMPTY_VALUE && g_ibuf_96[2] == EMPTY_VALUE && High[0] == Low[0] && High[0] == Close[0] && High[0] == Low[0]) {
      ld_16 = High[1] + l_iatr_0;
      if (soundAlerts) Alert("Short trade at " + Symbol() + "! Stop Loss at " + ld_16);
      if (emailAlerts) SendMail("Short trade at " + Symbol() + "!", "Short trade in at " + Symbol() + "! Stop Loss at " + ld_16);
   }
   return (0);
}