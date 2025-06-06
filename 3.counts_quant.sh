
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

#copying and renaming each BAM file using its subdir name
for DIR in "$BAM_PARENT"/*; do
    SAMPLE=$(basename "$DIR")
    BAM="$DIR/Aligned.sortedByCoord.out.bam"
    if [[ -f "$BAM" ]]; then
        cp "$BAM" "$TEMP_BAMS/${SAMPLE}.bam"
    fi
done

#running featureCounts
featureCounts -p -T "$THREADS" -t exon -g gene_id \
    -a "$GTF" -o "$OUT_FILE" "$TEMP_BAMS"/*.bam

#removing temp files
rm -r "$TEMP_BAMS"

echo "== FeatureCounts completed. Output saved to: $OUT_FILE =="