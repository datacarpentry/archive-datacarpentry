# 03-tidy-bonus-content.Rmd
Jenny Bryan  
`r format(Sys.time(), '%d %B, %Y')`  



This material is not part of the lesson. But it may be helpful when tidying data in real life.

## More about `rbind()`ing data frames

In [the main tidy lesson](02-tidy.md), the first step was to stack up `Film`-specific data frames row-wise. First I redo that, then present alternative methods for `rbind()`ing data frames.


```r
fship <- read.csv(file.path(data_dir, "The_Fellowship_Of_The_Ring.csv"))
ttow <- read.csv(file.path(data_dir, "The_Two_Towers.csv"))
rking <- read.csv(file.path(data_dir, "The_Return_Of_The_King.csv"))  
lotr_untidy <- rbind(fship, ttow, rking)
```

Note that the 3 underlying data frames are hard-wired into this command: `rbind(fship, ttow, rking)`. In real life, this can become very cumbersome and even impossible, if there is a large number of data frames that need to be combined. Things get challenging for two reasons:

  * listing the data frames explicitly can be a drag and error prone
  * the actual `rbind()`ing can take lots of memory and time
  
### Memory efficient row-binding

The `dplyr` package offers the function `rbind_list()` as an efficient substitute for the base `rbind()`.


```r
suppressPackageStartupMessages(library(dplyr))
lotr_untidy_2 <- rbind_list(fship, ttow, rking)
```

```
## Warning: Unequal factor levels: coercing to character
```

We get a warning about row-binding data frames with factors that don't have the same levels (here, the `Film` factor). The base function `rbind()` handles this by taking the union of factor levels, whereas `dplyr::rbind_list()` converts the affected factor to character.


```r
str(lotr_untidy)
```

```
## 'data.frame':	9 obs. of  4 variables:
##  $ Film  : Factor w/ 3 levels "The Fellowship Of The Ring",..: 1 1 1 2 2 2 3 3 3
##  $ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3 1 2 3 1 2 3
##  $ Female: int  1229 14 0 331 0 401 183 2 268
##  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
```

```r
str(lotr_untidy_2)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	9 obs. of  4 variables:
##  $ Film  : chr  "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Two Towers" ...
##  $ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3 1 2 3 1 2 3
##  $ Female: int  1229 14 0 331 0 401 183 2 268
##  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
```

It is easy to make `Film` back into a factor:


```r
lotr_untidy_2$Film <-
  factor(lotr_untidy_2$Film,
         levels = c("The Fellowship Of The Ring", "The Two Towers",
                    "The Return Of The King"))
```

The advantage of `dplyr::rbind_list()` over base `rbind()` will become apparent when the data frames you are row-binding are large and/or numerous. 

### Row-binding a list of data frames

Frequently the data frames destined for row-binding are collected together in a list. Here are several ways to proceed, starting with the most primitive.

To prepare, we collect the `Film`-specific data frames into a single list.


```r
lotr_files <- file.path(data_dir, c("The_Fellowship_Of_The_Ring.csv",
                                  "The_Two_Towers.csv",
                                  "The_Return_Of_The_King.csv"))
lotr_list <- lapply(lotr_files, read.csv)
str(lotr_list)
```

```
## List of 3
##  $ :'data.frame':	3 obs. of  4 variables:
##   ..$ Film  : Factor w/ 1 level "The Fellowship Of The Ring": 1 1 1
##   ..$ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3
##   ..$ Female: int [1:3] 1229 14 0
##   ..$ Male  : int [1:3] 971 3644 1995
##  $ :'data.frame':	3 obs. of  4 variables:
##   ..$ Film  : Factor w/ 1 level "The Two Towers": 1 1 1
##   ..$ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3
##   ..$ Female: int [1:3] 331 0 401
##   ..$ Male  : int [1:3] 513 2463 3589
##  $ :'data.frame':	3 obs. of  4 variables:
##   ..$ Film  : Factor w/ 1 level "The Return Of The King": 1 1 1
##   ..$ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3
##   ..$ Female: int [1:3] 183 2 268
##   ..$ Male  : int [1:3] 510 2673 2459
```

FYI, `lapply()` is one of the base R functions for data aggregation; it iteratively applies a function to each element of a vector.

#### Base R, brute force

We can use `rbind()` as before and give each data frame explicitly by specifying the 1st, 2nd, and 3rd elements of the list.


```r
lotr_untidy_3 <- rbind(lotr_list[[1]], lotr_list[[2]], lotr_list[[3]])
str(lotr_untidy_3)
```

```
## 'data.frame':	9 obs. of  4 variables:
##  $ Film  : Factor w/ 3 levels "The Fellowship Of The Ring",..: 1 1 1 2 2 2 3 3 3
##  $ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3 1 2 3 1 2 3
##  $ Female: int  1229 14 0 331 0 401 183 2 268
##  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
```

As you can imagine, this *really* does not scale well. What if there were 20 data frames in this list?!? Or 200?

#### Base R, `do.call()`

The arcane-sounding function `do.call()` "constructs and executes a function call from a name of a function and a list of arguments to be passed to it". Although the use of `do.call()` is not limited to `rbind()`, this is perhaps the most common use case:


