void orderHistory()
{
    numberOfLostOrder = 0;
    lossLotPoint = 0;

    for (int i = OrdersHistoryTotal() - 1; i >= 0; i--)
    {
        if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY))
            continue;
        if (OrderMagicNumber() != MAGIC_NU)
        {
            continue;
        }
        if (OrderProfit() > 0)
        {
            break;
        }
        numberOfLostOrder += 1;
        lossLotPoint += OrderProfit();
        Print("Profit for the order 10 ", OrderProfit());
    }
}