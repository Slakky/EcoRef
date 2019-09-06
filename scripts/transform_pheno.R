phenotypes.df <- read.table(file = "raw_data/phenotypic_data.tsv", sep = "\t", header = TRUE)
df.1 <- subset(phenotypes.df, select = -c(corrected.p.values, growth.defect.phenotype))
colnames(df.1)[colnames(df.1) == "strain"] <- "ID"
colnames(df.1)[colnames(df.1) == "s.scores"] <- "pheno"
df.1$pheno <- paste(df.1$condition, df.1$pheno, sep='_')
df.2 <- subset(df.1, select = -condition)
write.table(df.2, file='raw_data/pheno.tsv', quote=FALSE, sep='\t', col.names = NA)