```r
lotr_untidy_4 <- do.call(rbind, lotr_list)
str(lotr_untidy_4)
```

```
## 'data.frame':	9 obs. of  4 variables:
##  $ Film  : Factor w/ 3 levels "The Fellowship Of The Ring",..: 1 1 1 2 2 2 3 3 3
##  $ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3 1 2 3 1 2 3
##  $ Female: int  1229 14 0 331 0 401 183 2 268
##  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
```

This is a huge improvement over the brute force solution, because the individual data frames are no longer explicitly listed, one by one.

#### `dplyr::rbind_all()`

The `dplyr` package offers a memory-efficient solution for row-binding a list of data.frames, namely `rbind_all()`.


```r
lotr_untidy_5 <- rbind_all(lotr_list)
```

```
## Warning: Unequal factor levels: coercing to character
```

```r
str(lotr_untidy_5)
```

```
## Classes 'tbl_df', 'tbl' and 'data.frame':	9 obs. of  4 variables:
##  $ Film  : chr  "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Fellowship Of The Ring" "The Two Towers" ...
##  $ Race  : Factor w/ 3 levels "Elf","Hobbit",..: 1 2 3 1 2 3 1 2 3
##  $ Female: int  1229 14 0 331 0 401 183 2 268
##  $ Male  : int  971 3644 1995 513 2463 3589 510 2673 2459
```

We get the same warning as before about unequal factor levels for `Film`; resolve as shown above, if you want `Film` to be factor vs character.

The `rbind_all()` function from `dplyr` probably represents the best all around solution, because it addresses both pain points at once: it is memory efficient and it can operate on a list of data frames.

#### Other options

