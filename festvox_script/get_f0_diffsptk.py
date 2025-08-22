###########################################################################
##                                                                       ##
##  Author: Pallas13 (edsondasilvaguedes0@gmail) 2025                    ##
##                                                                       ##
###########################################################################
##                                                                       ##
## Uses DiffSPTK for extracting F0 and Voicing Information  		 ##
##                   (Basead in DiffSPTK Doc)		                 ##
###########################################################################

import diffsptk
import argparse
import numpy

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
    )
    parser.add_argument("--frame_period", required=True, type=int)
    parser.add_argument("--sample_rate", required=True, type=int)
    parser.add_argument("--f0_max", required=True, type=int)
    parser.add_argument("--f0_min", required=True, type=int)
    parser.add_argument("--input", required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()


fp = args.frame_period      # Frame period.
sample_rate = args.sample_rate # Sample Rate
f_min = args.f0_min # F0 Min
f_max = args.f0_max # F0 Max
input = args.input # Wave input
output = args.output # f0 output

# Read waveform.
X, sr = diffsptk.read(input)

# Estimate f0 of x.
pitch = diffsptk.Pitch(
    frame_period=fp,
    sample_rate=sample_rate,
    f_min=f_min,
    f_max=f_max,
    voicing_threshold=0.4,
    out_format="f0",
)

f0 = pitch(X)

numpy.savetxt(output, f0, delimiter="\n")
