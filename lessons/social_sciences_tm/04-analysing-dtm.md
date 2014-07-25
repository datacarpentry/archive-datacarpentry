---
layout: lesson
root: ../..
title: Analysing the document-term matrix
---
<div class="objectives" markdown="1">

#### Objectives
*   Analyse the document-term matrix to find most frequent words
*   Identify associations between words
  
</div>

Now we are at the point where we can start to extract useful new information from our data. The first step is to find the words that appear most frequently in our data and the second step is to find associations between words to help us understand how the words are being used. Since this is an exploratory data analysis you will need to repeat the analysis over and over with slight variations in the parameters until we get output that is interesting. 

To identify the most frequent words we can use the `findFreqTerms` function in `tm`. We could also convert the document-term matrix to a regular matrix and sort the matrix. However, this is problematic for larger document-term matrices, since the resulting matrix can be too big to store in memory (since the regular matrix has to allocate memory for each zero in the matrix, but the document-term matrix does not). Here we'll stick with using `findFreqTerms` since that's more versatile. The `lowfreq` argument specifies the minimum number of times the word should occur in the data:


```r
findFreqTerms(my_dtm_sparse, lowfreq=5)
```

We'll need to experiment with a bunch of different values for `lowfreq`, and even so, we might find that some of the words we're getting are uninteresting, such as 'able', 'also', 'use' and so on. One way to deal with those is to make a custom stopword list and run the remove stopwords function again. However, we can take a bit of a shortcut with stopwords. Instead of going back to the corpus, removing stopwords and numbers and so on, we can simply subset the columns of the document-term matrix using `[` to exclude the words we don't want any more. This `[` is a fundamental and widely used function in R that can be used to subset many kinds of data, not just text.


```r
remove <- c("able", "also", "use", "like", "id", "better", "basic", "will", "something") # words we probably don't want in our data
my_dtm_sparse_stopwords <- my_dtm_sparse[ , !(Terms(my_dtm_sparse) %in% remove)  ] # subset to remove those words
# when using [ to subset, the pattern is [ rows , columns ] so if we have a
# function before the comma then we're operating on the rows, and after the 
# comma is operating on the columns. In this case we are operating on the columns.
# The exclamation mark at the start of our column operation signifies 
# 'exclude', then we call the list of words in our data with 
# Terms(my_term) then we use %in% to literally mean 'in' 
# and then we provide our list of stopwords. So we're telling R to give us 
# all of the words in our data except those in our custom stopwordlist. 
```

Let's have a look at our frequent terms now and see what's left, some experimentation might still be needed with the `lowfreq` value:


```r
findFreqTerms(my_dtm_sparse_stopwords, lowfreq=5)
```

That gives us a nice manageable set of words that are highly relevant to our main question of what skills people want to learn. We can squeeze a bit more information out of these words by looking to see what other words they are often used with. The function `findAssocs` is ideal for this, and like the other functions in this lesson, requires an iterative approach to get the most informative output. So let's experiment with different values of `corlimit` (the lower limit of the correlation value between our word of interest and the rest of the words in our data): 


```r
findAssocs(my_dtm_sparse_stopwords, 'stata', corlimit = 0.25)
```

In this case we've learned that stata seems to be what some people are currently using, and is mentioned with SPSS, a sensible pairing as both are commercial software packages that are widely used in some research areas. But analysing these correlations one word at a time is tedious, so let's speed it up a bit by analysing a vector of words all at once. Let's do all of the high frequency words, first we'll store them in a vector object, then we'll pass that object to the `findAssocs` function (notice how we can drop the word `corlimit` in the `findAssocs`? Since it only takes one numeric argument it's unambiguous, so we can just pop the number in there without a label):


```r
my_highfreqs <- findFreqTerms(my_dtm_sparse_stopwords, lowfreq = 5)
my_highfreqs_assocs <- findAssocs(my_dtm_sparse_stopwords, my_highfreqs, 0.25)
my_highfreqs_assocs # have a look
my_highfreqs_assocs$python
```

This is where we can learn a lot about our respondents. For example 'learn' is associated with 'basics', 'linear' and 'modelling', indicating that our respondents are keen to learn more about linear modelling. 'Modelling' seems particularly frequent across many of the high frequency terms. We see 'visualization' associated with 'spatial' and 'modelling', and we see 'tools' associated with 'plot' suggesting a strong interest in learning about tools for data visualisation. 'R' is correlated with 'statistical', indicated that our respondents are aware of the unique strength of that programming language. And so on, now we have some quite specific insights into our respondents. 

So we've improved our understanding our our respondents nicely and we have a good sense of what's on their minds. The next step is to put these words in order of frequency so we know which are the most important in our survey, and visualise the data so we can easily see what's going on. 

<div class="keypoints" markdown="1">

#### Key Points
*   We can subset the document-term matrix using the `[` function to remove additional stopwords
*   Once stopwords are removed, the high-frequency words offer insights into the data
*   Analysing the words associated with the high-frequency words gives further insights into the context, meaning and use of the high-frequency words
*   We can automate the correlation analysis by passing a vector of words to the function, rather than just analysing one word at a time

</div>
