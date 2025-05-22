#!/bin/bash

# Avaliar modelo G2P usando o léxico TEST usando as métricas CER (Carecter Error Rate) e WER (Word Error Rate)

# Definir variaveis de ambiente
MODEL_INPUT=$1
TEST_INPUT=$2

# Rodar phonetisaurus de acordo com a arquitetura $(uname -m)
ARCH=$(uname -m)
#LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/
BIN_PATH=../tools/g2p/bin/$ARCH/
export PATH=$PATH:$BIN_PATH

# words_test_org.txt = palavras do test.dic
# phoneme_test_out.txt = transcrições das palavras do test.dic
# phoneme_test_out.txt = transcrições geradas pelo g2p com as palavras do test.dic
cat "$TEST_INPUT" | cut -f1 > words_test_org.txt
cat "$TEST_INPUT" | cut -f2 > phoneme_test_org.txt

LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/ phonetisaurus-g2pfst --model="$MODEL_INPUT"  --wordlist=words_test_org.txt | cut -f3 > phoneme_test_out.txt

# Limpar terminal
clear

# Mostrar resultadas das métricas usando CER, BLEU e WER.
echo "CER:"
jiwer -r phoneme_test_org.txt -h phoneme_test_out.txt --global -c

echo "WER:"
jiwer -r phoneme_test_org.txt -h phoneme_test_out.txt --global

echo "BLEU:"
sacrebleu phoneme_test_org.txt -i phoneme_test_out.txt | jq .score

# Limpar resíduos
rm phoneme_test_org.txt phoneme_test_out.txt words_test_org.txt
