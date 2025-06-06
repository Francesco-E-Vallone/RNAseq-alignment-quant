#!/bin/bash

#directories
INPUT_DIR="/archive/home/frvallon/B-lymphoma/fastq"
OUTPUT_DIR="/archive/home/frvallon/B-lymphoma/trimmed"
REPORT_DIR="$OUTPUT_DIR/reports"

#creating output dir if they don't exist
mkdir -p "$OUTPUT_DIR" "$REPORT_DIR"

#setting number of threads (use all but one core)
THREADS=$(nproc --ignore=1)

#looping through all _1.fastq.gz files
for R1 in "$INPUT_DIR"/*_1.fastq.gz; do
    SAMPLE=$(basename "$R1" _1.fastq.gz)
    R2="$INPUT_DIR/${SAMPLE}_2.fastq.gz"

    echo "== Trimming sample: $SAMPLE =="

    fastp \
        -i "$R1" -I "$R2" \
        -o "$OUTPUT_DIR/${SAMPLE}_1.trimmed.fastq.gz" \
        -O "$OUTPUT_DIR/${SAMPLE}_2.trimmed.fastq.gz" \
        --detect_adapter_for_pe \
        --thread "$THREADS" \
        --html "$REPORT_DIR/${SAMPLE}_fastp.html" \
        --json "$REPORT_DIR/${SAMPLE}_fastp.json"
done

echo "== All samples trimmed. Output in: $OUTPUT_DIR =="