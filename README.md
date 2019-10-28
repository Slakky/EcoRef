# Genetic landscape and overview of the Ecoref dataset [1]

### Brief description of the course

This research training course has been carried out at the IMBIM department of Comparative genetics and functional genomics in Uppsala University. Specifically at Örjan Carlborg research group. The course took place from the 1st of September to mid November. 

Carlborg's group is focused on the search of genetic variants in the genome that are related to specific phenotypes of interest. This is done through the development of new bioinformatic tools and statistical methods to analyse the large amount of genetic information produced nowadays. Currently the group has two main lines of research, both of them focusing on the modifying effects other genes interactions and the environment have over certain variants. One of these lines -and their main focus right now- is focusing on the discovery of new variants of interest by analysing gene by gene interactions ('GxG' from now on) integrating both low coverage genome sequencing and evolutionary information. The other line is aimed to study gene by environment ('GxE' from now on) interactions, with this approach the team has been able to identify environmental effects on epistatic loci [2].

As a bioinformatics focused research laboratory, a common day at Carlborg's group revolves around coding. We have an indefinite lunch break and a *fika* break occasionally.

Every friday we have a group meeting where everyone explains what has been done over the week and shows any results that  may have. On these group meetings I've had the oportunity to learn more about what the team is doing in terms of scientific research and I've also been able to learn new things about population genetics and genomics. Once a month there's a genomics section meeting where general administrative topics are discussed with all members of the department. 

As I've mentioned before, the group has two main lines of research. The one I've taken part of focuses on gene by gene by environment interactions. The group's idea is to do the same kind of analysis performed on yeast [2] on other species' datasets. What I've been doing on this research training course is a literature research to choose the most suitable software and to code the starting pipeline for the analyses. This will help the team on their future GxGxE projects.

<!-- you will need to group this report into two parts, that i hereby designate "the boring part" and "the exciting part".
from the student instructions for the research internship:
Boring part:
  - Background, where, when and for how long.

  - Describe the central activities of your workplace.
    * this should be a general summary of our research focus, i guess?
    * i'd argue to go heavy on the GxE part, and skim on the GxG ( i.e. Chicken) part

  - A short description of a common work day.
    * given that our days are not that variable, this should be easy.

  - A short description of group meetings, literature seminars, etc.
    * that should cover Group meetings, Genomics section meetings, Genomic seminars(hardly any, because no one wants to be a speaker.)



Interesting part:
  - short description of personnel, methods, equipment and possible research results.
    * this is the "paper-style report" that you've been working on.

- Briefly summarize your theory task
  * since the "theory task" we gave you is kinda "figure out these methods and problems", i reckon that we cover this with the introduction. I also assume that this document is rather geared towards laboratory work, and the theory part is to make sure we dont just use you as a pipetting-slave.

  - References to publications or similar.

  - Self-assessment of your experience during the research training.
  - What worked well and what could have been done better?
    * I'm, not sure how / where we fit this in. do you think it has to be its own section, or do we hide this in the discussion?
 -->
 
<!---### Project initial goals

1. Try to replicate the general trends seen on yeast [2]
1. Gain coding confidence both in Python and R
2. Learn the basics of Genome Wide Association Studies
3. Beef up statistical knowledge
4. Independent research and problem solving
-->

## Introduction

One of the main focuses of biology during the past 50 years has been the characterization of the genetic variation associated to certain diseases or anthropomorphic phenotypes such as weight or height. This has been possible thanks to the sequencing of the human genome [reference needed] and the discovery of whole-genome SNPs [Sachidanandam et al., 2001]. This led to the design of arrays that were able to genotype several variants in a genome-wide fashion. During the last decade, with the prices of sequencing a whole genome getting cheaper and cheaper, high-throughput sequencing has been the technology of choice, knocking off SNP arrays. 

With both marker information - derived from variant calling on sequencing results - , and phenotypic measures Genome Wide Association Studies (GWAS) can be performed to test for association between the trait and the genetic variants in a population of interest.


Traditionally, quantitative trait loci (QTLs) have been identified using linkage mapping populations such as recombinant inbred lines (RILs) and double haploid lines (DHs). However, such mapping populations are often generated from a cross between two parental lines. As a result, only a limited amount of natural allelic diversity can be captured in the population, leading to the identified QTLs spanning relatively large genomic regions and making identification of causal genes more difficult. Genome-wide association study (GWAS) utilizes the natural populations for QTL detection though marker-trait association [12, 13]. Integration of linkage mapping and GWAS provides a more powerful tool for identifying and verifying candidate genes underlying complex traits 
While GWAS studies tests association at discrete markers, Quantitative Trait Locus mapping (QTL mapping) tests association between markers, usually identifying significant genes.

