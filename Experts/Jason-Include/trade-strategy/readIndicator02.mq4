void readIndicator02()
{
    int counter_Indicator02 = 0;
    int findValue__Indicator02 = 0;
    while (findValue__Indicator02 == 0 && counter_Indicator02 < 1000)
    {
        double Indicator02_01_temp_buy = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 0, counter_Indicator02);
        double Indicator02_01_temp_sell = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 1, counter_Indicator02);
        counter_Indicator02++;
        if (Indicator02_01_temp_buy != EMPTY_VALUE)
        {
            Indicator02_01 = Indicator02_01_temp_buy;
            Indicator02_01_type = "buy";
            Indicator02_01_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 1;
        }

        if (Indicator02_01_temp_sell != EMPTY_VALUE)
        {
            Indicator02_01 = Indicator02_01_temp_sell;
            Indicator02_01_type = "sell";
            Indicator02_01_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 1;
        }
    }

    while (findValue__Indicator02 == 1 && counter_Indicator02 < 1000)
    {
        double Indicator02_02_temp_buy = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 0, counter_Indicator02);
        double Indicator02_02_temp_sell = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 1, counter_Indicator02);
        counter_Indicator02++;
        if (Indicator02_02_temp_buy != EMPTY_VALUE)
        {
            Indicator02_02 = Indicator02_02_temp_buy;
            Indicator02_02_type = "buy";
            Indicator02_02_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 2;
        }

        if (Indicator02_02_temp_sell != EMPTY_VALUE)
        {
            Indicator02_02 = Indicator02_02_temp_sell;
            Indicator02_02_type = "sell";
            Indicator02_02_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 2;
        }
    }

    while (findValue__Indicator02 == 2 && counter_Indicator02 < 1000)
    {
        double Indicator02_03_temp_buy = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 0, counter_Indicator02);
        double Indicator02_03_temp_sell = indicateVal01Reader("Jason-Indicator/Synergy_TradeSignal", 1, counter_Indicator02);
        counter_Indicator02++;
        if (Indicator02_03_temp_buy != EMPTY_VALUE)
        {
            Indicator02_03 = Indicator02_03_temp_buy;
            Indicator02_03_type = "buy";
            Indicator02_03_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 3;
        }

        if (Indicator02_03_temp_sell != EMPTY_VALUE)
        {
            Indicator02_03 = Indicator02_03_temp_sell;
            Indicator02_03_type = "sell";
            Indicator02_03_candleNumber = counter_Indicator02 - 1;
            findValue__Indicator02 = 3;
        }
    }
}
