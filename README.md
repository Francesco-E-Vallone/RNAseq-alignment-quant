# Burkitt Lymphoma RNA-seq: from FASTQ to normalized TPM counts
This repository contains a reproducible pipeline for processing RNA-seq data from the Burkitt Lymphoma dataset (PRJNA292327). Starting from raw FASTQ files, the workflow includes:
	• Genome indexing with STAR

 •	Read alignment to GRCh38
	
 •	BAM file generation
	
 •	Read count normalization to TPM (Transcripts Per Million)

The goal is to generate high-quality, gene-level normalized expression data suitable for downstream analysis and visualization.
