#!/bin/bash

#wget https://www.openslr.org/resources/146/cml_tts_dataset_portuguese_v0.1.tar.bz
wget https://www.dropbox.com/s/ohpc7epowv9ct7o/TTS-Portuguese-Corpus.zip


# Setup corpus

unzip TTS-Portuguese-Corpus.zip

mkdir Edresson/{etc,wav} -p

cp TTS-Portuguese-Corpus/wavs/* Edresson/wav/

