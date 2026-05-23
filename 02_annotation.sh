#!/bin/bash
# Pipeline for TE and structural annotation of F. oxysporum FO12

THREADS=16
GENOME="FO12_chromosome_level.fasta"

# 1. Transposable Element (TE) Annotation with EDTA v2.2.2
# Incorporating the curated TE library from Fol4287
EDTA.pl --genome $GENOME \
        --species others \
        --step all \
        --sensitive 1 \
        --anno 1 \
        --threads $THREADS

# 2. Structural and Functional Annotation with Funannotate v1.8.1
# Cleaning and sorting assembly
funannotate clean -i $GENOME -o FO12_clean.fasta
funannotate sort -i FO12_clean.fasta -o FO12_sorted.fasta

# Masking repeats (using EDTA output)
funannotate mask -i FO12_sorted.fasta -o FO12_masked.fasta -m repeatmasker

# Gene prediction (Ab initio + homology evidence)
funannotate predict -i FO12_masked.fasta \
                    -o funannotate_out \
                    -s "Fusarium oxysporum" \
                    --strain FO12 \
                    --cpus $THREADS

# Functional annotation (InterProScan, eggNOG, dbCAN, MEROPS)
funannotate annotate -i funannotate_out \
                     --cpus $THREADS