Other options for row binding data frames (and more) include the [`rbindlist()` function](http://stackoverflow.com/questions/15673550/why-is-rbindlist-better-than-rbind) from the [`data.table`](https://github.com/Rdatatable/data.table/) package and the `rbind.fill()` function from the `plyr` package. [This comparison](http://rcrastinate.blogspot.ca/2013/05/the-rbinding-race-for-vs-docall-vs.html) of row binding methods is informative, though it would be good to expand to include `data.table::rbindlist()` and `dplyr::rbind_all()`.

## More about gathering variables

In [the main tidy lesson](02-tidy.md), the second step was to gather the word counts stored as separate variables for `Females` and `Males` and stack them up to make two new variables: `Words` and `Gender`.

We start with the untidy data frame that results from any of the row-binding methods above.


```r
lotr_untidy
```

```
##                         Film   Race Female Male
## 1 The Fellowship Of The Ring    Elf   1229  971
## 2 The Fellowship Of The Ring Hobbit     14 3644
## 3 The Fellowship Of The Ring    Man      0 1995
## 4             The Two Towers    Elf    331  513
## 5             The Two Towers Hobbit      0 2463
## 6             The Two Towers    Man    401 3589
## 7     The Return Of The King    Elf    183  510
## 8     The Return Of The King Hobbit      2 2673
## 9     The Return Of The King    Man    268 2459
```

Here we repeat the `tidyr::gather()` approch from the main lesson, but also present alternatives that use no add-on packages at all and that use the more powerful `reshape2` package.

#### Base R, brute force

It is entirely possible to reshape data "by hand". Here we exploit R's recycling behavior to replicate the variables `Film` and `Race`. We create the new variable `Words` by concatenating `Female` and `Male` and we create a new factor `Gender`.


```r
lotr_tidy <-
  with(lotr_untidy,
       data.frame(Film = Film,
                  Race = Race,
                  Words = c(Female, Male),
                  Gender =rep(c("Female", "Male"), each = nrow(lotr_untidy))))
lotr_tidy
```

```
##                          Film   Race Words Gender
## 1  The Fellowship Of The Ring    Elf  1229 Female
## 2  The Fellowship Of The Ring Hobbit    14 Female
## 3  The Fellowship Of The Ring    Man     0 Female
## 4              The Two Towers    Elf   331 Female
## 5              The Two Towers Hobbit     0 Female
## 6              The Two Towers    Man   401 Female
## 7      The Return Of The King    Elf   183 Female
## 8      The Return Of The King Hobbit     2 Female
## 9      The Return Of The King    Man   268 Female
## 10 The Fellowship Of The Ring    Elf   971   Male
## 11 The Fellowship Of The Ring Hobbit  3644   Male
## 12 The Fellowship Of The Ring    Man  1995   Male
## 13             The Two Towers    Elf   513   Male
## 14             The Two Towers Hobbit  2463   Male
## 15             The Two Towers    Man  3589   Male
## 16     The Return Of The King    Elf   510   Male
## 17     The Return Of The King Hobbit  2673   Male
## 18     The Return Of The King    Man  2459   Male
```

#### Base R, `stack()`

I do not consider `stack()` useful in real life, given all the alternatives. Including only for completeness.


```r
lotr_tidy_2 <-
  with(lotr_untidy,
       data.frame(Film = Film,
                  Race = Race,
                  stack(lotr_untidy, c(Female, Male))))
names(lotr_tidy_2) <- c('Film', 'Race', 'Words', 'Gender')
lotr_tidy_2
```

```
##                          Film   Race Words Gender
## 1  The Fellowship Of The Ring    Elf  1229 Female
## 2  The Fellowship Of The Ring Hobbit    14 Female
## 3  The Fellowship Of The Ring    Man     0 Female
## 4              The Two Towers    Elf   331 Female
## 5              The Two Towers Hobbit     0 Female
## 6              The Two Towers    Man   401 Female
## 7      The Return Of The King    Elf   183 Female
## 8      The Return Of The King Hobbit     2 Female
## 9      The Return Of The King    Man   268 Female
## 10 The Fellowship Of The Ring    Elf   971   Male
## 11 The Fellowship Of The Ring Hobbit  3644   Male
## 12 The Fellowship Of The Ring    Man  1995   Male
## 13             The Two Towers    Elf   513   Male
## 14             The Two Towers Hobbit  2463   Male
## 15             The Two Towers    Man  3589   Male
## 16     The Return Of The King    Elf   510   Male
## 17     The Return Of The King Hobbit  2673   Male
## 18     The Return Of The King    Man  2459   Male
```

#### `tidyr::gather()`

This is repeated content from the main lesson.


```r
library(tidyr)
lotr_tidy_3 <-
  gather(lotr_untidy, key = 'Gender', value = 'Words', Female, Male)
lotr_tidy_3
```

```
##                          Film   Race Gender Words
## 1  The Fellowship Of The Ring    Elf Female  1229
## 2  The Fellowship Of The Ring Hobbit Female    14
## 3  The Fellowship Of The Ring    Man Female     0
## 4              The Two Towers    Elf Female   331
## 5              The Two Towers Hobbit Female     0
## 6              The Two Towers    Man Female   401
## 7      The Return Of The King    Elf Female   183
## 8      The Return Of The King Hobbit Female     2
## 9      The Return Of The King    Man Female   268
## 10 The Fellowship Of The Ring    Elf   Male   971
## 11 The Fellowship Of The Ring Hobbit   Male  3644
## 12 The Fellowship Of The Ring    Man   Male  1995
## 13             The Two Towers    Elf   Male   513
## 14             The Two Towers Hobbit   Male  2463
## 15             The Two Towers    Man   Male  3589
## 16     The Return Of The King    Elf   Male   510
## 17     The Return Of The King Hobbit   Male  2673
## 18     The Return Of The King    Man   Male  2459
```

#### `reshape2::melt()`

The `reshape2` package is more powerful than `tidyr` but also harder to use and often overkill. But some reshaping tasks are beyond the capabilities of `tidyr`, so its good to know `reshape2` is there when you need it.


```r
library(reshape2)
lotr_tidy_4 <-
  melt(lotr_untidy, measure.vars = c("Female", "Male"), value.name = 'Words')
lotr_tidy_4
```

```
##                          Film   Race variable Words
## 1  The Fellowship Of The Ring    Elf   Female  1229
## 2  The Fellowship Of The Ring Hobbit   Female    14
## 3  The Fellowship Of The Ring    Man   Female     0
## 4              The Two Towers    Elf   Female   331
## 5              The Two Towers Hobbit   Female     0
## 6              The Two Towers    Man   Female   401
## 7      The Return Of The King    Elf   Female   183
## 8      The Return Of The King Hobbit   Female     2
## 9      The Return Of The King    Man   Female   268
## 10 The Fellowship Of The Ring    Elf     Male   971
## 11 The Fellowship Of The Ring Hobbit     Male  3644
## 12 The Fellowship Of The Ring    Man     Male  1995
## 13             The Two Towers    Elf     Male   513
## 14             The Two Towers Hobbit     Male  2463
## 15             The Two Towers    Man     Male  3589
## 16     The Return Of The King    Elf     Male   510
## 17     The Return Of The King Hobbit     Male  2673
## 18     The Return Of The King    Man     Male  2459
```

In `reshape2` jargon, we want to `melt()` the untidy LOTR data. Under the hood, since we are `melt()`ing a data frame, the function `melt.data.frame()` is what's  actually used; read [the documentation](http://www.rdocumentation.org/packages/reshape2/functions/melt.data.frame). The first argument `data =` specifies the data frame to work on. The `measure.vars =` argument specifies the variables that should be gathered together to make a new variable -- here `Female` and `Male` word counts. The remaining variables -- `Film` and `Race` -- are assumed to be `id.vars` and will be replicated as necessary. Finally, if you want to name your new variable, indicate that via the `value.name =` argument.

Since `melt()` "will assume factor and character variables are id variables, and all others are measured," we could have just called it like so, but this seemed too magical to be useful for teaching!


```r
melt(lotr_untidy, value.name = 'Words')
```

## Resources

`dplyr` package: on [GitHub](https://github.com/hadley/dplyr) | an [introduction vignette](http://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)

`data.table` package: on [GitHub](https://github.com/Rdatatable/data.table/)

`tidyr` package: on [GitHub](https://github.com/hadley/tidyr),

`reshape2` package: on [GitHub](https://github.com/hadley/reshape)
