# What is Fest-TTS?

Fest-TTS is a TTS (Text-to-Speech) Engine that use Festival Speech Synthesis System for speech synthesis in Portuguese Brazilian (future work for outhers languages). Used FestVox (Festival Voice Toolkit) with some modifications for better synthesis, how better MCEP, F0 and STR extraction, and outhers modifications. Used HMM Models for Speech Synthesis (same method of speech synthesis in HTK and RHVoice).

This repository have files for language support, train G2P models, new scripts for extractions of features and outhers scripts. The voices models maked using this repository are available in *release* page. 

This project is a project of Course Completion Paper maked and developed by a person. In the future, source-code of Fest-TTS it will organized with documention for are possible work with outhers developers for support new languages and improvements. 

# Files of Support Language
| language | Description |
| ------------- | ------------- |
| vox_files/pt  | File for support language for Portuguese Brazilian |

# About Flite

Flite (Festival Lite) have some problems and a hard implemetions of new features are new method of G2P, text normalization. Today this repository focus on Festival.

# Future Implemetions
* New languages
    * Spanish Latan
    * Russian
    * German
* New methods of G2P
    * G2P using Marian-MNT
* New high voices using large speech corpora.
* Pos-Tagger
    * Pos-Tagger for better extractios of features for Speech Synthesis.

# Documention
For more informations about the voices of Fest-TTS included manual of installation and samples are available in [Fest-TTS](https://pallasspeechsystem.github.io/).

# Paper of Project

Paper with process of creation and more informations (Is available in Portuguese Brazilian Language) are available in [monografia.pdf](https://github.com/PallasSpeechSystem/Fest-TTS/blob/main/monografia.pdf)
