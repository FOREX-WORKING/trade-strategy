#property copyright "Copyright © 2013, ForexMT4Systems."
#property link      "http://www.forexmt4systems.com"

#property indicator_chart_window

//extern string   Currencies          = "AUD,CAD,CHF,EUR,GBP,JPY,NZD,USD,TRY,SGD,DKK,HKD,NOK,SEK,PLN,HUF,CZK,ZAR";
//extern string   CurrencyPairs       = "AUD,CAD,CHF,EUR,GBP,JPY,NZD,USD";
extern string   CurrencyPairs       = "EU,GU,AU,UJ,UF,UC,EJ,EG,EF,EA,GJ,GF";
extern string   FontName            = "Courier New";
extern int      FontSize            = 20;
extern string   OutputFormat        = "R3.1";
extern int      HorizPos            = 10;
extern int      VertPos             = 25;
extern int      VertSpacing         = 25;
extern int      RefreshEveryXMins   = 0;
extern color    Color1              = Red;
extern double   Level1              = 7.0;
extern color    Color2              = Orange;
extern double   Level2              = 5.0;
extern color    Color3              = Yellow;
extern double   Level3              = 2.0;
extern color    Color4              = DodgerBlue;
extern double   Level4              = 0.0;
extern bool     ShowNoOfPairs       = false;

double    spr, pnt, tickval, ccy_strength[8];
int       dig, tf, ccy_count[8], ccCP;
string    IndiName, ccy, CP[99], ccy_name[8];
datetime  prev_time;

//+------------------------------------------------------------------+
int init()   {
//+------------------------------------------------------------------+

  if (RefreshEveryXMins > 240)                             RefreshEveryXMins = 240;
  if (RefreshEveryXMins > 60 && RefreshEveryXMins < 240)   RefreshEveryXMins = 60;
  if (RefreshEveryXMins > 30 && RefreshEveryXMins < 60)    RefreshEveryXMins = 30;
  if (RefreshEveryXMins > 15 && RefreshEveryXMins < 30)    RefreshEveryXMins = 15;
  if (RefreshEveryXMins > 5  && RefreshEveryXMins < 15)    RefreshEveryXMins = 5;
  if (RefreshEveryXMins > 1  && RefreshEveryXMins < 5)     RefreshEveryXMins = 1;

  CurrencyPairs  = StringUpper(CurrencyPairs);
  if (CurrencyPairs == "")  CurrencyPairs = Symbol();
  if (StringSubstr(CurrencyPairs,StringLen(CurrencyPairs)-1,1) != ",")  CurrencyPairs = CurrencyPairs + ",";
  ccCP = StringFindCount(CurrencyPairs,",");
  for (int i=0; i<99; i++)
    CP[i] = "";
  int comma1 = -1;
  for (i=0; i<99; i++)  {
    int comma2 = StringFind(CurrencyPairs,",",comma1+1);
    string temp  = StringSubstr(CurrencyPairs,comma1+1,comma2-comma1-1);
    CP[i] = ExpandCcy(temp);
    if (comma2 >= StringLen(CurrencyPairs)-1)   break;
    comma1 = comma2;
  }  

  int checksum = 0;
  string str = "0";
  for (i=0; i<StringLen(str); i++)  
    checksum += i * StringGetChar(str,i);
  IndiName = "CurrencyStrength-" + checksum;
  IndicatorShortName(IndiName);

  ccy     = Symbol();
  tf      = Period();
  pnt     = MarketInfo(ccy,MODE_POINT);
  dig     = MarketInfo(ccy,MODE_DIGITS);
  spr     = MarketInfo(ccy,MODE_SPREAD);
  tickval = MarketInfo(ccy,MODE_TICKVALUE);
  if (dig == 3 || dig == 5) {
    pnt     *= 10;
    spr     /= 10;
    tickval *= 10;
  }

  ccy_name[0] = "USD";
  ccy_name[1] = "EUR";
  ccy_name[2] = "GBP";
  ccy_name[3] = "CHF";
  ccy_name[4] = "CAD";
  ccy_name[5] = "AUD";
  ccy_name[6] = "JPY";
  ccy_name[7] = "NZD";

  del_obj();
  plot_obj();    
  prev_time = -9999;
  return(0);
}

