#!/bin/bash

task=WM
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_PPI
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_Act.feat/filtered_func_data.nii.gz
NVOLUMES=`fslnvols ${DATA}`

# checking L1 output
if [ -e ${OUTPUT}.feat/stats/cope7.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.feat
fi

#EV files
EVDIR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs

#generate mask's timecourse
MASK=${basedir}/Masks/rT1_DLPFC_Seed.nii
TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/my_timecourse.txt
fslmeants -i $DATA -o $TIMECOURSE -m $MASK

#find and replace: run feat for smoothing
ITEMPLATE=${basedir}/templates/L1_WM_PPI_fixed.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_WM_PPI_fixed.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVDIR@'$EVDIR'@g' \
-e 's@TIMECOURSE@'$TIMECOURSE'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
