---
layout: page
---

# RNA-seq data analysis

This workshop on RNA-seq data analysis directed toward life scientists with little to no experience with statistical computing or bioinformatics. Part I (QC, alignment, & counting) assumes basic familiarity with the Unix shell. Part II (differential expression analysis) assumes basic familiarity with R.

By the end of the workshop, participants will: (1) know how to align and quantitate gene expression with RNA-seq data, and (2) know what packages to use and what steps to take to analyze RNA-seq data for differentially expressed genes.

The alignment step in this workshop requires a couple GB of RAM. This can be hard to manage if students are running a VM on a laptop. Further, there are several tools required for the workshop. This workshop runs best on an m3.xlarge AWS EC2 instance using the image ID ami-f462ef9c (username and password both "bioinfo"), which has all the software necessary for this analysis pre-installed. If not using this image, participants need to install:

* Basic shell utilities: gcc, make, ruby, curl, git, parallel, unzip, default-jre
* bowtie2: <http://bowtie-bio.sourceforge.net/bowtie2/index.shtml>
* tophat2: <http://ccb.jhu.edu/software/tophat/index.shtml>
* featureCounts (part of subread): <http://subread.sourceforge.net/>
* samtools: <http://samtools.sourceforge.net/>
* fastx-toolkit: <http://hannonlab.cshl.edu/fastx_toolkit/>
* FastQC: <http://www.bioinformatics.babraham.ac.uk/projects/fastqc/>
* R: <http://www.r-project.org/>
* RStudio: <http://www.rstudio.com/>
* R packages: Bioconductor core (i.e., `biocLite()`), DESeq2
