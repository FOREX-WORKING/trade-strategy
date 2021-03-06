/*
   Generated by EX4-TO-MQ4 decompiler V4.0.220.2c []
   Website: http://purebeam.biz
   E-mail : purebeam@gmail.com
*/
#property copyright "Copyright © 2008, Dean Malone"
#property link      "www.compassfx.com"

#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 DarkGreen
#property indicator_color2 FireBrick
#property indicator_color3 DarkGoldenrod
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
string Custom_Indicator = "sss";
string Copyright = "sss";
string Web_Address = "ssss";
string label = "ssss";
string EMail = "";
string Password = "";
double gda_148[];
double gda_152[];
double gda_156[];
double gda_160[];
double gda_164[];
int gi_168;
bool gi_172 = FALSE;
string gs_176;
bool gi_184 = FALSE;
int gi_188;
string gs_192;
string gs_200;
string gs_208;
string gs_216;
int gi_224;
int gi_228;
int gi_232;
bool gi_236 = FALSE;
string gs_240 = "-";
string gs_248 = "-";
string gs_256;
int gi_264 = -1;
int gi_268 = 80;

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
         gi_172 = TRUE;
         return (0);
      }
      IndicatorBuffers(5);
      SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
      SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
      SetIndexStyle(2, DRAW_LINE, STYLE_DOT, 1);
      SetIndexBuffer(0, gda_152);
      SetIndexBuffer(1, gda_148);
      SetIndexBuffer(2, gda_156);
      SetIndexBuffer(3, gda_160);
      SetIndexBuffer(4, gda_164);
      IndicatorShortName("Dynamic S/R | www.compassfx.com");
      SetIndexLabel(0, "Resistance");
      SetIndexLabel(1, "Support");
      SetIndexLabel(2, "S/R_Mean");
      SetIndexDrawBegin(0, 25);
      SetIndexDrawBegin(1, 25);
      SetIndexDrawBegin(2, 25);
      gi_172 = FALSE;
      gi_168 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
      if (gi_168 < 1) {
         if (isInstallerRunning() != 1) {
            gi_172 = TRUE;
            return (0);
         }
         runAutoInstaller();
         gi_172 = TRUE;
         return (0);
      }
      gs_192 = FileReadString(gi_168);
      gs_200 = FileReadString(gi_168);
      gi_224 = StrToInteger(FileReadString(gi_168));
      gs_256 = FileReadString(gi_168);
      if (gs_256 == "") gs_256 = "x";
      FileClose(gi_168);
      gi_236 = TRUE;
      gs_208 = gs_192;
      gs_216 = gs_200;
      if (GlobalVariableCheck("aSyn")) {
         gi_228 = GlobalVariableGet("aSyn");
         gi_232 = TimeLocal();
         if (gi_228 > gi_232) {
            gi_172 = mylogin(gs_192, gs_200);
            if (gi_264 == 1) {
               gi_172 = mylogin(gs_192, gs_200);
               gi_264 = -1;
            }
            if (gi_172) return (0);
         }
         if (gi_232 - gi_228 >= 1800) {
            gi_172 = mylogin(gs_192, gs_200);
            if (gi_264 == 1) {
               gi_172 = mylogin(gs_192, gs_200);
               gi_264 = -1;
            }
            if (gi_172) return (0);
         }
         if (gi_232 - gi_228 <= gi_268) return (0);
         gi_172 = mykeepalive();
         if (gi_264 == 1) {
            gi_172 = mykeepalive();
            gi_264 = -1;
         }
         if (!(gi_172)) return (0);
         return (0);
      }
      gi_172 = mylogin(gs_192, gs_200);
      if (gi_264 == 1) {
         gi_172 = mylogin(gs_192, gs_200);
         gi_264 = -1;
      }
      return (0);
   }
   SetIndexBuffer(0, gda_152);
   return (0);
}

