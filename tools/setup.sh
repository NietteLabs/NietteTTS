#!/bin/bash

# Script para fazer o setup das ferramentas base para o projeto.

#Fonte original: https://github.com/NietteLabs/FestPB

# Ubuntu
echo "Instalando os pacotes necessários para as ferramentas"
sleep 2
sudo apt-get install git build-essential libncurses5-dev sox cmake csh doxygen xsltproc graphviz git g++ autoconf-archive make libtool python3-setuptools python-dev-is-python3 python3-pip gfortran jq gawk libboost-all-dev
# Pacotes python
pip install sacrebleu jiwer --break-system-packages

# Export PATH
export PATH=$PATH:/home/$USER/.local/bin

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

#Compilar REAPER
echo "Compilar REAPER"
cd REAPER
mkdir build
cd build
cmake ..
make
cd ../../
echo "REAPER baixado e compilador com sucesso"

cd mitlm
./autogen.sh
make
sudo make install
sudo ldconfig
cd ..

cd kenlm/
mkdir build
cd build
cmake ../
make 
sudo make install
cd ../../

## Salva as variáveis das ferramentas em um arquivo
echo "ESTDIR=$ESTDIR" >> utils.source
echo "FLITEDIR=$FLITEDIR" >> utils.source
echo "FESTVOXDIR=$FESTVOXDIR" >> utils.source
echo "SPTKDIR=$SPTKDIR" >> utils.source
echo "REAPER=`pwd`/REAPER/build/reaper" >> utils.source


# Configurar corretamente o g2p
mkdir g2p
cp phonetisaurus-pypi/phonetisaurus/bin -r g2p/
cp phonetisaurus-pypi/phonetisaurus/lib -r g2p/

