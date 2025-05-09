#!/bin/bash

# Script para fazer o setup das ferramentas base para o projeto.

#Fonte original: https://github.com/NietteLabs/FestPB

# Ubuntu (and related) prerequisites:
echo "Instalando os pacotes necessários para as ferramentas"
sleep 2

sudo apt-get install git build-essential libncurses5-dev sox cmake openjdk-8-jdk openjdk-8-jre
sudo apt-get install csh doxygen xsltproc graphviz

# Get source (unstable)
#echo "Baixado e compilado: Festival Speech Synthesis, Speech Tools, Festvox, Flite e SPTK"
#git clone https://github.com/festvox/speech_tools
#git clone https://github.com/festvox/festival
#git clone https://github.com/festvox/festvox
#git clone https://github.com/festvox/flite

wget http://festvox.org/packed/SPTK-3.6.tar.gz
tar zxvf SPTK-3.6.tar.gz

export ESTDIR=`pwd`/speech_tools
export FLITEDIR=`pwd`/flite
export FESTVOXDIR=`pwd`/festvox
export SPTKDIR=`pwd`/SPTK

# Compile source
mkdir SPTK
patch -p0 <festvox/src/clustergen/SPTK-3.6.patch 
cd SPTK-3.6
./configure --prefix=$SPTKDIR
make
make install
cd ..

cd speech_tools
./configure
make
make all
cd ..

cd festival
./configure
make
make default_voices
cd ..

cd festvox
./configure
make
cd ..

cd flite
./configure
make
cd ..

#Baixar REAPER

#Fazer download e compilar REAPER
#echo "Fazer download REAPER do repertório Github"
#sleep 2
#git clone https://github.com/google/REAPER.git

#Compilar REAPER
echo "Compilar REAPER"
cd REAPER
mkdir build
cd build
cmake ..
make
cd ../../
echo "REAPER baixado e compilador com sucesso"
sleep 2

## Salva as variáveis das ferramentas em um arquivo
echo "ESTDIR=$ESTDIR" >> utils.source
echo "FLITEDIR=$FLITEDIR" >> utils.source
echo "FESTVOXDIR=$FESTVOXDIR" >> utils.source
echo "SPTKDIR=$SPTKDIR" >> utils.source
echo "REAPER=`pwd`/REAPER/build/reaper" >> utils.source
echo "G2P_PB=`pwd`/annotator/fb_nlplib.jar" >> utils.source


# Clonar binários prontos do G2P e configurar corretamente
#git clone https://github.com/rhasspy/phonetisaurus-pypi/
mkdir g2p

cp phonetisaurus-pypi/phonetisaurus/bin -r g2p/
cp phonetisaurus-pypi/phonetisaurus/lib -r g2p/


