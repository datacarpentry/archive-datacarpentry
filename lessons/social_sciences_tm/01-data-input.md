---
layout: lesson
root: ../..
title: Getting text data into R
---
<div class="objectives" markdown="1">

#### Objectives
*   Input the survey data into R
*   Inspect the data in R

</div>


Surveys are mostly conducted online using a web form. Most online survey applications provide a simple way to get the data by exporting a CSV file. CSV files are plain text files where the columns are separated by commas, hence 'comma separated variables' or CSV. The advantage of a CSV over an Excel or SPSS file is that we can open and read a CSV file using just about any software, including a simple text editor. We're not tied to a certain version of a certain expensive program when we work with CSV, so it's a good format to work with for maximum portability and endurance. We could also import text files, PDF files or other file formats for this kind of text analysis. For simplicity here we have a CSV file with just one column. This is an excerpt from real survey data that have been anonymised and de-identified. 

Built into R is a convenient function for importing CSV files into the R environment:


```r
survey_data <- read.csv("survey_data.csv", stringsAsFactors = FALSE)
```

You need to give R the full path to the CSV file on your computer, or you can use the function `setwd` to set a working directory for your R session before the `read.csv` line. Once you specify the appropriate working directory you can just refer to the CSV file by its name rather than the whole path. The argument `stringsAsFactors = FALSE` keeps the text as a character type, rather than converting it to a factor, which is the default setting. Factors are useful in many settings, but not this one. 

Now that we have the CSV data in our R environment, we want to inspect it to see that the import process went as expected. There are two handy functions we can use for this `str` will report on the structure of our data, and `head` will show us the first five rows of the data. We're looking to see that the data in R resembles what we see in the CSV file (which we can inspect in a spreadsheet program).


```r
str(survey_data) 
head(survey_data)
```

And we see that it looks pretty good. The output from `str` shows we have 73 observations (rows) and 1 variable (column), our data is formatted as 'character' (indicated by 'chr'). The output from `head` shows there are no weird characters, in the first five rows at least. One detail we can change to improve usability is the column name, it's rather long an unwieldy, so let's shorten it. First we'll see exactly what it is, then we'll replace it:


```r
names(survey_data) # inspect col names, wow so long and unreadable!
names(survey_data) <- "skills_to_acquire" # replace
names(survey_data) # check that the replacement worked as intended
```

Now we have the data in, and we're confident that the import process went well, we can carry on with quantification. 


<div class="keypoints" markdown="1">

#### Key Points
*   Survey responses can be collected online and the data can be exported as a CSV file
*   CSV files are advantageous because they're not bound to certain programs
*   R easily imports CSV files
*   R has convenient functions for inspecting and modifying data after import

</div>
