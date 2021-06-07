/*
   Generated by EX4-TO-MQ4 decompiler V4.0.220.2c []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright � 2008, Dean Malone"
#property link      "www.compassfx.com"

#property indicator_separate_window
#property indicator_buffers 6
#property indicator_color1 Black
#property indicator_color2 MediumBlue
#property indicator_color3 Yellow
#property indicator_color4 MediumBlue
#property indicator_color5 Green
#property indicator_color6 Red
/*
#import "as2_updater.dll"
   int isExeRunning();
   int runAutoUpdater();
   int isInstallerRunning();
   int runAutoInstaller();
#import "Synergy.dll"
   string gGrab(string a0, string a1);
#import
*/
int gi_76 = -1;
double gda_80[];
double gda_84[10];
string gsa_88[10];
string gsa_92[10];
int gi_96;
extern string Custom_Indicator = "Traders Dynamic Index";
extern string Copyright = "� 2008, Dean Malone";
extern string Web_Address = "www.compassfx.com";
int gi_124 = 10;
int gi_128 = PRICE_TYPICAL;
extern string label = "--Login Information--";
extern string EMail = "";
extern string Password = "";
extern string TDI_Fast = "Off";
double gda_164[];
double gda_168[];
double gda_172[];
double gda_176[];
double gda_180[];
double gda_184[];
int gi_188;
bool gi_192 = FALSE;
string gs_196;
bool gi_204 = FALSE;
int gi_208;
string gs_212;
string gs_220;
string gs_228;
string gs_236;
int gi_244;
bool gi_248;
int gi_252;
int gi_256;
int gi_260 = 80;
string gs_264 = "http://www.synergyforex.com/server/server2/";
string gs_272 = "http://www.compassfx.com/server/";
string gs_280;
int gi_288 = -1;

int doLoginCheck(string as_0) {
   double lda_16[10];
   string lsa_20[10];
   string ls_24;
   bool li_8 = FALSE;
   int li_12 = FileOpen("indicators_debug.txt", FILE_CSV|FILE_READ, ",");
   if (li_12 != -1) {
      if (FileSize(li_12) > 100000) {
         FileClose(li_12);
         FileDelete("indicators_debug.txt");
      } else FileClose(li_12);
   }
   int li_44 = 0;
   bool li_48 = FALSE;
   ArrayInitialize(lda_16, 2.01);
   fillGlobalBuffers(as_0);
   int li_40 = openOutputFile();
   lda_16[0] = iCustom(NULL, 0, "Synergy_TradeSignal", "verInfo_AS", 0, 0);
   lsa_20[0] = "Synergy_TradeSignal";
   lda_16[1] = iCustom(NULL, 0, "Synergy_Continuation", "verInfo_AS", 0, 0);
   lsa_20[1] = "Synergy_Continuation";
   lda_16[2] = iCustom(NULL, 0, "Synergy_Volatility", "verInfo_AS", 0, 0);
   lsa_20[2] = "Synergy_Volatility";
   lda_16[3] = iCustom(NULL, 0, "Synergy_DSR", "verInfo_AS", 0, 0);
   lsa_20[3] = "Synergy_DSR";
   lda_16[4] = iCustom(NULL, 0, "Synergy_TDI", "verInfo_AS", 0, 0);
   lsa_20[4] = "Synergy_TDI";
   lda_16[5] = iCustom(NULL, 0, "Synergy_HeikenAshi", "verInfo_AS", 0, 0);
   lsa_20[5] = "Synergy_HeikenAshi";
   lda_16[6] = iCustom(NULL, 0, "Synergy_RangeFactor", "verInfo_AS", 0, 0);
   lsa_20[6] = "Synergy_RangeFactor";
   lda_16[7] = iCustom(NULL, 0, "Synergy_MTF", "verInfo_AS", 0, 0);
   lsa_20[7] = "Synergy_MTF";
   lda_16[8] = iCustom(NULL, 0, "Synergy_TradeTargets", "verInfo_AS", 0, 0);
   lsa_20[8] = "Synergy_TradeTargets";
   for (int li_32 = 0; li_32 < gi_76; li_32++) {
      for (int li_36 = 0; li_36 < 9; li_36++) {
         if (gsa_88[li_32] == lsa_20[li_36]) {
            li_8 = TRUE;
            Print("Indicator : ", lsa_20[li_36], " Value : ", lda_16[li_36], " Latest Version : ", gda_84[li_32]);
            if (lda_16[li_36] < gda_84[li_32]) {
               gsa_92[li_44] = gsa_88[li_32];
               li_44++;
               if (MathAbs(lda_16[li_36] - gda_84[li_32]) >= 0.05) {
                  li_48 = TRUE;
                  if (!GlobalVariableCheck("rA_synergy")) GlobalVariableSet("rA_synergy", 1);
               }
            }
         }
      }
      if (!li_8) {
         gsa_92[li_44] = gsa_88[li_32];
         li_44++;
      }
      li_8 = FALSE;
   }
   Print("-- Advanced Synergy Version Information --");
   Print("Files that need to be updated: ", li_44);
   if (li_44 > 0) Print("Executing AutoUpdater.exe now...");
   writeOutputFile(li_40, li_44);
   closeOutputFile(li_40, li_44);
   if (li_44 == 0) return (0);
   int li_52 = runAutoUpdater();
   if (li_48 == FALSE) return (0);
   return (1);
}

