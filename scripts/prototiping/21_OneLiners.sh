#Creates a table used to do a manhattan plot with pvalues and positions in the chromosome. The input file is the output from pyseer
cat <(echo "CHR SNP BP P B MDS MAF") <(paste <(sed "1d" /home/claudio/nas/A22.0P5_FE_SNPS.txt | cut -d "_" -f 2) <(sed "1d" /home/claudio/nas/A22.0P5_FE_SNPS.txt | cut -f 4) <(sed "1d" /home/claudio/nas/A22.0P5_FE_SNPS.txt | cut -f 5) <(sed "1d" /home/claudio/nas/A22.0P5_FE_SNPS.txt | awk '{ print ( $(NF-2) ) }') <(sed "1d" /home/claudio/nas/A22.0P5_FE_SNPS.txt | cut -f 2) | awk '{if($5>0.5){print "26",".",$1,$2,$3,$4,1-$5}else{print "26",".",$1,$2,$3,$4,$5}}' ) | tr " " "\t" > /home/claudio/nas/A22.0P5_FE_SNPS.plot 


##Creates a table with the ID of the strain and its full path .tsv
cat <(echo "ID Path") <(paste<(for f in /path/to/gfile/*; do basename $f .fa; done) <(for f in /path/to/file/*: do readlink -m $f; done) | awk '{ print $Â1, $2}') | tr " " "\t" > output.out
