#!/bin/bash

BASEDIR=`pwd`
cd ..
MAINDATADIR=`pwd`/Data
MAINOUTPUTDIR=`pwd`/Analysis
cd $BASEDIR

##bash L2_Emotion_PPI.sh $subj $task $run
subj=$1

INPUT01=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_LR/L1_Emotion_PPI.feat
INPUT02=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_RL/L1_Emotion_PPI.feat
OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_Emotion_PPI

# checking L2 output
NCOPES=7 #check last cope since they are done sequentially
if [ -e ${OUTPUT}.gfeat/cope${NCOPES}.feat/cluster_mask_zstat1.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.gfeat
fi

for run in LR RL; do
  rm -rf ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_${run}/L1_Emotion_PPI.feat/reg
  mkdir -p ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_${run}/L1_Emotion_PPI.feat/reg
  ln -s $FSLDIR/etc/flirtsch/ident.mat ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_${run}/L1_Emotion_PPI.feat/reg/example_func2standard.mat
  ln -s $FSLDIR/etc/flirtsch/ident.mat ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_${run}/L1_Emotion_PPI.feat/reg/standard2example_func.mat
  ln -s $FSLDIR/data/standard/MNI152_T1_2mm.nii.gz ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_EMOTION_${run}/L1_Emotion_PPI.feat/reg/standard.nii.gz
done

#find and replace
ITEMPLATE=${BASEDIR}/templates/L2_Emo_PPI.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_Emotion_PPI.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@INPUT01@'$INPUT01'@g' \
-e 's@INPUT02@'$INPUT02'@g' \
<$ITEMPLATE> $OTEMPLATE

#runs feat on output template
feat $OTEMPLATE