//+------------------------------------------------------------------+
int deinit()  {
//+------------------------------------------------------------------+
  del_obj();
  return(0);
}

//+------------------------------------------------------------------+
int start()  {
//+------------------------------------------------------------------+
  if (RefreshEveryXMins == 0) {
    del_obj();
    plot_obj();    
  }
  else {
    if(prev_time != iTime(ccy,RefreshEveryXMins,0))  {
      del_obj();
      plot_obj();
      prev_time = iTime(ccy,RefreshEveryXMins,0);
  } }      
  return(0);
}

//+------------------------------------------------------------------+
void plot_obj()   {
//+------------------------------------------------------------------+

  ArrayInitialize(ccy_strength,0.0);
  ArrayInitialize(ccy_count,0);

  for (int i=0; i<ccCP; i++)   {
    double day_high     = MarketInfo(CP[i],MODE_HIGH);
    double day_low      = MarketInfo(CP[i],MODE_LOW);
    double curr_bid     = MarketInfo(CP[i],MODE_BID);
    double bid_ratio    = DivZero(curr_bid - day_low, day_high - day_low);

    double ind_strength = 0;
    if (bid_ratio >= 0.97)   ind_strength = 9;    else
    if (bid_ratio >= 0.90)   ind_strength = 8;    else
    if (bid_ratio >= 0.75)   ind_strength = 7;    else
    if (bid_ratio >= 0.60)   ind_strength = 6;    else
    if (bid_ratio >= 0.50)   ind_strength = 5;    else
    if (bid_ratio >= 0.40)   ind_strength = 4;    else
    if (bid_ratio >= 0.25)   ind_strength = 3;    else
    if (bid_ratio >= 0.10)   ind_strength = 2;    else
    if (bid_ratio >= 0.03)   ind_strength = 1;

    string temp = StringSubstr(CP[i],0,3);
    for (int j=0; j<8; j++)   {
      if (ccy_name[j] == temp)  {
        ccy_strength[j] += ind_strength;
        ccy_count[j]    += 1;
        break;
    } }    

    temp = StringSubstr(CP[i],3,3);
    for (j=0; j<8; j++)   {
      if (ccy_name[j] == temp)  {
        ccy_strength[j] += 9 - ind_strength;
        ccy_count[j]    += 1;
        break;
  } } }    

  int xp = HorizPos;
  int yp = VertPos;
  for (j=0; j<8; j++)  {
    if (ccy_count[j] < 1)   continue;
    double out_value = DivZero(ccy_strength[j],ccy_count[j]);
    string tstr1 = ccy_name[j] + NumberToStr(out_value,OutputFormat);
    if (ShowNoOfPairs)  
      tstr1 = tstr1 + NumberToStr(-ccy_count[j],"(3");
    string objname = IndiName + "-" + j;
    ObjectCreate(objname,OBJ_LABEL,0,0,0);
    ObjectSet(objname,OBJPROP_XDISTANCE,xp);
    ObjectSet(objname,OBJPROP_YDISTANCE,yp);
    color FontColor = White;
    if (out_value >  Level1)   FontColor = Color1;    else
    if (out_value >  Level2)   FontColor = Color2;    else
    if (out_value >  Level3)   FontColor = Color3;    else
    if (out_value >= Level4)   FontColor = Color4;
    ObjectSetText(objname,tstr1,FontSize,FontName,FontColor);
    yp += VertSpacing;
  }        
  return(0);
}

//+------------------------------------------------------------------+
//| del_obj                                                          |
//+------------------------------------------------------------------+
void del_obj()
{
  int k=0;
  while (k<ObjectsTotal())   {
    string objname = ObjectName(k);
    if (StringSubstr(objname,0,StringLen(IndiName)) == IndiName)  
      ObjectDelete(objname);
    else
      k++;
  }    
  return(0);
}

