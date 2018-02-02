#!/bin/sh

for s in `cat sublist`; do 
	if [ $s -lt 119833 ]; then
		aws s3 cp --recursive /data/Analysis/$s s3://ppitest/$s
	fi
done

