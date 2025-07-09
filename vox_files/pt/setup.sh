#!/bin/bash

LANG=$LANG
ARCH=$(uname -m)
LD_LIBRARY_PATH=$2/festvox/g2p/lib/$ARCH/
BIN_PATH=$2/festvox/g2p/bin/$ARCH
PATH=$PATH:$BIN_PATH
MODEL_INPUT=$2/festvox/g2p/model_g2p.fst

WORD=$(echo $1 | gawk '{print tolower($0)}' | sed "s/É/é/g" | sed "s/Á/á/g" | sed "s/Í/í/g" | sed "s/Ó/ó/g" | sed "s/Ú/ú/g")

PHONES=$(LD_LIBRARY_PATH=$LD_LIBRARY_PATH phonetisaurus-g2pfst --model="$MODEL_INPUT"  --word="$WORD" | cut -f3)

echo "($PHONES)"
#echo $PHONES 
