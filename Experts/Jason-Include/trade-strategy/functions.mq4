// int  OrderSend(
//    string   symbol,              // symbol
//    int      cmd,                 // operation
//    double   volume,              // volume
//    double   price,               // price
//    int      slippage,            // slippage
//    double   stoploss,            // stop loss
//    double   takeprofit,          // take profit
//    string   comment=NULL,        // comment
//    int      magic=0,             // magic number
//    datetime expiration=0,        // pending order expiration
//    color    arrow_color=clrNONE  // color
//    );

int orderPosition(
    int typeOfOrder,
    double lotSize,
    double orderPrice,
    double st,
    double tp,
    color colorr
)
{
    return OrderSend(
        Symbol(),
        typeOfOrder,
        lotSize,
        orderPrice,
        3,
        st,
        tp,
        "comment",
        MAGIC_NU,
        0,
        colorr
    );
}