int start() {
   //if (gi_172) return (0);
   if (Custom_Indicator == "verInfo_AS") {
      gda_80[0] = 2.02;
      return (0);
   }
   if (Copyright != "98w34988suesdfe" && !gi_184) {
      gi_184 = TRUE;
      gs_176 = "Synergy_DSR";
   }
   if (Copyright == "98w34988suesdfe") {
      gda_152[0] = 14325.112;
      return (0);
   }
   int li_4 = IndicatorCounted();
   if (Bars <= 25) return (0);
   if (!gi_172) {
      if (GlobalVariableCheck("aSyn")) {
         gi_228 = GlobalVariableGet("aSyn");
         gi_232 = TimeLocal();
         if (gi_228 > gi_232) {
            gi_172 = mylogin(gs_192, gs_200);
            if (gi_264 == 1) {
               gi_172 = mylogin(gs_192, gs_200);
               gi_264 = -1;
            }
            if (gi_172) return (0);
         }
         if (gi_232 - gi_228 >= 1800) {
            gi_172 = mylogin(gs_192, gs_200);
            if (gi_264 == 1) {
               gi_172 = mylogin(gs_192, gs_200);
               gi_264 = -1;
            }
            if (gi_172) return (0);
         }
         if (gi_232 - gi_228 > gi_268) {
            gi_172 = mykeepalive();
            if (gi_264 == 1) {
               gi_172 = mykeepalive();
               gi_264 = -1;
            }
            if (gi_172) return (0);
         }
      } else {
         resetIndy();
         gi_172 = TRUE;
         return (0);
      }
   }
   int li_8 = Bars - li_4;
   if (li_4 > 0) li_8++;
   else {
      gda_152[li_8] = High[li_8];
      gda_148[li_8] = Low[li_8];
   }
   for (int li_12 = 0; li_12 < li_8; li_12++) gda_160[li_12] = (High[iHighest(NULL, 0, MODE_HIGH, 3, li_12)] + Low[iLowest(NULL, 0, MODE_LOW, 3, li_12)] + Close[li_12]) / 3.0;
   for (li_12 = 0; li_12 < li_8; li_12++) gda_164[li_12] = iMAOnArray(gda_160, Bars, 25, 0, MODE_SMA, li_12);
   for (li_12 = li_8 - 1; li_12 >= 0; li_12--) {
      if (gda_160[li_12 + 1] > gda_164[li_12 + 1] && gda_160[li_12] < gda_164[li_12]) gda_152[li_12] = High[iHighest(NULL, 0, MODE_HIGH, 28, li_12)];
      else gda_152[li_12] = gda_152[li_12 + 1];
   }
   for (li_12 = li_8 - 1; li_12 >= 0; li_12--) {
      if (gda_160[li_12 + 1] < gda_164[li_12 + 1] && gda_160[li_12] > gda_164[li_12]) gda_148[li_12] = Low[iLowest(NULL, 0, MODE_LOW, 28, li_12)];
      else gda_148[li_12] = gda_148[li_12 + 1];
   }
   for (li_12 = 0; li_12 < li_8; li_12++) gda_156[li_12] = NormalizeDouble((gda_152[li_12] + gda_148[li_12]) / 2.0, Digits);
   return (0);
}

