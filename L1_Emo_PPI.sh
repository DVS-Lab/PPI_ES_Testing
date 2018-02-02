#!/bin/bash

task=EMOTION
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_PPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_Act.feat/filtered_func_data.nii.gz
NVOLUMES=`fslnvols ${DATA}`

# checking L1 output
if [ -e ${OUTPUT}.feat/cluster_mask_zstat7.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.feat
fi

#EV files
EVFEAR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/fear.txt
EVNEUT=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/neut.txt

#generate mask's timecourse
MASK=${basedir}/Masks/rT1_Amygdala_Seed.nii
TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/my_timecourse.txt
fslmeants -i $DATA -o $TIMECOURSE -m $MASK

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_EMO_PPI_fixed.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_PPI_fixed.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVFEAR@'$EVFEAR'@g' \
-e 's@EVNEUT@'$EVNEUT'@g' \
-e 's@TIMECOURSE@'$TIMECOURSE'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
