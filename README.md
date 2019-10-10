# Genetic landscape and overview of the Ecoref dataset [1]

## Project's initial goals

1. Try to replicate the general trends seen on yeast [2]
1. Gain coding confidence both in Python and R
2. Learn the basics of Genome Wide Association Studies
3. Beef up statistical knowledge
4. Independent research and problem solving

## Introduction

Introduce GWAS topic and results previously seen on yeast. 3 - 4 sentences top.

Bacerial GWAS two main problems we need to deal with: strong pop structure and causative variation presence on the pangenome 

haploid clonal nature -> all variants are correlated. If after 100 generations we introduce 50 new mutations of which one is causal of the phenotype of study, we will not be able to pinpoint with enough resolution the variant as causal. Instead we would find that all 50 variants are related to the phenotype (since they are correlated between them)

This is not specific to bacteria tho, In other organisms GWASs there is also correlation between variants due to LD, but this usually decays after some kb, allowing us to map the association to certain regions. This is not possible in bacteria bc LD is present genome-wide. All of this results in a strong population structure that will greatly increase type I error (false positives). 

But not every causative variant is going to be hidden under lineage effects. There are cases were an association might be correctly mapped to locus effects. Both horizontal DNA transfer and homoplasy across the genealogy can help break the LD and the correlation of variants across the genome. The relative importance of either of these factors will depend on the species of study. 

The classic approach of snp calling against a reference although usefull as a first attempt at describing the population, doesnt allow us to map most common variation present in the pangenome. The alignment nature of SNP calling implies that there are going to be missaligned regions that will jeopardize our power to detect variants of interest. This gets worse when we have big amounts of sequences not shared between the whole population. 


## Methods

I dont where to comment on the dataset (number of strains, environments, origin etc). For me it makes more sense to comment on it in methdos but idk.  

Two different approaches to the problem: bugwas [3] and pyseer [4].

Explain what is bugwas based on, how does it solve the two problems described above. Document the python script used to properly format the data for bugwas. Mention also snakemake. 

Why I didnt trust the bugwas results? -> there's no support for continuous phenotypes, not clear output, manhattan plots are filled with lineage effects. 

How does pyseer improve this? Explain the three different runs I made.

  - genotype variation using SNPs (VCF)
    - population structure -> mash
    - population structure -> phylogeny
    - population structue -> genotype kinship
  - genotype variation using kmers
    Comment on the scripts used to get the assemblies and to count unitigs [5]


Document the scripts to format the data for the input and plotting. This time the formatting scripts are based on command tools such awk and sed. Ideally I would make a snake pipeline with an option to choose the type of run. 


## Results

If I see something interesting on the 4 environments im prototiping now -> show different results (bugwas pyseer and different runs within pyseer) in the 4 different environments.

Show whatever is my final result if applicable

## Discussion

Will my work be usefull? Is it replicable? Is it reproducible? 

Comment on what I learnt and experience??


## Bibliography

1. Galardini, M. et al. Phenotype inference in an Escherichia coli strain panel. eLife 6, (2017).
2. Forsberg, S., Bloom, J., Sadhu, M., Kruglyak, L. & Carlborg, Ö. Accounting for genetic interactions improves modeling of individual quantitative trait phenotypes in yeast. Nature Genetics 49:497-503 (2017).
3. Earle, S. et al. Identifying lineage effects when controlling for population structure improves power in bacterial association studies. Nature Microbiology 1, (2016).
4. Lees, John A., Galardini, M., et al. pyseer: a comprehensive tool for microbial pangenome-wide association studies. Bioinformatics 34:4310–4312 (2018).
5. Jaillard M., Lima L. et al. A fast and agnostic method for bacterial genome-wide association studies: Bridging the gap between k-mers and genetic events. PLOS Genetics. 14, e1007758 (2018). 
