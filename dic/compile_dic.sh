#!/bin/bash

# Definido variaveis
DIC_INPUT=$1

echo "Converter léxico para formato puro do Festival"
cut -f1 "$DIC_INPUT" | sed 's/^/( "/g' | tr "[:upper:]" "[:lower:]" > w.tmp
cut -f2 "$DIC_INPUT" | sed 's/^/" nil (/g' | sed 's/$/))/g' > p.tmp

paste w.tmp p.tmp -d" " | sed 's/ "/"/g' > "$(basename "$DIC_INPUT" .tsv).raw"

echo "Compilar lexico"
for i in "$(cat ../tools/utils.source)"; do
export $i
done

export LANG=$LANG
$ESTDIR/../festival/bin/festival -b '(lex.compile "'$(basename "$DIC_INPUT" .tsv).raw'" "'$(basename "$DIC_INPUT" .tsv).out'")'

echo "Limpar arquivos"

rm p.tmp w.tmp



