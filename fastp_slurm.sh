#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=0-00:30:00
#SBATCH -p general

rawdir=$PWD # rawdir is the location the script was run from 

echo -e fastp ${1}"\n"

fastp -w 10 -g -A -l 50 -q 38 -u 5 -p --cut_front --cut_tail --cut_window_size 3 --cut_mean_quality 30 -h ${1}_fastp.html -i ${1}_r1.fq.gz -I ${1}_r2.fq.gz --out1 ${1}_qc1.fq.gz --out2 ${1}_qc2.fq.gz



