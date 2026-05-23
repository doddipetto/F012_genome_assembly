#!/bin/bash
# Pipeline for de novo assembly of Fusarium oxysporum FO12

THREADS=16
GENOME_SIZE="50m"
NANO_READS="all_reads_F012.fastq.gz"

# 1. De novo assembly with Oxford Nanopore reads using Flye v.2.9.6
# Parameters based on manuscript: -nano-hq, 50m genome size, minimum read length 3000
flye --nano-hq $NANO_READS \
     -g $GENOME_SIZE \
     -m 3000 \
     -t $THREADS \
     --out-dir flye_assembly

# 2. Hi-C Scaffolding (Pipeline using Juicer and 3D-DNA)
# Generating restriction site map for DpnII (GATC)
python generate_site_positions.py DpnII FO12_draft.fasta FO12_draft

# Juicer alignment
bwa index FO12_draft.fasta

# Added the '-a' flag (assembly mode) to skip post-processing steps 
# and generate the merged_nodups.txt required for 3D-DNA
juicer.sh -d juicer_out \
          -D juicer \
          -s DpnII \
          -z FO12_draft.fasta \
          -p FO12_draft.chrom.sizes \
          -t $THREADS \
          -a

# 3. 3D-DNA Scaffolding
run-asm-pipeline.sh -r 2 FO12_draft.fasta juicer_out/aligned/merged_nodups.txt