But GWAS and QTL mapping 

Carlborg's lab was able to apply these concepts to identify GxGxE interactions on a yeast dataset

we have been able to find genetic variation which may contribute to a given phenotype of interest in a hypothesis-free manner. 

Introduce GWAS topic and results previously seen on yeast. 3 - 4 sentences top.

Why perform this analysis? 

Bacterial GWAS two main problems we need to deal with: strong pop structure and causative variation presence on the pangenome

haploid clonal nature -> all variants are correlated. If after 100 generations we introduce 50 new mutations of which one is causal of the phenotype of study, we will not be able to pinpoint with enough resolution the variant as causal. Instead we would find that all 50 variants are related to the phenotype (since they are correlated between them)

This is not specific to bacteria tho, In other organisms GWASs there is also correlation between variants due to LD, but this usually decays after some kb, allowing us to map the association to certain regions. This is not possible in bacteria bc LD is present genome-wide. All of this results in a strong population structure that will greatly increase type I error (false positives).

But not every causative variant is going to be hidden under lineage effects. There are cases were an association might be correctly mapped to locus effects. Both horizontal DNA transfer and homoplasy across the genealogy can help break the LD and the correlation of variants across the genome. The relative importance of either of these factors will depend on the species of study.

The classic approach of snp calling against a reference although usefull as a first attempt at describing the population, doesnt allow us to map most common variation present in the pangenome. The alignment nature of SNP calling implies that there are going to be missaligned regions that will jeopardize our power to detect variants of interest. This gets worse when we have big amounts of sequences not shared between the whole population.

aims


## Methods

I dont know where to comment on the dataset (number of strains, environments, origin etc). For me it makes more sense to comment on it in methdos but idk.  

Two different approaches to the problem: bugwas [3] and pyseer [4].

Explain what is bugwas based on, how does it solve the two problems described above. Document the python script used to properly format the data for bugwas. Mention also snakemake.

Why I didnt trust the bugwas results? -> there's no support for continuous phenotypes, not clear output, manhattan plots are filled with lineage effects.

<!--- regarding the lineage effects in bugwas: just out of interest, which MAF did you use? --->

How does pyseer improve this? Explain the three different runs I made.

  - genotype variation using SNPs (VCF)
    - population structure -> mash
    - population structure -> phylogeny
    - population structue -> genotype kinship
  - genotype variation using kmers
    Comment on the scripts used to get the assemblies and to count unitigs [5]


Document the scripts to format the data for the input and plotting. This time the formatting scripts are based on command tools such awk and sed. Ideally I would make a snake pipeline with an option to choose the type of run.


## Results

If I see something interesting on the 4 environments im prototyping now -> show different results (bugwas pyseer and different runs within pyseer) in the 4 different environments.

Show whatever is my final result if applicable

<!-- i think you can easily use some of some of the manhattan plots here, or show the pvalue distributions we talked about. one of the stated targets of the project was to " figure out" which software to use. making a comparison between what you chose to use, and for example bugwas with strong lineage effects would be nice to see, particularly if you pick a condition/environment with strong lineage effects -->

## Discussion
<!--
- how much do i trust these results?
  - what are possible factors biasing my results?
  - is there anything that could be done next/differently in order to alleviate these biases?

- what are the next steps?
-->

Will my work be useful? Is it replicable? Is it reproducible?

Comment on what I learnt and experience??


## Bibliography

1. Galardini, M. et al. Phenotype inference in an Escherichia coli strain panel. eLife 6, (2017).
2. Zan, Y., Carlborg, O. Yeast growth responses to environmental perturbations are associated with rewiring of large epistatic networks bioRxiv 659730
3. Moore, J., Asselbergs, F. & Williams, S. Bioinformatics challenges for genome-wide association studies. Bioinformatics 26, 445-455 (2010).
4. Forsberg, S., Bloom, J., Sadhu, M., Kruglyak, L. & Carlborg, Ö. Accounting for genetic interactions improves modeling of individual quantitative trait phenotypes in yeast. Nature Genetics 49:497-503 (2017).
5. Earle, S. et al. Identifying lineage effects when controlling for population structure improves power in bacterial association studies. Nature Microbiology 1, (2016).
6. Lees, John A., Galardini, M., et al. pyseer: a comprehensive tool for microbial pangenome-wide association studies. Bioinformatics 34:4310–4312 (2018).
7. Jaillard M., Lima L. et al. A fast and agnostic method for bacterial genome-wide association studies: Bridging the gap between k-mers and genetic events. PLOS Genetics. 14, e1007758 (2018).
