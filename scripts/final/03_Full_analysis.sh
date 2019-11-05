#!/bin/sh

for i in $(awk 'NR>1{print $2}' /home/claudio/Comp_Genetics/results/bugwas_phenotypes.tsv | cut -d'_' -f 1 | sort | uniq);
	do python3 15_WashData_LinLoc.py $i;
	done

