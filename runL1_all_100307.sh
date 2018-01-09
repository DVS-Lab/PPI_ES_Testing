#!/bin/bash

NCORES=28

# Social task
#for subj in `cat sublist`; do
for subj in 100307; do 
 for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_Act.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_Act.sh $run $subj &
  done
done

# Emotion task
#for subj in `cat sublist`; do

for subj in 100307; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Emo_Act.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Emo_Act.sh $run $subj &
  done
done

# WM task
#for subj in `cat sublist`; do
for subj in 100307; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_WM_Act.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_WM_Act.sh $run $subj &
  done
done


#Since PPI scripts need filtered_func file from Act scripts
sleep 15m

#for subj in `cat sublist`; do

for subj in 100307; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_PPI.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_PPI.sh $run $subj &
  done
done

#for subj in `cat sublist`; do

for subj in 100307; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_nPPI.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_nPPI.sh $run $subj &
  done
done


#for subj in `cat sublist`; do
for subj in 100307; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Emo_PPI.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Emo_PPI.sh $run $subj &
  done
done


#for subj in `cat sublist`; do
#for subj in 100307; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_WM_PPI.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
    #bash L1_WM_PPI.sh $run $subj &
 # done
#done