int openOutputFile() {
   bool li_4;
   FileDelete("as2_update.txt");
   int li_0 = FileOpen("as2_update.txt", FILE_WRITE);
   if (li_0 < 1) {
      Alert("Can not open as2_update.txt for writing!");
      li_4 = TRUE;
   } else li_4 = FALSE;
   if (li_4 == FALSE) return (li_0);
   else return (li_4);
}

void writeOutputFile(int ai_0, int ai_4) {
   FileWrite(ai_0, ai_4);
   for (int li_12 = 0; li_12 < ai_4; li_12++) FileWrite(ai_0, gsa_92[li_12] + ".ex4");
}

void closeOutputFile(int ai_0, int ai_4) {
   FileClose(ai_0);
}

void fillGlobalBuffers(string as_0) {
   string ls_8;
   string ls_16;
   string ls_24;
   int li_32 = -1;
   int li_40 = 0;
   string ls_44 = "";//gGrab(as_0 + "update.php", 0);
   FileDelete("temp.txt");
   int li_36 = FileOpen("temp.txt", FILE_WRITE|FILE_READ);
   if (li_36 < 1) {
      Alert("Can not open temp text file!");
      return;
   }
   Print(ls_44);
   FileWrite(li_36, ls_44);
   FileSeek(li_36, 0, SEEK_SET);
   gi_76 = StrToDouble(FileReadString(li_36));
   while (true) {
      ls_24 = FileReadString(li_36);
      if (StringFind(ls_24, "DONE") != -1) break;
      li_32 = StringFind(ls_24, ",", 0);
      ls_8 = StringSubstr(ls_24, 0, li_32);
      ls_16 = StringSubstr(ls_24, li_32 + 1, StringLen(ls_24) - li_32);
      gda_84[li_40] = StrToDouble(ls_16);
      gsa_88[li_40] = ls_8;
      li_40++;
      if (!(FileIsEnding(li_36))) continue;
      break;
   }
   FileClose(li_36);
}

void logResult(string as_0, int ai_8, string as_12) {
   int li_20 = FileOpen("indicators_debug.txt", FILE_CSV|FILE_WRITE|FILE_READ, ",");
   if (li_20 < 1) {
      Print("Cannot open indicators_debug.txt for appendage!");
      return;
   }
   if (FileSeek(li_20, 0, SEEK_END) == FALSE) {
      Print("Problem seeking to the end of the file! Aborting...");
      return;
   }
   FileWrite(li_20, as_0, TimeCurrent(), ai_8, as_12);
   FileClose(li_20);
}

