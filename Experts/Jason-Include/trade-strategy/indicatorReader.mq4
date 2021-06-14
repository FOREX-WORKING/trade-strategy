double indicateVal01Reader (string indicatorName , int mode,int  shift) {
    return iCustom(
        Symbol(),
        Period(),
        indicatorName,
        mode,//mode
        shift//shift
    );
}
