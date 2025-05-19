#!/bin/bash
#SBATCH --job-name=star_align
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=06:00:00
#SBATCH --output=logs/star_align_%j.out
#SBATCH --error=logs/star_align_%j.err

mkdir -p logs

#loading Docker module
module load docker

#defining project path
PROJECT_DIR=/archive/home/frvallon/B-Lymphoma

#running the alignment script using Docker
srun docker run --rm \
  -v $PROJECT_DIR:$PROJECT_DIR \
  -w $PROJECT_DIR \
  gitlab.c3s.unito.it:5000/frvallon/rnaseq_alignment:latest \
  bash ./rnaseq_alignment/star_alignment.sh