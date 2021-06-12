bool checkForHistoryAndTrading() 
{
     if (Bars < 100 || IsTradeAllowed() == false){
        return false;
    }
    return true;
}
