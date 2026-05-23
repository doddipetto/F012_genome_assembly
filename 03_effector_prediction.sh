#!/bin/bash
# Pipeline for Effector Prediction in FO12

PROTEOME="FO12_proteins.fasta"

# 1. Secretome prediction with SignalP 6.0
signalp6 --fastafile $PROTEOME \
         --organism eukarya \
         --output_dir signalp_out \
         --format txt \
         --mode fast

# Extract secreted proteins list (hypothetical script to parse SignalP output)
# grep "SP" signalp_out/prediction_results.txt > secreted_proteins.list

# 2. Effector prediction with EffectorP 3.0
EffectorP.py -i secreted_proteins.fasta \
             -o effectorP_results.txt \
             -E effectorP_candidates.fasta

# 3. Transmembrane domain filtering with deepTMHMM v1.0
deepTMHMM --fasta effectorP_candidates.fasta \
          --outdir deepTMHMM_out

# The final effectorome consists of EffectorP candidates lacking transmembrane domains.