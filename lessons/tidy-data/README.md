This is a lesson on tidying data. Specifically, what to do when a conceptual variable is spread out over 2 or more variables in a data frame.

Data used: words spoken by characters of different races and gender in the Lord of the Rings movie trilogy

  * [00-intro](00-intro.md) shows untidy and tidy data. Then we demonstrate how tidy data is more useful for analysis and visualization. Includes references, resources, and exercises.
  * [01-tidy](01-tidy.md) show __how__ to tidy data, using `gather()` from the `tidyr` package. Includes references, resources, and exercises.
  * [02-tidy-bonus-content](02-tidy-bonus-content.md) is not part of the lesson but may be useful as learners try to apply the principles of tidy data in real world settings. Includes links to packages used.

Learner-facing dependencies:

  * `tidyr` is the only true dependency of this lesson
  * `ggplot2` is used for illustration but is not mission critical 
  * `dplyr` and `reshape2` are used in the bonus content

Instructor dependencies:

  * `curl` if you execute the code to grab the Lord of the Rings data used in examples from GitHub. However I include the input `.tsv` in the `data` sub-directory, so data download is avoidable.
  * `rmarkdown`, `knitr`, and `xtable` if you want to compile the `Rmd` to `md` and `html`
