This is a lesson on tidying data. Specifically, what to do when a conceptual variable is spread out over 2 or more variables in a data frame.

Data used: words spoken by characters of different races and gender in the Lord of the Rings movie trilogy

  * [01-intro](01-intro.md) shows untidy and tidy data. Then we demonstrate how tidy data is more useful for analysis and visualization. Includes references, resources, and exercises.
  * [02-tidy](02-tidy.md) shows __how__ to tidy data, using `gather()` from the `tidyr` package. Includes references, resources, and exercises.
  * [03-tidy-bonus-content](03-tidy-bonus-content.md) is not part of the lesson but may be useful as learners try to apply the principles of tidy data in more general settings. Includes links to packages used.

Learner-facing dependencies:

  * files in the `tidy-data` sub-directory of the Data Carpentry `data` directory
  * `tidyr` package (only true dependency)
  * `ggplot2` is used for illustration but is not mission critical 
  * `dplyr` and `reshape2` are used in the bonus content

Instructor dependencies:

  * `curl` if you execute the code to grab the Lord of the Rings data used in examples from GitHub. Note that the files are also included in the `datacarpentry/data/tidy-data` directory, so data download is avoidable.
  * `rmarkdown`, `knitr`, and `xtable` if you want to compile the `Rmd` to `md` and `html`

Possible to do's

  * Domain-specific exercises could be added instead of or in addition to the existing exercises. Instructor could show basic principles and code using the LOTR data via projector and then pose challenges for the students using completely different data.
  * Cover more common data tidying tasks, such as:
    - split a variable that contains values and units into two separate variables, e.g. `10 km_square` becomes `10` and `km_square`
    - simple joins or merges of two data tables, e.g. add info on LOTR film duration or box office gross
    - renaming variables, revaluing factors, etc. to make data more self-documenting