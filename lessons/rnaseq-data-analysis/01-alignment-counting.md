---
layout: page
---

# RNA-seq: reads to counts

In this section of the workshop we will start with raw RNA-seq reads and do everything that we need to do to get a *count matrix* - a table or "spreadsheet" in a single file containing the the number of reads mapping to each gene for each sample. This count matrix is the input into R for differential gene expression analysis. A count matrix is a table in a single file with a row for every gene and a column for every sample. Cell<sub>i,j</sub> will contain the number of genes mapping to the <em>i</em>th gene for the <em>j</em>th sample. For example, in the table below, 865 reads mapped to GeneB for sample ctl2.

|       | ctl1 | ctl2 | ctl3 | uvb1 | uvb2 | uvb3 |
|-------|------|------|------|------|------|------|
| GeneA | 33   | 54   | 10   | 12   | 50   | 49   |
| GeneB | 255  | 865  | 864  | 5446 | 2664 | 4665 |
| GeneC | 0    | 0    | 1    | 2    | 3    |  15  |

## Objectives

- Quality assessment for raw sequencing read
- Quality control to trim low-quality sequence data from the ends of reads
- Align reads to the genome for all samples
- Count the number of reads mapping to each gene for each sample

## Data management

First, let's extract the fastq files if we haven't done so already:

```bash
cd data
ls -l
gunzip *.fastq.gz
ls -l
```

## Quality control

### Quality assessment

Next, let's run some quality control analysis. Google search "FastQC" to find the [FastQC](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/) package from Simon Andrews. It's a program that pretty much everyone uses for QC analysis that can be run at the command line on a batch of FASTQ files.

You'll also need java to run it (`sudo apt-get install default-jre`).

First let's get some help on FastQC. Most bioinformatics programs have a `-h` or `--help` option that gives you some very basic documentation on how to run it. These aren't the same as built-in UNIX man pages. For more in-depth documentation you need to read the paper or visit the tool's website to download a manual. For instance, take a look at the [online FastQC documentation](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/) and look specifically at the differences between [good Illumina data](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/good_sequence_short_fastqc.html) and [bad Illumina data](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/bad_sequence_fastqc.html).

```bash
fastqc -h
fastqc *.fastq --threads 4 --outdir .
```

Open up your SFTP client and enter your IP address and credentials. Transfer this data over to your computer to view it. You'll see how the last 5 bases of each read is pretty terrible quality, so let's trim those reads.

### Trimming: one sample

