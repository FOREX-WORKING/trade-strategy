void firstTrade()
{
    if (
        numberOfOpenTrade == 0
        && lossLotPoint == 0.0
    )
    {

        if (
            marketStatus >= 10 && marketStatus < 20)
        {
            orderPosition(
                OP_BUY,
                orderLotSize,
                Ask,
                0,
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
                0,
                NormalizeDouble(Bid - InitialRespectPip * Point, Digits),
                Red

            );
        }
    }
}