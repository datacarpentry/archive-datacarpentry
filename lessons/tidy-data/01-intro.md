# 01-intro.Rmd
Jenny Bryan  
`r format(Sys.time(), '%d %B, %Y')`  

<blockquote class="twitter-tweet" lang="en"><p>If I had one thing to tell biologists learning bioinformatics, it would be &quot;write code for humans, write data for computers&quot;.</p>&mdash; Vince Buffalo (@vsbuffalo) <a href="https://twitter.com/vsbuffalo/statuses/358699162679787521">July 20, 2013</a></blockquote>

An important aspect of "writing data for computers" is to make your data __tidy__ (see White et al and Wickham in the Resources). There's an emerging consensus on key features of __tidy__ data:

  * Each column is a variable
  * Each row is an observation

If you are struggling to make a figure, for example, stop and think hard about whether your data is __tidy__. Untidiness is a common, often overlooked cause of agony in data analysis and visualization.

## Lord of the Rings example

I will give you a concrete example of some untidy data I created from [this data from the Lord of the Rings Trilogy](https://github.com/jennybc/lotr).




<table border = 1>
<tr>
<td>
<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Tue Nov  4 16:14:42 2014 -->
<table border=1>
<caption align="top"> The Fellowship Of The Ring </caption>
<tr> <th> Race </th> <th> Female </th> <th> Male </th>  </tr>
  <tr> <td> Elf </td> <td align="right"> 1229 </td> <td align="right"> 971 </td> </tr>
  <tr> <td> Hobbit </td> <td align="right"> 14 </td> <td align="right"> 3644 </td> </tr>
  <tr> <td> Man </td> <td align="right"> 0 </td> <td align="right"> 1995 </td> </tr>
   </table>
</td>
<td>
<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Tue Nov  4 16:14:42 2014 -->
<table border=1>
<caption align="top"> The Two Towers </caption>
<tr> <th> Race </th> <th> Female </th> <th> Male </th>  </tr>
  <tr> <td> Elf </td> <td align="right"> 331 </td> <td align="right"> 513 </td> </tr>
  <tr> <td> Hobbit </td> <td align="right"> 0 </td> <td align="right"> 2463 </td> </tr>
  <tr> <td> Man </td> <td align="right"> 401 </td> <td align="right"> 3589 </td> </tr>
   </table>
</td>
<td>
<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Tue Nov  4 16:14:42 2014 -->
<table border=1>
<caption align="top"> The Return Of The King </caption>
<tr> <th> Race </th> <th> Female </th> <th> Male </th>  </tr>
  <tr> <td> Elf </td> <td align="right"> 183 </td> <td align="right"> 510 </td> </tr>
  <tr> <td> Hobbit </td> <td align="right"> 2 </td> <td align="right"> 2673 </td> </tr>
  <tr> <td> Man </td> <td align="right"> 268 </td> <td align="right"> 2459 </td> </tr>
   </table>
</td>
</tr>
</table>

We have one table per movie. In each table, we have the total number of words spoken, by characters of different races and genders.

You could imagine finding these three tables as separate worksheets in an Excel workbook. Or hanging out in some cells on the side of a worksheet that contains the underlying data raw data. Or as tables on a webpage or in a Word document.

This data has been formatted for consumption by *human eyeballs* (paraphrasing Murrell; see Resources). The format makes it easy for a *human* to look up the number of words spoken by female elves in The Two Towers. But this format actually makes it pretty hard for a *computer* to pull out such counts and, more importantly, to compute on them or graph them.

## Exercises

Look at the tables above and answer these questions:

  * What's the total number of words spoken by male hobbits?
  * Does a certain `Race` dominate a movie? Does the dominant `Race` differ across the movies?
  
How well does your approach scale if there were many more movies or if I provided you with updated data that includes all the `Races` (e.g. dwarves, orcs, etc.)?

## Tidy Lord of the Rings data

Here's how the same data looks in tidy form:

<!-- html table generated in R 3.1.1 by xtable 1.7-4 package -->
<!-- Tue Nov  4 16:14:42 2014 -->
<table border=1>
<tr> <th> Film </th> <th> Race </th> <th> Gender </th> <th> Words </th>  </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Elf </td> <td> Female </td> <td align="right"> 1229 </td> </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Elf </td> <td> Male </td> <td align="right"> 971 </td> </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Hobbit </td> <td> Female </td> <td align="right"> 14 </td> </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Hobbit </td> <td> Male </td> <td align="right"> 3644 </td> </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Man </td> <td> Female </td> <td align="right"> 0 </td> </tr>
  <tr> <td> The Fellowship Of The Ring </td> <td> Man </td> <td> Male </td> <td align="right"> 1995 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Elf </td> <td> Female </td> <td align="right"> 331 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Elf </td> <td> Male </td> <td align="right"> 513 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Hobbit </td> <td> Female </td> <td align="right"> 0 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Hobbit </td> <td> Male </td> <td align="right"> 2463 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Man </td> <td> Female </td> <td align="right"> 401 </td> </tr>
  <tr> <td> The Two Towers </td> <td> Man </td> <td> Male </td> <td align="right"> 3589 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Elf </td> <td> Female </td> <td align="right"> 183 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Elf </td> <td> Male </td> <td align="right"> 510 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Hobbit </td> <td> Female </td> <td align="right"> 2 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Hobbit </td> <td> Male </td> <td align="right"> 2673 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Man </td> <td> Female </td> <td align="right"> 268 </td> </tr>
  <tr> <td> The Return Of The King </td> <td> Man </td> <td> Male </td> <td align="right"> 2459 </td> </tr>
   </table>

Notice that tidy data is generally taller and narrower. It doesn't fit nicely on the page. Certain elements get repeated alot, e.g. `Hobbit`. For these reasons, we often instinctively resist __tidy__ data as inefficient or ugly. But, unless and until you're making the final product for a textual presentation of data, ignore your yearning to see the data in a compact form.

## Benefits of tidy data

With the data in tidy form, it's natural to *get a computer* to do further summarization or to make a figure. This assumes you're using language that is "data-aware", which R certainly is. Let's answer the questions posed above.

#### What's the total number of words spoken by male hobbits?


```r
aggregate(Words ~ Race * Gender, data = lotr_tidy, FUN = sum)
```

```
##     Race Gender Words
## 1    Elf Female  1743
## 2 Hobbit Female    16
## 3    Man Female   669
## 4    Elf   Male  1994
## 5 Hobbit   Male  8780
## 6    Man   Male  8043
```

Now it takes just one line of code to compute the word total for both genders of all `Races` across all `Films`. The total number of words spoken by male hobbits is 8780. It was important here to have all word counts in a single variable, within a data frame that also included variables for `Race` and `Gender`.

#### Does a certain `Race` dominate a movie? Does the dominant `Race` differ across the movies?

First, we sum across `Gender`, to obtain word counts for the different races by movie.




```r
(by_race_film <- aggregate(Words ~ Race * Film, data = lotr_tidy, FUN = sum))
```

```
##     Race                       Film Words
## 1    Elf The Fellowship Of The Ring  2200
## 2 Hobbit The Fellowship Of The Ring  3658
## 3    Man The Fellowship Of The Ring  1995
## 4    Elf             The Two Towers   844
## 5 Hobbit             The Two Towers  2463
## 6    Man             The Two Towers  3990
## 7    Elf     The Return Of The King   693
## 8 Hobbit     The Return Of The King  2675
## 9    Man     The Return Of The King  2727
```
We can stare hard at those numbers to answer the question. But even nicer is to depict the word counts we just computed in a barchart. 


```r
library(ggplot2)
p <- ggplot(by_race_film, aes(x = Film, y = Words, fill = Race))
p + geom_bar(stat = "identity", position = "dodge") +
  coord_flip() + guides(fill = guide_legend(reverse=TRUE))
```

![](./01-intro_files/figure-html/barchart-lotr-words-by-film-race.png) 

`Hobbits` are featured heavily in The Fellowhip of the Ring, where as `Men` had a lot more screen time in The Two Towers. They were equally prominent in the last movie, The Return of the King.

Again, it was important to have all the data in a single data frame, all word counts in a single variable, and associated variables for `Film` and `Race`.

## Take home message

Having the data in __tidy__ form was a key enabler for our data aggregations and visualization.

Tidy data is integral to efficient data analysis and visualization.

If you're skeptical about any of the above claims, it would be interesting to get the requested word counts, the barchart, or the insight gained from the chart *without* tidying or plotting the data. And imagine redoing all of that on the full dataset, which includes 3 more `Races`, e.g. `Dwarves`.

### Where to next?

In [the next lesson](02-tidy.md), we'll show how to tidy this data.

Our summing over `Gender` to get word counts for `Film * Race` was an example of __data aggregation__. The base function `aggregate()` does simple aggregation. For more flexibility, check out the packages `plyr` and `dplyr`. *point to other lessons when/if they exist?*

The figure was made with `ggplot2`, a popular package that implements the Grammar of Graphics in R.

### Resources

  * [Bad Data Handbook](http://shop.oreilly.com/product/0636920024422.do) by By Q. Ethan McCallum, published by O'Reilly.
    - Chapter 3: Data Intended for Human Consumption, Not Machine Consumption by Paul Murrell.
  * Nine simple ways to make it easier to (re)use your data by EP White, E Baldridge, ZT Brym, KJ Locey, DJ McGlinn, SR Supp. *Ideas in Ecology and Evolution* 6(2): 1–10, 2013. doi:10.4033/iee.2013.6b.6.f <http://library.queensu.ca/ojs/index.php/IEE/article/view/4608>
    - See the section "Use standard table formats"
  * Tidy data by Hadley Wickham. Journal of Statistical Software. Vol. 59, Issue 10, Sep 2014. <http://www.jstatsoft.org/v59/i10>
    - [`tidyr`](https://github.com/hadley/tidyr), an R package to tidy data.
    - R packages by the same author that do heavier lifting in the data reshaping and aggregation department include [`reshape2`](https://github.com/hadley/reshape), [`plyr`](https://github.com/hadley/plyr) and [`dplyr`](https://github.com/hadley/dplyr).
    


