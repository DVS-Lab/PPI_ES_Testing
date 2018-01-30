#!/bin/bash

BASEDIR=`pwd`
cd ..
MAINOUTPUTDIR=`pwd`/Analysis
cd $BASEDIR

##bash L2_Soc_Act.sh $subj $task $run
TYPE=$1
COPENUM=$2

OUTPUT=${MAINOUTPUTDIR}/L3_${TYPE}_${COPENUM}

# checking L3 output
if [ -e ${OUTPUT}.gfeat/cope1.feat/cluster_mask_zstat1.nii.gz ]; then
  exit
else
  rm -rf ${OUTPUT}.gfeat
fi

#find and replace
ITEMPLATE=${BASEDIR}/templates/L3.fsf
OTEMPLATE=${MAINOUTPUTDIR}/L3_${TYPE}_${COPENUM}.fsf
sed -e 's@OUTPUT@'$OUTPUT'@g' \
-e 's@TYPE@'$TYPE'@g' \
-e 's@COPENUM@'$COPENUM'@g' \
<$ITEMPLATE> $OTEMPLATE

#runs feat on output template
feat $OTEMPLATE

# delete old stuff
#rm -rf ${OUTPUT}.gfeat/cope1.feat/filtered_func_data.nii.gz
#rm -rf ${OUTPUT}.gfeat/cope1.feat/var_filtered_func_data.nii.gz
