#!/bin/bash
path=/archive/home/frvallon/B-lymphoma

# Use SLURM-defined threads if available, else default to 1
THREADS=${SLURM_CPUS_PER_TASK:-1}

#inspecting a read length from a fastq file (parameter for the alignment)
read_length=$(gunzip -c $path/fastq/SRR2149844_1.fastq.gz | awk "NR==2 {print length; exit}") #it returned 75
echo "Length of the reads is $read_length"

#setting paths
g_dir=$path/refseq #path to the directory where the genome index will be stored
g_fna=$g_dir/GCF_000001405.40_GRCh38.p14_genomic.fna #path to the genome fasta file
g_anno=$g_dir/genomic.gtf #path to the annotation file

#running STAR genome indexing   
STAR --runMode genomeGenerate \
     --genomeDir $g_dir \
     --genomeFastaFiles $g_fna \
     --sjdbGTFfile $g_anno \
     --sjdbOverhang $((read_length - 1)) \
     --runThreadN $THREADS

echo "Genome indexing completed"