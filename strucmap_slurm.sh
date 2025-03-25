#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=1
#SBATCH --mem=20G
#SBATCH --time=0-05:00:00
#SBATCH -p general

echo -e StructureMap ${1}"\n"

StructureMap -i ${1}sort.bam -o ${1}.sprofile -im 2000 -fs ${1}_lens.txt 

