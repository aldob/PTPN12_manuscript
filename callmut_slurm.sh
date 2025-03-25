#!/bin/bash
#2>&1 | tee

#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=0-05:00:00
#SBATCH -p general

echo -e callMUT ${1}"\n"

callMUT -rb -i ${1}.mpileup -o ${1}.mprofile -ic NA
