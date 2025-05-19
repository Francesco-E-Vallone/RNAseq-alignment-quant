#!/bin/bash
#SBATCH --job-name=counts_quant
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=02:00:00
#SBATCH --output=logs/counts_quant_%j.out
#SBATCH --error=logs/counts_quant_%j.err

#making sure logs/ exists
mkdir -p logs

#defining working directory
PROJECT_DIR=/archive/home/frvallon/B-lymphoma
SCRIPT_DIR=/archive/home/frvallon/rnaseq_alignment

#loading Docker module
module load docker

#running the script inside the Docker image
srun docker run --rm \
  -v $PROJECT_DIR:$PROJECT_DIR \
  -v $SCRIPT_DIR:$SCRIPT_DIR \
  -w $SCRIPT_DIR \
  registry.gitlab.c3s.unito.it/frvallon/rnaseq_alignment/rnaseq_align:latest \
  bash "$SCRIPT_DIR/3.counts_quant.sh"