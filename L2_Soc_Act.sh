#!/bin/bash

BASEDIR=`pwd`
cd ..
MAINOUTPUTDIR=`pwd`/Analysis
cd $BASEDIR

##bash L2_Soc_Act.sh $subj $task $run
subj=$1

INPUT1=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_LR/L1_Social_Act.feat
INPUT2=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_RL/L1_Social_Act.feat
OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_Social_Act

# checking L2 output
NCOPES=2 #check last cope since they are done sequentially
if [ -e ${OUTPUT}.gfeat/cope${NCOPES}.feat/cluster_mask_zstat1.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.gfeat
fi

for run in LR RL; do
  rm -rf ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/reg
  mkdir -p ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/reg
  ln -s $FSLDIR/etc/flirtsch/ident.mat ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/reg/example_func2standard.mat
  ln -s $FSLDIR/etc/flirtsch/ident.mat ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/reg/standard2example_func.mat
  ln -s $FSLDIR/data/standard/MNI152_T1_2mm.nii.gz ${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_SOCIAL_${run}/L1_Social_Act.feat/reg/standard.nii.gz
done

#find and replace
ITEMPLATE=${BASEDIR}/templates/L2_Soc_Act.fsf
OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/L2_Soc_Act.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@INPUT1@'$INPUT1'@g' \
-e 's@INPUT2@'$INPUT2'@g' \
<$ITEMPLATE> $OTEMPLATE

#runs feat on output template
feat $OTEMPLATE

for C in `seq $NCOPES`; do
  rm -rf ${OUTPUT}.gfeat/cope${C}.feat/filtered_func_data.nii.gz
  rm -rf ${OUTPUT}.gfeat/cope${C}.feat/var_filtered_func_data.nii.gz
done