//+------------------------------------------------------------------+
string TFToStr(int tf)
//+------------------------------------------------------------------+
// Converts a MT4-numeric timeframe to its descriptor string
// Usage:   string s=TFToStr(15) returns s="M15"
{
  switch (tf)  {
    case     1 :  return("M1");
    case     5 :  return("M5");
    case    15 :  return("M15");
    case    30 :  return("M30");
    case    60 :  return("H1");
    case   240 :  return("H4");
    case  1440 :  return("D1");
    case 10080 :  return("W1");
    case 43200 :  return("MN");
  }  
  return(0);
}  

//+------------------------------------------------------------------+
string NumberToStr(double n, string mask)
//+------------------------------------------------------------------+
// Formats a number using a mask, and returns the resulting string
// Usage:    string result = NumberToStr(number,mask)
// 
// Mask parameters:
// n = number of digits to output, to the left of the decimal point
// n.d = output n digits to left of decimal point; d digits to the right
// -n.d = floating minus sign at left of output
// n.d- = minus sign at right of output
// +n.d = floating plus/minus sign at left of output
// ( or ) = enclose negative number in parentheses
// $ or £ or ¥ or € = include floating currency symbol at left of output
// % = include trailing % sign
// , = use commas to separate thousands
// Z or z = left fill with zeros instead of spaces
// R or r = round result in rightmost displayed digit
// B or b = blank entire field if number is 0
// * = show asterisk in leftmost position if overflow occurs
// ; = switch use of comma and period (European format)
// L or l = left align final string 
// T ot t = trim end result

