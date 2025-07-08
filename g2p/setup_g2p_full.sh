#!/bin/bash


# Criar arquivo de treinamento
mkdir models/
#bash split.sh wikipron/data/scrape/tsv/por_latn_bz_broad_filtered.tsv models/train.dic models/test.dic
cat wikipron/data/scrape/tsv/por_latn_bz_broad_filtered.tsv | gawk '{print tolower($0)}' > models/full.dic
cat userdict.tsv >> models/full.dic
# Rodar phonetisaurus de acordo com a arquitetura $(uname -m)
ARCH=$(uname -m)
#LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/
BIN_PATH=$NIETTETTS_DEV/tools/g2p/bin/$ARCH/
PATH=$PATH:$BIN_PATH

# Treinar modelo g2p
# Fonte Original: https://github.com/AdolfVonKleist/Phonetisaurus

echo "Alinhamento de Diciónario (5min-10min):"
LD_LIBRARY_PATH=$NIETTETTS_DEV/tools/g2p/lib/$ARCH/ phonetisaurus-align --input=models/full.dic --ofile=models/train_full.corpus --seq1_del=false --seq2_del=false --nbest=8 --mbr=true --iter=40 --grow=true --fb=true
echo "Treinando modelo n-gram (5s-10s):" 
estimate-ngram -wv vocab -o 6 -t models/train_full.corpus -wl /tmp/ngram.tmp
rm /tmp/ngram.tmp
lmplz --discount_fallback --collapse_values -o 6 --limit_vocab_file vocab < models/train_full.corpus > models/train_full.o8.arpa
echo "Convertendo para formato OpenFst (10s-20s)"
LD_LIBRARY_PATH=$NIETTETTS_DEV/tools/g2p/lib/$ARCH/ phonetisaurus-arpa2wfst --lm=models/train_full.o8.arpa --ofile=models/train_full.o8.fst

