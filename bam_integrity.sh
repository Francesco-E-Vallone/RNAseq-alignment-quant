#!/bin/bash

BAM_DIR=/archive/home/frvallon/B-lymphoma/bam
INVALID_BAMS="invalid_bams.txt"
> $INVALID_BAMS

echo "== Checking BAM file integrity... =="

for bam in $(find $BAM_DIR -name "Aligned.sortedByCoord.out.bam"); do
    samtools quickcheck -v "$bam" 2>&1 | grep -q "was not identified" && echo "$bam" >> $INVALID_BAMS
done

if [[ -s $INVALID_BAMS ]]; then
    echo "== Some BAM files are invalid: =="
    cat $INVALID_BAMS
else
    echo "== All BAM files appear to be valid =="
fi