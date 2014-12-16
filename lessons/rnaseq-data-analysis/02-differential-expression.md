---
layout: page
---



# RNA-seq: differential gene expression analysis

*[back to course contents](..)*

This is an introduction to RNAseq analysis involving reading in count data from an RNAseq experiment, exploring the data using base R functions and then analysis with the DESeq2 package.

## Install and load packages

First, we'll need to install some add-on packages. Most generic R packages are hosted on the Comprehensive R Archive Network (CRAN, <http://cran.us.r-project.org/>). To install one of these packages, you would use `install.packages("packagename")`. You only need to install a package once, then load it each time using `library(packagename)`. Let's install the **gplots** and **calibrate** packages.


```r
install.packages("gplots")
install.packages("calibrate")
```

Bioconductor packages work a bit differently, and are not hosted on CRAN. Go to <http://bioconductor.org/> to learn more about the Bioconductor project. To use any Bioconductor package, you'll need a few "core" Bioconductor packages. Run the following commands to (1) download the installer script, and (2) install some core Bioconductor packages. You'll need internet connectivity to do this, and it'll take a few minutes, but it only needs to be done once.


```r
# Download the installer script
source("http://bioconductor.org/biocLite.R")

# biocLite() is the bioconductor installer function. Run it without any
# arguments to install the core packages or update any installed packages.
# This requires internet connectivity and will take some time!
biocLite()
```

