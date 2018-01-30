#!/bin/bash

BASEDIR=`pwd`
cd ..
MAINDATADIR=`pwd`/Data
MAINOUTPUTDIR=`pwd`/Analysis
cd $BASEDIR

for RUN in LR RL; do 
	for TYPE in Act PPI; do
		SOC=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_SOCIAL_${RUN}/L1_Social_${TYPE}.feat/stats/cope1.nii.gz | wc -l`
		EMO=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_EMOTION_${RUN}/L1_Emotion_${TYPE}.feat/stats/cope1.nii.gz | wc -l`
		WM=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_WM_${RUN}/L1_WM_${TYPE}.feat/stats/cope1.nii.gz | wc -l`
		echo "L1 counts for $RUN $TYPE: Social has $SOC; Emotion has $EMO; WM has $WM"
	done
done

for RUN in LR RL; do 
	DMN=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_SOCIAL_${RUN}/L1_Social_nPPI_DMN.feat/stats/cope1.nii.gz | wc -l`
	ECN=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_SOCIAL_${RUN}/L1_Social_nPPI_ECN.feat/stats/cope1.nii.gz | wc -l`
	echo "L1 counts for $RUN nPPI: Social DMN has $DMN; Social ECN has $ECN"
done

#ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/tfMRI_WM_RL/L1_WM_PPI.feat | wc -l
#ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_WM_PPI.gfeat/stats/cope7.nii.gz | wc -l 

for TYPE in Act PPI; do
	SOC=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_Social_${TYPE}.gfeat/cope1.feat/stats/cope1.nii.gz | wc -l`
	EMO=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_Emotion_${TYPE}.gfeat/cope1.nii.gz | wc -l`
	WM=`ls -1 ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_WM_${TYPE}.gfeat/cope1.feat/stats/cope1.nii.gz | wc -l`
	echo "L2 counts for $TYPE: Social has $SOC; Emotion has $EMO; WM has $WM"
done

DMN=`ls -1d ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_Social_nPPI_DMN.gfeat/cope1.feat/stats/cope1.nii.gz | wc -l`
ECN=`ls -1d ${MAINOUTPUTDIR}/*/MNINonLinear/Results/L2_Social_nPPI_ECN.gfeat/cope1.feat/stats/cope1.nii.gz | wc -l`
echo "L2 counts for nPPI: Social DMN has $DMN; Social ECN has $ECN"


