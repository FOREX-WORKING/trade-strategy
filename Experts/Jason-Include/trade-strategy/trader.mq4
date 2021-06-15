#include "orderHistory.mq4"
#include "firstTrade.mq4"

void trader()
{


   
    orderHistory();
    firstTrade();

    ObjectCreate("numberOfOpenTrade", OBJ_LABEL, 0, 0, 0);
    ObjectSet("numberOfOpenTrade", OBJPROP_CORNER, 1);
    ObjectSet("numberOfOpenTrade", OBJPROP_XDISTANCE, 25);
    ObjectSet("numberOfOpenTrade", OBJPROP_YDISTANCE, 30);
    ObjectSetText("numberOfOpenTrade", "numberOfOpenTrade: " + numberOfOpenTrade, 12, "Verdana", Yellow);

    ObjectCreate("lossLotPoint", OBJ_LABEL, 0, 0, 0);
    ObjectSet("lossLotPoint", OBJPROP_CORNER, 1);
    ObjectSet("lossLotPoint", OBJPROP_XDISTANCE, 25);
    ObjectSet("lossLotPoint", OBJPROP_YDISTANCE, 45);
    ObjectSetText("lossLotPoint", "lossLotPoint: " + lossLotPoint, 12, "Verdana", Red);

    ObjectCreate("numberOfLostOrder", OBJ_LABEL, 0, 0, 0);
    ObjectSet("numberOfLostOrder", OBJPROP_CORNER, 1);
    ObjectSet("numberOfLostOrder", OBJPROP_XDISTANCE, 25);
    ObjectSet("numberOfLostOrder", OBJPROP_YDISTANCE, 60);
    ObjectSetText("numberOfLostOrder", "numberOfLostOrder: " + numberOfLostOrder, 12, "Verdana", White);


    
    
}