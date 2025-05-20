#!/bin/bash

#Baseado em NietteTTS/tools/festvox/src/general/traintest

#Dividir léxico em train e test em 90%/10%
DIC_INPUT=$1
TRAIN_OUPUT=$2
TEST_OUTPUT=$3

#Split linhas que terminam com 9 $DIC_INPUT para test
cat -n "$DIC_INPUT" | cut -f1 | grep  '.*9$' > lines_test.txt

#Split linhas que não terminam com 9 $DIC_INPUT para train
cat -n "$DIC_INPUT" | cut -f1 | grep  '.*[^9]$' > lines_train.txt

cat -n $DIC_INPUT | grep -f lines_train.txt | cut -f2,3 > $TRAIN_OUPUT

cat -n $DIC_INPUT | grep -f lines_test.txt | cut -f2,3 > $TEST_OUTPUT

rm lines_train.txt
rm lines_test.txt