{
  if (MathAbs(n) == 2147483647)
    n = 0;
    
  mask = StringUpper(mask);
  int dotadj = 0;
  int dot    = StringFind(mask,".",0);
  if (dot < 0)  {
    dot    = StringLen(mask);
    dotadj = 1;
  }  

  int nleft  = 0;
  int nright = 0;
  for (int i=0; i<dot; i++)  {
    string char = StringSubstr(mask,i,1);
    if (char >= "0" && char <= "9")   nleft = 10 * nleft + StrToInteger(char);
  }
  if (dotadj == 0)   {
    for (i=dot+1; i<=StringLen(mask); i++)  {
      char = StringSubstr(mask,i,1);
      if (char >= "0" && char <= "9")  nright = 10 * nright + StrToInteger(char);
  } }
  nright = MathMin(nright,7);

  if (dotadj == 1)  {
    for (i=0; i<StringLen(mask); i++)  {
      char = StringSubstr(mask,i,1);
      if (char >= "0" && char <= "9")  {
        dot = i;
        break;
  } } }

  string csym = "";
  if (StringFind(mask,"$",0) >= 0)   csym = "$";
  if (StringFind(mask,"£",0) >= 0)   csym = "£";
  if (StringFind(mask,"€",0) >= 0)   csym = "€";
  if (StringFind(mask,"¥",0) >= 0)   csym = "¥";

  string leadsign  = "";
  string trailsign = "";
  if (StringFind(mask,"+",0) >= 0 && StringFind(mask,"+",0) < dot)  {
    leadsign = " ";
    if (n > 0)   leadsign  = "+";
    if (n < 0)   leadsign  = "-";
  }    
  if (StringFind(mask,"-",0) >= 0 && StringFind(mask,"-",0) < dot)
    if (n < 0)  leadsign  = "-"; else leadsign = " ";
  if (StringFind(mask,"-",0) >= 0 && StringFind(mask,"-",0) > dot)
    if (n < 0)  trailsign  = "-"; else trailsign = " ";
  if (StringFind(mask,"(",0) >= 0 || StringFind(mask,")",0) >= 0)  {
    leadsign  = " ";
    trailsign = " ";
    if (n < 0)  { 
      leadsign  = "("; 
      trailsign = ")";
  } }    

  if (StringFind(mask,"%",0) >= 0)   trailsign = "%";

  if (StringFind(mask,",",0) >= 0) bool comma = true; else comma = false;
  if (StringFind(mask,"Z",0) >= 0) bool zeros = true; else zeros = false;
  if (StringFind(mask,"B",0) >= 0) bool blank = true; else blank = false;
  if (StringFind(mask,"R",0) >= 0) bool round = true; else round = false;
  if (StringFind(mask,"*",0) >= 0) bool overf = true; else overf = false;
  if (StringFind(mask,"L",0) >= 0) bool lftsh = true; else lftsh = false;
  if (StringFind(mask,";",0) >= 0) bool swtch = true; else swtch = false;
  if (StringFind(mask,"T",0) >= 0) bool trimf = true; else trimf = false;

  if (round) n = MathFix(n,nright);
  string outstr = n;

  int dleft = 0;
  for (i=0; i<StringLen(outstr); i++)  {
    char = StringSubstr(outstr,i,1);
    if (char >= "0" && char <= "9")   dleft++;
    if (char == ".")   break;
  }
  
// Insert fill characters.......
  if (zeros) string fill = "0"; else fill = " ";
  if (n < 0)
    outstr = "-" + StringRepeat(fill,nleft-dleft) + StringSubstr(outstr,1,StringLen(outstr)-1);
  else  
    outstr = StringRepeat(fill,nleft-dleft) + StringSubstr(outstr,0,StringLen(outstr));

  outstr = StringSubstr(outstr,StringLen(outstr)-9-nleft,nleft+1+nright-dotadj);

// Insert the commas.......  
  if (comma)   {
    bool digflg = false;
    bool stpflg = false;
    string out1 = "";
    string out2 = "";
    for (i=0; i<StringLen(outstr); i++)  {
      char = StringSubstr(outstr,i,1);
      if (char == ".")   stpflg = true;
      if (!stpflg && (nleft-i == 3 || nleft-i == 6 || nleft-i == 9)) 
        if (digflg)   out1 = out1 + ","; else out1 = out1 + " "; 
      out1 = out1 + char;    
      if (char >= "0" && char <= "9")   digflg = true;
    }  
    outstr = out1;
  }  
// Add currency symbol and signs........  
  outstr = csym + leadsign + outstr + trailsign;

// 'Float' the currency symbol/sign.......
  out1 = "";
  out2 = "";
  bool fltflg = true;
  for (i=0; i<StringLen(outstr); i++)   {
    char = StringSubstr(outstr,i,1);
    if (char >= "0" && char <= "9")   fltflg = false;
    if ((char == " " && fltflg) || (blank && n == 0) )   out1 = out1 + " ";   else   out2 = out2 + char;
  }   
  outstr = out1 + out2;

// Overflow........  
  if (overf && dleft > nleft)  outstr = "*" + StringSubstr(outstr,1,StringLen(outstr)-1);

// Left shift.......
  if (lftsh)   {
    int len = StringLen(outstr);
    outstr = StringLeftTrim(outstr);
    outstr = outstr + StringRepeat(" ",len-StringLen(outstr));
  }

// Switch period and comma.......
  if (swtch)   {
    out1 = "";
    for (i=0; i<StringLen(outstr); i++)   {
      char = StringSubstr(outstr,i,1);
      if (char == ".")   out1 = out1 + ",";     else
      if (char == ",")   out1 = out1 + ".";     else
      out1 = out1 + char;
    }    
    outstr = out1;
  }  

  if (trimf)    outstr = StringTrim(outstr);
  return(outstr);
}

//+------------------------------------------------------------------+
string StringRepeat(string str, int n)
//+------------------------------------------------------------------+
// Repeats the string STR N times
// Usage:    string x=StringRepeat("-",10)  returns x = "----------"
{
  string outstr = "";
  for(int i=0; i<n; i++)  {
    outstr = outstr + str;
  }
  return(outstr);
}

//+------------------------------------------------------------------+
string StringLeftTrim(string str)
//+------------------------------------------------------------------+
// Removes all leading spaces from a string
// Usage:    string x=StringLeftTrim("  XX YY  ")  returns x = "XX  YY  "
{
  bool   left = true;
  string outstr = "";
  for(int i=0; i<StringLen(str); i++)  {
    if (StringSubstr(str,i,1) != " " || !left) {
      outstr = outstr + StringSubstr(str,i,1);
      left = false;
  } }
  return(outstr);
}

