# 00-intro.Rmd
Jenny Bryan  
`r format(Sys.time(), '%d %B, %Y')`  

<blockquote class="twitter-tweet" lang="en"><p>If I had one thing to tell biologists learning bioinformatics, it would be &quot;write code for humans, write data for computers&quot;.</p>&mdash; Vince Buffalo (@vsbuffalo) <a href="https://twitter.com/vsbuffalo/statuses/358699162679787521">July 20, 2013</a></blockquote>

An important aspect of "writing data for computers" is to make your data __tidy__ (see White et al and Wickham in the Resources). There's an emerging consensus on key features of __tidy__ data:

  * Each column is a variable
  * Each row is an observation

If you are struggling to make a figure, for example, stop and think hard about whether your data is __tidy__. Untidiness is an extremely common, often overlooked cause of unnecessary agony in data analysis and visualization.

## Lord of the Rings example

I will give you a concrete example of some untidy data I created from [this data from the Lord of the Rings Trilogy](https://github.com/jennybc/lotr).




<table border = 1>
<tr>
<td>
<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Wed Jul 23 15:25:37 2014 -->
<TABLE border=1>
<CAPTION ALIGN="top"> The Fellowship Of The Ring </CAPTION>
<TR> <TH> Race </TH> <TH> Female </TH> <TH> Male </TH>  </TR>
  <TR> <TD> Elf </TD> <TD align="right"> 1229 </TD> <TD align="right"> 971 </TD> </TR>
  <TR> <TD> Hobbit </TD> <TD align="right"> 14 </TD> <TD align="right"> 3644 </TD> </TR>
  <TR> <TD> Man </TD> <TD align="right"> 0 </TD> <TD align="right"> 1995 </TD> </TR>
   </TABLE>
</td>
<td>
<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Wed Jul 23 15:25:37 2014 -->
<TABLE border=1>
<CAPTION ALIGN="top"> The Two Towers </CAPTION>
<TR> <TH> Race </TH> <TH> Female </TH> <TH> Male </TH>  </TR>
  <TR> <TD> Elf </TD> <TD align="right"> 331 </TD> <TD align="right"> 513 </TD> </TR>
  <TR> <TD> Hobbit </TD> <TD align="right"> 0 </TD> <TD align="right"> 2463 </TD> </TR>
  <TR> <TD> Man </TD> <TD align="right"> 401 </TD> <TD align="right"> 3589 </TD> </TR>
   </TABLE>
</td>
<td>
<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Wed Jul 23 15:25:37 2014 -->
<TABLE border=1>
<CAPTION ALIGN="top"> The Return Of The King </CAPTION>
<TR> <TH> Race </TH> <TH> Female </TH> <TH> Male </TH>  </TR>
  <TR> <TD> Elf </TD> <TD align="right"> 183 </TD> <TD align="right"> 510 </TD> </TR>
  <TR> <TD> Hobbit </TD> <TD align="right"> 2 </TD> <TD align="right"> 2673 </TD> </TR>
  <TR> <TD> Man </TD> <TD align="right"> 268 </TD> <TD align="right"> 2459 </TD> </TR>
   </TABLE>
</td>
</tr>
</table>

We have one table per movie. In each table, I'm showing the total number of words spoken, by characters of different races and genders.

You could imagine finding these three tables as separate worksheets in an Excel workbook. Or snuggled up next to each other in a single worksheet. Or hanging out in some cells on the side of a worksheet that containing the underlying data raw data. Or as tables on a webpage or in a Word document.

In all cases, that data has been provided in a format designed for consumption by *human eyeballs* (paraphrasing Murrell; see Resources). The format makes it easy for a *human* to look up the number of words spoken by female elves in The Two Towers. But this format actually makes it pretty hard for a *computer* to pull out such counts and, more importantly, to compute on them or graph them. 

## Tidy Lord of the Rings data

Here's how the same data looks in tidy form:

<!-- html table generated in R 3.1.0 by xtable 1.7-3 package -->
<!-- Wed Jul 23 15:25:37 2014 -->
<TABLE border=1>
<TR> <TH> Film </TH> <TH> Race </TH> <TH> Gender </TH> <TH> Words </TH>  </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Elf </TD> <TD> F </TD> <TD align="right"> 1229 </TD> </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Elf </TD> <TD> M </TD> <TD align="right"> 971 </TD> </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Hobbit </TD> <TD> F </TD> <TD align="right"> 14 </TD> </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Hobbit </TD> <TD> M </TD> <TD align="right"> 3644 </TD> </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Man </TD> <TD> F </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD> The Fellowship Of The Ring </TD> <TD> Man </TD> <TD> M </TD> <TD align="right"> 1995 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Elf </TD> <TD> F </TD> <TD align="right"> 331 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Elf </TD> <TD> M </TD> <TD align="right"> 513 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Hobbit </TD> <TD> F </TD> <TD align="right"> 0 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Hobbit </TD> <TD> M </TD> <TD align="right"> 2463 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Man </TD> <TD> F </TD> <TD align="right"> 401 </TD> </TR>
  <TR> <TD> The Two Towers </TD> <TD> Man </TD> <TD> M </TD> <TD align="right"> 3589 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Elf </TD> <TD> F </TD> <TD align="right"> 183 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Elf </TD> <TD> M </TD> <TD align="right"> 510 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Hobbit </TD> <TD> F </TD> <TD align="right"> 2 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Hobbit </TD> <TD> M </TD> <TD align="right"> 2673 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Man </TD> <TD> F </TD> <TD align="right"> 268 </TD> </TR>
  <TR> <TD> The Return Of The King </TD> <TD> Man </TD> <TD> M </TD> <TD align="right"> 2459 </TD> </TR>
   </TABLE>

Notice that tidy data is generally taller and narrower. Certain elements get repated alot, e.g. `Hobbit`. It doesn't "fit on a page" as nicely, so we often instinctively resist it. But, unless and until you're making the final product for a textual presentation of data, ignore your yearning to see the data in a compact form.

## Benefits of tidy data

With the data in tidy form, it's natural to do more summarization or to make a figure. Here we sum across gender, to obtain word counts for the different races by movie.




```r
(by_film_race <- aggregate(Words ~ Film * Race, data = lotr_tidy, FUN = sum))
```

```
##                         Film   Race Words
## 1 The Fellowship Of The Ring    Elf  2200
## 2             The Two Towers    Elf   844
## 3     The Return Of The King    Elf   693
## 4 The Fellowship Of The Ring Hobbit  3658
## 5             The Two Towers Hobbit  2463
## 6     The Return Of The King Hobbit  2675
## 7 The Fellowship Of The Ring    Man  1995
## 8             The Two Towers    Man  3990
## 9     The Return Of The King    Man  2727
```

Now we depict the word counts we just computed in a barchart. 


```r
library(ggplot2)
p <- ggplot(by_film_race, aes(x = Film, y = Words, fill = Race))
p + geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + guides(fill = guide_legend(reverse=TRUE))
```

![plot of chunk barchart-lotr-words-by-film-race](./00-intro_files/figure-html/barchart-lotr-words-by-film-race.png) 

Notice the following general principles:

  * Having tidy data made it easier to get total word count for all combinations of `Film` and `Race`.
  * Having tidy data and a nice intermediate summary made it easier to create a barchart of word counts.
  * Having a barchart made it much easier for a human to see that `Hobbits` were featured heavily in The Fellowhip of the Ring, where as `Men` had a lot more screen time in The Two Towers. They were equally prominent in the last movie, The Return of the King.

Tidy data is integral to efficient data analysis and visualization.

If you're skeptical about any of the above claims, it would be interesting to try to get the word counts, the barchart, or the insight gained from the chart *without* tidying or plotting the data.

### Where to next?

In the next lesson *will point to 00-tidy.Rmd when it exists*, we'll show how to tidy this data.

Our summing over `Gender` to get word counts for `Film * Race` was an example of __data aggregation__. The base function `aggregate()` does simple aggregation. For more flexibility, check out the packages `plyr` and `dplyr`. *point to other lessons when/if they exist?*

The figure was made with `ggplot2`, a popular package that implements the Grammar of Graphics in R.

### Resources

  * [Bad Data Handbook](http://shop.oreilly.com/product/0636920024422.do) by By Q. Ethan McCallum, published by O'Reilly.
    - Chapter 3: Data Intended for Human Consumption, Not Machine Consumption by Paul Murrell.
  * Nine simple ways to make it easier to (re)use your data by EP White, E Baldridge, ZT Brym, KJ Locey, DJ McGlinn, SR Supp. *Ideas in Ecology and Evolution* 6(2): 1–10, 2013. doi:10.4033/iee.2013.6b.6.f <http://library.queensu.ca/ojs/index.php/IEE/article/view/4608>
  * Tidy data by Hadley Wickham. Preprint available <http://vita.had.co.nz/papers/tidy-data.pdf>.
    - [`tidyr`](https://github.com/hadley/tidyr), an R package to tidy data.
    - R packages by the same author that do heavier lifting in the data reshaping and aggregation department include [`reshape2`](https://github.com/hadley/reshape), [`plyr`](https://github.com/hadley/plyr) and [`dplyr`](https://github.com/hadley/dplyr).
    


