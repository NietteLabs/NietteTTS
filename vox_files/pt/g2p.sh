#!/bin/bash

TMP=/tmp/g2p_$$

INPUT_FILE=$1

. "$INPUT_FILE"

# G2P HEADER
#WORD=""
#MODEL_G2P
#PHONE_FILE

USER_DIR=/home/$USER/
DIC=$USER_DIR/.local/share/niettetts/dics/niettelabs_pt_addenda.scm

# Atualizar dicionario com a nova palavra
update_dic() {
    WORD=$1
    PHONE="$2"
    #Converter léxico para formato puro do Festival"
    echo -e "$WORD\t$PHONE" >$TMP.dic.tmp
    cut -f1 $TMP.dic.tmp | sed 's/^/( "/g' | tr "[:upper:]" "[:lower:]" >$TMP.w.tmp
    cut -f2 $TMP.dic.tmp | sed 's/^/" nil (/g' | sed 's/$/))/g' >$TMP.p.tmp

    paste $TMP.w.tmp $TMP.p.tmp -d" " | sed 's/ "/"/g' >$TMP.raw.tmp
    festival -b '(lex.compile "'$TMP.raw.tmp'" "'$TMP.out.tmp'")' >/dev/null
    REG="(lex.add.entry '"
    REG1=")"
    cat $TMP.out.tmp | sed '1d' | sed "s/^/$REG/g" | sed "s/$/$REG1/g" >>"$DIC"
    rm $TMP.*
}

# Normalizar palavra
normal_word() {
    WORD=$1
    echo "$WORD" >$TMP.word
    WORD=$(awk '{print tolower($0)}' $TMP.word | sed "s/É/é/g" | sed "s/Á/á/g" | sed "s/Í/í/g" | sed "s/Ó/ó/g" | sed "s/Ú/ú/g")
    echo "$WORD" >$TMP.word
}

phonetisaurus() {
    PHONES=$(phonetisaurus-g2pfst --model="$MODEL_G2P" --wordlist="$TMP.word" | cut -f3 | sed "s/}}f//g")
}

if [[ -z "${WORD}" ]]; then
    PHONES=""
    echo "($PHONES)" >"$PHONE_FILE"
else
    normal_word "$WORD"
    phonetisaurus
    update_dic "$WORD" "$PHONES"
    echo "($PHONES)" >"$PHONE_FILE"
fi
