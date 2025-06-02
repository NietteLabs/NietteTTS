#!/bin/bash


# Criar arquivo de treinamento
mkdir models/
bash split.sh wikipron/data/scrape/tsv/por_latn_bz_broad_filtered.tsv models/train.dic models/test.dic
#cat wikipron/data/scrape/tsv/por_latn_bz_broad_filtered.tsv > models/train.dic
cat dic_add.tsv >> models/train.dic 

# Rodar phonetisaurus de acordo com a arquitetura $(uname -m)
ARCH=$(uname -m)
#LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/
BIN_PATH=../tools/g2p/bin/$ARCH/
PATH=$PATH:$BIN_PATH

# Treinar modelo g2p
# Fonte Original: https://github.com/AdolfVonKleist/Phonetisaurus

echo "Alinhamento de Diciónario (5min-10min):"
LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/ phonetisaurus-align --input=models/train.dic --ofile=models/train.corpus --seq1_del=false --seq2_del=false --nbest=4
echo "Treinando modelo n-gram (5s-10s):" 
estimate-ngram -wv vocab -o 8 -t models/train.corpus -wl /tmp/ngram.tmp
rm /tmp/ngram.tmp
lmplz --collapse_values -o 8 --interpolate_unigrams 0 --limit_vocab_file vocab --discount_fallback < models/train.corpus > models/train.o8.arpa
echo "Convertendo para formato OpenFst (10s-20s)":
LD_LIBRARY_PATH=../tools/g2p/lib/$ARCH/ phonetisaurus-arpa2wfst --lm=models/train.o8.arpa --ofile=models/train.o8.fst

