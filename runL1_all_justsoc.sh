#!/bin/bash

NCORES=28

# Social task
for subj in `cat sublist`; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_Act.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_Act.sh $run $subj &
  done
done

for subj in `cat sublist`; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_PPI.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_PPI.sh $run $subj &
  done
done

for subj in `cat sublist`; do
  for run in RL LR; do
    #Manages the number of jobs and cores
    while [ $(ps -ef | grep -v grep | grep L1_Soc_nPPI.sh | wc -l) -ge $NCORES ]; do
        sleep 1m
    done
    bash L1_Soc_nPPI.sh $run $subj &
  done
done

bash runL2_all.submit
