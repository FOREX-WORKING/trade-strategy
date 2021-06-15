int stopUpdatesssssss;

void OrdersAsistance()
{
    numberOfOpenTrade = 0;
 
    

    for (int i = OrdersTotal() - 1; i >= 0; i--)
    {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
            continue;
        if (OrderMagicNumber() != MAGIC_NU)
        {
            continue;
        }
        if (OrderSymbol() != Symbol())
        {
            continue;
        }
        arrayOfTrade[numberOfOpenTrade] = OrderTicket();
        numberOfOpenTrade += 1;

        // if (OrderType() == OP_BUY)
        // {
        //     stopUpdatesssssss = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(Indicator01Support1, Digits), OrderTakeProfit(), OrderExpiration());
        // }

        // if (OrderType() == OP_SELL)
        // {
        //     stopUpdatesssssss = OrderModify(OrderTicket(), OrderOpenPrice(), NormalizeDouble(Indicator01Resistance1, Digits), OrderTakeProfit(), OrderExpiration());
        // }
    }
}