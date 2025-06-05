#!/bin/bash

rm Pieroni/etc/txt.done.data 
mkdir Pieroni/{etc,wav}
iconv --from-code=ISO-8859-9 --to-code=UTF-8 1000-sentences-thls-dataset/sentences.txt > sentence_utf8.txt
for i in $(seq -w 1 1000); do
N=$(echo "$i"p)
FRASE=$(sed -n "$N" 1000-sentences-thls-dataset/sentence_utf8.txt | gawk '{print tolower($0)}' | sed "s/\"/\'/g" | tr "-" " " | sed "s/ë/e/g" )
echo $N
echo "( THLS_PTBR_1000_FRA_$i \"$FRASE\" )" >> Pieroni/etc/txt.done.data
done

cp 1000-sentences-thls-dataset/Sentences/*.wav Pieroni/wav
rm sentence_utf8.txt 