int init() {
   string ls_0;
   if (Custom_Indicator == "verInfo_AS") {
      IndicatorBuffers(1);
      SetIndexBuffer(0, gda_80);
      return (0);
   }
   if (Copyright != "98w34988suesdfe") {
      if (Copyright == "987349873498734") {
         gi_124 = 8;
         gi_128 = 5;
      }
      if (!IsDllsAllowed()) {
         Alert("WARNING: Must allow DLL imports. Go to Tools > Options > Expert Advisors and check \"Allow DLL imports\".");
         gi_192 = TRUE;
         return (0);
      }
      IndicatorShortName("Traders Dynamic Index | www.compassfx.com  ");
      SetIndexBuffer(0, gda_164);
      SetIndexBuffer(1, gda_168);
      SetIndexBuffer(2, gda_172);
      SetIndexBuffer(3, gda_176);
      SetIndexBuffer(4, gda_180);
      SetIndexBuffer(5, gda_184);
      SetIndexStyle(0, DRAW_NONE);
      SetIndexStyle(1, DRAW_LINE);
      SetIndexStyle(2, DRAW_LINE, STYLE_SOLID, 2);
      SetIndexStyle(3, DRAW_LINE);
      SetIndexStyle(4, DRAW_LINE, STYLE_SOLID, 2);
      SetIndexStyle(5, DRAW_LINE, STYLE_SOLID, 2);
      SetIndexLabel(0, NULL);
      SetIndexLabel(1, "Upper Limit");
      SetIndexLabel(2, "Market Base Line");
      SetIndexLabel(3, "Lower Limit");
      SetIndexLabel(4, "RSI Price Line");
      SetIndexLabel(5, "Trade Signal Line");
      SetLevelValue(0, 50);
      SetLevelValue(1, 68);
      SetLevelValue(2, 32);
      SetLevelStyle(2, 1, Gray);
      ls_0 = strToUpper(TDI_Fast);
      if (StringFind(ls_0, "ON") != -1) {
         gi_124 = 8;
         gi_128 = 5;
      }
      gi_192 = FALSE;
      gi_188 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
      if (gi_188 < 1) {
         gi_248 = FALSE;
         if (isInstallerRunning() != 1) {
            gi_192 = TRUE;
            return (0);
         }
         runAutoInstaller();
         gi_192 = TRUE;
         return (0);
      }
      gs_228 = FileReadString(gi_188);
      gs_236 = FileReadString(gi_188);
      gi_244 = StrToInteger(FileReadString(gi_188));
      gs_280 = FileReadString(gi_188);
      if (gs_280 == "") gs_280 = "x";
      FileClose(gi_188);
      gi_248 = TRUE;
      gs_212 = gs_228;
      gs_220 = gs_236;
      if (GlobalVariableCheck("aSyn")) {
         gi_252 = GlobalVariableGet("aSyn");
         gi_256 = TimeLocal();
         if (gi_252 > gi_256) {
            gi_192 = mylogin(gs_228, gs_236);
            if (gi_288 == 1) {
               gi_192 = mylogin(gs_228, gs_236);
               gi_288 = -1;
            }
            if (gi_192) return (0);
         }
         if (gi_256 - gi_252 >= 900) {
            gi_192 = mylogin(gs_228, gs_236);
            if (gi_288 == 1) {
               gi_192 = mylogin(gs_228, gs_236);
               gi_288 = -1;
            }
            if (gi_192) return (0);
         }
         if (gi_256 - gi_252 <= gi_260) return (0);
         gi_192 = mykeepalive();
         if (gi_288 == 1) {
            gi_192 = mykeepalive();
            gi_288 = -1;
         }
         if (!(gi_192)) return (0);
         return (0);
      }
      gi_192 = mylogin(gs_228, gs_236);
      if (gi_288 == 1) {
         gi_192 = mylogin(gs_228, gs_236);
         gi_288 = -1;
      }
      return (0);
   } else SetIndexBuffer(0, gda_164);
   return (0);
}

int start() {
   double ld_4;
   double lda_12[];
   //if (gi_192) return (0);
   if (Custom_Indicator == "verInfo_AS") {
      gda_80[0] = 2.02;
      return (0);
   }
   if (Copyright == "98w34988suesdfe") {
      gda_164[0] = 14325.112;
      return (0);
   }
   if (Copyright != "98w34988suesdfe" && !gi_204) {
      gi_204 = TRUE;
      gs_196 = "Synergy_TDI";
   }
   if (!gi_192) {
      if (GlobalVariableCheck("aSyn")) {
         gi_252 = GlobalVariableGet("aSyn");
         gi_256 = TimeLocal();
         if (gi_252 > gi_256) {
            gi_192 = mylogin(gs_228, gs_236);
            if (gi_288 == 1) {
               gi_192 = mylogin(gs_228, gs_236);
               gi_288 = -1;
            }
            if (gi_192) return (0);
         }
         if (gi_256 - gi_252 >= 900) {
            gi_192 = mylogin(gs_228, gs_236);
            if (gi_288 == 1) {
               gi_192 = mylogin(gs_228, gs_236);
               gi_288 = -1;
            }
            if (gi_192) return (0);
         }
         if (gi_256 - gi_252 > gi_260) {
            gi_192 = mykeepalive();
            if (gi_288 == 1) {
               gi_192 = mykeepalive();
               gi_288 = -1;
            }
            if (gi_192) return (0);
         }
      } else {
         resetIndy();
         gi_192 = TRUE;
         return (0);
      }
   }
   ArrayResize(lda_12, 34);
   int li_16 = IndicatorCounted();
   int li_20 = Bars - li_16 - 1;
   for (int li_24 = li_20; li_24 >= 0; li_24--) {
      gda_164[li_24] = iRSI(NULL, 0, gi_124, gi_128, li_24);
      ld_4 = 0;
      for (int li_28 = li_24; li_28 < li_24 + 34; li_28++) {
         lda_12[li_28 - li_24] = gda_164[li_28];
         ld_4 += gda_164[li_28] / 34.0;
      }
      gda_168[li_24] = ld_4 + 1.6185 * StDev(lda_12, 34);
      gda_176[li_24] = ld_4 - 1.6185 * StDev(lda_12, 34);
      gda_172[li_24] = (gda_168[li_24] + gda_176[li_24]) / 2.0;
   }
   for (li_24 = li_20; li_24 >= 0; li_24--) {
      gda_180[li_24] = iMAOnArray(gda_164, 0, 2, 0, MODE_SMA, li_24);
      gda_184[li_24] = iMAOnArray(gda_164, 0, 7, 0, MODE_SMA, li_24);
   }
   return (0);
}

