#! /usr/bin/Rscript

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Please supply the condition you.n", call.=FALSE)
  }

## input:
condition <- args[1]
d.m <- as.matrix(read.table(file = sprintf('/home/claudio/Comp_Genetics/%s_Results/%s_Distance_Matrix.tsv', condition, condition), sep = '\t', header = TRUE))
d.m[is.na(d.m)] <- 0
library(ape)
my.tree <- nj(dist(d.m))
my.tree$tip.label <- d.m[,1]
write.tree(my.tree, file=sprintf('/home/claudio/Comp_Genetics/%s_Results/%s_Tree.nwk', condition, condition), tree.names = TRUE)
