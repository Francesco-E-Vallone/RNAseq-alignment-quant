#!/bin/bash

#defining paths
PROJECT_DIR="/archive/home/frvallon/B-lymphoma"
BAM_DIR="$PROJECT_DIR/alignment"
COUNTS_DIR="$PROJECT_DIR/raw_counts"
GTF="$PROJECT_DIR/refseq/genomic.gtf"
OUT_FILE="$COUNTS_DIR/gene_counts.txt"

#creating output directory
mkdir -p "$COUNTS_DIR"

#running featureCounts on all BAMs in one go
featureCounts -p -a "$GTF" -o "$OUT_FILE" "$BAM_DIR"/*.bam

echo "FeatureCounts completed. Output saved to: $OUT_FILE"