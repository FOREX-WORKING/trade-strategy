/*
   Generated by EX4-TO-MQ4 decompiler V4.0.220.2c []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright � 2008, Dean Malone"
#property link      "www.compassfx.com"

#property indicator_separate_window
#property indicator_minimum -0.1
#property indicator_maximum 1.5
#property indicator_buffers 2
#property indicator_color1 Red
#property indicator_color2 DodgerBlue
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
extern string Custom_Indicator = "Continuation";
extern string Copyright = "� 2008, Dean Malone";
extern string Web_Address = "www.compassfx.com";
extern string label = "--Login Information--";
extern string EMail = "";
extern string Password = "";
extern string MA_Method_Help = "SMA=0, EMA=1";
extern int MA_Method = 0;
extern double MA_Period = 2.0;
double gda_168[];
double gda_172[];
double gda_176[];
double gda_180[];
int gi_184 = 0;
string gs_188;
string gs_196;
string gs_204;
string gs_212;
int gi_220;
int gi_224;
int gi_228;
bool gi_232 = FALSE;
int gi_236;
int gi_240;
bool gi_244 = FALSE;
string gs_248;
bool gi_256 = FALSE;
string gs_260 = "http://www.synergyforex.com/server/server2/";
string gs_268 = "http://www.compassfx.com/server/";
string gs_276;
int gi_284 = -1;
int gi_288 = 80;

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
   if (Custom_Indicator == "verInfo_AS") {
      IndicatorBuffers(1);
      SetIndexBuffer(0, gda_80);
      return (0);
   }
   if (Copyright != "98w34988suesdfe") {
      if (!IsDllsAllowed()) {
         Alert("WARNING: Must allow DLL imports. Go to Tools > Options > Expert Advisors and check \"Allow DLL imports\".");
         gi_244 = TRUE;
         return (0);
      }
      IndicatorShortName("Continuation | www.compassfx.com  ");
      IndicatorBuffers(4);
      SetIndexStyle(0, DRAW_HISTOGRAM);
      SetIndexStyle(1, DRAW_HISTOGRAM);
      SetIndexBuffer(0, gda_168);
      SetIndexBuffer(1, gda_172);
      SetIndexBuffer(2, gda_176);
      SetIndexBuffer(3, gda_180);
      SetIndexLabel(0, "Cont_Down");
      SetIndexLabel(1, "Cont_Up");
      SetIndexDrawBegin(0, 10);
      SetIndexDrawBegin(1, 10);
      gi_244 = FALSE;
      gi_240 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
      if (gi_240 < 1) {
         gi_232 = FALSE;
         if (isInstallerRunning() != 1) {
            gi_244 = TRUE;
            return (0);
         }
         runAutoInstaller();
         gi_244 = TRUE;
         return (0);
      }
      gs_188 = FileReadString(gi_240);
      gs_196 = FileReadString(gi_240);
      gi_220 = StrToInteger(FileReadString(gi_240));
      gs_276 = FileReadString(gi_240);
      FileClose(gi_240);
      gi_232 = TRUE;
      if (gs_276 == "") gs_276 = "x";
      gs_204 = gs_188;
      gs_212 = gs_196;
      if (GlobalVariableCheck("aSyn")) {
         gi_224 = GlobalVariableGet("aSyn");
         gi_228 = TimeLocal();
         if (gi_224 > gi_228) {
            gi_244 = mylogin(gs_188, gs_196);
            if (gi_284 == 1) {
               gi_244 = mylogin(gs_188, gs_196);
               gi_284 = -1;
            }
            if (gi_244) return (0);
         }
         if (gi_228 - gi_224 >= 1800) {
            gi_244 = mylogin(gs_188, gs_196);
            if (gi_284 == 1) {
               gi_244 = mylogin(gs_188, gs_196);
               gi_284 = -1;
            }
            if (gi_244) return (0);
         }
         if (gi_228 - gi_224 <= gi_288) return (0);
         gi_244 = mykeepalive();
         if (gi_284 == 1) {
            gi_244 = mykeepalive();
            gi_284 = -1;
         }
         if (!(gi_244)) return (0);
         return (0);
      }
      gi_244 = mylogin(gs_188, gs_196);
      if (gi_284 == 1) {
         gi_244 = mylogin(gs_188, gs_196);
         gi_284 = -1;
      }
      return (0);
   }
   SetIndexBuffer(0, gda_168);
   return (0);
}

int start() {
   double ld_4;
   double ld_12;
   double ld_20;
   double ld_28;
   double ld_36;
   double ld_44;
   double ld_52;
   double ld_60;
   //if (gi_244) return (0);
   if (Custom_Indicator == "verInfo_AS") {
      gda_80[0] = 2.02;
      return (0);
   }
   if (Copyright == "98w34988suesdfe") {
      gda_168[0] = 14325.112;
      return (0);
   }
   if (Copyright != "98w34988suesdfe" && !gi_256) {
      gi_256 = TRUE;
      gs_248 = "Synergy_Continuation";
   }
   if (!gi_244) {
      if (GlobalVariableCheck("aSyn")) {
         gi_224 = GlobalVariableGet("aSyn");
         gi_228 = TimeLocal();
         if (gi_224 > gi_228) {
            gi_244 = mylogin(gs_188, gs_196);
            if (gi_284 == 1) {
               gi_244 = mylogin(gs_188, gs_196);
               gi_284 = -1;
            }
            if (gi_244) return (0);
         }
         if (gi_228 - gi_224 >= 1800) {
            gi_244 = mylogin(gs_188, gs_196);
            if (gi_284 == 1) {
               gi_244 = mylogin(gs_188, gs_196);
               gi_284 = -1;
            }
            if (gi_244) return (0);
         }
         if (gi_228 - gi_224 > gi_288) {
            gi_244 = mykeepalive();
            if (gi_284 == 1) {
               gi_244 = mykeepalive();
               gi_284 = -1;
            }
            if (gi_244) return (0);
         }
      } else {
         resetIndy();
         gi_244 = TRUE;
         return (0);
      }
   }
   if (Bars <= 10) return (0);
   gi_184 = IndicatorCounted();
   if (gi_184 < 0) return (-1);
   if (gi_184 > 0) gi_184--;
   for (int li_68 = Bars - gi_184 - 1; li_68 >= 0; li_68--) {
      ld_4 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_CLOSE, li_68), Digits);
      ld_12 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_LOW, li_68), Digits);
      ld_20 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_OPEN, li_68), Digits);
      ld_28 = NormalizeDouble(iMA(NULL, 0, MA_Period, 0, MA_Method, PRICE_HIGH, li_68), Digits);
      ld_36 = NormalizeDouble((gda_176[li_68 + 1] + (gda_180[li_68 + 1])) / 2.0, Digits);
      ld_60 = NormalizeDouble((ld_4 + ld_28 + ld_20 + ld_12) / 4.0, Digits);
      ld_44 = MathMax(ld_28, MathMax(ld_36, ld_60));
      ld_52 = MathMin(ld_20, MathMin(ld_36, ld_60));
      if (ld_36 < ld_60) {
         gda_168[li_68] = 0;
         gda_172[li_68] = 1;
      } else {
         gda_168[li_68] = 1;
         gda_172[li_68] = 0;
      }
      gda_176[li_68] = ld_36;
      gda_180[li_68] = ld_60;
   }
   return (0);
}

int checkFilename() {
   double ld_0 = iCustom(NULL, 0, gs_248, "", "98w34988suesdfe", "", "", "", "", "", 0, 0, 0, 0);
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
         gi_244 = TRUE;
         return (1);
      }
      GlobalVariableDel("rA_synergy");
   }
   int li_32 = -1;
   string ls_44 = StringConcatenate(gs_260, "login_test.php");
   string ls_52 = StringConcatenate("user=", as_0, "&pass=", as_8, "&ver=2%2E1");
   string ls_60 = "";//gGrab(ls_44, ls_52);
   if (StringSubstr(ls_60, 0, 1) == "0") li_32 = 0;
   if (StringSubstr(ls_60, 0, 1) == "2") li_32 = 2;
   if (StringSubstr(ls_60, 0, 1) == "3") li_32 = 3;
   if (StringSubstr(ls_60, 0, 1) == "4") li_32 = 4;
   if (StringSubstr(ls_60, 0, 1) == "6") li_32 = 6;
   if (StringSubstr(ls_60, 0, 1) == "7") li_32 = 7;
   GlobalVariableDel("advSynSW");
   logResult("Continuation", li_32, " LOGIN");
   switch (li_32) {
   case 0:
      gi_244 = doLoginCheck(gs_260);
      if (gi_244) return (1);
      li_24 = StringFind(ls_60, "SVR=");
      li_28 = StringFind(ls_60, "DONE");
      li_40 = StringFind(ls_60, "zZD1");
      if (li_24 == -1) gs_276 = "x";
      else {
         if (li_28 == -1) gs_276 = "x";
         else gs_276 = StringSubstr(ls_60, li_24 + 4, li_28 - li_24 - 4);
      }
      gi_288 = StrToInteger(StringSubstr(ls_60, 4, li_40 - 4));
      if (gi_288 <= 0) gi_288 = 180;
      if (gi_288 >= 600) gi_288 = 600;
      gi_236 = TimeLocal();
      gs_204 = as_0;
      gs_212 = as_8;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_240 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_240 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_240, gs_188);
      FileWrite(gi_240, gs_196);
      FileWrite(gi_240, TimeLocal());
      FileWrite(gi_240, gs_276);
      FileClose(gi_240);
      return (0);
   case 7:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      gi_236 = TimeLocal();
      gs_204 = gs_188;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_240 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_240 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_240, gs_188);
      FileWrite(gi_240, gs_196);
      FileWrite(gi_240, TimeLocal());
      FileClose(gi_240);
      return (0);
   case 6:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      if (gi_232) FileDelete("advsynergy.bin");
      return (1);
   case 2:
      Alert("Incorrect EMail -- Please check your EMail address spelling.");
      if (gi_232) FileDelete("advsynergy.bin");
      return (1);
   case 3:
      Alert("Email OK -- Incorrect Password!\n Please check your password spelling\n and make sure Caps Lock is NOT on.");
      if (gi_232) FileDelete("advsynergy.bin");
      return (1);
   case 4:
      Alert("Your account has been disabled!\n Please contact support@compassfx.com");
      if (gi_232) FileDelete("advsynergy.bin");
      return (1);
   case -1:
      if (gs_276 != "x" && gs_276 != "" && gs_268 != gs_276) gs_268 = gs_276;
      if (gs_260 == gs_268) {
         if (IsConnected()) {
            Alert("Connection Error!\n An error connecting to the Internet has occurred.\n Please close MetaTrader and re-open.");
            resetIndy();
            return (1);
         }
         gi_96 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
         if (gi_96 < 1) return (1);
         FileClose(gi_96);
         gs_204 = as_0;
         gs_212 = as_8;
         GlobalVariableSet("aSyn", TimeLocal());
         return (0);
      }
      gs_260 = gs_268;
      gi_284 = 1;
      return (1);
   }
   return (0);
}

int mykeepalive() {
   int li_0 = -1;
   string ls_4 = StringConcatenate(gs_260, "keepalive_new.php");
   string ls_12 = StringConcatenate("user=", gs_204, "&pass=", gs_212);
   string ls_20 = "";//gGrab(ls_4, ls_12);
   if (StringSubstr(ls_20, 0, 1) == "0") li_0 = 0;
   if (StringSubstr(ls_20, 0, 1) == "1") li_0 = 1;
   if (StringSubstr(ls_20, 0, 1) == "2") li_0 = 2;
   if (StringSubstr(ls_20, 0, 1) == "3") li_0 = 3;
   if (StringSubstr(ls_20, 0, 1) == "4") li_0 = 4;
   if (StringSubstr(ls_20, 0, 1) == "5") li_0 = 5;
   if (li_0 != -1)
      if (GlobalVariableCheck("advSynSW")) GlobalVariableDel("advSynSW");
   logResult("MTF", li_0, DoubleToStr(GlobalVariableCheck("advSynSW"), 0) + " -- KEEPALIVE");
   switch (li_0) {
   case 1:
      gi_244 = mylogin(gs_204, gs_212);
      if (gi_284 == 1) {
         gi_244 = mylogin(gs_204, gs_212);
         gi_284 = -1;
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
      if (gs_276 != "x" && gs_276 != "" && gs_276 != gs_268) gs_268 = gs_276;
      if (gs_260 == gs_268) {
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
         gs_260 = gs_268;
         gi_284 = 1;
         return (1);
      }
      break;
   }
   GlobalVariableSet("aSyn", TimeLocal());
   return (0);
}

void resetIndy() {
   ArrayInitialize(gda_168, EMPTY_VALUE);
   ArrayInitialize(gda_172, EMPTY_VALUE);
   ArrayInitialize(gda_176, EMPTY_VALUE);
   ArrayInitialize(gda_180, EMPTY_VALUE);
   GlobalVariableDel("aSyn");
   GlobalVariableDel("advSynSW");
}
int isInstallerRunning(){
return(0);
}
void runAutoInstaller(){
}
int runAutoUpdater(){return(0);}
int isExeRunning(){return(0);}