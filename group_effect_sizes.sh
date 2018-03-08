#!/bin/bash

#SBATCH --job-name=EffectSizes
#SBATCH --output=error/out.EffectSizes
#SBATCH --error=error/err.EffectSizes
#SBATCH --time=3:00:00
#SBATCH --nodes=1
#SBATCH --partition=russpold
#SBATCH --qos=russpold

# Directory of Connectome in a box
#ConnectomeInABoxDir=$HCPDIR

# Experiment to be analyzed
Paradigm=("WM" "EMOTION" "SOCIAL")

# Which contrast from the experiment
#NContrasts= 7
#WM Contrast 6: 2bk_ppi > 0bk_ppi, Emo Contrast 4: Fear_ppi > Neut_ppi,Social Contrast 6: Mental_ppi > Random_ppi
Contrast = (6 4 6)

# Working Directory
#WorkDir=/home/jdurnez/effect_sizes/HCP_group_effect_sizes/
WorkDir=/mnt/c/Users/tue90350/Desktop/EffectSizeAnalysis/

# File with subjects to be included and disks on which they appear
#SubjectsFile=$WorkDir/SubjectSelection/IDs_all_cons_and_unrelated.txt
SubjectsFile=/mnt/c/Users/tue90350/Documents/GitHub/PPI_ES_Testing/sublist

for exp in {0..2} ; do
    ConDir=$WorkDir/*/tfMRI_${Paradigm[exp]}/

    # Extract Effectsizes
    python $WorkDir/EffectSize/EffectSize.py ${Paradigm[exp]} $ConDir $WorkDir/
  #done
done
