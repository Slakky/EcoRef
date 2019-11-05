#! /usr/bin/Rscript

args = commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  stop("Please supply the condition you.n", call.=FALSE)
  }

## input:
condition <- args[1]
library(bugwas)
lin_loc(gen = sprintf('/home/claudio/Comp_Genetics/%s_Results/%s_Genotypes.tsv', condition, condition), pheno = sprintf('/home/claudio/Comp_Genetics/%s_Results/%s_Phenotypes.tsv', condition, condition), phylo = sprintf('/home/claudio/Comp_Genetics/%s_Results/%s_Tree.nwk', condition, condition) ,prefix = condition ,gem.path = '/home/claudio/Comp_Genetics/bugwas/gemma/gemma.0.93b', output.dir ='.')
