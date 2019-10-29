# Genetic landscape and overview of the Ecoref dataset [1]

### Brief description of the course

This research training course has been carried out at the IMBIM department of Comparative genetics and functional genomics in Uppsala University. Specifically, at Örjan Carlborg’s research group. The course took place from the 1st of September to mid-November. 

Carlborg's group is focused on the search of genetic variants in the genome that are related to specific phenotypes of interest. This is done through the development of new bioinformatic tools and statistical methods to analyze the large amount of genetic information produced nowadays. Currently the group has two main lines of research, both of them focusing on the modifying effects epistasis and the environment have over variants associated with given phenotypes. One of these lines -and their main focus right now- is focusing on the discovery of new variants of interest by analyzing gene by gene interactions ('GxG' from now on) integrating both low coverage genome sequencing and evolutionary information. The other line is aimed to study gene by environment ('GxE' from now on) interactions, with this approach the team has been able to identify environmental effects on epistatic loci in yeast [1]. These are gene by gene by environment interactions (‘GxGxE’ from now on).

As a bioinformatics focused research laboratory, a common day at Carlborg's group revolves around coding. We have an indefinite lunch break and a fika break occasionally.

Every Friday we have a group meeting where everyone explains what has been done over the week and shows any results that may have. On these group meetings I've had the opportunity to learn more about what the team is doing in terms of scientific research and I've also been able to learn new things about population genetics and genomics. Once a month there's a genomics section meeting where general administrative topics are discussed with all members of the department. 

As I've mentioned before, the group has two main lines of research. The one I've taken part of focuses on gene by gene by environment interactions. The group's idea is to do the same kind of analysis performed on yeast [1] on a bacterial dataset.  In order to identify GxGxE interactions on bacteria we need first to find genetic variants associated with the given phenotype. Once this is done, further interaction analyses can be performed on these variants. During this research training course, I’ve done a literature research to look for available software to detect these variants and choose the most suitable program. In order to do so, I’ve tested two different programs (see Methods section) on a public Escherichia coli dataset [2]. I’ve also built the starting pipeline implementing these programs for the analyses that may be carried out on other bacterial datasets. This will help the team on their future bacterial GxGxE project. 


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

One of the main focuses of biology during the past 50 years has been the characterization of the genetic variation associated to certain phenotypes. It was possible thanks to the sequencing of the human genome [3] and the discovery of whole-genome SNPs [4]. This led to the design of arrays that were able to genotype several variants in a genome-wide fashion. During the last decade, with the prices of whole-genome sequencing getting cheaper and cheaper, high-throughput sequencing has been the technology of choice, knocking off SNP arrays.

With both marker information - derived from variant calling on whole-genome sequencing - and phenotypic measures Genome Wide Association Studies (GWAS) can be performed to test for association between the trait and genetic markers in a population of interest. GWAS have been mostly focused on humans. But the increasing number of bacterial genomes available has caused GWAS to be used to determine genetic variation associated with different traits in bacterial populations. The main challenge of this project was to deal with bacterial GWAS problems: strong population structure and causative variation presence on the pangenome.

Due to the haploid clonal nature of bacteria and the lack of recombination, all variants in bacterial genomes are correlated.  What this means is that if we introduce 10 new variants in a bacterial population of which only one is causal of the phenotype of study, we will not be able to identify this variant as causal. Instead, we would find that all 10 variants are related to the phenotype since they are correlated between them due to the lack of recombination and the clonal nature of bacteria. This phenomenon can be seen as a genome-wide linkage disequilibrium. In turn, this generates clonal lineages with discrete genetic backgrounds. Associations between variants that are correlated with these genetic backgrounds and the phenotype are known as “lineage effects”. These effects although inevitable, should be taken into account. 

Is every variant association going to be cofounded with lineage effects? No. There are cases were an association might be correctly mapped to “locus effects”. Both horizontal DNA transfer and homoplasy across the phylogeny can help break the LD and the correlation of variants across the genome. The relative importance of either of these factors will depend on the species of study.

The classic approach for variant calling is based on alignment of the reads against a reference genome. The choice of the reference genome is key on bacterial populations. If we only include the core genome, there are going to be misalignments with the accessory genomes of the different strains. This would jeopardize our power to detect variants of interest. It is preferred then to use the pangenome as the reference genome when working with bacterial populations. 


## Methods
# Biological data 

The dataset used in this project is publicly available [2]. It consists of 696 Escherichia coli strains phenotyped for 214 environments. The measured phenotype is growth, quantified using an s-score that calculates the deviation from the expected growth. The authors provide phenotypic information – s-scores – and genotypic information – in a VCF file – that were used in my analyses. Other relevant information is also available for the dataset such as pangenome, phylogeny, conditions and strains. 

# Software

After a literature research, two different programs were chosen as candidates to perform the analyses: bugwas [5] and pyseer [6].

Bugwas is implemented in R and it tests for locus and lineage associations in bacterial GWAS. One thing to consider with bugwas is that it only takes binary, discrete phenotypes. The typical processing pipeline starts with an alignment-free k-mer counting to encapsulate genetic variability. This deals with the problem of not capturing enough variants due to the high variability in the pangenome of the bacterial population.  In order to test for lineage effects and locus effects bugwas is based on the fact that Principal Component Analysis (PCA) can correct for population structure on GWAS studies [7] if these are included as fixed effects on the Linear Mixed Model. Every Principal Component (PC) will correspond to a lineage on bacterial populations. To detect lineage effects while boosting power Bugwas includes the PC – read ‘lineages’ here – as random effects on the LMM and recovers indications of lineage-level associations. Then it tests these associations between the lineage and the phenotype using a Wald test [8]. One thing to consider with bugwas is that it only takes binary, discrete phenotypes.

Pyseer is a Python reimplementation of SEER [9]. What characterizes pyseer is its comprehensive and reconciliating nature, adding previously separated approaches (bugwas and scoary) into one single package. Pyseer can take as input different formats that encapsulate genetic diversity in the population (SNPs, k-mers or presence/absence of COGs), it also incorporates different association models (Fixed effects Generalized Linear Models and Linear Mixed Models). Furthermore, it includes the bugwas method to estimate possible lineage effects.

Although bugwas outputs plots directly, pyseer output is tab delimited. Because of this I had to re-implement manhattan (see next section) an existing R package that plots human-driven GWAS results.

# Scripts
	
Bioinformatic tools use input that have to be formatted in a specific way for the tool to work properly. This format rarely matches with the one your raw data has.  Because of this, in order to use the software mentioned above, the data had to be reformatted in a different manner depending on the software used.


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
