#!/bin/bash
#2>&1 | tee

srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # srcdir is the location of this script and should contain all other scripts
rawdir=$PWD # rawdir is the location the script was run from and should only contain the bcl directory



########################################################### QC and trimming ####################################################################

echo -e "\n"Fastp ${1}"\n"
sbatch -J=fp --output=$rawdir/log/fastp_${1}.log --wait $srcdir/fastp_slurm.sh ${1}



######################################################### Alignment and sorting ####################################################################

echo -e "\n"Aligning ${1}"\n"
sbatch -J=bt --output=$rawdir/log/bt2_${1}.log --wait $srcdir/bt2_slurm.sh ${1}



############################################################### mpileup and mprofiling ####################################################################

echo -e "\n"StructureMap ${1}"\n"
sbatch -J=sm --output=$rawdir/log/strucmap_${1}.log --wait $srcdir/strucmap_slurm.sh ${1}

echo -e "\n"Mpileup ${1}"\n"
sbatch -J=mp --output=$rawdir/log/mpileup_${1}.log --wait $srcdir/mpileup_slurm.sh ${1}

echo -e "\n"callMUT ${1}"\n"
sbatch -J=cm --output=$rawdir/log/callmut_${1}.log --wait $srcdir/callmut_slurm.sh ${1}

rm $rawdir/rawdata/${1}.mpileup

echo -e "\n"Analysis ${1}"\n"
sbatch -J=gm --output=$rawdir/log/gman_${1}.log --wait $srcdir/gmanalysis_slurm.sh ${1}



