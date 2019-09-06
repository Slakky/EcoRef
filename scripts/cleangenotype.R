df.1 <- read.table(file = "raw_data/genotypes.tsv", sep = "\t", header = TRUE)
ID <- colnames(df.1)
cleanID <- gsub("(.*)_.*", "\\1", ID)
colnames(df.1) <- cleanID
write.table(df.1, file='raw_data/gen.tsv', quote=FALSE, sep='\t', col.names = NA)
