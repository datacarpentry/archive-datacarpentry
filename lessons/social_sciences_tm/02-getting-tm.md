---
layout: lesson
root: ../..
title: Creating a document-term matrix
---
<div class="objectives" markdown="1">

#### Objectives
*   Install and use the tm package for R
*   Quantify the text by converting it to a document-term matrix
  

</div>

With our data in R, we are now ready to begin manipulations and analyses. Note that we're not working directly on the CSV file, we're working on a copy of the data in R. This means that if we make a change to the data that we don't like, we can start over by importing the original CSV file again. Keeping the original data intact like this is good practice for ensuring a reproducible workflow.

The basic install of R does not come with many useful functions for working with text. However, there is a very powerful contributed package called `tm` (for 'text mining') which is collection of functions for working with text that we will use. We'll need to download this package and then make these functions available to our R session. You only need to do this once per computer, so if you've already downloaded the `tm` package onto your computer in the recent past you can skip that line, but don't skip `library(tm)`, that's necessary each time you open R:


```r
install.packages("tm", repos = 'http://cran.us.r-project.org') # download the tm package from the web
library(tm) # make the functions available to our session
```

One of the strengths of working with R is that there is often a lot of documentation, and often this contains examples of how to use the functions. The `tm` package is a reasonably good example of this and we can see the documentation using:


```r
help(package = tm)
```

From here we can browse the functions and access the vignettes which give a detailed guide to using the most important functions. You'll also find a lot of information on the stackoverflow Q&A website under the `tm` tag (http://stackoverflow.com/questions/tagged/tm) that can be hard to find in the documentation (or is not there at all). We'll go directly on and continue working with the survey data by converting the free text into a document-term matrix. First we convert to a corpus, a file format in the tm package for a collection of documents containing text in the same format the we read it in the CSV file. Then we convert to a document-term matrix, and then have a look to see that the number of documents in the document-term matrix matches the number of rows in our CSV.  


```r
my_corpus <- Corpus(DataframeSource(survey_data))
my_corpus # inspect
my_dtm <- DocumentTermMatrix(my_corpus)
my_dtm # inspect
```

We can also see the number of unique words in the data, referenced as `terms` in the document-term matrix. The value for `Maximal term length` tells us the number of characters in the longest word. Is this case it's very long, usually a result of punctuation joining words together like 'document-term'. We'll do something about this in a moment. 

We want to see the actual rows and columns of the document-term matrix to verify that the conversion went as expected, so we use the function `inspect`, and we can subset the document-term matrix to inspect certain rows and columns (since it can be unwieldy to scroll through the whole document-term matrix). The `inspect` function can also be used on `my_corpus` if you want to see how that looks.


```r
inspect(my_dtm) # see rather too much to make sense of
inspect(my_dtm[1:10, 1:10]) # see just the first 10 rows and columns
```

The most striking detail here is that the matrix is mostly zeros, this is quite normal, since not every word will be in every response. We can also see a lot of punctuation stuck on the words that we don't want. In the next lesson we'll tackle those. 

<div class="keypoints" markdown="1">

#### Key Points
*   Key text analysis functions are in the contributed package tm
*   The tm package can be downloaded and installed using R
*   The documentation can be easily accessed using R
*   The free text can be easily converted to a document-term matrix
*   The document-term matrix needs some work before it's ready for analysis, for example removal of punctuation. 

</div>
