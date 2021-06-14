void readIndicator01() 
{
    Indicator01Resistance0 = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 0, 0);
    Indicator01Resistance1 = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 0, 1);
    Indicator01Mean0       = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 2, 0);
    Indicator01Mean1       = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 2, 1);
    Indicator01Support0    = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 1, 0);
    Indicator01Support1    = indicateVal01Reader("Jason-Indicator/Synergy_DSR", 1, 1);
    // Print("Indicator01Resistance0: " + Indicator01Resistance0 );
}

