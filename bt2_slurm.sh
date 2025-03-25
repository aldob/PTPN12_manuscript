#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=18
#SBATCH --mem=120G
#SBATCH --time=5-00:00:00
#SBATCH -p general

echo -e Alignment ${1}"\n"

(bowtie2 -t -p 18 --fr --maxins 2000 --dovetail --ignore-quals -D 20 -R 4 -N 1 --np 0 --dpad 49 --gbar 2 --mp 3.2,0.35 --rdg 1,1 --rfg 5,2 --score-min L,-1.0,-0.5 -x hg38 \
-1 ${1}_qc1.fq.gz -2 ${1}_qc2.fq.gz \
| samtools sort -o ${1}sort.bam -O bam -l 0 -@ 18 -m 5G) \
2> $rawdir/log/${1}_align.log

samtools index ${1}sort.bam
