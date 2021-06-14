// 10 buy only 

// 15 Sell->buy in channel 2


// 20 sell only
// 21 Sell in channel 1


void findTrend()
{

    ObjectCreate("TrendMarket", OBJ_LABEL, 0, 0, 0);
    ObjectSet("TrendMarket", OBJPROP_CORNER, 1);
    ObjectSet("TrendMarket", OBJPROP_XDISTANCE, 25);
    ObjectSet("TrendMarket", OBJPROP_YDISTANCE, 5);

    if (marketStatus == 10) {
        ObjectSetText("TrendMarket", "Trend Market: 10 buy only ", 15, "Verdana", Green);
    }
    if (marketStatus == 11) {
        ObjectSetText("TrendMarket", "Trend Market: 11 Buy in channel 1", 15, "Verdana", Green);
    }
    if (marketStatus == 15) {
        ObjectSetText("TrendMarket", "Trend Market: 15 Sell->buy in channel 2", 15, "Verdana", Green);
    }
    if (marketStatus == 19) {
        ObjectSetText("TrendMarket", "Trend Market: 19 buy only ", 15, "Verdana", Green);
    }
    if (marketStatus == 20) {
        ObjectSetText("TrendMarket", "Trend Market: 20 sell only", 15, "Verdana", Red);
    }
    if (marketStatus == 21) {
        ObjectSetText("TrendMarket", "Trend Market: 21 Sell in channel 1", 15, "Verdana", Red);
    }
    if (marketStatus == 25) {
        ObjectSetText("TrendMarket", "Trend Market: 25 Buy->sell in channel 2", 15, "Verdana", Red);
    }
    if (marketStatus == 29) {
        ObjectSetText("TrendMarket", "Trend Market: 29 sell only", 15, "Verdana", Red);
    }



    if (
        (
            Bid > Indicator01Resistance0
            && Close[1] > Indicator01Resistance0
        )
        || (
            marketStatus == 0
            &&  Indicator02_01 != EMPTY_VALUE
            &&  Bid >  Indicator02_01 
            &&  Indicator02_01_type == "buy"
        )
    )
    {
        marketStatus = 10;
        return;
    }


    if (
        marketStatus == 20 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Bid >  Indicator02_01 
        &&  Indicator02_01_type == "buy"
    ){
        marketStatus = 11;
        return;
    }

    if (
        marketStatus == 21 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Bid >  Indicator02_01 
        &&  Indicator02_01_type == "buy"
    ){
        
        marketStatus = 15;
        return;
    }

    if(
        marketStatus == 25 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Bid >  Indicator02_01 
        &&  Indicator02_01_type == "buy"
    ){
        marketStatus = 19;
        return;
    }
    
    if (
        (
            Ask < Indicator01Support0
            && Close[1] < Indicator01Support0
        )
        || (
            marketStatus == 0
            &&  Indicator02_01 != EMPTY_VALUE
            &&  Ask <  Indicator02_01 
            &&  Indicator02_01_type == "sell"
        )
    )
    {
        marketStatus = 20;
        return;
    }

    
    if (
        marketStatus == 10 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Ask <  Indicator02_01 
        &&  Indicator02_01_type == "sell"
    ){
        marketStatus = 21;
        return;
    }

    if (
        marketStatus == 11 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Ask < Indicator02_01 
        &&  Indicator02_01_type == "sell"
    ){
        
        marketStatus = 25;
        return;
    }


    if(
        marketStatus == 15 
        &&  Ask <  Indicator01Resistance1  
        &&  Bid >  Indicator01Support1  
        &&  Indicator02_01 != EMPTY_VALUE
        &&  Ask <  Indicator02_01 
        &&  Indicator02_01_type == "sell"
    ){
        marketStatus = 29;
        return;
    }


      




     



  



}