# Fusarium oxysporum FO12 - Genome Assembly and Annotation

This repository contains the command-line strings, custom scripts, and bioinformatic pipelines used for the chromosome-level assembly and annotation of the biocontrol agent *Fusarium oxysporum* strain FO12.

## Overview
The FO12 genome was assembled using a hybrid approach combining Oxford Nanopore Technologies (ONT) long reads and Illumina Hi-C chromatin conformation capture data. 

* **Total assembly length:** 57.60 Mb
* **Scaffolds:** 14 chromosome-scale pseudomolecules
* **Predicted protein-coding genes:** 16,068

## Repository Structure
* `01_assembly.sh`: Commands used for initial *de novo* assembly (Flye) and Hi-C scaffolding preparation.
* `02_annotation.sh`: Commands for transposable element (TE) prediction (EDTA) and structural/functional annotation (Funannotate).
* `03_effector_prediction.sh`: Pipeline for identifying the FO12 effectorome using SignalP, EffectorP, and deepTMHMM.

## Citation
If you use the data or scripts in this repository, please cite:
> Doddi, A. *et al.* (2026). A chromosome-level genome assembly of the Fusarium oxysporum biocontrol strain FO12.

## Data Availability
The final assembled genome is available at NCBI GenBank under accession **GCA_055853645.1**. Raw sequencing data (Nanopore and Hi-C) are deposited under BioProject **PRJNA1426711**.
