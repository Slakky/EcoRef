#!/usr/bin/python
import sys
import pandas as pd
import collections
import matplotlib.pyplot as plt
import subprocess

condition = sys.argv[1]

all_phenotypes = pd.read_csv('/home/claudio/Comp_Genetics/results/bugwas_phenotypes.tsv', sep = '\t')
genotypes = pd.read_csv('/home/claudio/Comp_Genetics/raw_data/genotypes_noref_formatted.tsv', sep = '\t')

subset_phenotypes = all_phenotypes[all_phenotypes['pheno'].str.contains(condition)]
genotypes_1 = genotypes.rename(columns={"Unnamed: 0":"ps"})

ini_samples_genotypes = list(genotypes_1.columns.values[2:])
ini_samples_phenotypes = list(subset_phenotypes.iloc[:,0])

# Removing the reference sample from the phenotypes (aka NT12001)
ini_samples_phenotypes = [sample for sample in ini_samples_phenotypes if sample != 'NT12001']

# Which are the samples that do not match
nomatch_samples = [sample for sample in ini_samples_phenotypes if sample not in ini_samples_genotypes]
nomatch_samples = list(dict.fromkeys(nomatch_samples))
    
# Get rid of duplicates and nomatching samples on the phenotypes
phenotypes_1 = subset_phenotypes.drop_duplicates(subset=['ID'])
phenotypes_2 = phenotypes_1[~phenotypes_1['ID'].isin(nomatch_samples) & phenotypes_1['ID'].isin(ini_samples_phenotypes)] ## ~ = negation
phenotypes_2['pheno'] = phenotypes_2['pheno'].map(lambda x: x.split('_')[1])
phenotypes_2.to_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Phenotypes.tsv'.format(condition), sep = '\t', index = False)    
# Get sample list to filter
samples_phenotypes = list(phenotypes_2.iloc[:,0])
with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_Filter_Tree.tsv'.format(condition), 'w') as fp:
    fp.write('\n'.join('{}'.format(sample) for sample in samples_phenotypes))
samples_phenotypes.insert(0,'ps')
    
# Subset the genotype dataframe with the phenotype samples
subset_genotypes = genotypes_1[samples_phenotypes]
    
# Remove invariant sites
invariant_sites = []
for i, k in subset_genotypes.iterrows():
    if len(set(k[1:]))== 1:
        invariant_sites.append(False)
    else:
        invariant_sites.append(True)
subset_genotypes = subset_genotypes[invariant_sites]
subset_genotypes.to_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Genotypes.tsv'.format(condition), sep = '\t', index = False)



with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf'.format(condition), 'w') as bcffile:
    subprocess.call(['bcftools', 'view', '-S', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Filter_Tree.tsv'.format(condition), '/home/claudio/Comp_Genetics/input/snps.vcf.gz'])

with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf.gz'.format(condition), 'w') as snpsfile:
    subprocess.call(['bgzip', '-c', '/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf'.format(condition)])
subprocess.call(['/home/claudio/Comp_Genetics/tassel-5-standalone/run_pipeline.pl', '-Xms512m', '-Xmx10g', '-importGuess', '/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf.gz'.format(condition), '-CreateTreePlugin', '-clusteringMethod', 'Neighbor_Joining', '-endPlugin', '-export', 'hello_there', '-exportType', 'SqrMatrix'])
subprocess.call(['rm', '/home/claudio/Comp_Genetics/scripts/hello_there1.txt'])
subprocess.call(['mv', '/home/claudio/Comp_Genetics/scripts/hello_there2.txt', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)])

with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix_2.tsv'.format(condition), 'rw') as tsvfile:
    subprocess.call(['tail', '-n', '+6', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)])
subprocess.call(['mv', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix_2.tsv'.format(condition), '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)])

distance_matrix = pd.read_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition), sep = '\t', header = None)

substitute = list(distance_matrix[0])
substitute.insert(0, 'samples')
distance_matrix.columns = substitute
distance_matrix.to_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition), sep = '\t', index = None)

subprocess.call (["Rscript", "--vanilla", "/home/claudio/Comp_Genetics/scripts/13_Tree_from_matrix.R", condition])
subprocess.call (["Rscript", "--vanilla", "/home/claudio/Comp_Genetics/scripts/14_General_LinLoc.R", condition])
