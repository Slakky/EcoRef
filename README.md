<a href="https://www.vecteezy.com/free-vector/double-helix"></a>

## Brief description of the course ##

This research training course has been carried out in the section for Comparative genetics and functional genomics within the department for medical biochemistry and microbiology at Uppsala University. Specifically, in theresearch group for Computational genomics, lead by Prof. Örjan Carlborg. The course took place from the 1st of September to mid-November.

The research at the Carlborg group is focused on the structure of the genotype-phenotype map in complex traits. This is done through the development of new bioinformatic tools and statistical methods to analyze the large amount of genetic information produced nowadays. Currently the group has two main lines of research, both of them focusing on the modifying effects epistasis and the environment have over variants associated with given phenotypes. One of these lines - and their ongoing project - focuses on gene by gene interactions (&#39;GxG&#39;), integrating both low coverage genome sequencing and evolutionary information. The other line aims to study gene by environment (&#39;GxE&#39; from now on) interactions. Using this approach, the team has been able to identify environmental effects on epistatic loci in yeast (Zan &amp; Carlborg 2019). These are gene by gene by environment interactions (&#39;GxGxE&#39; from now on).

As a bioinformatics focused research laboratory, a common day at the Carlborg group revolves around the development of pipelines, analysis of data, evaluation of statistical methodologies, among others. We have a lunch break and a _fika_ break occasionally.

Every Friday we have a group meeting where everyone explains what has been done over the week and shows any results that may have. On these group meetings I&#39;ve had the opportunity to learn more about what the team is doing in terms of scientific research and I&#39;ve also been able to learn new things about population genetics and genomics. Once a month there&#39;s a genomics section meeting where general administrative topics are discussed with all members of the department.

As I&#39;ve mentioned before, the group has two main lines of research. The one I&#39;ve taken part of focuses on gene by gene by environment interactions. The group&#39;s idea is to do the same kind of analysis performed on yeast (Zan &amp; Carlborg 2019) on a bacterial dataset.  In order to identify GxGxE interactions on bacteria we need first to find genetic variants associated with the given phenotype. Once this is done, further interaction analyses can be performed on these variants. During this research training course, I&#39;ve done a literature research to look for available software to detect these variants and choose the most suitable program. In order to do so, I&#39;ve tested two different programs (see Methods section) on a public _Escherichia coli_ dataset (Galardini _et al._ 2017). I&#39;ve also built the starting pipeline implementing these programs for the analyses that may be carried out on other bacterial datasets. This will help the team on their future bacterial GxGxE project.



## Introduction ##

One of the main focuses of biology during the past 50 years has been the characterization of the genetic variation associated with certain phenotypes. It has been possible to identify this genetic variation thanks to the sequencing of the human genome  (International Human Genome Sequencing Consortium 2001) and the discovery of  the human genome sequence variation(The International SNP Map Working Group 2001). This led to the design of arrays that were able to genotype several variants in a genome-wide fashion. During the last decade, with the prices of whole-genome sequencing getting cheaper and cheaper, high-throughput sequencing has been the technology of choice, knocking off SNP arrays.

With both marker information - derived from variant calling on whole-genome sequencing - and phenotypic measures Genome Wide Association Studies (GWAS) can be performed to test for association between the trait and genetic markers in a population of interest. GWAS have been mostly focused on humans. But the increasing number of bacterial genomes available has caused GWAS to be used to determine genetic variation associated with different traits in bacterial populations. The main challenge of this project was to deal with bacterial GWAS problems: strong population structure and causative variation presence on the pangenome.

Due to the haploid clonal nature of bacteria and the lack of recombination, all variants in bacterial genomes are correlated.  What this means is that if we introduce 10 new variants in a bacterial population of which only one is causal of the phenotype of study, we will not be able to identify this variant as causal. Instead, we would find that all 10 variants are related to the phenotype since they are correlated between them due to the lack of recombination and the clonal nature of bacteria. This phenomenon can be seen as a genome-wide linkage disequilibrium. In turn, this generates clonal lineages with discrete genetic backgrounds. Associations between variants that are correlated with these genetic backgrounds and the phenotype are known as &quot;lineage effects&quot;. These effects although inevitable, should be taken into account.

Is every variant association going to be cofounded with lineage effects? No. There are cases were an association might be correctly mapped to &quot;locus effects&quot;. Both horizontal DNA transfer and homoplasy across the phylogeny can help break the LD and the correlation of variants across the genome. The relative importance of either of these factors will depend on the species of study.

The classic approach for variant calling is based on alignment of the reads against a reference genome. The choice of the reference genome is key on bacterial populations. If we only include the core genome, there are going to be misalignments with the accessory genomes of the different strains. This would jeopardize our power to detect variants of interest. It is preferred to use the pangenome as the reference genome when working with bacterial populations.





## Methods ##

### Biological data ###

The dataset used in this project is publicly available [https://evocellnet.github.io/ecoref/](Galardini _et al._ 2017). It consists of 696 _Escherichia coli_ strains phenotyped for 214 environments. The measured phenotype is growth. The authors provide phenotypic information and genotypic information that were used in my analyses. Other relevant information is also available for the dataset such as pangenome, phylogeny, conditions and strains.

#### Software ####

After a literature research, two different programs were chosen as candidates to perform the analyses: _bugwas_  (Earle _et al._ 2016) and _pyseer_(Lees _et al._ 2018).

_Bugwas_ is implemented in R and it tests for locus and lineage associations in bacterial GWAS. One thing to consider with _bugwas_ is that it only takes binary, discrete phenotypes. The typical processing pipeline starts with an alignment-free k-mer counting to encapsulate genetic variability. This deals with the problem of not capturing enough variants due to the high variability in the pangenome of the bacterial population.  In order to test for lineage effects and locus effects _bugwas_ is based on the fact that Principal Component Analysis (PCA) can correct for population structure on GWAS studies (Reich _et al._ 2006) if these are included as fixed effects on the Linear Mixed Model. Every Principal Component (PC) will correspond to a lineage on bacterial populations. To detect lineage effects while boosting power _Bugwas_ includes the PC – read &#39;lineages&#39; here – as random effects on the LMM and recovers indications of lineage-level associations. Then it tests these associations between the lineage and the phenotype using a Wald test (Wald 1943). One thing to consider with _bugwas_ is that it only takes binary, discrete phenotypes.

_Pyseer_ is a Python reimplementation of SEER (Lees _et al._ 2016). What characterizes _pyseer_ is its comprehensive and reconciling nature, adding previously separated approaches, _bugwas_ and _scoary_ _(_Brynildsrud _et al._ 2016), into one single package. _Pyseer_ can take as input different formats that encapsulate genetic diversity in the population (SNPs, k-mers or presence/absence of COGs), it also incorporates different association models (Fixed effects Generalized Linear Models and Linear Mixed Models). Furthermore, it includes _bugwas_ method to estimate possible lineage effects.

Although bugwas outputs plots directly, pyseer output consists of raw data in .tsv format. Because of this I had to modify qqman_(D. Turner 2018)_ an existing R package that plots human-driven GWAS results.

#### Scripts ####

An important technical difficulty of using _bugwas_ is making sure that the identity and order of samples between the VCF file, phenotype file and population structure match up correctly. Therefore, I had to code my own Python script to correctly format the data and match the samples among files before using these data as input to _bugwas_. Furthermore, I had to normalize between 0 and 1 the phenotype values and remove the invariant sites from the original VCF.

In order to run _bugwas_,a population phylogenetic tree has to be provided. As different conditions on this dataset may have different sets of samples, I also generalized the construction of a specific phylogenetic tree for every condition. For this I used the command line tools in _Tassel_ _(Bradbury et al._ 2007). Inside the main script I call other secondary R scripts of my own that transform the output from _Tassel_ to a newick tree and run _bugwas&#39; lin\_loc_ (lineage and locus effects) function with all the required parameters, everything is run on default. This function outputs Manhattan Plots, QQ plots and PCA plots for a given condition. These give us information about significant associations between the variant tested and the condition. I automated all of these analyses for the 214 environments inside a Snakemake pipeline where the user can tweak the directories and the phenotypes to loop through. The _bugwas_ run is more script focused, setting rules, conditions and parameters inside the script itself.

The _pyseer_ implementation is more pipeline focused, defining rules and loops inside the pipeline. Hence, the processing is easier to follow and modify. The user has a _yaml_ config file where most tweakable parameters can be modified in addition to directories and other general best practices. _Pyseer_, although having more options and being more versatile than _bugwas,_ is more user-friendly, dealing with most of the formatting problems _bugwas_ has automatically.  The pipeline that is right now implemented is using a VCF file (--vcf) as input for genetic diversity in the samples, a linear mixed model for association (--lmm) that uses a kinship matrix as an indication of similarities between samples to correct for population structure (--similarity) and is also able to output _bugwas_ lineage effects (--lineage) using the same kinship matrix as before to estimate distances between samples (--distances). As I&#39;ve mentioned on the previous section, _pyseer_ output is tab delimited, so I had to modify _qqman_&#39;s _manhattan_ function in order to plot the results. What I basically did is modify the logic that loops through chromosomes in human driven GWAS and loop through conditions. Moreover, if there are similar conditions (i.e. increasing molarity of the same compound), the modified function plots these conditions on the same axes with different colors (see Results).

## Results ##

Although results were obtained with the _bugwas_ implementation, I didn&#39;t trust them much because I was using a continuous phenotype that was not being correctly tested with the association model used in _bugwas_. Because of this, the results were not interpretable.

With the _pyseer_ implementation I obtained interpretable and coherent results. Only 2 of the more than 200 plots are shown on Figure 1 for illustration purposes.  On both conditions a significant common peak can be identified on the middle of the genome. Thus, we can say that this region of the genome has variants that affect growth under these conditions. Further analyses, like the ones performed on yeast (Zan &amp; Carlborg 2019), can be done in order to discern this possible GxGxE interactions.


## Discussion ##

Although the results obtained through _pyseer_ were good enough to trust, there are still things that need to be addressed. The built pipeline uses SNPs as input for the genetic diversity in the population but as it&#39;s been mentioned on the introduction, an alignment-free k-mer counting is preferable due to the high variability of sequences present in the pangenome.

Moreover, _bugwas_ was implemented in a script fashion rather than in a pipeline like _pyseer_&#39;s case. Even though the current state of the script&#39;s documentation allows for proper understanding of the logic and processing, it would&#39;ve been better if it was fully implemented in a pipeline.



## Self-assessment ##

During this research training course, I&#39;ve had the opportunity to meet brilliant scientists and learn a lot from them, both academically and personally. From my perspective, this research training has been a perfect fit to replace my other courses. I&#39;ve had the experience of working with real data, real problems and learn the theory along the way. It&#39;s also reassuring to know that the work I&#39;ve been doing will have some use in the future.



## Bibliography ##

Bradbury PJ, Zhang Z, Kroon DE, Casstevens TM, Ramdoss Y, Buckler ES. 2007. TASSEL: software for association mapping of complex traits in diverse samples. Bioinformatics 23: 2633–2635.

Brynildsrud O, Bohlin J, Scheffer L, Eldholm V. 2016. Rapid scoring of genes in microbial pan-genome-wide association studies with Scoary. Genome Biology 17: 238.

D. Turner S. 2018. qqman: an R package for visualizing GWAS results using Q-Q and manhattan plots. Journal of Open Source Software 3: 731.

Earle SG, Wu C-H, Charlesworth J, Stoesser N, Gordon NC, Walker TM, Spencer CCA, Iqbal Z, Clifton DA, Hopkins KL, Woodford N, Smith EG, Ismail N, Llewelyn MJ, Peto TE, Crook DW, McVean G, Walker AS, Wilson DJ. 2016. Identifying lineage effects when controlling for population structure improves power in bacterial association studies. Nature Microbiology 1: 16041.

Galardini M, Koumoutsi A, Herrera-Dominguez L, Varela JAC, Telzerow A, Wagih O, Wartel M, Clermont O, Denamur E, Typas A, Beltrao P. 2017. Phenotype inference in an Escherichia coli strain panel. eLife, doi 10.7554/eLife.31035.

International Human Genome Sequencing Consortium. 2001. Initial sequencing and analysis of the human genome. Nature 409: 860–921.

Lees JA, Galardini M, Bentley SD, Weiser JN, Corander J. 2018. pyseer: a comprehensive tool for microbial pangenome-wide association studies. Bioinformatics 34: 4310–4312.

Lees JA, Vehkala M, Välimäki N, Harris SR, Chewapreecha C, Croucher NJ, Marttinen P, Davies MR, Steer AC, Tong SYC, Honkela A, Parkhill J, Bentley SD, Corander J. 2016. Sequence element enrichment analysis to determine the genetic basis of bacterial phenotypes. Nature Communications 7: 12797.

Reich D, Patterson NJ, Shadick NA, Weinblatt ME, Price AL, Plenge RM. 2006. Principal components analysis corrects for stratification in genome-wide association studies. Nature Genetics 38: 904–909.

The International SNP Map Working Group. 2001. A map of human genome sequence variation containing 1.42 million single nucleotide polymorphisms. Nature 409: 928–933.

Wald A. 1943. Tests of Statistical Hypotheses Concerning Several Parameters When the Number of Observations is Large. Transactions of the American Mathematical Society 54: 426–482.

Zan Y, Carlborg Ö. 2019. Yeast growth responses to environmental perturbations are associated with rewiring of large epistatic networks. bioRxiv 659730.
