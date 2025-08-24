#!/bin/bash

TMP=/tmp/g2p_$$

LANG=$LANG
ARCH=$(uname -m)
LD_LIBRARY_PATH=$2/festvox/g2p/lib/$ARCH/
BIN_PATH=$2/festvox/g2p/bin/$ARCH
PATH=$PATH:$BIN_PATH
MODEL_INPUT=$2/festvox/g2p/model_g2p.fst
USER_DIR=/home/$USER/
DIC=$USER_DIR/.local/share/niettetts/dics/niettelabs_pt_addenda.scm

WORD=$(echo $1 | gawk '{print tolower($0)}' | sed "s/É/é/g" | sed "s/Á/á/g" | sed "s/Í/í/g" | sed "s/Ó/ó/g" | sed "s/Ú/ú/g" | sed "s/}}f//g")
PHONES=$(LD_LIBRARY_PATH=$LD_LIBRARY_PATH phonetisaurus-g2pfst --model="$MODEL_INPUT"  --word="$WORD" | cut -f3 | sed "s/}}f//g")

# Atualizar dicionario com a nova palavra
update_dic(){
WORLD=$1
PHONE="$2"
#Converter léxico para formato puro do Festival"
echo -e "$WORLD\t$PHONE" > $TMP.dic.tmp
cut -f1 $TMP.dic.tmp | sed 's/^/( "/g' | tr "[:upper:]" "[:lower:]" > $TMP.w.tmp
cut -f2 $TMP.dic.tmp | sed 's/^/" nil (/g' | sed 's/$/))/g' > $TMP.p.tmp

paste $TMP.w.tmp $TMP.p.tmp -d" " | sed 's/ "/"/g' > $TMP.raw.tmp
festival -b '(lex.compile "'$TMP.raw.tmp'" "'$TMP.out.tmp'")' > /dev/null
REG="(lex.add.entry '"
REG1=")"
cat $TMP.out.tmp | sed '1d' | sed "s/^/$REG/g" | sed "s/$/$REG1/g" >> $DIC
rm $TMP.*
}

update_dic $WORD "$PHONES"
echo "($PHONES)"
