#!/bin/bash

#for i in $(ls *.wav); do fname=$(basename $i .wav); n=$(echo $fname | cut -f2 -d"-"); echo $n;  n_1=$(echo "$n + 0" | bc);  mv F017-$n.wav F017-$n_1.wav; done

iconv --from-code=ISO-8859-9 --to-code=UTF-8 1000-sentences-thls-dataset/sentences.txt | gawk '{print tolower($0)}' | sed "s/\"/\'/g" | tr "-" " " | sed "s/ë/e/g" > 1000-sentences-thls-dataset/sentence_utf8.txt
for i in $(seq -w 1 1000); do
N=$(echo "$i"p)
FRASE=$(sed -n "$N" 1000-sentences-thls-dataset/sentence_utf8.txt)
N=$(echo "$i - 1" | bc)
echo "( F017-$N \"$FRASE\" )"
done

#cp 1000-sentences-thls-dataset/Sentences/*.wav Pieroni/wav
#rm sentence_utf8.txt 
