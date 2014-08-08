---
layout: lesson
root: ../..
title: Preparing the document-term matrix
---
<div class="objectives" markdown="1">

#### Objectives
*   Prepare the document-term matrix for analysis
*   Remove wanted elements from the text
  

</div>

Now we've sailed through getting the data into R and getting it into the document-term matrix format we can see that there are few problems that we need to deal with before we can get on with the analysis. When we inspected the document-term matrix we saw that the text is polluted with punctuation, and probably other things like sneaky white spaces that are hard to spot, and numbers (meaning digits). We want to remove all of that before we move on. 

But there are also some other things we should also remove. To get to the words that we're interested in, we can remove all the uninteresting words such as 'a', 'the', and so on. These uninteresting words are often called stopwords and we can delete them from our data to simplify and speed up our operations. We can also convert all the words to lower case, since upper and lower case have no semantic difference here (for the most part, an abbreviation is an obvious exception, if we were expecting those to be important we might skip the case conversion).  

The `tm` package contains convenient functions for removed these things from text data. There are many other related functions of course, such as stemming (which will reduce 'learning' and 'learned' to 'learn'), part-of-speech tagging (for example, to select only the nouns), weighting, and so on, that similarly clean and transform the data, but we'll stick with the simple ones for now. We can easily do this cleaning during the process of converting the corpus to a document-term matrix:


```r
my_dtm <- DocumentTermMatrix(my_corpus, 
                             control = list(removePunctuation = TRUE, 
                                            stripWhitespace = TRUE,
                                            removeNumbers = TRUE, 
                                            stopwords =  TRUE, 
                                            tolower = TRUE, 
                                            wordLengths=c(1,Inf)))
# This last line with 'wordLengths' overrides the default minimum
# word length of 3 characters. We're expecting a few important single
# character words, so we set the function to keep those. Normally words
# with <3 characters are uninteresting in most text mining applications
my_dtm # inspect
inspect(my_dtm[1:10, 1:10]) # inspect again
```

And now we see that when we inspect the document-term matrix the punctuation has gone. We can also see that the number of terms has been reduced, and the `Maximal term length` value has also dropped. We can have a look through the words that are remaining after this data cleaning:


```r
Terms(my_dtm)
```

The majority of words look fine, there are a few odd ones in there that we're left with after removing punctuation. We can work on these removing sparse terms, since these long words probably only occur once in the corpus. We'll use the function `removeSparseTerms` which takes an argument between <1 (ie. 0.9999) and zero for how sparse the resulting document-term matrix should be. Typically we'll need to make several passes at this to find a suitable sparsity value. Too close to zero and we'll have hardly any words left, so it's useful to experiment with a bunch of different values here.  


```r
my_dtm_sparse <- removeSparseTerms(my_dtm, 0.98)
my_dtm_sparse # inspect
```

Now we've got a dataset that has be cleaned of most of the unwanted items such as punctuation, numerals and very common words that are of little interest. We're ready to learn something from the data!

<div class="keypoints" markdown="1">

#### Key Points
*   Text needs to be cleaned before analysis to remove uninteresting elements
*   The tm package has convenient functions for cleaning the text
*   Inspecting the output after each transformation helps to assess the effectiveness of the data cleaning, and some transformations need to be iterated over to suit the data

</div>