//+------------------------------------------------------------------+
string StringUpper(string str)
//+------------------------------------------------------------------+
// Converts any lowercase characters in a string to uppercase
// Usage:    string x=StringUpper("The Quick Brown Fox")  returns x = "THE QUICK BROWN FOX"
{
  string outstr = "";
  string lower  = "abcdefghijklmnopqrstuvwxyz";
  string upper  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for(int i=0; i<StringLen(str); i++)  {
    int t1 = StringFind(lower,StringSubstr(str,i,1),0);
    if (t1 >=0)  
      outstr = outstr + StringSubstr(upper,t1,1);
    else
      outstr = outstr + StringSubstr(str,i,1);
  }
  return(outstr);
}  

//+------------------------------------------------------------------+
string StringLower(string str)
//+------------------------------------------------------------------+
// Converts any uppercase characters in a string to lowercase
// Usage:    string x=StringUpper("The Quick Brown Fox")  returns x = "the quick brown fox"
{
  string outstr = "";
  string lower  = "abcdefghijklmnopqrstuvwxyz";
  string upper  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  for(int i=0; i<StringLen(str); i++)  {
    int t1 = StringFind(upper,StringSubstr(str,i,1),0);
    if (t1 >=0)  
      outstr = outstr + StringSubstr(lower,t1,1);
    else
      outstr = outstr + StringSubstr(str,i,1);
  }
  return(outstr);
}

//+------------------------------------------------------------------+
string StringTrim(string str)
//+------------------------------------------------------------------+
// Removes all spaces (leading, traing embedded) from a string
// Usage:    string x=StringUpper("The Quick Brown Fox")  returns x = "TheQuickBrownFox"
{
  string outstr = "";
  for(int i=0; i<StringLen(str); i++)  {
    if (StringSubstr(str,i,1) != " ")
      outstr = outstr + StringSubstr(str,i,1);
  }
  return(outstr);
}

//+------------------------------------------------------------------+
double MathFix(double n, int d)
//+------------------------------------------------------------------+
// Returns N rounded to D decimals - works around a precision bug in MQL4
{
  return(MathRound(n*MathPow(10,d)+0.000000000001*MathSign(n))/MathPow(10,d));
}  

//+------------------------------------------------------------------+
double DivZero(double n, double d)
//+------------------------------------------------------------------+
// Divides N by D, and returns 0 if the denominator (D) = 0
// Usage:   double x = DivZero(y,z)  sets x = y/z
{
  if (d == 0) return(0);  else return(n/d);
}  

//+------------------------------------------------------------------+
int MathSign(double n)
//+------------------------------------------------------------------+
// Returns the sign of a number (i.e. -1, 0, +1)
// Usage:   int x=MathSign(-25)   returns x=-1
{
  if (n > 0) return(1);
  else if (n < 0) return (-1);
  else return(0);
}  

//+------------------------------------------------------------------+
int StringFindCount(string str, string str2)
//+------------------------------------------------------------------+
// Returns the number of occurrences of STR2 in STR
// Usage:   int x = StringFindCount("ABCDEFGHIJKABACABB","AB")   returns x = 3
{
  int c = 0;
  for (int i=0; i<StringLen(str); i++)
    if (StringSubstr(str,i,StringLen(str2)) == str2)  c++;
  return(c);
}

//+------------------------------------------------------------------+
string ExpandCcy(string str)
//+------------------------------------------------------------------+
{
  str = StringTrim(StringUpper(str));
  if (StringLen(str) < 1 || StringLen(str) > 2)   return(str);
  string str2 = "";
  for (int i=0; i<StringLen(str); i++)   {
    string char = StringSubstr(str,i,1);
    if (char == "A")  str2 = str2 + "AUD";     else
    if (char == "C")  str2 = str2 + "CAD";     else   
    if (char == "E")  str2 = str2 + "EUR";     else   
    if (char == "F")  str2 = str2 + "CHF";     else   
    if (char == "G")  str2 = str2 + "GBP";     else   
    if (char == "J")  str2 = str2 + "JPY";     else   
    if (char == "N")  str2 = str2 + "NZD";     else   
    if (char == "U")  str2 = str2 + "USD";     else   
    if (char == "H")  str2 = str2 + "HKD";     else   
    if (char == "S")  str2 = str2 + "SGD";     else   
    if (char == "Z")  str2 = str2 + "ZAR";   
  }  
  return(str2);
}

