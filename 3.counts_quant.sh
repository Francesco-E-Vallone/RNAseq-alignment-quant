#!/bin/bash

#setting number of threads (use all but one core)
THREADS=$(nproc --ignore=1)

#defining paths
PROJECT_DIR="/archive/home/frvallon/B-lymphoma"
BAM_PARENT="$PROJECT_DIR/bam"
COUNTS_DIR="$PROJECT_DIR/raw_counts"
GTF="$PROJECT_DIR/refseq/genomic.gtf"
OUT_FILE="$COUNTS_DIR/gene_counts.txt"

#creating output directory
mkdir -p "$COUNTS_DIR"

#creating temporary directory to store renamed BAMs
TEMP_BAMS=$(mktemp -d)
echo "== Temporary BAM directory: $TEMP_BAMS =="

#copying and renaming each BAM file using its subdir name
COPIED=0
for DIR in "$BAM_PARENT"/*; do
    SAMPLE=$(basename "$DIR")
    BAM="$DIR/Aligned.sortedByCoord.out.bam"
    if [[ -f "$BAM" ]]; then
        echo "Copying $BAM to $TEMP_BAMS/${SAMPLE}.bam"
        cp "$BAM" "$TEMP_BAMS/${SAMPLE}.bam"
        COPIED=$((COPIED + 1))
    else
        echo "== WARNING: BAM not found in $DIR =="
    fi
done

if [[ "$COPIED" -eq 0 ]]; then
    echo "== ERROR: No BAM files found. Exiting. =="
    exit 1
fi

echo "== Running featureCounts on $COPIED BAM files... =="
featureCounts -p -s 2 -T "$THREADS" -t exon -g gene_id \
    -a "$GTF" -o "$OUT_FILE" "$TEMP_BAMS"/*.bam

#removing temp files
rm -r "$TEMP_BAMS"

echo "== FeatureCounts completed. Output saved to: $OUT_FILE =="