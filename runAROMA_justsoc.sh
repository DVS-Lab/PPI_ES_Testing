#!/bin/bash

basedir=`pwd`
cd ..
MAINDATADIR=/s3/hcp
MAINOUTPUTDIR=`pwd`/Analysis
cd $basedir


for task in SOCIAL EMOTION WM; do
    for subj in `cat sublist`; do
	for RUN in LR RL; do

		#Manages the number of jobs and cores
		SCRIPTNAME=runAROMA.sh
		NCORES=28
		while [ $(ps -ef | grep -v grep | grep $SCRIPTNAME | wc -l) -ge $NCORES ]; do
	  		sleep 1m
		done

		bash runAROMA.sh $task $RUN $subj &
		sleep 1

	done

    done
done

bash runL1_all_justsoc.sh
