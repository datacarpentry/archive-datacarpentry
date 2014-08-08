#Data Carpentry data

This directory contains the datasets used as examples for the lessons in the datacarpentry/lessons directory. Here is a list of the subdirectories and contents.

##biology

Example data from the biological sciences. 

### aphid data

**Publication**: Bahlai, C.A., Schaafsma, A.W., Lagos, D., Voegtlin, D., Smith, J.L., Welsman, J.A., Xue, Y., DiFonzo, C., Hallett, R.H., 2014. Factors inducing migratory forms of soybean aphid and an examination of North American spatial dynamics of this species in the context of migratory behavior. Agriculture and Forest Entomology. 16, 240-250 http://dx.doi.org/10.1111/afe.12051

**Downloaded from**: http://lter.kbs.msu.edu/datatables/122

**Used in**: Excel lessons (datacarpentry/lessons/excel/ecology-examples)

**Files**

* Master_suction_trap_data_list_uncleaned.csv : a pre-cleaning version of the dataset 
* aphid_data_Bahlai_2014.xlsx : spreadsheet with aphid data

### Portal mammals data

This is data on a small mammal community in southern Arizona over the last 35 years. This is part of a larger project studying the effects of rodents and ants on the plant community. The rodents are sampled on a series of 24 plots, with different experimental manipulations of which rodents are allowed to access the plots.

**Publication**: S. K. Morgan Ernest, Thomas J. Valone, and James H. Brown. 2009. Long-term monitoring and experimental manipulation of a Chihuahuan Desert ecosystem near Portal, Arizona, USA. Ecology 90:1708.

**Downloaded from:** [http://esapubs.org/archive/ecol/E090/118/]()

**Used in:** excel, shell, R, python and SQL lessons

**Files**

* plots.csv : a list of the experimental plot IDs and descriptions
* species.csv : a list of the two-letter species code and information about the species
* surveys.csv : the full list of observations of species on plots
* surveys-exercise-extract_month.csv : a small  subset of the surveys data used in one of the excel lessons
* portal_mammals.sqlite : a SQLite database of the mammal data; incorporates plots.csv, species.csv and surveys.csv

## text_mining
Data used in lessons aimed at text-mining in the social sciences. 

### plos

Full-text of several articles from PLOS ONE, PLOS Computational Biology, and PLOS Biology. 

**Downloaded from:** http://www.plosone.org/

**Used in:** text-mining R lesson in lessons/R/materials/08-text_mining-R

**Files**

* plos_1.txt: [DOI:10.1371/journal.pone.0059813](http://dx.doi.org/10.1371/journal.pone.0059813)
* plos_2.txt: [DOI:10.1371/journal.pone.0001248](http://dx.doi.org/10.1371/journal.pone.0001248)
* plos_3.txt: [DOI:10.1371/annotation/69333ae7-757a-4651-831c-f28c5eb02120](http://dx.doi.org/10.1371/annotation/69333ae7-757a-4651-831c-f28c5eb02120)
* plos_4.txt: [DOI:10.1371/journal.pone.0080763](http://dx.doi.org/10.1371/journal.pone.0080763)
* plos_5.txt: [DOI:10.1371/journal.pone.0102437](http://dx.doi.org/10.1371/journal.pone.0102437)
* plos_6.txt: [DOI:10.1371/journal.pone.0017342](http://dx.doi.org/10.1371/journal.pone.0017342)
* plos_7.txt: [DOI:10.1371/journal.pone.0092931](http://dx.doi.org/10.1371/journal.pone.0092931)
* plos_8.txt: [DOI:10.1371/journal.pone.0091497](http://dx.doi.org/10.1371/journal.pone.0091497) 
* plos_9.txt: [DOI:10.1371/annotation/28ac6052-4f87-4b88-a817-0cd5743e83d6](http://dx/doi.org/10.1371/annotation/28ac6052-4f87-4b88-a817-0cd5743e83d6)
* plos_10.txt: [DOI:10.1371/journal.pcbi.1003594](http://dx.doi.org/10.1371/journal.pcbi.1003594)
* plos_11.txt: [DOI:10.1371/journal.pbio.002007](http://dx.doi.org/10.1371/journal.pbio.002007)
* plos_12.txt: [DOI:10.1371/journal.pbio.1001702](http://dx.doi.org/10.1371/journal.pbio.1001702)
* plos_13.txt: [DOI:10.1371/journal.pone.0054689](http://dx.doi.org/10.1371/journal.pone.0054689)
* plos_14.txt: [DOI:10.1371/journal.pone.0074321](http://dx.doi.org/10.1371/journal.pone.0074321)
* plos_15.txt: [DOI:10.1371/journal.pbio.1001248](http://dx.doi.org/10.1371/journal.pbio.1001248)
* plos_16.txt: [DOI:10.1371/journal.pbio.0000073](http://dx.doi.org/10.1371/journal.pbio.0000073)
* plos_17.txt: [DOI:10.1371/annotation/bb686276-234c-4881-bcd5-5051d0e66bfc](http://dx.doi.org/10.1371/annotation/bb686276-234c-4881-bcd5-5051d0e66bfc)
* plos_18.txt: [DOI:10.1371/journal.pbio.1001896](http://dx.doi.org/10.1371/journal.pbio.1001896)
* plos_19.txt: [DOI:10.1371/journal.pone.0099750](http://dx.doi.org/10.1371/journal.pone.0099750)
* plos_20.txt: [DOI:10.1371/annotation/48e29578-a073-42e7-bca4-2f96a5998374](http://dx.doi.org/10.1371/annotation/48e29578-a073-42e7-bca4-2f96a5998374)
 
## tidy-data
Sample data for data cleaning exercises. Includes the words spoken by characters of different races and gender in the Lord of the Rings movie trilogy.

**Publication:** J.R.R. Tolkien. The Lord of the Rings. Ballantine Books, New York. Copyright 1954-1974. Volume I. The Fellowship of the Ring. Volume II. The Two Towers. Volume III. The Return of the King.

**Downloaded from:** [jennybc on github](https://github.com/jennybc/lotr); original dataset at [manyeyes](http://www-958.ibm.com/software/data/cognos/manyeyes/datasets/words-spoken-by-character-race-scene/versions/1.txt)

**Used in:** data-tidying R lesson in lessons/tidy-data

**Files**

* Male.csv: the word counts for male characters in LOTR
* Female.csv: the word counts for female characters in LOTR
* The_Fellowship_Of_The_Ring.csv: word counts in FOTR
* The_Return_Of_The_King.csv: word counts in ROTK
* The_Two_Towers.csv: word counts in TT
* lotr_clean.tsv: original data in tidy form
* lotr_tidy.tsv: the multi-film, tidy dataset generated at the end of the lessons
  
