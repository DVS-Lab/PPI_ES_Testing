#!/bin/bash

task=EMOTION
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir

OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_Act
DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/smoothing.feat/ICA_AROMA/denoised_func_data_nonaggr.nii.gz
NVOLUMES=`fslnvols ${DATA}`

# checking L1 output
if [ -e ${OUTPUT}.feat/cluster_mask_zstat1.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.feat
fi

#EV files
EVFEAR=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/fear.txt
EVNEUT=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/neut.txt

#find and replace: run feat
ITEMPLATE=${basedir}/templates/L1_Emo_Act.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Emotion_Act.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@DATA@'$DATA'@g' \
-e 's@NVOLUMES@'$NVOLUMES'@g' \
-e 's@EVFEAR@'$EVFEAR'@g' \
-e 's@EVNEUT@'$EVNEUT'@g' \
<$ITEMPLATE> $OTEMPLATE
feat $OTEMPLATE

#delete unused files
#rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz
