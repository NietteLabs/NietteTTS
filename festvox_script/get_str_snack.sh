#!/bin/sh
#MIT License
#Copyright (c) 2025 NietteLabs
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:

#The above copyright notice and this permission notice shall be included in all
#copies or substantial portions of the Software.

#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#SOFTWARE.
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
        tclsh8.6 $NIETTETTS_DEV/festvox_script/get_str.tcl -H $F0MAX -L $F0MIN -f $FILTERS -n 7 -p $FRAMESHIFT -r $SAMPFREQ wav/$fname.wav | $X2X +aa -c 7 >str/$fname.str

    done