double StDev(double ada_0[], int ai_4) {
   return (MathSqrt(Variance(ada_0, ai_4)));
}

double Variance(double ada_0[], int ai_4) {
   double ld_8;
   double ld_16;
   for (int li_24 = 0; li_24 < ai_4; li_24++) {
      ld_8 += ada_0[li_24];
      ld_16 += MathPow(ada_0[li_24], 2);
   }
   return ((ld_16 * ai_4 - ld_8 * ld_8) / (ai_4 * (ai_4 - 1)));
}

int checkFilename() {
   double ld_0 = iCustom(NULL, 0, gs_196, "", "98w34988suesdfe", "", "", "", "", "", 0, 0);
   if (ld_0 != 14325.112) return (-1);
   else return (1);
}

int mylogin(string as_0, string as_8) {
   string ls_16;
   int li_24;
   int li_28;
   int li_40;
   if (GlobalVariableCheck("rA_synergy")) {
      if (isExeRunning() != 1) {
         gi_192 = TRUE;
         return (1);
      }
      GlobalVariableDel("rA_synergy");
   }
   int li_32 = -1;
   string ls_44 = StringConcatenate(gs_264, "login_test.php");
   string ls_52 = StringConcatenate("user=", as_0, "&pass=", as_8, "&ver=2%2E1");
   string ls_60 = "";//gGrab(ls_44, ls_52);
   if (StringSubstr(ls_60, 0, 1) == "0") li_32 = 0;
   if (StringSubstr(ls_60, 0, 1) == "2") li_32 = 2;
   if (StringSubstr(ls_60, 0, 1) == "3") li_32 = 3;
   if (StringSubstr(ls_60, 0, 1) == "4") li_32 = 4;
   if (StringSubstr(ls_60, 0, 1) == "6") li_32 = 6;
   if (StringSubstr(ls_60, 0, 1) == "7") li_32 = 7;
   GlobalVariableDel("advSynSW");
   logResult("TDI", li_32, " LOGIN");
   switch (li_32) {
   case 0:
      gi_192 = doLoginCheck(gs_264);
      if (gi_192) return (1);
      li_24 = StringFind(ls_60, "SVR=");
      li_28 = StringFind(ls_60, "DONE");
      li_40 = StringFind(ls_60, "zZD1");
      if (li_24 == -1) gs_280 = "x";
      else {
         if (li_28 == -1) gs_280 = "x";
         gs_280 = StringSubstr(ls_60, li_24 + 4, li_28 - li_24 - 4);
      }
      gi_260 = StrToInteger(StringSubstr(ls_60, 4, li_40 - 4));
      if (gi_260 <= 0) gi_260 = 180;
      if (gi_260 >= 600) gi_260 = 600;
      gi_208 = TimeLocal();
      gs_212 = as_0;
      gs_220 = as_8;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_188 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_188 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_188, gs_228);
      FileWrite(gi_188, gs_236);
      FileWrite(gi_188, TimeLocal());
      FileWrite(gi_188, gs_280);
      FileClose(gi_188);
      return (0);
   case 7:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      gi_208 = TimeLocal();
      gs_212 = gs_228;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_188 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_188 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_188, gs_228);
      FileWrite(gi_188, gs_236);
      FileWrite(gi_188, TimeLocal());
      FileClose(gi_188);
      return (0);
   case 6:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      if (gi_248) FileDelete("advsynergy.bin");
      return (1);
   case 2:
      Alert("Incorrect EMail -- Please check your EMail address spelling.");
      if (gi_248) FileDelete("advsynergy.bin");
      return (1);
   case 3:
      Alert("Email OK -- Incorrect Password!\n Please check your password spelling\n and make sure Caps Lock is NOT on.");
      if (gi_248) FileDelete("advsynergy.bin");
      return (1);
   case 4:
      Alert("Your account has been disabled!\n Please contact support@compassfx.com");
      if (gi_248) FileDelete("advsynergy.bin");
      return (1);
   case -1:
      if (gs_280 != "x" && gs_280 != "" && gs_272 != gs_280) gs_272 = gs_280;
      if (gs_264 == gs_272) {
         if (IsConnected()) {
            Alert("Connection Error!\n An error connecting to the Internet has occurred.\n Please close MetaTrader and re-open.");
            resetIndy();
            return (1);
         }
         gi_96 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
         if (gi_96 < 1) return (1);
         FileClose(gi_96);
         gs_212 = as_0;
         gs_220 = as_8;
         GlobalVariableSet("aSyn", TimeLocal());
         return (0);
      }
      gs_264 = gs_272;
      gi_288 = 1;
      return (1);
   }
   return (0);
}

