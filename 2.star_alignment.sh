
#!/bin/bash

#determine number of threads to use (all but one core)
THREADS=$(nproc --ignore=1)

#setting directories
FASTQ_DIR="/archive/home/frvallon/B-lymphoma/fastq"
GENOME_DIR="/archive/home/frvallon/B-lymphoma/refseq"
OUT_DIR="/archive/home/frvallon/B-lymphoma/bam"

#creating output directory if it doesn't exist
mkdir -p "$OUT_DIR"

#looping through all *_1.fastq.gz files
for R1 in "$FASTQ_DIR"/*_1.fastq.gz; do
    SAMPLE=$(basename "$R1" _1.fastq.gz)
    R2="$FASTQ_DIR/${SAMPLE}_2.fastq.gz"

    echo "Processing sample: $SAMPLE"

    #making output subdir
    SAMPLE_OUT="$OUT_DIR/$SAMPLE"
    mkdir -p "$SAMPLE_OUT"

    #running STAR
    STAR --runThreadN "$THREADS" \
         --genomeDir "$GENOME_DIR" \
         --readFilesIn "$R1" "$R2" \
         --readFilesCommand zcat \
         --outFileNamePrefix "$SAMPLE_OUT/" \
         --outSAMtype BAM SortedByCoordinate \
         --quantMode GeneCounts
    echo "STAR alignment completed for $SAMPLE"
done