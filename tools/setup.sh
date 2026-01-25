#!/bin/bash

# Script para fazer o setup das ferramentas base para o projeto.

#Fonte original: https://github.com/NietteLabs/FestPB

# Ubuntu
echo "Instalando os pacotes necessários para as ferramentas"
sudo apt-get install git build-essential libncurses5-dev sox cmake csh doxygen xsltproc graphviz git g++ autoconf-archive make libtool python3-setuptools python-dev-is-python3 python3-pip gfortran jq gawk libboost-all-dev python3-num2words tcl8.6 tcl-snack

# Pacotes python
pip install sacrebleu jiwer --break-system-packages

# Export PATH
export PATH=$PATH:/home/$USER/.local/bin
export ESTDIR=$(pwd)/speech_tools
export FESTVOXDIR=$(pwd)/festvox
export SPTKDIR=$(pwd)/SPTK/build/

# Compile source
mkdir SPTK/build
cd SPTK/build
cmake ../
make -j$(nproc)
cd ../../

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

#Compilar REAPER
echo "Compilar REAPER"
cd REAPER
mkdir build
cd build
cmake ..
make -j$(nproc)
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
make -j$(nproc)
sudo make install
cd ../../

cd Phonetisaurus
make clean
./configure --enable-static --disable-shared
make -j(nproc)
sudo make install
cd ../

## Salva as variáveis das ferramentas em um arquivo
echo "ESTDIR=$ESTDIR" >>utils.source
echo "FESTVOXDIR=$FESTVOXDIR" >>utils.source
echo "SPTKDIR=$SPTKDIR" >>utils.source
echo "REAPER=$(pwd)/REAPER/build/reaper" >>utils.source
echo "NIETTETTS_DEV=$(cd ../ && pwd)" >>utils.source
