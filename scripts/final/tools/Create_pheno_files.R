phenotypes.df <- read.table(file = '/home/claudio/nas/phenotypic_data.tsv', sep = "\t", header = TRUE)
df.1 <- subset(phenotypes.df, select = -c(corrected.p.values, growth.defect.phenotype))
colnames(df.1)[colnames(df.1) == "strain"] <- 'samples'
colnames(df.1)[colnames(df.1) == "s.scores"] <- 'pheno'
samples_list <- as.list(levels(unique(df.1$condition)))
for (env in samples_list){
    df.2 <- df.1[df.1$condition == unlist(env),]
    df.3 <- subset(df.2, select = -condition)
    write.table(df.3, file = sprintf('/home/claudio/nas/phenotypes/%s.tsv', unlist(env)), row.names = FALSE, col.names = TRUE, sep='\t', quote = FALSE)
}
df.1[df.1$condition == unlist(samples_list[1]),]