int checkFilename() {
   double ld_0 = iCustom(NULL, 0, gs_176, "", "98w34988suesdfe", "", "", "", "", 0, 0);
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
         gi_172 = TRUE;
         return (1);
      }
      GlobalVariableDel("rA_synergy");
   }
   int li_32 = -1;
   string ls_44 = StringConcatenate(gs_240, "login_test.php");
   string ls_52 = StringConcatenate("user=", as_0, "&pass=", as_8, "&ver=2%2E1");
   string ls_60 = "";//gGrab(ls_44, ls_52);
   if (StringSubstr(ls_60, 0, 1) == "0") li_32 = 0;
   if (StringSubstr(ls_60, 0, 1) == "2") li_32 = 2;
   if (StringSubstr(ls_60, 0, 1) == "3") li_32 = 3;
   if (StringSubstr(ls_60, 0, 1) == "4") li_32 = 4;
   if (StringSubstr(ls_60, 0, 1) == "6") li_32 = 6;
   if (StringSubstr(ls_60, 0, 1) == "7") li_32 = 7;
   GlobalVariableDel("advSynSW");
   logResult("DSR", li_32, " LOGIN");
   switch (li_32) {
   case 0:
      gi_172 = doLoginCheck(gs_240);
      if (gi_172) return (1);
      li_24 = StringFind(ls_60, "SVR=");
      li_28 = StringFind(ls_60, "DONE");
      li_40 = StringFind(ls_60, "zZD1");
      if (li_24 == -1) gs_256 = "x";
      else {
         if (li_28 == -1) gs_256 = "x";
         else gs_256 = StringSubstr(ls_60, li_24 + 4, li_28 - li_24 - 4);
      }
      gi_268 = StrToInteger(StringSubstr(ls_60, 4, li_40 - 4));
      if (gi_268 <= 0) gi_268 = 180;
      if (gi_268 >= 600) gi_268 = 600;
      gi_188 = TimeLocal();
      gs_208 = as_0;
      gs_216 = as_8;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_168 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_168 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_168, gs_192);
      FileWrite(gi_168, gs_200);
      FileWrite(gi_168, TimeLocal());
      FileWrite(gi_168, gs_256);
      FileClose(gi_168);
      return (0);
   case 7:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      gi_188 = TimeLocal();
      gs_208 = gs_192;
      GlobalVariableSet("aSyn", TimeLocal());
      gi_168 = FileOpen("advsynergy.bin", FILE_WRITE, 8);
      if (gi_168 < 1) {
         Print("Cannot open password cache!");
         return (0);
      }
      FileWrite(gi_168, gs_192);
      FileWrite(gi_168, gs_200);
      FileWrite(gi_168, TimeLocal());
      FileClose(gi_168);
      return (0);
   case 6:
      Alert(StringSubstr(ls_60, 4, StringLen(ls_60)));
      if (gi_236) FileDelete("advsynergy.bin");
      return (1);
   case 2:
      Alert("Incorrect EMail -- Please check your EMail address spelling.");
      if (gi_236) FileDelete("advsynergy.bin");
      return (1);
   case 3:
      Alert("Email OK -- Incorrect Password!\n Please check your password spelling\n and make sure Caps Lock is NOT on.");
      if (gi_236) FileDelete("advsynergy.bin");
      return (1);
   case 4:
      Alert("Your account has been disabled!\n Please contact support@compassfx.com");
      if (gi_236) FileDelete("advsynergy.bin");
      return (1);
   case -1:
      if (gs_256 != "x" && gs_256 != "" && gs_248 != gs_256) gs_248 = gs_256;
      if (gs_240 == gs_248) {
         if (IsConnected()) {
            Alert("Connection Error!\n An error connecting to the Internet has occurred.\n Please close MetaTrader and re-open.");
            resetIndy();
            return (1);
         }
         gi_96 = FileOpen("advsynergy.bin", FILE_CSV|FILE_READ);
         if (gi_96 < 1) return (1);
         FileClose(gi_96);
         gs_208 = as_0;
         gs_216 = as_8;
         GlobalVariableSet("aSyn", TimeLocal());
         return (0);
      }
      gs_240 = gs_248;
      gi_264 = 1;
      return (1);
   }
   return (0);
}

int mykeepalive() {
   int li_0 = -1;
   string ls_4 = StringConcatenate(gs_240, "keepalive_new.php");
   string ls_12 = StringConcatenate("user=", gs_208, "&pass=", gs_216);
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
      gi_172 = mylogin(gs_208, gs_216);
      if (gi_264 == 1) {
         gi_172 = mylogin(gs_208, gs_216);
         gi_264 = -1;
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
      if (GlobalVariableCheck("advSynSW")) {
         if (TimeLocal() - GlobalVariableGet("advSynSW") > 1200.0) {
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
      }
   }
   GlobalVariableSet("aSyn", TimeLocal());
   return (0);
}

void resetIndy() {
   ArrayInitialize(gda_152, EMPTY_VALUE);
   ArrayInitialize(gda_148, EMPTY_VALUE);
   ArrayInitialize(gda_156, EMPTY_VALUE);
   ArrayInitialize(gda_160, EMPTY_VALUE);
   ArrayInitialize(gda_164, EMPTY_VALUE);
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