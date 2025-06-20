ARCH=$(uname -m)
LD_LIBRARY_PATH=festvox/g2p/lib/$ARCH/
BIN_PATH=festvox/g2p/bin/$ARCH
PATH=$PATH:$BIN_PATH

WORD=$1
MODEL_INPUT=festvox/g2p/model_g2p.fst
PHONES=$(LD_LIBRARY_PATH=festvox/g2p/lib/$ARCH/ phonetisaurus-g2pfst --model="$MODEL_INPUT"  --word=$WORD | cut -f3)

echo "($PHONES)"
#echo $PHONES 
