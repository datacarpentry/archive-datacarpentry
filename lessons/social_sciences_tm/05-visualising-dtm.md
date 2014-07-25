---
layout: lesson
root: ../..
title: Visualising the document-term matrix
---
<div class="objectives" markdown="1">

#### Objectives
*   Analyse the rank of frequencies
*   Visualise the results with ggplot2
*   Visualise correlations of words with Rgraphviz
  
</div>

We have some useful and new insights into our data, but we don't yet know which words are more frequent that others. Which are our respondents more interested in, R or Python? We also want to visualise our results so we can effectively communicate them to others.  Let's make a table that includes the exact frequencies of our high-frequency words. This is a three step operation: starting first in the middle of the function, we use `[` again to subset the document-term matrix to get only the columns for our high-frequency words, second we use `as.matrix` convert the document-term matrix to a regular matrix, third, use `colSums` to compute the column sums to get the total count for each word across all the documents (survey respondents):


```r
my_highfreqs_values <- colSums(as.matrix(my_dtm_sparse_stopwords[, my_highfreqs]))
```

The output of this line is an object called a 'named number' which is not an ideal format for making a table or plotting, so we'll need to get it into a data frame, which is much more useful. We'll use the function `data.frame` and then separately extract the words and their frequencies into columns of the data frame, assigning column names at the same time (here they are 'word' and 'freq'):


```r
my_highfreqs_values_df <- data.frame(word = names(my_highfreqs_values),
                                     freq = my_highfreqs_values)
my_highfreqs_values_df # have a look
```

Now we have a table, which is progress. If we have a glance up and down we can see what word occur most frequently. We can go a step further and sort the table to make it quicker to see the rank order of words in our data, once again using `[` with the addition of `order` to organise our data frame: 


```r
my_highfreqs_values_df <- my_highfreqs_values_df[with(my_highfreqs_values_df, order(freq)), ]
# this seems like a lot of typing for such a simple operation. If you're feeling brave
#  and want to type less, check out the 'arrange' function in the 'dplyr' package, it's 
# a lot less typing and quicker for large datasets.
my_highfreqs_values_df # have a look 
```

That's much better, now we've got a something that we can easily adapt to include in a report, for example by using the `write.csv` function to put the table into a spreadsheet file. We can see that 'data', 'analysis' and 'r' are the three most frequent words, indicating that these are the skills and tools our respondents are most interested in. Let's plot this so we can summarise our results in a high-impact visualisation. R comes with versatile built-in plotting functions, but we'll use a contributed package called `ggplot2` which produces publication-quality plots with minimum effort. We'll install the package first, assuming this is first time you've used `ggplot`. If you've already used it on your computer you can skip `install.packages`, but don't skip `library(ggplot2)`!


```r
# get the package
install.packages("ggplot2", repos = 'http://cran.us.r-project.org')
# make code available to our session
library(ggplot2)
# draw the plot
ggplot(my_highfreqs_values_df, aes(reorder(word, -freq), freq)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  xlab("high frequency words") +
  ylab("freqeuncy") + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0, vjust = 0.2)) 
```

There's quite a bit going on in that `ggplot` function, briefly we specify the dataset and the columns to plot, then in the same line we reorder the data from the highest frequency word to the lowest (`ggplot` doesn't care about our previous ordering), then specify a bar plot with `geom_bar`, then adjust the background colour with `theme_minimal`, then customize the axis labels, and finally rotate and center the horizontal axis labels. The result is a clear picture of the data, and we see a strong interest in data analysis using R. Python is one of the lowest frequency words in this set, so if were planning lessons for our respondents we now know that R is the language they're most familiar with and most interested to learn. 

Our second plot will visualise some of the correlations between the high-frequency words. We're using a package called `Rgraphviz` that is available in an online repository called [Bioconductor](http://www.bioconductor.org/). One of the great things about R is the huge number of user-contributed packages, but one of the downsides is they're scattered across a few different repositories. Most are on CRAN, followed by Bioconductor, and a small number on GitHub. Each repository requires a slightly different method for obtaining the package, as you can see in the code chunk below. Once we've got the Rgraphviz package ready, we can draw a cluster graph of our high frequency words and link them when they have at least a correlation of at least 0.15 (in this case). You'll need to experiment with different values of `corThreshold` to get a plot that gives meaningful information, too low and you'll get a mess of spaghetti lines, and too high and you'll get nothing. The vignette for Rgraphviz explains how to add colour to the plot and many other customisations, we'll stick with the basic plot here: 


```r
source("http://bioconductor.org/biocLite.R")
biocLite("Rgraphviz")
library(Rgraphviz, suppressUpdates=TRUE)

plot(my_dtm_sparse_stopwords, 
     terms = findFreqTerms(my_dtm_sparse_stopwords, 
                           lowfreq = 5), 
     corThreshold = 0.15)
```

We can quickly see the centrality of 'learn', and how words like 'stata' and 'using' are correlated with many other words. 'Databases' is left unconnected, indicating that there's isn't much of a pattern in its appearance in the survey responses - perhaps our respondents were not sure what exactly a database is and what it's used for, or they had such different ideas about databases there is no strong correlation with other words.

That wraps up this introductory lesson to text mining survey responses with R. We've gone through some of the key tasks of getting data into R, cleaning and transforming it using specialised packages, doing quantitative analyses and finally creating visualisations. We've also learned a lot about common functions and quirks when using R. The value of this exercise comes from the new insights we've gathered from our data that were not obvious from a casual inspection of the raw data file. From here you have a solid foundation for text mining with R, ready to apply to all kinds of other data and research questions. You shouldn't hesitate to augment what you've learnt here with the help built-in to R and the packages, online tutorials, and your imaginative experiments at the command line.  


<div class="keypoints" markdown="1">

#### Key Points
*   Data can to be rearranged and reordered to make it more readable and easier to extract insights
*   Visualising the word frequencies with a simple bar plot gives a clear picture of the most frequent words
*   A cluster plot helps us see correlations between words and better understand patterns in word use in our data


</div>
`
