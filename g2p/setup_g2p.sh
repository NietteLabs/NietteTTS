#!/bin/bash


# Criar arquivo de treinamento
cat wikipron/data/scrape/tsv/por_latn_bz_broad_filtered.tsv > train.dic

# Rodar phonetisaurus de acordo com a arquitetura $(uname -m)
ARCH=$(uname -m)
#LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/
BIN_PATH=../tools/g2p/bin/$ARCH/
PATH=$PATH:$BIN_PATH

# Treinar modelo g2p
# Fonte Original: https://github.com/AdolfVonKleist/Phonetisaurus

# Align the dictionary (5m-10m)
LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/ phonetisaurus-align --input=train.dic \
  --ofile=train.corpus --seq1_del=false
# Train an n-gram model (5s-10s):
estimate-ngram -o 8 -t train.corpus \
  -wl train.o8.arpa
# Convert to OpenFst format (10s-20s):
LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/ phonetisaurus-arpa2wfst --lm=train.o8.arpa --ofile=train.o8.fst

