#!/bin/bash

# Converte CETUC DATASET para formato
make_txt() {
    ID_SPEAK="$1"
    for i in $(seq -w 1 1000); do
        N=$(echo "$i"p)
        FRASE=$(sed -n "$N" sentences_thls_utf8.txt)
        N=$(echo "$i - 1" | bc)
        echo "( $ID_SPEAK-$N \"$FRASE\" )" >>"$ID_SPEAK".txt
    done
}

rename_wavs() {
    DIR_CORPUS=$1
    for speak in $DIR_CORPUS/*; do
echo $speak
        for i in $speak/*.wav; do
            fname=$(basename $i .wav)
            ID_SPEAK=$(echo "$fname" | cut -f1 -d"-")
	    echo $fname
            n=$(echo "$fname" | cut -f2 -d"-")
            n_1=$(echo "$n + 0" | bc)
	    FRASE=$(cat $speak/$ID_SPEAK-$n.txt)
	    echo "( $ID_SPEAK-$n_1 \"$FRASE\" )" >>"$ID_SPEAK".txt
            INPUT=$speak/$ID_SPEAK-$n.wav
            OUTPUT=$speak/$ID_SPEAK-$n_1.wav
            mv "$INPUT" "$OUTPUT"
        done
    done
}

rename_wavs $1
