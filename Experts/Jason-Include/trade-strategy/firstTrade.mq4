void firstTrade()
{
    if (
        numberOfOpenTrade == 0
    )
    {

        if (
            marketStatus >= 10 && marketStatus < 20)
        {
            orderPosition(
                OP_BUY,
                orderLotSize,
                Ask,
                NormalizeDouble(Bid - stopPip * Point, Digits),
                NormalizeDouble(Ask + InitialRespectPip * Point, Digits),
                Green

            );
        }

        if (
            marketStatus >= 20)
        {
            orderPosition(
                OP_SELL,
                orderLotSize,
                Bid,
                NormalizeDouble(Ask + stopPip * Point, Digits),
                NormalizeDouble(Bid - InitialRespectPip * Point, Digits),
                Red

            );
        }
    }
}