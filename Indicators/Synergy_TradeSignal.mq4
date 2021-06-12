/*
   Generated by EX4-TO-MQ4 decompiler V4.0.220.2c []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright � 2008, Dean Malone"
#property link      "www.compassfx.com"

#property indicator_chart_window
#property indicator_buffers 6
#property indicator_color1 DeepSkyBlue
#property indicator_color2 Violet
#property indicator_color3 Yellow
#property indicator_color4 Yellow
#property indicator_color5 Blue
#property indicator_color6 Gray

int gi_76 = -1;
double gda_80[];
double gda_84[10];
string gsa_88[10];
string gsa_92[10];
int gi_96;
string Custom_Indicator = "Synergy Trade Signal";
string Copyright = "� 2008, Dean Malone";
string Web_Address = "www.compassfx.com";
string label = "--Login Information--";
string EMail = "";
string Password = "";
string Enable_Alert = "On";
string Enable_Display = "Off";
color Display_Color = White;
int Display_Corner = 2;
string Display_Corner_Help = "Enter 0, 1, 2, or 3 to change corners";
string Yellow_Arrows = "Off";
string Dynamic_S_R = "Off";
string Range_Factor = "On";
string PAC_Surf = "Off";
string Fast_TDI = "Off";
double MyRangeFactor = 0.0;
double MyVolatility = 0.0;
string RangeFactor_Help = "If MyRangeFactor = 0.0 - Defaults = (M1=0.01,M5=0.02,M15=0.04,M30=0.06,H1=0.08,H4=0.14,D1=0.4)";
string Volatility_Help = "If MyVolatility = 0.0 - Defaults = (M1=0.0001,M5=0.0002,M15=0.0004,M30=0.0006,H1=0.0008,H4=0.0014,D1=0.005)";
double gd_252;
double gd_260;
int gi_268 = 2;
int gi_272 = 80;
double gda_276[];
double gda_280[];
double gda_284[];
double gda_288[];
double gd_292;
double gd_300;
double gd_308;
double gd_316;
double gd_340;
double gd_348;
double gd_356;
double gd_380;
double gd_388;
double gd_396;
double gd_404;
double gd_468 = 500.0;
double gd_476;
double gd_484;
double gd_492;
double gd_500;
double gda_508[];
double gda_512[];
double gda_516[5];
double gda_520[5];
double gda_524[5];
int gi_528 = 0;
bool gi_532 = TRUE;
bool gi_536 = TRUE;
bool gi_540 = TRUE;
bool gi_544 = FALSE;
bool gi_548 = TRUE;
bool gi_552 = TRUE;
bool gi_556 = TRUE;
bool gi_560;
bool gi_564;
bool gi_568 = FALSE;
int gi_572;
bool gi_576 = FALSE;
string gs_580;
int gi_588 = 5;
int gi_592 = 15;
int gi_596 = 10;
int gi_600 = 12;
double gd_604 = 0.0;
double gd_612 = 0.0;
int gt_620 = -1;
string gs_624;
string gs_632;
int gi_640;
bool gi_644;
int gi_648;
int gi_652;
string gs_656 = "http://www.synergyforex.com/server/server2/";
string gs_664 = "http://www.compassfx.com/server/";
string gs_672;
int gi_680 = -1;
double gda_684[];
double gda_688[];
double gda_692[];
double gda_696[];
double gda_700[];
double gda_704[];
double gda_708[];
double gda_712[];
double gd_716;
double gd_724;
double gd_732;
double gd_740;
string gs_dummy_748;
int gi_756;
string gs_760;
string gs_768;
int gi_776 = 80;
int gt_780 = 0;
int gi_784 = 0;


bool NewBarEntry(int ai_0) {
   datetime lt_4 = Time[ai_0];
   if (gt_780 < lt_4) {
      gt_780 = lt_4;
      return (TRUE);
   } else return (FALSE);
}

string PeriodString() {
   string ls_0 = "no info";
   switch (Period()) {
   case PERIOD_MN1:
      ls_0 = " on monthly chart";
      break;
   case PERIOD_W1:
      ls_0 = " on weekly chart";
      break;
   case PERIOD_D1:
      ls_0 = " on daily chart";
      break;
   case PERIOD_H4:
      ls_0 = " on 4-hour chart";
      break;
   case PERIOD_H1:
      ls_0 = " on 1-hour chart";
      break;
   case PERIOD_M30:
   case PERIOD_M15:
   case PERIOD_M5:
   case PERIOD_M1:
      ls_0 = " on " + Period() + "-minute chart";
   }
   return (ls_0);
}

int deinit() {
   ObjectDelete("alert_status");
   ObjectDelete("alert_title");
   ObjectDelete("dsr_status");
   ObjectDelete("dsr_title");
   ObjectDelete("rf_status");
   ObjectDelete("rf_title");
   ObjectDelete("tdi_status");
   ObjectDelete("tdi_title");
   ObjectDelete("ts_title");
   ObjectDelete("ylw_status");
   ObjectDelete("ylw_title");
   ObjectDelete("pac_title");
   ObjectDelete("pac_status");
   return (0);
}

int init() {
   string ls_4;
   string ls_12;
   string ls_20;
   string ls_28;
   string ls_36;
   string ls_44;
   string ls_52;
  // resetIndy();
   if (Custom_Indicator == "verInfo_AS") {
      SetIndexBuffer(0, gda_80);
      return (0);
   }
   if (Copyright == "Inertia_09374987" || Copyright == "5394834" || Copyright == "1032612") {
      IndicatorBuffers(8);
      SetIndexBuffer(0, gda_684);
      SetIndexStyle(0, DRAW_HISTOGRAM, STYLE_SOLID, 4);
      SetIndexLabel(0, "Buy Pressure");
      SetIndexEmptyValue(0, 0.0);
      SetIndexBuffer(1, gda_688);
      SetIndexStyle(1, DRAW_HISTOGRAM, STYLE_SOLID, 4);
      SetIndexLabel(1, "Neutral Pressure");
      SetIndexEmptyValue(1, 0.0);
      SetIndexBuffer(2, gda_692);
      SetIndexStyle(2, DRAW_HISTOGRAM, STYLE_SOLID, 4);
      SetIndexLabel(2, "Red Pressure");
      SetIndexEmptyValue(2, 0.0);
      SetIndexStyle(3, DRAW_NONE);
      SetIndexEmptyValue(3, 0.0);
      SetIndexBuffer(3, gda_696);
      SetIndexStyle(4, DRAW_NONE);
      SetIndexEmptyValue(4, 0.0);
      SetIndexBuffer(4, gda_700);
      SetIndexStyle(5, DRAW_NONE);
      SetIndexEmptyValue(5, 0.0);
      SetIndexBuffer(5, gda_704);
      SetIndexStyle(6, DRAW_NONE);
      SetIndexBuffer(6, gda_708);
      SetIndexStyle(7, DRAW_NONE);
      SetIndexBuffer(7, gda_712);
   }
   if (Copyright != "98w34988suesdfe" && (Copyright != "Inertia_09374987" && Copyright != "5394834" && Copyright != "1032612")) {
      /*if (!IsDllsAllowed()) {
         Alert("WARNING: Must allow DLL imports. Go to Tools > Options > Expert Advisors and check \"Allow DLL imports\".");
         gi_576 = TRUE;
         return (0);
      }*/
      switch (Period()) {
      case PERIOD_MN1:
         gd_260 = 0.005;
         gd_252 = 0.5;
         break;
      case PERIOD_W1:
         gd_260 = 0.005;
         gd_252 = 0.5;
         break;
      case PERIOD_D1:
         gd_260 = 0.005;
         gd_252 = 0.4;
         break;
      case PERIOD_H4:
         gd_260 = 0.0014;
         gd_252 = 0.14;
         break;
      case PERIOD_H1:
         gd_260 = 0.0008;
         gd_252 = 0.08;
         break;
      case PERIOD_M30:
         gd_260 = 0.0006;
         gd_252 = 0.06;
         break;
      case PERIOD_M15:
         gd_260 = 0.0004;
         gd_252 = 0.04;
         break;
      case PERIOD_M5:
         gd_260 = 0.0002;
         gd_252 = 0.02;
         break;
      case PERIOD_M1:
         gd_260 = 0.0001;
         gd_252 = 0.01;
      }
      if (Digits < 4) gd_260 = 100.0 * gd_260;
      if (MyVolatility != 0.0) gd_260 = MyVolatility;
      if (MyRangeFactor != 0.0) gd_252 = MyRangeFactor;
      IndicatorBuffers(6);
      SetIndexStyle(0, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(0, 233);
      SetIndexBuffer(0, gda_276);
      SetIndexStyle(1, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(1, 234);
      SetIndexBuffer(1, gda_280);
      SetIndexStyle(2, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(2, 233);
      SetIndexBuffer(2, gda_508);
      SetIndexStyle(3, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(3, 234);
      SetIndexBuffer(3, gda_512);
      SetIndexStyle(4, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(4, 159);
      SetIndexBuffer(4, gda_284);
      SetIndexStyle(5, DRAW_ARROW, STYLE_SOLID, 0);
      SetIndexArrow(5, 159);
      SetIndexBuffer(5, gda_288);
      IndicatorShortName("Synergy_TradeSignal");
      gi_576 = FALSE;
      if (gi_576 == FALSE) {
         ls_4 = strToUpper(Dynamic_S_R);
         ls_12 = strToUpper(Range_Factor);
         ls_20 = strToUpper(Yellow_Arrows);
         ls_28 = strToUpper(Fast_TDI);
         ls_36 = strToUpper(Enable_Alert);
         ls_44 = strToUpper(Enable_Display);
         ls_52 = strToUpper(PAC_Surf);
         if (StringFind(ls_52, "ON") != -1) gi_556 = TRUE;
         else gi_556 = FALSE;
         if (StringFind(ls_44, "ON") != -1) gi_552 = TRUE;
         else gi_552 = FALSE;
         if (StringFind(ls_4, "ON") != -1) gi_532 = TRUE;
         else gi_532 = FALSE;
         if (StringFind(ls_12, "ON") != -1) gi_536 = TRUE;
         else gi_536 = FALSE;
         if (StringFind(ls_20, "ON") != -1) gi_540 = TRUE;
         else gi_540 = FALSE;
         if (StringFind(ls_28, "ON") != -1) gi_544 = TRUE;
         else gi_544 = FALSE;
         if (StringFind(ls_36, "ON") != -1) gi_548 = TRUE;
         else gi_548 = FALSE;
         if (gi_544) {
            gi_532 = FALSE;
            gi_536 = FALSE;
         }
         
         if (/*Copyright != "987987987eee98797" && */gi_552) 
            drawHUD(gi_532, gi_536, gi_540, gi_544, gi_548, gi_556);
         gi_576 = true;
      }
   } else SetIndexBuffer(0, gda_276);
   
   return (0);
}

int start() {
  // if (gi_576) return (0);
   if (Custom_Indicator == "verInfo_AS") {
      gda_80[0] = 2.02;
      return (0);
   }
   if (Copyright == "Inertia_09374987" || Copyright == "5394834" || Copyright == "1032612") {
      myInertia();
      return (0);
   }
   if (Copyright == "98w34988suesdfe") {
      gda_276[0] = 14325.112;
      return (0);
   }
   if (Copyright != "98w34988suesdfe" && !gi_568) {
      gi_568 = TRUE;
      gs_580 = "Synergy_TradeSignal";
   }
 /*  if (!gi_576) {
      if (GlobalVariableCheck("aSyn")) {
         gi_648 = GlobalVariableGet("aSyn");
         gi_652 = TimeLocal();
         if (gi_648 > gi_652) {
            gi_576 = mylogin(gs_624, gs_632);
            if (gi_680 == 1) {
               gi_576 = mylogin(gs_624, gs_632);
               gi_680 = -1;
            }
            if (gi_576) return (0);
         }
         if (gi_652 - gi_648 >= 1800) {
            gi_576 = mylogin(gs_624, gs_632);
            if (gi_680 == 1) {
               gi_576 = mylogin(gs_624, gs_632);
               gi_680 = -1;
            }
            if (gi_576) return (0);
         }
         if (gi_652 - gi_648 > gi_776) {
            gi_576 = mykeepalive();
            if (gi_680 == 1) {
               gi_576 = mykeepalive();
               gi_680 = -1;
            }
            if (gi_576) return (0);
         }
      } else {
         resetIndy();
         gi_576 = TRUE;
         return (0);
      }
   }*/
   int li_4 = IndicatorCounted();
   if (li_4 < 0) return (-1);
   int li_8 = Bars - li_4;
   if (li_8 > Bars - 34 - 1) li_8 = Bars - 34 - 1;
   else li_8--;
   if (Copyright == "987987987eee98797" && li_8 > 50) li_8 = 50;
   for (int li_12 = li_8; li_12 >= 0; li_12--) {
      gd_292 = iCustom(NULL, 0, "Synergy_HeikenAshi", "", 2, li_12);
      gd_300 = iCustom(NULL, 0, "Synergy_HeikenAshi", "", 3, li_12);
      gd_308 = iCustom(NULL, 0, "Synergy_HeikenAshi", "", 1, li_12);
      gd_316 = iCustom(NULL, 0, "Synergy_HeikenAshi", "", 0, li_12);
      if (!gi_544) {
         gd_340 = iCustom(NULL, 0, "Synergy_TDI", "", "", 4, li_12);
         gd_348 = iCustom(NULL, 0, "Synergy_TDI", "", "", 5, li_12);
         gd_356 = iCustom(NULL, 0, "Synergy_TDI", "", "", 2, li_12);
      } else {
         gd_340 = iCustom(NULL, 0, "Synergy_TDI", "", "987349873498734", "", "", "", "", "", 4, li_12);
         gd_348 = iCustom(NULL, 0, "Synergy_TDI", "", "987349873498734", "", "", "", "", "", 5, li_12);
         gd_356 = iCustom(NULL, 0, "Synergy_TDI", "", "987349873498734", "", "", "", "", "", 2, li_12);
      }
      if (gi_540) {
         gd_484 = iCustom(NULL, 0, "Synergy_TradeSignal", "", "Inertia_09374987", 0, li_12);
         gd_500 = iCustom(NULL, 0, "Synergy_TradeSignal", "", "Inertia_09374987", 1, li_12);
         gd_492 = iCustom(NULL, 0, "Synergy_TradeSignal", "", "Inertia_09374987", 2, li_12);
      }
      gd_396 = iCustom(NULL, 0, "Synergy_DSR", "", 2, li_12);
      gd_380 = NormalizeDouble(iMA(NULL, 0, 5, 0, MODE_SMMA, PRICE_HIGH, li_12), Digits);
      gd_388 = NormalizeDouble(iMA(NULL, 0, 5, 0, MODE_SMMA, PRICE_LOW, li_12), Digits);
      gd_404 = NormalizeDouble(iStdDev(NULL, 0, 7, 0, MODE_SMA, PRICE_CLOSE, li_12), Digits);
      gd_476 = iCustom(NULL, 0, "Synergy_RangeFactor", "", 0, li_12);
      if (gd_292 < gd_300 && gd_308 > gd_316 && (gi_532 && gd_300 >= gd_396) || !gi_532 && gd_300 > gd_380 && gd_340 > gd_348 && gd_340 > gd_356 && gd_340 > 50.0 && gd_404 > gd_260 &&
         (gi_536 && gd_476 > gd_252) || !gi_536) {
         if (gi_540) {
            if (gda_276[li_12] != EMPTY_VALUE && gd_500 != 0.0 || gd_492 != 0.0) {
               gda_508[li_12] = gd_388 - (gd_380 - gd_388) / 2.0;
               gda_276[li_12] = EMPTY_VALUE;
            } else {
               if (gda_508[li_12] != EMPTY_VALUE && gd_484 != 0.0) {
                  gda_276[li_12] = gd_388 - (gd_380 - gd_388) / 2.0;
                  gda_508[li_12] = EMPTY_VALUE;
               }
            }
         }
         if (gi_556) {
            if (gda_508[li_12] != EMPTY_VALUE || gda_276[li_12] != EMPTY_VALUE) {
               if (gd_292 >= gd_380 - gi_268 * Point && gd_300 <= gd_380 - gi_268 * Point) {
                  gda_284[li_12] = EMPTY_VALUE;
                  gda_288[li_12] = gd_388 - 0.8 * (gd_380 - gd_388);
               }
            }
         }
         if (NewBarEntry(li_12)) {
            if (gi_540) {
               if (gd_500 != 0.0) gda_508[li_12] = gd_388 - (gd_380 - gd_388) / 2.0;
               else gda_276[li_12] = gd_388 - (gd_380 - gd_388) / 2.0;
            } else gda_276[li_12] = gd_388 - (gd_380 - gd_388) / 2.0;
            gi_784 = 1;
            if (gi_556 && gd_292 >= gd_380 - gi_268 * Point && Copyright != "987987987eee98797") gda_284[li_12] = gd_388 - 0.8 * (gd_380 - gd_388);
            if (gi_548 && li_12 == 0 && Copyright != "987987987eee98797") Alert(Symbol() + ": Buy conditon @ " + DoubleToStr(Ask, Digits) + PeriodString());
         }
      }
      if (gd_292 > gd_300 && gd_316 > gd_308 && (gi_532 && gd_300 <= gd_396) || !gi_532 && gd_300 < gd_388 && gd_340 < gd_348 && gd_340 < gd_356 && gd_340 < 50.0 && gd_404 > gd_260 &&
         (gi_536 && gd_476 < (-gd_252)) || !gi_536) {
         if (gi_540) {
            if (gda_280[li_12] != EMPTY_VALUE && gd_500 != 0.0 || gd_484 != 0.0) {
               gda_512[li_12] = gd_380 + (gd_380 - gd_388) / 2.0;
               gda_280[li_12] = EMPTY_VALUE;
            } else {
               if (gda_512[li_12] != EMPTY_VALUE && gd_492 != 0.0) {
                  gda_280[li_12] = gd_380 + (gd_380 - gd_388) / 2.0;
                  gda_512[li_12] = EMPTY_VALUE;
               }
            }
         }
         if (gi_556) {
            if (gda_280[li_12] != EMPTY_VALUE || gda_512[li_12] != EMPTY_VALUE) {
               if (gd_292 <= gd_388 + gi_268 * Point && gd_300 >= gd_388 + gi_268 * Point) {
                  gda_284[li_12] = EMPTY_VALUE;
                  gda_288[li_12] = gd_380 + 0.8 * (gd_380 - gd_388);
               }
            }
         }
         if (NewBarEntry(li_12)) {
            if (gi_540) {
               if (gd_500 != 0.0) gda_512[li_12] = gd_380 + (gd_380 - gd_388) / 2.0;
               else gda_280[li_12] = gd_380 + (gd_380 - gd_388) / 2.0;
            } else gda_280[li_12] = gd_380 + (gd_380 - gd_388) / 2.0;
            gi_784 = -1;
            if (gi_556 && gd_292 <= gd_388 + gi_268 * Point && Copyright != "987987987eee98797") gda_284[li_12] = gd_380 + 0.8 * (gd_380 - gd_388);
            if (gi_548 && li_12 == 0 && Copyright != "987987987eee98797") Alert(Symbol() + ": Sell condition @ " + DoubleToStr(Bid, Digits) + PeriodString());
         }
      }
   }
   return (0);
}

int checkFilename() {
   double ld_0 = iCustom(NULL, 0, gs_580, "", "98w34988suesdfe", 0, 0);
   if (ld_0 != 14325.112) return (-1);
   else return (1);
}

string strToUpper(string as_0) {
   int li_24;
   string ls_8 = "";
   int li_16 = StringLen(as_0);
   for (int li_20 = 0; li_20 < li_16; li_20++) {
      li_24 = StringGetChar(as_0, li_20);
      if (li_24 >= 'a' && li_24 <= 'z') li_24 -= 32;
      ls_8 = StringSetChar(ls_8, li_20, li_24);
   }
   return (ls_8);
}

void drawHUD(bool ai_0, bool ai_4, bool ai_8, bool ai_12, bool ai_16, bool ai_20) {
   int li_24;
   if (Display_Corner > 3) Display_Corner = 0;
   if (Display_Corner != 1 && Display_Corner != 3) li_24 = gi_588 + gi_596;
   else li_24 = gi_588 + 40;
   ObjectCreate("ts_title", OBJ_LABEL, 0, 0, 0);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("ts_title", OBJPROP_YDISTANCE, gi_592);
   else ObjectSet("ts_title", OBJPROP_YDISTANCE, gi_592 + 6 * gi_600);
   ObjectSet("ts_title", OBJPROP_XDISTANCE, gi_588);
   ObjectSetText("ts_title", "  Trade like a BOSS", 9, "Tahoma", DodgerBlue);//Display_Color);
   ObjectSet("ts_title", OBJPROP_CORNER, Display_Corner);
   
   ObjectCreate("ylw_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ylw_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("ylw_title", OBJPROP_YDISTANCE, gi_592 + gi_600);
   else ObjectSet("ylw_title", OBJPROP_YDISTANCE, gi_592 + 5 * gi_600);
   ObjectSetText("ylw_title", "Yellow Arrows - ", 8, "Tahoma", Display_Color);
   ObjectSet("ylw_title", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("dsr_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("dsr_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("dsr_title", OBJPROP_YDISTANCE, gi_592 + gi_600 << 1);
   else ObjectSet("dsr_title", OBJPROP_YDISTANCE, gi_592 + 4 * gi_600);
   ObjectSetText("dsr_title", "Dynamic S/R - ", 8, "Tahoma", Display_Color);
   ObjectSet("dsr_title", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("rf_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("rf_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("rf_title", OBJPROP_YDISTANCE, gi_592 + 3 * gi_600);
   else ObjectSet("rf_title", OBJPROP_YDISTANCE, gi_592 + 3 * gi_600);
   ObjectSetText("rf_title", "Range Factor - ", 8, "Tahoma", Display_Color);
   ObjectSet("rf_title", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("pac_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("pac_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("pac_title", OBJPROP_YDISTANCE, gi_592 + gi_600 << 2);
   else ObjectSet("pac_title", OBJPROP_YDISTANCE, gi_592 + 2 * gi_600);
   ObjectSetText("pac_title", "PAC Surf - ", 8, "Tahoma", Display_Color);
   ObjectSet("pac_title", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("tdi_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("tdi_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("tdi_title", OBJPROP_YDISTANCE, gi_592 + 5 * gi_600);
   else ObjectSet("tdi_title", OBJPROP_YDISTANCE, gi_592 + gi_600);
   ObjectSetText("tdi_title", "Fast TDI - ", 8, "Tahoma", Display_Color);
   ObjectSet("tdi_title", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("alert_title", OBJ_LABEL, 0, 0, 0);
   ObjectSet("alert_title", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("alert_title", OBJPROP_YDISTANCE, gi_592 + 6 * gi_600);
   else ObjectSet("alert_title", OBJPROP_YDISTANCE, gi_592);
   ObjectSetText("alert_title", "Audible Alerts - ", 8, "Tahoma", Display_Color);
   ObjectSet("alert_title", OBJPROP_CORNER, Display_Corner);
   if (Display_Corner != 1 && Display_Corner != 3) li_24 = gi_588 + gi_596 + gi_272;
   else li_24 = gi_588 + gi_596;
  
   ObjectCreate("ylw_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("ylw_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("ylw_status", OBJPROP_YDISTANCE, gi_592 + gi_600);
   else ObjectSet("ylw_status", OBJPROP_YDISTANCE, gi_592 + 5 * gi_600);
   ObjectSetText("ylw_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("ylw_status", OBJPROP_CORNER, Display_Corner);
  
   ObjectCreate("dsr_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("dsr_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("dsr_status", OBJPROP_YDISTANCE, gi_592 + gi_600 << 1);
   else ObjectSet("dsr_status", OBJPROP_YDISTANCE, gi_592 + 4 * gi_600);
   ObjectSetText("dsr_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("dsr_status", OBJPROP_CORNER, Display_Corner);
 
   ObjectCreate("rf_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("rf_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("rf_status", OBJPROP_YDISTANCE, gi_592 + 3 * gi_600);
   else ObjectSet("rf_status", OBJPROP_YDISTANCE, gi_592 + 3 * gi_600);
   ObjectSetText("rf_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("rf_status", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("pac_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("pac_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("pac_status", OBJPROP_YDISTANCE, gi_592 + gi_600 << 2);
   else ObjectSet("pac_status", OBJPROP_YDISTANCE, gi_592 + 2 * gi_600);
   ObjectSetText("pac_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("pac_status", OBJPROP_CORNER, Display_Corner);

   ObjectCreate("tdi_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("tdi_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("tdi_status", OBJPROP_YDISTANCE, gi_592 + 5 * gi_600);
   else ObjectSet("tdi_status", OBJPROP_YDISTANCE, gi_592 + gi_600);
   ObjectSetText("tdi_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("tdi_status", OBJPROP_CORNER, Display_Corner);
 
   ObjectCreate("alert_status", OBJ_LABEL, 0, 0, 0);
   ObjectSet("alert_status", OBJPROP_XDISTANCE, li_24);
   if (Display_Corner == 0 || Display_Corner == 1) ObjectSet("alert_status", OBJPROP_YDISTANCE, gi_592 + 6 * gi_600);
   else ObjectSet("alert_status", OBJPROP_YDISTANCE, gi_592);
   ObjectSetText("alert_status", "ON", 8, "Tahoma", LimeGreen);
   ObjectSet("alert_status", OBJPROP_CORNER, Display_Corner);

   if (!ai_0) ObjectSetText("dsr_status", "OFF", 8, "Tahoma", Red);
   if (!ai_4) ObjectSetText("rf_status", "OFF", 8, "Tahoma", Red);
   if (!ai_8) ObjectSetText("ylw_status", "OFF", 8, "Tahoma", Red);
   if (!ai_12) ObjectSetText("tdi_status", "OFF", 8, "Tahoma", Red);
   if (!ai_16) ObjectSetText("alert_status", "OFF", 8, "Tahoma", Red);
   if (!ai_20) ObjectSetText("pac_status", "OFF", 8, "Tahoma", Red);
}

void myInertia() {
   gs_580 = "Synergy_TradeSignal";
   if (Copyright == "5394834") {
      Inertia_Typical();
      return;
   }
   if (Copyright == "1032612") {
      DM_HA_Mod();
      return;
   }
   int li_0 = IndicatorCounted();
   int li_4 = Bars - li_0;
   if (li_4 > 0) li_4--;
   if (li_4 >= 0) {
      for (int li_8 = li_4; li_8 >= 0; li_8--) {
         gd_716 = iCustom(NULL, 0, gs_580, "", "5394834", 3, li_8);
         gd_724 = iCustom(NULL, 0, gs_580, "", "5394834", 4, li_8);
         gd_732 = iCustom(NULL, 0, gs_580, "", "5394834", 5, li_8);
         gd_740 = iMA(Symbol(), 0, 5, 0, MODE_SMMA, PRICE_MEDIAN, li_8);
         gd_292 = iCustom(NULL, 0, gs_580, "", "1032612", 6, li_8);
         gd_300 = iCustom(NULL, 0, gs_580, "", "1032612", 7, li_8);
         gi_560 = FALSE;
         gi_564 = FALSE;
         if (gd_716 != 0.0 && gd_300 >= gd_740 && gd_300 > gd_292) {
            gda_684[li_8] = 1;
            gda_692[li_8] = 0;
            gi_560 = TRUE;
         }
         if (gd_732 != 0.0 && gd_300 <= gd_740 && gd_300 < gd_292) {
            gda_684[li_8] = 0;
            gda_692[li_8] = 1;
            gi_564 = TRUE;
         }
         if (gi_560 == FALSE && gi_564 == FALSE) {
            gda_688[li_8] = 1;
            gda_684[li_8] = 0;
            gda_692[li_8] = 0;
         } else gda_688[li_8] = 0;
      }
   }
}

void Inertia_Typical() {
   double ld_12;
   double ld_20;
   double ld_28;
   double ld_36;
   int li_0 = IndicatorCounted();
   int li_4 = Bars - li_0;
   if (li_4 > 0) li_4--;
   if (li_4 >= 0) {
      gd_604 = 0.2;
      gd_612 = 1.0 - gd_604;
      for (int li_8 = li_4; li_8 >= 0; li_8--) {
         if (gt_620 == -1 || gt_620 < Time[li_8]) {
            shiftBuffers();
            gt_620 = Time[li_8];
         }
         ld_12 = iMA(Symbol(), 0, 13, 0, MODE_EMA, PRICE_TYPICAL, li_8);
         ld_20 = iMA(Symbol(), 0, 13, 0, MODE_EMA, PRICE_TYPICAL, li_8 + 1);
         gda_516[0] = iMA(Symbol(), 0, 8, 0, MODE_EMA, PRICE_TYPICAL, li_8) - iMA(Symbol(), 0, 17, 0, MODE_EMA, PRICE_TYPICAL, li_8);
         gda_520[0] = gd_604 * gda_516[0] + gd_612 * gda_520[1];
         ld_28 = gda_516[0] - gda_520[0];
         ld_36 = gda_516[1] - gda_520[1];
         if (ld_12 > ld_20 && ld_28 > ld_36) gda_696[li_8] = 1;
         else gda_696[li_8] = 0.0;
         if (ld_12 < ld_20 && ld_28 < ld_36) gda_704[li_8] = 1;
         else gda_704[li_8] = 0.0;
         if (gda_696[li_8] == 0.0 && gda_704[li_8] == 0.0) gda_700[li_8] = 1;
         else gda_700[li_8] = 0.0;
      }
   }
}

void DM_HA_Mod() {
   double ld_0;
   double ld_24;
   if (Bars > 10) {
      gi_528 = IndicatorCounted();
      if (gi_528 >= 0) {
         if (gi_528 > 0) gi_528--;
         for (int li_32 = Bars - gi_528 - 1; li_32 >= 0; li_32--) {
            ld_24 = NormalizeDouble((Open[li_32] + High[li_32] + Low[li_32] + Close[li_32]) / 4.0, Digits);
            ld_24 = (ld_24 + Close[li_32]) / 2.0;
            ld_0 = NormalizeDouble((gda_708[li_32 + 1] + (gda_712[li_32 + 1])) / 2.0, Digits);
            gda_708[li_32] = ld_0;
            gda_712[li_32] = ld_24;
         }
      }
   }
}

void shiftBuffers() {
   gda_516[1] = gda_516[0];
   gda_516[0] = 0.0;
   gda_520[1] = gda_520[0];
   gda_520[0] = 0.0;
}



