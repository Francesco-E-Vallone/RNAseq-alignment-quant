#!/bin/bash
#SBATCH --job-name=star_index
#SBATCH --cpus-per-task=8
#SBATCH --mem=60G
#SBATCH --time=10:00:00
#SBATCH --output=logs/star_index_%j.out
#SBATCH --error=logs/star_index_%j.err

mkdir -p logs

#loading the Docker module
module load docker

#defining dir
PROJECT_DIR=/archive/home/frvallon/B-Lymphoma

#creating log folder
mkdir -p $PROJECT_DIR/logs

#running the STAR indexing script inside the Docker image
srun docker run --rm \
  -v $PROJECT_DIR:$PROJECT_DIR \
  -w $PROJECT_DIR \
  registry.gitlab.c3s.unito.it/frvallon/rnaseq_alignment/rnaseq_align:latest \
  bash ./1.star_genome_indexing.sh