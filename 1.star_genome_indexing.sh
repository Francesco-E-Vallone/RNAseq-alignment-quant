#!/bin/bash
path="/archive/home/frvallon/B-lymphoma"

#setting paths
g_dir="/archive/home/frvallon/B-lymphoma/refseq"                                        #path to the directory where the genome index will be stored
g_fna="/archive/home/frvallon/B-lymphoma/refseq/GCF_000001405.40_GRCh38.p14_genomic.fna"  #path to the genome fasta file
g_anno="/archive/home/frvallon/B-lymphoma/refseq/genomic.gtf"                                 #path to the annotation file
 
#setting paths
g_dir="/archive/home/frvallon/B-lymphoma/refseq" #path to the directory where the genome index will be stored
g_fna="/archive/home/frvallon/B-lymphoma/refseq/GCF_000001405.40_GRCh38.p14_genomic.fna" #path to the genome fasta file
g_anno="/archive/home/frvallon/B-lymphoma/refseq/genomic.gtf" #path to the annotation file

THREADS=$(($(nproc) - 1))
echo "Using $THREADS threads for genome indexing"

#running STAR genome indexing   
STAR --runMode genomeGenerate \
     --genomeDir "$g_dir" \
     --genomeFastaFiles "$g_fna" \
     --sjdbGTFfile "$g_anno" \
     --sjdbOverhang 74 \
     --runThreadN "$THREADS"

echo "Genome indexing completed"
