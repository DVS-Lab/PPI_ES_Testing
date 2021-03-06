#!/bin/bash

NCORES=28

# WM task
#for subj in `cat sublist`; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_WM_Act.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
    #bash L1_WM_Act.sh $run $subj &
  #done
#done

# Social task
#for subj in `cat sublist`; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_Soc_Act.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
    #bash L1_Soc_Act.sh $run $subj &
  #done
#done

for subj in `cat sublist`; do
  for run in LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_PPI.sh | wc -l) -ge $NCORES ]; do
        sleep 3s
    done
    bash L1_Soc_PPI.sh $run $subj &
  done
done

#for subj in `cat sublist`; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_Soc_nPPI.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
   # bash L1_Soc_nPPI.sh $run $subj &
  #done
#done


# Emotion task
#for subj in `cat sublist`; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_Emo_Act.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
    #bash L1_Emo_Act.sh $run $subj &
  #done
#done

#for subj in `cat sublist`; do
 # for run in RL LR; do
    #Manages the number of jobs and cores
  #  while [ $(ps -ef | grep -v grep | grep L1_Emo_PPI.sh | wc -l) -ge $NCORES ]; do
   #     sleep 1m
    #done
    #bash L1_Emo_PPI.sh $run $subj &
  #done
#done




#for subj in `cat sublist`; do
#  for run in RL LR; do
#    #Manages the number of jobs and cores
#    while [ $(ps -ef | grep -v grep | grep L1_WM_PPI.sh | wc -l) -ge $NCORES ]; do
#        sleep 1m
#    done
#    bash L1_WM_PPI.sh $run $subj &
#  done
#done