To install specific packages, first download the installer script if you haven't done so, and use `biocLite("packagename")`. This only needs to be done once then you can load the package like any other package. Let's download the [DESeq2 package](http://www.bioconductor.org/packages/release/bioc/html/DESeq2.html):


```r
# Do only once
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
```

Now let's load the packages we'll use:


```r
library(DESeq2)
library(gplots)
library(calibrate)
```

```
## Error in library(calibrate): there is no package called 'calibrate'
```

Bioconductor packages usually have great documentation in the form of *vignettes*. For a great example, take a look at the [DESeq2 vignette for analyzing count data](http://www.bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.pdf).

## Introduction and data import

Analyzing an RNAseq experiment begins with sequencing reads. These are aligned to a reference genome, then the number of reads mapped to each gene can be counted.

The data for this tutorial comes from a PLOS ONE paper, [Genome-Wide Transcriptional Profiling of Skin and Dorsal Root Ganglia after Ultraviolet-B-Induced Inflammation](http://www.plosone.org/article/info%3Adoi%2F10.1371%2Fjournal.pone.0093338), and the raw data can be downloaded from [Gene Expression Omnibus database (GEO)](http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE54413).

This data has already been downloaded and aligned to the human genome. The command line tool [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) was used to count reads mapped to human genes from the [Ensembl annotation](http://www.ensembl.org/info/data/ftp/index.html).

The output from this tool is provided in the `counts.txt` file in the `data` directory. Have a look at this file in the shell, using `head`.

First, set your working directory to the top level of the RNA-seq course. Import the data into R as a `data.frame` and examine it again. You can set the arguments of `read.table` to import the first row as a header giving the column names, and the first column as row names.


```r
# Filename with output from featureCounts
countfile <- "data/counts.txt"
# Read in the data
countdata <- read.table(countfile, header = TRUE, row.names = 1)
head(countdata)
colnames(countdata)
class(countdata)
```

The data.frame contains information about genes (one gene per row) with the gene positions in the first five columns and then information about the number of reads aligning to the gene in each experimental sample. There are three replicates for control (column names starting with "ctl") and three for samples treated with ultraviolet-B light (starting "uvb"). We don't need the information on gene position for this analysis, just the counts for each gene and sample, so we can remove it from the data frame.


```r
# Remove first five columns (chr, start, end, strand, length)
countdata <- countdata[, -(1:5)]
head(countdata)
colnames(countdata)
```

We can rename the columns to something shorter and a bit more readable.


```r
# Manually
c("ctl1", "ctl2", "ctl3", "uvb1", "uvb2", "uvb3")
```

We can do it manually, but what if we have 600 samples instead of 6? This would become cumbersome. Also, it's always a bad idea to hard-code sample phenotype information at the top of the file like this. A better way to do this is to use the `gsub` command to strip out the extra information. This more robust to introduced errors, for example if the column order changes at some point in the future or you add additional replicates.


```r
# Using gsub -- robust. Get help with ?gsub
gsub(pattern = "trimmed_|.fastq_tophat.accepted_hits.bam", replacement = "", 
    x = colnames(countdata))
colnames(countdata) <- gsub(pattern = "trimmed_|.fastq_tophat.accepted_hits.bam", 
    replacement = "", x = colnames(countdata))
head(countdata)
```

---

**EXERCISE**

There's an R function called `rowSums()` that calculates the sum of each row in a numeric matrix, like the count matrix we have here, and it returns a vector. There's also a function called `which.max()` that determines the index of the maximum value in a vector.

0. Find the gene with the highest expression across all samples -- remember, each row is a gene.
0. Extract the expression data for this gene for all samples.
0. In which sample does it have the highest expression?
0. What is the function of the gene? Can you suggest why this is the top expressed gene?



---

## Data investigation using base R

We can investigate this data a bit more using some of the basic R functions before going on to use more sophisticated analysis tools.

First make a copy of the data, because we'll need it later. We will work on the copy. We will calculate the mean for each gene for each condition and plot them.


```r
cd2 <- countdata  #make a copy

# get Control columns
colnames(cd2)

# grep searches for matches to a pattern. Get help with ?grep

# get the indexes for the controls
grep("ctl", colnames(cd2))
ctlCols <- grep("ctl", colnames(cd2))
head(cd2[, ctlCols])

# use the rowMeans function
cd2$ctlmean <- rowMeans(cd2[, ctlCols])
head(cd2)

# same for uvb
uvbCols <- grep("uvb", colnames(cd2))
cd2$uvbmean <- rowMeans(cd2[, uvbCols])

head(cd2)
```

---

**EXERCISE**

Using the `subset()` function, print out all the columns where the control mean does not equal 0 **and** where the UVB mean does not equal zero.

Bonus: code golf -- use the fewest characters to get the same solution.



---

**EXERCISE**

1. Plot the mean expression of each gene in control against the UVB sample mean. Are there any outliers?
2. How could you make this plot more informative and look more professional? Hint: try plotting on the log scale and using a different point character.


```r
plot(cd2$ctlmean, cd2$uvbmean)
with(cd2, plot(log10(ctlmean), log10(uvbmean), pch = 16))
with(cd2, plot(ctlmean, uvbmean, log = "xy", pch = 16))
```

---

## Poor man's differential gene expression

We can find candidate differentially expressed genes by looking for genes with a large change between control and UVB samples. A common threshold used is log2 fold change more than 2 or less than -2. We will calculate log2 fold change for all the genes and colour the genes with log2 fold change of more than 2 or less than -2 on the plot.

First, check for genes with a mean expression of 0. Putting zeroes into the log2 fold change calculation will produce NAs, so we might want to remove these genes. Note: this is for mathematical reasons, although different software may produce different results when you try to do `log2(0)`.


```r
head(cd2$ctlmean)
head(cd2$ctlmean > 0)
```

In R, `TRUE` and `FALSE` can be represented as `1` and `0`, respectively. When we call `sum(cd2$ctlmean > 0)`, we're really asking, "how many genes have a mean above 0 in the control group?"


```r
sum(cd2$ctlmean > 0)
sum(cd2$uvbmean > 0)
```

Now, let's subset the data and keep things where either the control or UVB group means are greater than zero.


```r
nrow(cd2)
cd2 <- subset(cd2, cd2$ctlmean > 0 | cd2$uvbmean > 0)
nrow(cd2)
head(cd2)
```

Mathematically things work out better for us when we test things on the log scale. On the absolute scale, upregulation goes from 1 to infinity, while downregulation is bounded by 0 and 1. On the log scale, upregulation goes from 0 to infinity, and downregulation goes from 0 to negative infinity. Let's compute a log-base-2 of the fold change.

When we do this we'll see some `Inf` and `-Inf` values. This is what happens when we take `log2(Inf)` or `log2(0)`.


```r
# calculate the log2 fold change
cd2$log2FC <- log2(cd2$uvbmean/cd2$ctlmean)
head(cd2)

# see how many are up, down, or both (using the absolute value function)
sum(cd2$log2FC > 2)
sum(cd2$log2FC < -2)
sum(abs(cd2$log2FC) > 2)
```

We can few just the "outliers" with `subset(cd2, abs(log2FC)>2)`, which gets us just the things that have a large fold change in either direction. Let's plot these.


```r
with(cd2, plot(ctlmean, uvbmean, log = "xy", pch = 16))
subset(cd2, abs(log2FC) > 2)
# use the points function to add more points to the same axes
with(subset(cd2, abs(log2FC) > 2), points(ctlmean, uvbmean, pch = 16, col = "red"))
```

What do you notice about the positions of the outliers on these plots? How would you interpret this? What are some of the problems with this simple approach?

## DESeq2 analysis

DESeq2 is an R package for analyzing count-based NGS data like RNA-seq. It is available from [Bioconductor](http://www.bioconductor.org/). Bioconductor is a project to provide tools for analysing high-throughput genomic data including RNA-seq, ChIP-seq and arrays. You can explore Bioconductor packages [here](http://www.bioconductor.org/packages/release/BiocViews.html#___Software).

Just like R packages from CRAN, you only need to install Bioconductor packages once, then load them every time you start a new R session.


```r
source("http://bioconductor.org/biocLite.R")
biocLite("DESeq2")
```


```r
library("DESeq2")
citation("DESeq2")
```

It requires the count data to be in matrix form, and an additional dataframe describing sample metadata. Notice that the **colnames of the countdata** match the **rownames of the metadata*.


```r
mycoldata <- read.csv("data/coldata.csv", row.names = 1)
mycoldata
```

DESeq works on a particular type of object called a DESeqDataSet. The DESeqDataSet is a single object that contains input values, intermediate calculations like how things are normalized, and all results of a differential expression analysis. You can construct a DESeqDataSet from a count matrix, a metadata file, and a formula indicating the design of the experiment.


```r
dds <- DESeqDataSetFromMatrix(countData = countdata, colData = mycoldata, design = ~condition)
dds
```

Next, let's run the DESeq pipeline on the dataset, and reassign the resulting object back to the same variable. Before we start, `dds` is a bare-bones DESeqDataSet. The `DESeq()` function takes a DESeqDataSet and returns a DESeqDataSet, but with lots of other information filled in (normalization, results, etc). Here, we're running the DESeq pipeline on the `dds` object, and reassigning the whole thing back to `dds`, which will now be a DESeqDataSet populated with results.


```r
dds <- DESeq(dds)
```

Now, let's use the `results()` function to pull out the results from the `dds` object. Let's re-order by the adjusted p-value.


```r
# Get differential expression results
res <- results(dds)
head(res)

# Order by adjusted p-value
res <- res[order(res$padj), ]
head(res)
```

Combine DEseq results with the original counts data. Write significant results to a file.


```r
sig <- subset(res, padj < 0.05)
dir.create("results")
write.csv(sig, file = "results/sig.csv")  # tab delim data
```

You can open this file in Excel or any text editor (try it now).

## Data Visualization

We can also do some exploratory plotting of the data.

The differential expression analysis above operates on the raw (normalized) count data. But for visualizing or clustering data as you would with a microarray experiment, you ned to work with transformed versions of the data. First, use a *regularlized log* transofmration while re-estimating the dispersion ignoring any information you have about the samples (`blind=TRUE`). Perform a principal components analysis and hierarchical clustering.


```r
# Transform
rld <- rlogTransformation(dds)

# Principal components analysis
plotPCA(rld, intgroup = "condition")

# Hierarchical clustering analysis let's get the actual values for the first
# few genes
head(assay(rld))
## now transpose those
t(head(assay(rld)))
## now get the sample distances from the transpose of the whole thing
dist(t(assay(rld)))
sampledist <- dist(t(assay(rld)))
plot(hclust(sampledist))
```

Let's plot a heatmap.


```r
# ?heatmap for help
sampledist
as.matrix(sampledist)
sampledistmat <- as.matrix(sampledist)
heatmap(sampledistmat)
```

That's a horribly ugly default. You can change the built-in heatmap function, but others are better.


```r
# better heatmap with gplots
library("gplots")
heatmap.2(sampledistmat)
heatmap.2(sampledistmat, key = FALSE, trace = "none")
colorpanel(10, "black", "white")
heatmap.2(sampledistmat, col = colorpanel(64, "black", "white"), key = FALSE, 
    trace = "none")
heatmap.2(sampledistmat, col = colorpanel(64, "steelblue", "white"), key = FALSE, 
    trace = "none")
heatmap.2(sampledistmat, col = colorpanel(64, "red", "white", "blue"), key = FALSE, 
    trace = "none")
```

What about a histogram of the p-values?


```r
# Examine plot of p-values
hist(res$pvalue, breaks = 50, col = "grey")
```

Let's plot an MA-plot. This shows the fold change versus the overall expression values.


```r
with(res, plot(baseMean, log2FoldChange, pch = 16, cex = 0.5, log = "x"))
with(subset(res, padj < 0.05), points(baseMean, log2FoldChange, col = "red", 
    pch = 16))

# optional: label the points with the calibrate package. see ?textxy for
# help
library("calibrate")
```

```
## Error in library("calibrate"): there is no package called 'calibrate'
```

```r
res$Gene <- rownames(res)
head(res)
with(subset(res, padj < 0.05), textxy(baseMean, log2FoldChange, labs = Gene, 
    cex = 1, col = "red"))
```

```
## Error in eval(expr, envir, enclos): could not find function "textxy"
```

Let's create a volcano plot.


```r
par(pch = 16)
with(res, plot(log2FoldChange, -log10(pvalue), main = "Volcano plot"))
with(subset(res, padj < 0.05), points(log2FoldChange, -log10(pvalue), col = "red"))
with(subset(res, abs(log2FoldChange) > 2), points(log2FoldChange, -log10(pvalue), 
    col = "orange"))
with(subset(res, padj < 0.05 & abs(log2FoldChange) > 2), points(log2FoldChange, 
    -log10(pvalue), col = "green"))
# Add legend
legend("topleft", legend = c("FDR<0.05", "|LFC|>2", "both"), pch = 16, col = c("red", 
    "orange", "green"))
# Label points
with(subset(res, padj < 0.05 & abs(log2FoldChange) > 2), textxy(log2FoldChange, 
    -log10(pvalue), labs = Gene, cex = 1))
```

```
## Error in eval(expr, envir, enclos): could not find function "textxy"
```

## Record package and version info with `sessionInfo()`

The `sessionInfo()` prints version information about R and any attached packages. It's a good practice to always run this command at the end of your R session and record it for the sake of reproducibility in the future.


```r
sessionInfo()
```

```
## R version 3.1.2 (2014-10-31)
## Platform: x86_64-apple-darwin13.4.0 (64-bit)
## 
## locale:
## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
## 
## attached base packages:
## [1] parallel  stats4    methods   stats     graphics  grDevices utils    
## [8] datasets  base     
## 
## other attached packages:
##  [1] gplots_2.15.0             DESeq2_1.6.2             
##  [3] RcppArmadillo_0.4.550.1.0 Rcpp_0.11.3              
##  [5] GenomicRanges_1.18.3      GenomeInfoDb_1.2.3       
##  [7] IRanges_2.0.1             S4Vectors_0.4.0          
##  [9] BiocGenerics_0.12.1       knitr_1.8                
## [11] BiocInstaller_1.16.1     
## 
## loaded via a namespace (and not attached):
##  [1] acepack_1.3-3.3      annotate_1.44.0      AnnotationDbi_1.28.1
##  [4] base64enc_0.1-2      BatchJobs_1.5        BBmisc_1.8          
##  [7] Biobase_2.26.0       BiocParallel_1.0.0   bitops_1.0-6        
## [10] brew_1.0-6           caTools_1.17.1       checkmate_1.5.1     
## [13] cluster_1.15.3       codetools_0.2-9      colorspace_1.2-4    
## [16] DBI_0.3.1            digest_0.6.6         evaluate_0.5.5      
## [19] fail_1.2             foreach_1.4.2        foreign_0.8-61      
## [22] formatR_1.0          Formula_1.1-2        gdata_2.13.3        
## [25] genefilter_1.48.1    geneplotter_1.44.0   ggplot2_1.0.0       
## [28] grid_3.1.2           gtable_0.1.2         gtools_3.4.1        
## [31] Hmisc_3.14-6         iterators_1.0.7      KernSmooth_2.23-13  
## [34] labeling_0.3         lattice_0.20-29      latticeExtra_0.6-26 
## [37] locfit_1.5-9.1       MASS_7.3-35          munsell_0.4.2       
## [40] nnet_7.3-8           plyr_1.8.1           proto_0.3-10        
## [43] RColorBrewer_1.1-2   reshape2_1.4.1       rpart_4.1-8         
## [46] RSQLite_1.0.0        scales_0.2.4         sendmailR_1.2-1     
## [49] splines_3.1.2        stringr_0.6.2        survival_2.37-7     
## [52] tools_3.1.2          XML_3.98-1.1         xtable_1.7-4        
## [55] XVector_0.6.0
```


## Going further

* After the course, download the [Integrative Genome Viewer](http://www.broadinstitute.org/igv/) from the Broad Institute. Download all your .bam files from your AWS instance, and load them into IGV. Try navigating to regions around differentially expressed genes to view how reads map to genes differently in the controls versus the irradiated samples.
* Can you see any genes where differential expression is likely attributable to a specific isoform?
* Do you see any instances of differential exon usage? You can investigate this formally with the [DEXSeq](http://www.bioconductor.org/packages/release/bioc/html/DEXSeq.html) package.
* Read about pathway analysis with [GOSeq](http://www.bioconductor.org/packages/release/bioc/html/goseq.html) or [SeqGSEA](http://www.bioconductor.org/packages/release/bioc/html/SeqGSEA.html) - tools for gene ontology analysis and gene set enrichment analysis using next-generation sequencing data.
* Read about multifactor designs in the [DESeq2 vignette](http://www.bioconductor.org/packages/release/bioc/vignettes/DESeq2/inst/doc/DESeq2.pdf) for cases where you have multiple variables of interest (e.g. irradiated vs controls in multiple tissue types).

***After the course, make sure you stop any running AWS instances.***
