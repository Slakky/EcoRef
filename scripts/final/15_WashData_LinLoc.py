#!/usr/bin/python
import sys
import pandas as pd
import collections
import matplotlib.pyplot as plt
import subprocess
import glob


# calling the script like script.py [condition to test]  
condition = sys.argv[1]

# snakemake mkdirs automatically subprocess.call(['mkdir', '/home/claudio/Comp_Genetics/{0}_Results/'.format(condition)])

all_phenotypes = pd.read_csv('/home/claudio/Comp_Genetics/input/bugwas_phenotypes.tsv', sep = '\t')
genotypes = pd.read_csv('/home/claudio/Comp_Genetics/raw_data/genotypes_noref_formatted.tsv', sep = '\t')

subset_phenotypes = all_phenotypes[all_phenotypes['pheno'].str.contains(condition)]
genotypes_1 = genotypes.rename(columns={"Unnamed: 0":"ps"}) # when importing the df it defaults the first column to unnamed

ini_samples_genotypes = list(genotypes_1.columns.values[2:])
ini_samples_phenotypes = list(subset_phenotypes.iloc[:,0])

# Removing the reference sample from the phenotypes (aka NT12001, this is specific to the given dataset). Maybe compare here the two initial lists to see if they match and then proceed accordingly, i.e. remove the non matching samples from one or another
ini_samples_phenotypes = [sample for sample in ini_samples_phenotypes if sample != 'NT12001']

# Which are the samples that do not match between pheno and geno
nomatch_samples = [sample for sample in ini_samples_phenotypes if sample not in ini_samples_genotypes]
nomatch_samples = list(dict.fromkeys(nomatch_samples)) #unique
    
# Get rid of duplicates and nomatching samples on the phenotypes df
phenotypes_1 = subset_phenotypes.drop_duplicates(subset=['ID'])
phenotypes_2 = phenotypes_1[~phenotypes_1['ID'].isin(nomatch_samples) & phenotypes_1['ID'].isin(ini_samples_phenotypes)] ## ~ = negation
phenotypes_2['pheno'] = phenotypes_2['pheno'].map(lambda x: float(x.split('_')[1])) # taking only the phenotype value (it column has form of 'string_value'


def norm(x): 
    ''' function that normalizes phenotype scores between 0 and 1 '''
    
    y = (x - phenotypes_2['pheno'].min())/(phenotypes_2['pheno'].max() - phenotypes_2['pheno'].min())
    return y

phenotypes_2['pheno'] = phenotypes_2['pheno'].apply(norm)
phenotypes_2.to_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Phenotypes.tsv'.format(condition), sep = '\t', index = False)    

# Get sample list to filter the vcf. Here I use the phenotype dataframe as the template bc I still haven't filtered the genotype dataframe to contain the same samples.
samples_phenotypes = list(phenotypes_2.iloc[:,0])

#I need the samples to filter the tree as a file since I'm using bcftools to filter the vcf (see below).
with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_Filter_Tree.tsv'.format(condition), 'w') as fp:
    fp.write('\n'.join('{}'.format(sample) for sample in samples_phenotypes))
    
# Subset the genotype dataframe with the phenotype samples
samples_phenotypes.insert(0,'ps') #specific to this application, bugwas needs the first column to be named as ps in the genotype dataframe (it's already there but I need to have it on the sample list in order to filter correctly).
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



#bcftools to filter the vcf
with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf'.format(condition), 'w') as bcffile:
    subprocess.call(['bcftools', 'view', '-S', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Filter_Tree.tsv'.format(condition), '/home/claudio/Comp_Genetics/input/snps.vcf.gz'], stdout = bcffile)

#zip and remove    
with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf.gz'.format(condition), 'w') as snpsfile:
    subprocess.call(['bgzip', '-c', '/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf'.format(condition)], stdout = snpsfile)
subprocess.call(['rm', '/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf'.format(condition)])

#tassel to build the tree from the vcf file. The output is a distance matrix.
subprocess.call(['/home/claudio/Comp_Genetics/tassel-5-standalone/run_pipeline.pl', '-Xms512m', '-Xmx10g', '-importGuess', '/home/claudio/Comp_Genetics/{0}_Results/{0}_snps.vcf.gz'.format(condition), '-CreateTreePlugin', '-clusteringMethod', 'Neighbor_Joining', '-endPlugin', '-export', '/home/claudio/Comp_Genetics/{0}_Results/matrix.txt'.format(condition), '-exportType', 'SqrMatrix'])
subprocess.call(['rm', '/home/claudio/Comp_Genetics/{0}_Results/matrix1.txt'.format(condition)])
subprocess.call(['mv', '/home/claudio/Comp_Genetics/{0}_Results/matrix2.txt'.format(condition), '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)])

#Remove the first six lines
with open('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix_2.tsv'.format(condition), 'w') as tsvfile:
    subprocess.call(['tail', '-n', '+6', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)], stdout = tsvfile)
subprocess.call(['mv', '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix_2.tsv'.format(condition), '/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition)])

distance_matrix = pd.read_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition), sep = '\t', header = None)

#The distance matrix does not have column names bc it is assumed to be simmetrical. Here I assign the column names according to the row names (samples), for convenience. 
substitute = list(distance_matrix[0])
substitute.insert(0, 'samples')
distance_matrix.columns = substitute
distance_matrix.to_csv('/home/claudio/Comp_Genetics/{0}_Results/{0}_Distance_Matrix.tsv'.format(condition), sep = '\t', index = None)

subprocess.call (["Rscript", "--vanilla", "/home/claudio/Comp_Genetics/scripts/13_Tree_from_matrix.R", condition])
subprocess.call (["Rscript", "--vanilla", "/home/claudio/Comp_Genetics/scripts/14_General_LinLoc.R", condition])
subprocess.check_call(['mv'] + glob.glob('/home/claudio/Comp_Genetics/scripts/{0}*'.format(condition)) + ['../{0}_Results/'.format(condition)])
subprocess.call(['mv', '/home/claudio/Comp_Genetics/scripts/output', '../{0}_Results/'.format(condition)])

