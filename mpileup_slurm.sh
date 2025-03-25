#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=1 
#SBATCH --mem=200G
#SBATCH --time=0-10:00:00
#SBATCH -p general

echo -e mpileup ${1}"\n"

samtools mpileup --no-BAQ -d 1000000000 ${1}sort.bam -f GRCh38.p10.genome.fa | cut -f -5 > ${1}.mpileup


