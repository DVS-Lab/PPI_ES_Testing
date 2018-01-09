#!/bin/bash

task=SOCIAL
run=$1
subj=$2

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir

for RSNmap in DMN ECN; do

  OUTPUT=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_nPPI_${RSNmap}
  DATA=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.feat/filtered_func_data.nii.gz
  NVOLUMES=`fslnvols ${DATA}`

  # checking L1 output
  if [ -e ${OUTPUT}.feat/cluster_mask_zstat1.nii.gz ]; then
    exit
  else
    rm -rf ${OUTPUT}.feat
  fi

  #EV files
  EVMENTAL=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/mental.txt
  EVRND=${MAINDATADIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/EVs/rnd.txt

  #generate mask's timecourse
  NET=${basedir}/Masks/PNAS_2mm_${RSNmap}.nii.gz
  MASK=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.feat/mask
  TIMECOURSE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_Act.feat/net_${RSNmap}_ts.txt
  fsl_glm -i $DATA -d $NET -o $TIMECOURSE --demean -m $MASK

  #find and replace: run feat for smoothing
  ITEMPLATE=${basedir}/templates/L1_SOC_PPI.fsf
  OTEMPLATE=${MAINOUTPUTDIR}/${subj}/MNINonLinear/Results/tfMRI_${task}_${run}/L1_Social_nPPI_${RSNmap}.fsf
  sed -e 's@OUTPUT@'$OUTPUT'@g' \
  -e 's@DATA@'$DATA'@g' \
  -e 's@NVOLUMES@'$NVOLUMES'@g' \
  -e 's@EVMENTAL@'$EVMENTAL'@g' \
  -e 's@EVRND@'$EVRND'@g' \
  -e 's@TIMECOURSE@'$TIMECOURSE'@g' \
  <$ITEMPLATE> $OTEMPLATE
  feat $OTEMPLATE

  #delete unused files
  rm -rf ${OUTPUT}.feat/filtered_func_data.nii.gz
  rm -rf ${OUTPUT}.feat/stats/res4d.nii.gz
  rm -rf ${OUTPUT}.feat/stats/corrections.nii.gz
  rm -rf ${OUTPUT}.feat/stats/threshac1.nii.gz

done