Google "FASTX Toolkit" to find [Greg Hannon's FASTX-Toolkit software](http://hannonlab.cshl.edu/fastx_toolkit/). This lets you do lots of things for manipulating FASTQ and FASTA files. We're just going to use a feature to trim the end of the reads. You can see which tool you need by looking at the [online documentation](http://hannonlab.cshl.edu/fastx_toolkit/commandline.html).

First, let's run `fastx_trimmer` to get some help.

```bash
fastx_trimmer -h
```

It tells us we can use the `-t` option followed by a number to trim that number of nucleotides off the end of the read. It tells us that the default way to use the program is to feed data off the `STDIN`, which is UNIX-speak for piping in data. It's default output is the `STDOUT`, which is UNIX-speak for "printing" the data to the screen. Let's see what that means:

```bash
head -n 8 ctl1.fastq
head -n 8 ctl1.fastq | fastx_trimmer -t 5
```

We get some error about an invalid quality score value. Let's learn a little bit about quality scores. Google FASTQ format and click the Wikipedia article, and scroll down to the [section on quality](http://en.wikipedia.org/wiki/FASTQ_format#Quality). Next scroll down to encoding. Quality scores are encoded in a FASTQ file different ways. You just have to know that this is quality score encoding is Sanger, or Phred+33. There are other tools out there that can tell you what kind of quality score you have, and convert between different quality score encodings. But Sanger/Phred+33 is the most common. Unfortunately `fastx_trimmer` doesn't seem to recognize this encoding. Let's Google that error message specifically. Google "fastx_trimmer invalid quality score value" and you'll arrive at a [SEQAnswers](http://seqanswers.com/forums/showthread.php?t=7596) thread that tells you the answer. (Look who provided that answer, by the way, Simon Andrews, the author of FASTQC!). You can also go to the [FASTX-Toolkit homepage](http://hannonlab.cshl.edu/fastx_toolkit/index.html), and if you scroll down a bit, you'll see that back in 2009 this was added as an option, but it's still not documented in the command line help.

I show you this because this is what doing bioinformatics is like in the real world. You think you have the right tool for the job, you try to run it like the documentation says to run it, and it doesn't work. You Google around to try to find the solution to the problem or better documentation. SEQAnswers is a great resource, and so is Biostars.

Let's try that again:

```bash
head -n 8 ctl1.fastq
head -n 8 ctl1.fastq | fastx_trimmer -t 5 -Q33
```

Look at that! `fastx_trimmer` trimmed 5 bases off the end of two reads coming in from a pipe and spit it back out to the screen. We could do this to the whole file if we did something like `cat ctl1.fastq | fastx_trimmer ... > trimmed_ctl1.fastq`. Or we could use the command line options to take input files and write output files.

```bash
fastx_trimmer -h
fastx_trimmer -Q33 -t 5 -i ctl1.fastq -o trimmed_ctl1.fastq
```

Let's take a look at those files to make sure it worked right. Also, let's do a word count as a sanity check to make sure we didn't lose any reads or anything.

```bash
head -n 4 ctl1.fastq trimmed_ctl1.fastq
wc ctl1.fastq trimmed_ctl1.fastq
```

---

**EXERCISE**

Run `ls` on the current directory. We need to clean things up before they get out of hand.

- Remove the trimmed file you just created
- Make a directory called "QC"
- Move all the fastqc output directories and zip files into the QC directory (hint, you can do this all with a wildcard and a single `mv` command)
- Use `find ... | parallel ...` to run `wc` on all the fastq files in parallel

---

### Trimming: all samples in parallel

Let's use GNU parallel to run these trimming jobs in parallel:

```bash
find *.fastq | parallel --dry-run "fastx_trimmer -t 5 -Q33 -i {} -o trimmed_{}"
```

Tip: `*` matches everything or nothing. If we wanted to look at the first few lines of one of these files, we could do this:

```bash
head *ctl1.fastq
```

Which would print the first few lines of the trimmed and untrimmed version.

Let's make a directory for all the untrimmed files:

```bash
mkdir untrimmed
mv ctl*.fastq uvb*.fastq untrimmed
```

## Alignment

### Building an index

For the sake of time and compute requirements I've extracted reads that originate from a 100MB region of chromosome 4. In reality, you would want to do this with the entire genome. The first step here is to create an index.

Google "Ensembl FTP" to get to the [FTP download page](http://useast.ensembl.org/info/data/ftp/index.html). Scroll down to the Human FASTA sequences. Click that link and copy the link to download the FASTA sequence for chromsome 4. While we're at it let's go ahead and download the gene set annotation (GTF file). We're looking at chromosome 4.

This is what you *would* do if you were doing this on your own. But this can take a while so I've already downloaded and extracted these two files for you. See `~/genomedata`.

```bash
wget ftp://ftp.ensembl.org/pub/release-77/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.chromosome.4.fa.gz
wget ftp://ftp.ensembl.org/pub/release-77/gtf/homo_sapiens/Homo_sapiens.GRCh38.77.gtf.gz
gunzip Homo_sapiens*.gz
```

Or just move them from genomedata in the home directory:

```bash
ls -l ~/genomedata
mv ~/genomedata/* .
```

Now, let's build an index. Tophat is a spliced aligner. It uses the Bowtie aligner under the hood. To run Bowtie we have to first build an index using a utility that comes with Bowtie. You only have to do this once each time you build a reference. First, let's get a little help, then get it started running while we talk about alignment and aligner indexes.

```bash
bowtie2-build -h
bowtie2-build chr4.fa chr4
```

### Alignment with TopHat

Let's try a small sample first. First, run `tophat -h` to get a little help. Let's also look at the [TopHat documentation online](http://ccb.jhu.edu/software/tophat/manual.shtml).

```bash
tophat -h
head -n 40000 trimmed_ctl1.fastq > test10k.fastq
tophat --no-coverage-search -o test10k_tophat chr4 test10k.fastq
```

---

**EXERCISE**

First, look around at the results, then delete those files when you're done:

- Go into the output directory that was just created.
- Look at the `align_summary.txt` file that was created (**don't try to `cat` the .bam files in that directory!**)
- When you're done, remove the entire directory containing that test output, and remove the test10k.fastq file you created.

Next, Using `find` and `parallel --dry-run`, try to construct the command that would run all the samples through tophat in parallel. Using the `-o` option, make the output for each run be a directory with `_tophat` appended to it. The command generated should look like this:

```
tophat --no-coverage-search -o trimmed_ctl1.fastq_tophat chr4 trimmed_ctl1.fastq
tophat --no-coverage-search -o trimmed_ctl2.fastq_tophat chr4 trimmed_ctl2.fastq
tophat --no-coverage-search -o trimmed_ctl3.fastq_tophat chr4 trimmed_ctl3.fastq
tophat --no-coverage-search -o trimmed_uvb1.fastq_tophat chr4 trimmed_uvb1.fastq
tophat --no-coverage-search -o trimmed_uvb2.fastq_tophat chr4 trimmed_uvb2.fastq
tophat --no-coverage-search -o trimmed_uvb3.fastq_tophat chr4 trimmed_uvb3.fastq
```

**But, don't launch the jobs just yet**

---

Now, before we launch those jobs, let's take a look at the help for GNU parallel. We can specify an upper limit to the number of jobs run in parallel using the -j option. Let's only run three jobs in parallel so we don't crash our system. Tophat consumes quite a bit of memory, and we only have 15GB available to us.

```bash
parallel -h
find trimmed_*.fastq | parallel -j 3 --dry-run "tophat --no-coverage-search -o {}_tophat chr4 {}"
```

---

**EXERCISE**

- When that's done, from the main data directory, look at all the `align_summary.txt` files with one command.
- Using `grep`, pull out the line that shows you the number of mapped reads.

---

### View the alignment

If time allows let's look around with samtools Tview. Much better to do this with software such as the Broad's [Integrative Genomics Viewer (IGV)](http://www.broadinstitute.org/igv/).

```bash
cd trimmed_ctl1.fastq_tophat/
samtools view accepted_hits.bam | less
samtools index accepted_hits.bam
samtools tview
samtools tview accepted_hits.bam ../chr4.fa
# ?
# g 4:82426400
# . to turn on off dot view
# n to turn on nt colors
# b to turn on base call qualities
# r to toggle read names
# space/backspace to move around
```


## Counting

Remember what we want to end up with is a table that gives us the number of reads mapping to each gene for each sample.

All we have now is an alignment which tells us for each sample the genomic positions of where each read aligned on the reference sequeunce. It doesn't tell us anything about genes. For that we'll need a gene annotation, which tells us the genomic position of genes (more specifically, exons). Then we can kind of intersect the two.

```bash
head chr4.gtf
```

There's a tool called featureCounts that's part of a larger package called subread that very quickly goes through all your alignments for all your samples and counts which reads map to exons in a supplied annotation file.

<http://subread.sourceforge.net/>

If you run `featureCounts` without any arguments, it gives you some help.

You're required to give it an annotation file, an output file, and one ore more input files.

You might want to pay special attention to the `-t` and `-g` options. Here we want to count all the reads mapping to any exon of a gene (`-t exon`), and summarize the counts for that gene across all the exons that gene has (`-g gene_name`). Use `less genes.gtf` to look at the annotation to see what the names of the meta-features are.  

We can also use the `-T` option to specify that we want to run multiple threads to speed things up.

Take a look at other options for dealing with paired-end data, strand-specific data, multi-mapping reads, etc.

```bash
featureCounts -a chr4.gtf -o counts.txt -t exon -g gene_name -T 4 */accepted_hits.bam
```

After mapping is complete, take a look at the summary file produced. Open up cyberduck and using SFTP, download the counts.txt file you just created. ***Finally, terminate the AWS EC2 instance after you've downloaded all the data you need.***

## Resources

- [Illumina iGenomes](http://support.illumina.com/sequencing/sequencing_software/igenome.html): Gene annotations and pre-computed indexes for a variety of organisms.
- Bowtie2 Manual: <http://bowtie-bio.sourceforge.net/bowtie2/manual.shtml>
- Tophat2
  - Tutorial: <http://ccb.jhu.edu/software/tophat/tutorial.shtml>
  - Manual: <http://ccb.jhu.edu/software/tophat/manual.shtml>
- featureCounts tutorial: <http://bioinf.wehi.edu.au/featureCounts/>
