#!/bin/bash
. etc/voice.defs
mkdir deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/{festival/trees,syntax} -p

# Voice Model
cp festival/trees/"$FV_VOICENAME"_f0.tree deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/
cp festival/trees/"$FV_VOICENAME"_mcep.tree deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/
cp festival/trees/"$FV_VOICENAME"_mcep.params deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/

# SpamF0 Model
cp festival/trees/phrase.tree deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/
cp festival/trees/acc.tree deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/
cp festival/trees/cb.params deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/festival/trees/

# Phrasing Model
cp syntax/*.tree deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/syntax/
cp syntax/grammar.20.gpos.out deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/syntax/grammar.20.gpos.out

# Outher File
cp -r festvox deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/
cp README.md deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/
cp COPYING deb/$FV_FULLVOICENAME/usr/share/festival/voices/$FV_LANG/${FV_FULLVOICENAME}/

# Make deb info
mkdir deb/$FV_FULLVOICENAME/DEBIAN
cp deb.txt deb/$FV_FULLVOICENAME/DEBIAN/control