int mykeepalive() {
   int li_0 = -1;
   string ls_4 = StringConcatenate(gs_264, "keepalive_new.php");
   string ls_12 = StringConcatenate("user=", gs_212, "&pass=", gs_220);
   string ls_20 = "";//gGrab(ls_4, ls_12);
   if (StringSubstr(ls_20, 0, 1) == "0") li_0 = 0;
   if (StringSubstr(ls_20, 0, 1) == "1") li_0 = 1;
   if (StringSubstr(ls_20, 0, 1) == "2") li_0 = 2;
   if (StringSubstr(ls_20, 0, 1) == "3") li_0 = 3;
   if (StringSubstr(ls_20, 0, 1) == "4") li_0 = 4;
   if (StringSubstr(ls_20, 0, 1) == "5") li_0 = 5;
   if (li_0 != -1)
      if (GlobalVariableCheck("advSynSW")) GlobalVariableDel("advSynSW");
   logResult("TDI", li_0, DoubleToStr(GlobalVariableCheck("advSynSW"), 0) + " -- KEEPALIVE");
   switch (li_0) {
   case 1:
      gi_192 = mylogin(gs_212, gs_220);
      if (gi_288 == 1) {
         gi_192 = mylogin(gs_212, gs_220);
         gi_288 = -1;
      }
      return (0);
   case 2:
      Alert("Your account has been logged into from a different computer.\n  This connection has been terminated.");
      resetIndy();
      return (1);
   case 3:
      Alert("Your username was not found in our database of logged in users.\n Please close indicators and re-open\n them to re-login.");
      resetIndy();
      return (1);
   case 4:
      Alert(StringSubstr(ls_20, 4, StringLen(ls_20)));
      GlobalVariableSet("aSyn", TimeLocal());
      break;
   case 5:
      Alert(StringSubstr(ls_20, 4, StringLen(ls_20)));
      resetIndy();
      return (1);
   case -1:
      if (gs_280 != "x" && gs_280 != "" && gs_280 != gs_272) gs_272 = gs_280;
      if (gs_264 == gs_272) {
         if (GlobalVariableCheck("advSynSW")) {
            if (TimeLocal() - GlobalVariableGet("advSynSW") <= 1200.0) break;
            if (IsConnected()) {
               Alert("Connection Error!\n An error connecting to the Internet has occurred.\n Please close MetaTrader and re-open.");
               resetIndy();
               return (1);
            }
            gi_96 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
            if (gi_96 < 1) return (1);
            FileClose(gi_96);
            return (0);
         }
         GlobalVariableSet("advSynSW", TimeLocal());
      } else {
         gs_264 = gs_272;
         gi_288 = 1;
         return (1);
      }
      break;
   }
   GlobalVariableSet("aSyn", TimeLocal());
   return (0);
}

void resetIndy() {
   ArrayInitialize(gda_164, EMPTY_VALUE);
   ArrayInitialize(gda_168, EMPTY_VALUE);
   ArrayInitialize(gda_172, EMPTY_VALUE);
   ArrayInitialize(gda_180, EMPTY_VALUE);
   ArrayInitialize(gda_184, EMPTY_VALUE);
   ArrayInitialize(gda_176, EMPTY_VALUE);
   GlobalVariableDel("aSyn");
   GlobalVariableDel("advSynSW");
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
int isInstallerRunning(){
return(0);
}
void runAutoInstaller(){
}
int runAutoUpdater(){return(0);}
int isExeRunning(){return(0);}