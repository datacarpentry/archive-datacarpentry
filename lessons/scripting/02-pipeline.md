---
layout: lesson
root: ../..
title: Data pipelining
---

#### Objectives
*   Automate data processing and analysis steps in the form of scripts.
*   Make data processing and analysis steps easily repeatable.
*   Create shell scripts that implement an executable and modifiable pipeline.

The Unix command shell is not the only command interpreter for which
command sequences, loops, conditionals can be scripted, and thereby
made executable as a unit. For example, we have already seen that R
can be scripted, and most SQL databases can be, too. So can be nearly
all environments for data processing, analysis, and visualization that
have a command prompt.  This can be exploited for creating automated,
executable, and repeatable data pipelines.

Our goal in this lesson is to create a fully automated, executable
pipeline that demonstrates taking data from combining and subsetting
all the way to analysis and visualization. We will see that once we
have this, we have a codified version of the sequence of steps from
start to finish that can be re-executed at any time, by anyone, and
which can be easily modified.

#### Tools that read commands can be scripted

If a tool can be invoked on the command line and then
reads commands from the terminal, it can be scripted, simply by using
the shell to pipe commands to the tool (using something similar to
`cat file-with-commands | tool` or `echo "a command" | tool`). For a
program, reading commands from the terminal prompt or reading commands
from a pipe is practically the same - namely reading from "`standard
input`". Some tools have additional command line options to adjust
their behavior if commands get piped to them rather than typed at the
terminal. For example, there might be an option to suppress certain
greetings that a tool might print for a user on the terminal. Or there
might be an option to ensure that the tool terminates once it reads
the last command. But the principle is the same.

How this can be exploited for creating automated, repeatable data
pipelines we will now demonstrate by putting the final results of the
SQL section together with the final results of the R section.

#### Scripting the analysis and visualization in R
 
We'll begin with the R part. Rather than typing in or copy&amp;pasting
the commands we used for the data analysis and plotting steps we
learned during the section on data analysis in R, we want to execute a
command that does the whole sequence.

R has a command line interface (which RStudio packages into a nice
user-interface), and can be asked to read R commands from a file
instead of the terminal. We can test this with the most minimal R
script possible, an empty file:

~~~
$ touch test.R
$ cat test.R | R
Fatal error: you must specify '--save', '--no-save' or '--vanilla'
~~~

Why the error? When R exits, it needs to know whether or not to save
the history and current R environment into files that would be picked
up by the next invocation of R. We need to choose one or the other, or
specify with `--vanilla` that no such prior history and environment is
to be loaded at the beginning nor saved at the end. 

~~~
$ touch test.R
$ cat test.R | R --vanilla

R version 3.1.0 (2014-04-10) -- "Spring Dance"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin10.8.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 
$
~~~

As we can see, R prints its whole initial greeting, then the command
prompt, reads the file for reading the command (which is empty), and
then terminates. It'd be better if the greeting and command prompt
didn't get printed to the terminal, because we already we won't be
typing anything at the prompt. In other words, we'd like R to be a
little "smarter" about reading commands from a file. For this, R has a
`BATCH` command mode:

~~~
$ R CMD BATCH test.R
~~~

There is no output to the terminal from this. However, R still
captures the whole terminal output, in a file with the same base name
as the script, but with extension `.Rout`:

~~~
$ R CMD BATCH test.R
$ cat test.Rout

R version 3.1.0 (2014-04-10) -- "Spring Dance"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin10.8.0 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> 
> proc.time()
   user  system elapsed 
  0.195   0.027   0.210 
$
~~~

Even though there is nothing in this file that we haven't seen yet
(aside from the timing provided, which can be turned off with the
`--no-timing` command line option), we will see later that this can be
very useful for verifying what commands were actually executed.

With this information we can now automate the sequence of data
aggregation and plotting commands with which the R section
finished. Let's put these commands into a text file that we'll call
`barplot-figure.R`, using a text editor:

~~~
dat  <- read.csv("surveys.csv", header=TRUE, na.strings="")
# only cases without NA
dat2 <- dat[complete.cases(dat$wgt),]

# aggregate by species
meanvals <- aggregate(wgt~species, data=dat2, mean)

pdf("R_plot.pdf")
# change to species to genus for joined dataset
barplot(meanvals$wgt, names.arg=meanvals$species, cex.names=0.4, col=c("blue"))
dev.off()
~~~

We can load the data into R, compute species means, and plot the
results to a file all through executing a single command:

~~~
$ R CMD BATCH barplot-figure.R
~~~

**Exercises**:

1. The above execution creates 2 files. Find them and explain what
   they contain.
2. A particularly nit-picky reviewer of the paper in which we included
   this plot asks that the bars can't be blue but have to be green
   instead. What does it take to change the figure?

#### Scripting combining and subsetting data in SQL

Suppose that the data isn't already all neatly packaged up in a
single file. Suppose, for example, we now want to aggregate weights
by genus, not by species. This information isn't in a single CSV file
- we need to join (recombine) data first. We have learned in the SQL
section how to do this relatively easily by pulling the data into a
relational database, then issuing SQL commands. Like most other
relational database systems, these steps can be scripted in SQLite,
including exporting the results of a SQL query into a file.

SQLite comes with a command line program, named `sqlite3` (to
distinguish it from versions of SQLite prior to v3). We invoke it like
any other program, and if we don't provide any arguments, `sqlite3`
prints a command prompt and waits for input:

~~~
$ sqlite3 
SQLite version 3.8.4.3 2014-04-03 16:53:12
Enter ".help" for usage hints.
Connected to a transient in-memory database.
Use ".open FILENAME" to reopen on a persistent database.
sqlite> 
~~~     

As noted earlier, instead of typing commands at the prompt, we can
pipe them to `sqlite3`, which will then read its input from the pipe:

~~~
$ echo ".help" | sqlite3
~~~

This will print the help on SQLite's internal (non-SQL) "dot" commands
(which start with a dot), and then exit (why?).

Files in CSV format are imported into an SQLite database using the
`.import` directive, which needs to be followed by a file name and the
name of a table to be created from the file. Before we do this we also
need to tell SQLite that our file is in CSV format, with the first
line being a column header line. To see how that works, let's put the
following into a text file, which we'll call `sqlite-script.sql`.

~~~
.mode csv
.import surveys.csv surveys
~~~

Now we can pipe it to `sqlite3`:

~~~
$ cat sqlite-script.sql | sqlite3
~~~

By default, sqlite opens an in-memory database, which will disappear
once sqlite exits, so the above won't result in anything we can
inspect afterwards. However, we can add an SQL command to the script
to convince ourselves that the table has really been created, and
contains something:

~~~
$ echo "SELECT * FROM surveys;" >> sqlite-script.sql
$ cat sqlite-script.sql | sqlite3
~~~

And we should see lots of rows from the surveys.csv files roll
past. That is, if we put a SQL query into a text file and pipe it to
sqlite, sqlite will execute the query and print the result, just as it
would in interactive mode or through the user interface. If we choose
CSV format (`.mode csv`), sqlite will essentially print the query
results as CSV-formatted data. There is one quirk, however. By default
sqlite does not include a header row in CSV format, but having one
will help tremendously not only with better documenting our data, but
also with loading the generated data into other programs such as R. We
can control this by adding `.headers on` before the query.

Now that we know how to script the database import and SQL subsetting,
we add the other csv file imports and replace the query in the sqlite
script with the one that subsets the data in the way that enables us
to aggregate them in R by genus rather than species.

~~~
.mode csv
.import plots.csv plots
.import species.csv species
.import surveys.csv surveys
.headers on
SELECT species.genus, species.species AS speciesname, surveys.*
FROM surveys
JOIN species ON surveys.species = species.species_id
WHERE species.taxa = 'Rodent';
~~~

The full sqlite script is in `./scripts/sqlite-import.sql`.

**Exercise**

1. Sqlite can be asked to print the query results to a file instead of
   standard output. Find out the command for how to control this
   (`.help` at the sqlite prompt yields help on all "dot" commands),
   and add it to the script.

#### Scripting the data pipeline from start to finish

Now we can put together the whole pipeline from importing data into a
database, combining and subsetting, generating a new dataset, loading
data into R, to running the analysis.

We create this as a shell script called `workflow.sh`. To break down the
task into units we have already solved, we start with a skeleton that
gives the major steps as comment text:

~~~
#!/bin/bash

# Load the data into database, combine, filter, export


# Load into R for analysis and plotting

~~~

Because less standard programs are not always in the same location or
in the path, it is typically a good practice to turn these into
variables so they can be easily adapted from one machine to
another. Here we'll need R and sqlite, and in the example below sqlite
is in a location for which we need to specify the full path.

~~~
#!/bin/bash

# paths to programs
sqlite=/usr/local/opt/sqlite/bin/sqlite3
R=R

# Load the data into database, combine, filter, export


# Load into R for analysis and plotting

~~~

We should be able to run this shell script, even for now it will not
do anything.

Now we fill in the sqlite pipeline command for loading the data into a
database, and re-exporting the combined and filtered the subset.

~~~
#!/bin/bash

# paths to programs
sqlite=/usr/local/opt/sqlite/bin/sqlite3
R=R

# Load the data into database, combine, filter, export
cat sqlite-import.sql | $sqlite > result.csv


# Load into R for analysis and plotting

~~~

We can run this script again to verify that it still works. It should
now produce the `results.csv` output file.

Then we add the R command to load the subset data into R, run the
analysis, and plot the results.

~~~
#!/bin/bash

# paths to programs
sqlite=/usr/local/opt/sqlite/bin/sqlite3
R=R

# Load the data into database, combine, filter, export
cat sqlite-import.sql | $sqlite > result.csv


# Load into R for analysis and plotting
$R CMD BATCH barplot-figure.R
~~~

We can run this script again, and should obtain the plot and other
files (see above). (Note that this will still use the aggregation by
species.)

**Exercises**

1. Change the workflow so that the data gets aggregated by genus, not
   by species. Which file needs to be changed?
2. Change the workflow to aggregate by plot type.
3. Bonus take-home challenge: create a pipeline script that aggregates
   by genus, but does this separately for each (i.e., loops over) plot
   type, generating a figure for each plot type.

#### Key Points

* Codifying the steps of a data processing and analysis workflow in
  the form of an automated executable script makes repeating the
  workflow in exactly the same way easy, including for yourself.
* An executable script can also be modified easily, and thus repeating
  the workflow with different parameters, or even different sets of
  input data, becomes easy as well.
* If the script is kept under version control, the way it changes over
  the course of a study can be self-documenting, almost in the sense
  of an electronic lab notebook. Particularly so if changes are
  accompanied by commit log messages that explain why the changes were
  made.
* Here we showed scripting executable data workflows in bash, but
  other languages, in particular scripting languages, can be and are
  used for this purpose as well, including Python, Perl, and Ruby.
* Similar to building complex programs, seemingly complex workflows
  are best built up from small to larger steps such that each of them can be
  tested individually. Not only does this break a daunting project
  down into tractable pieces, but frequent testing also localizes the
  source of unexpected problems to a small part of the whole workflow,
  which can greatly help debugging and troubleshooting.
