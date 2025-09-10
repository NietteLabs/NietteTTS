#!/bin/bash

git submodule update --init

# Compilar ferramentas
cd tools/
bash setup.sh
cd ..

for i in $(cat tools/utils.source); do
echo $i
export $i
done

# Construir modelo G2P
cd g2p
bash setup_g2p_full.sh
bash setup_g2p.sh
cd ..

# Configurar FestVox com suporte de idiomas do NietteTTS
cp $NIETTETTS_DEV/vox_files/* $FESTVOXDIR/src/vox_files/ -rv


