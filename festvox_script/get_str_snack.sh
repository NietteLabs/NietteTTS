#!/bin/sh
#####################################################-*-mode:shell-script-*-
##                                                                       ##
##                     Carnegie Mellon University                        ##
##                         Copyright (c) 2013                            ##
##                        All Rights Reserved.                           ##
##                                                                       ##
##  Permission is hereby granted, free of charge, to use and distribute  ##
##  this software and its documentation without restriction, including   ##
##  without limitation the rights to use, copy, modify, merge, publish,  ##
##  distribute, sublicense, and/or sell copies of this work, and to      ##
##  permit persons to whom this work is furnished to do so, subject to   ##
##  the following conditions:                                            ##
##   1. The code must retain the above copyright notice, this list of    ##
##      conditions and the following disclaimer.                         ##
##   2. Any modifications must be clearly marked as such.                ##
##   3. Original authors' names are not deleted.                         ##
##   4. The authors' names are not used to endorse or promote products   ##
##      derived from this software without specific prior written        ##
##      permission.                                                      ##
##                                                                       ##
##  CARNEGIE MELLON UNIVERSITY AND THE CONTRIBUTORS TO THIS WORK         ##
##  DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING      ##
##  ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT   ##
##  SHALL CARNEGIE MELLON UNIVERSITY NOR THE CONTRIBUTORS BE LIABLE      ##
##  FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    ##
##  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN   ##
##  AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,          ##
##  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF       ##
##  THIS SOFTWARE.                                                       ##
##                                                                       ##
###########################################################################
##                                                                       ##
##  Author: Alok Parlikar (aup@cs.cmu.edu) Jan 2013                      ##
##                                                                       ##
###########################################################################
##                                                                       ##
## Uses SPTK for extracting F0 and Voicing Information                   ##
##                                                                       ##
###########################################################################

###########################################################################
##                                                                       ##
##  Author: Pallas13 (edsondasilvaguedes0@gmail) 2025                    ##
##                                                                       ##
###########################################################################
##                                                                       ##
## Uses SNACK for extracting STR using MaryTTS Script for STR                          		 ##
##          (Basead in SPTK F0 extraction script)                        ##
###########################################################################

LANG=C
export LANG

if [ ! "$ESTDIR" ]; then
    echo "environment variable ESTDIR is unset"
    echo "set it to your local speech tools directory e.g."
    echo '   bash$ export ESTDIR=/home/awb/projects/speech_tools/'
    echo or
    echo '   csh% setenv ESTDIR /home/awb/projects/speech_tools/'
    exit 1
fi

if [ ! "$FESTVOXDIR" ]; then
    echo "environment variable FESTVOXDIR is unset"
    echo "set it to your local festvox directory e.g."
    echo '   bash$ export FESTVOXDIR=/home/awb/projects/festvox/'
    echo or
    echo '   csh% setenv FESTVOXDIR /home/awb/projects/festvox/'
    exit 1
fi

if [ ! "$SPTKDIR" ]; then
    echo "environment variable SPTKDIR is unset"
    echo "set it to your local festvox directory e.g."
    echo '   bash$ export SPTKDIR=/usr/local/SPTK/'
    echo or
    echo '   csh% setenv SPTKDIR /usr/local/SPTK/'
    exit 1
fi

VERSION=$($SPTKDIR/mgcep -h | grep version)

if [ ! "$VERSION" = ' SPTK: version 4.3' ]; then
    echo "Your SPTK verion is $VERSION, is need SPTK-4.3"
    echo "git clone https://github.com/sp-nitech/SPTK"
    echo "cd SPTK"
    echo "mkdir build"
    echo "cmake ../"
    echo "make -j$(nproc)"
    echo "export SPTKDIR=$(PWD)"
    exit 1
fi

X2X=$SPTKDIR/x2x

F0MIN=50
F0MAX=200
F0MEAN=110

if [ ! -d str ]; then
    mkdir str
fi

if [ -f etc/f0.params ]; then
    . etc/f0.params
fi

if [ ! -f etc/silence ]; then
    $ESTDIR/../festival/bin/festival -b festvox/build_clunits.scm
    "(find_silence_name)"
fi
SILENCE=$(awk '{print $1}' etc/silence)

PROMPTFILE=etc/txt.done.data
if [ $# = 1 ]; then
    PROMPTFILE=$1
fi

cat $PROMPTFILE |
    awk '{print $2}' |
    while read i; do
        fname=$i
        SAMPFREQ=$($ESTDIR/bin/ch_wave -info wav/$fname.wav | grep 'Sample rate' | cut -d ' ' -f 3)
        FRAMELEN=$(echo | awk "{print int(0.025*$SAMPFREQ)}")
        FRAMESHIFT=$(echo | awk "{print int(0.005*$SAMPFREQ)}")

        case "$SAMPFREQ" in
        48000)
            FILTERS=$NIETTETTS_DEV/filters/mix_excitation_5filters_199taps_48Kz.txt
            ;;
        44000)
            FILTERS=$NIETTETTS_DEV/filters/mix_excitation_7filters_99taps_44Kz.txt
            ;;
        16000)
            FILTERS=$NIETTETTS_DEV/filters/mix_excitation_5filters_99taps_16Kz.txt
            ;;
        *)
            echo filters for $SAMPFREQ not found, set sample rate in 16000, 44000 or 48000hz.
            exit 0
            ;;
        esac

        echo $fname STR extraction with SNACK using $FILTERS

#       tclsh8.6 $NIETTETTS_DEV/festvox_script/get_str.tcl -H $F0MAX -L $F0MIN -f $FILTERS -n 5 -p $FRAMESHIFT -r $SAMPFREQ -s $FRAMELEN wav/$fname.wav | $X2X +aa -c 5 > str/$fname.str
        tclsh8.6 $NIETTETTS_DEV/festvox_script/get_str.tcl -H $F0MAX -L $F0MIN -f $FILTERS -n 5 -p $FRAMESHIFT -r $SAMPFREQ wav/$fname.wav | $X2X +aa -c 5 > str/$fname.str

    done
