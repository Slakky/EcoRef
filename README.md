# Genetic landscape and overview of the Ecoref dataset [1]

## Project's initial goals

1. Try to replicate the general trends seen on yeast [2]
1. Gain coding confidence both in Python and R
2. Learn the basics of Genome Wide Association Studies
3. Beef up statistical knowledge
4. Independent research and problem solving

## Problems encountered and solutions  - if applicable

First of all, getting familiar with the dataset and understanding how the data was generated / curated. In this case, the phenotype data obtained
was properly controlled to avoid confounding effects. The phentoype measured in the dataset is growth. This growth is expressed as an s-score
relative to the total growth of the reference strain (strain 'NT12001'). 

On this step I encountered my first problem. The terminology was not consisten through the data, while some times the reference strain was referred 
as 'reference' some others it was referred as 'NT12001'. In order to solve this problem I had to start getting more familiar with UNIX text processing
tools such as *awk* or *sed*, due to their clear advantage over script languages when dealing with huge amount of data and relatively simple
regex operations. Related to this formatting isue I also found that some sample names were not matching between the phenotype data and the genotype data.
That is, in the genotype and phylogenetic data the samples were named following their assembly fasta format convention: 'sample_NNN.fa' where N is any random number 
between 0 and 9 that serves as a unique identifier; while on the phenotype data those were named just with the sample name: 'sample'. 

This was one of the first scripts I wrote with Tilman's help. 
```bash
sed 's:_[0-9]*\.fasta::g' tree.nwk > tree_clear.nwk
```

In perspective I am now able to write more complex sed and awk scripts (see below). 

Once I *thought* the datasets were properly formatted I started to look for available tools in the literature that would allow me
to perform traditional GWAS on the dataset while accounting for population structure and lineage effects. But first I needed to get familiar with this
population genetics terms, since even though I've seen them on lectures I wanted to make sure I understood the concepts on the practical level before jumping
into the whole data in - data out bioinformatic analysis. 

## Bibliography

1. Galardini, M. et al. Phenotype inference in an Escherichia coli strain panel. eLife 6, (2017).
2. Forsberg, S., Bloom, J., Sadhu, M., Kruglyak, L. & Carlborg, Ö. Accounting for genetic interactions improves modeling of individual quantitative trait phenotypes in yeast. Nature Genetics 49, 497-503 (2017).
