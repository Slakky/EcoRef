#!/bin/sh

file_in='/home/claudio/nas/A22.0P5_FE_SNPS.txt'
file_out='/home/claudio/nas/A22.0P5_FE_SNPS.plot'

cat <(echo "#CHR SNP BP minLOG10(P) log10(p) r^2") <(paste <(sed "1d" $file_in | cut -d "_" -f 2) <(sed "1d" $file_in | cut -f 4) | awk '{p = -log($2)/log(10);print "26",".",$1,p,p,"0"}' ) | tr " " "\t" > $file_out

