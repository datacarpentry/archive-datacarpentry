---
layout: lesson
root: ../..
title: Shell Scripts
---

#### Objectives
*   Write a shell script that runs a command or series of commands for a fixed set of files.
*   Run a shell script from the command line.
*   Write a shell script that operates on a set of files defined by the user on the command line.
*   Create pipelines that include user-written shell scripts.

We are finally ready to see what makes the shell such a powerful
environment for data wrangling. It allows us to take the commands we
repeat frequently and save them in files so that we can re-run all
those operations again later by typing a single command.

For historical reasons, a bunch of commands saved in a file is usually
called a [shell script](../../gloss.html#shell-script), but make no
mistake: these are actually small programs.

To learn how shell scripts are built and how they work, let's build a
shell script that takes as input a list of file names on the command
line, and assuming that each file is in comma-delimited value (CSV)
format, counts the number of columns and prints them to the terminal.

Generally speaking, the best way to build a shell script is
incrementally, one command at a time, and by figuring out how to
accomplish the desired task on a single given file first. This can
typically be done on the command line interactively.

So let's see how can count the number of columns in the file
`surveys.csv`. First, intuitively the line with the column names also
contains the information about the number of columns:

~~~
$ head -n 1 surveys.csv
~~~

If we could count the number of commas in this line, we'd (almost) have the number of columns. The tool `wc` can count characters:

~~~
$ echo ",,," | wc -c
~~~ 

> Question: Why does this show one more than the number of commas?

If we could delete everything but the commas, we would have the desired input to `wc -c`. The tool `tr` (translate characters in one set to those in another) has a mode to accomplish this: with the `-d` switch it doesn't translate, but deletes the characters in the specified set from the input. We want to delete everything but commas. Instead of enumerating all characters that aren't comma, `tr` with the `-c` option allows us to say _"delete the complement of this set"_. Then our set of which to take the complement is the comma:

~~~
$ echo "12345abcde," | tr -c -d ,
~~~

> Question: Why is the result of enumerating all characters other than
> the comma slightly different from taking the complement of a comma?
>
> ~~~
> # taking the complement of comma:
> $ echo "12345abcde," | tr -c -d ,
> # expressly enumerate all characters to be deleted
> $ echo "12345abcde," | tr -d 12345abcde
> ~~~

Now we can put the command together:

~~~
$ head -n 1 surveys.csv | tr -c -d , | wc -c
~~~

To get the actual number of columns, we only need to add 1. This can
be accomplished using the `expr` command (which is built into bash):

~~~
$ expr `head -n 1 surveys.csv | tr -c -d , | wc -c` + 1
~~~

Now that we have the command working for one file, we can put it into
a shell script. A shell script is essentially a text file of shell
commands. Let's create open a new file in a text editor, put this one
line into it, and save it as `numcols.sh`. 

> #### Text vs. Whatever
>
> We usually call programs like Microsoft Word or LibreOffice Writer "text
> editors", but we need to be a bit more careful when it comes to
> programming. By default, Microsoft Word uses `.docx` files to store not
> only text, but also formatting information about fonts, headings, and so
> on. This extra information isn't stored as characters, and doesn't mean
> anything to tools like `head`: they expect input files to contain
> nothing but the letters, digits, and punctuation on a standard computer
> keyboard. When editing programs, therefore, you must either use a plain
> text editor, or be careful to save files as plain text.

We can now run this file as a shell script by passing it as an
argument to `bash`, our shell:

~~~
$ bash numcols.sh
~~~

Sure enough, our script's output is exactly what we would get if we ran
that pipeline directly.

> ### Execution permission and search path
>
> 'Normal' commandline programs (like `wc`, `ls`, etc) aren't executed
>  by being passed to as an argument to the shell. Shouldn't this work
>  for shell scripts, too, if they are programs like any other?
>  The answer is it does, but some prerequisites have to be met (that
>  for pre-installed programs we never have to worry about):
>
> 1. The shell needs to be able to find a program it is asked to
>    execute. This is achieved by either putting the program into one
>    of the directories listed in the `PATH` environment variable (or
>    adding the directory in which the program is to the `PATH`), or
>    by giving the full path to the program (even if it is in the
>    current directory).
>         ~~~
>         $ ./numcols.sh
>         ~~~
>
> 2. The program needs to be permitted to be executed by the
>    user. Compare the following two:
>
>         ~~~
>         $ ls -l /bin/ls
>         $ ls -l numcols.sh
>         ~~~ 
>
>    The permissions of a file are changed with `chmod`:
>
>         ~~~
>         $ chmod ugo+x numcols.sh
>         ~~~
>
> 3. The shell needs to know how to execute a program that is a
>    script, i.e., it needs to know which interpreter to invoke for
>    the script. The shell obtains this from the "hashbang" line,
>    which must be the first non-comment, non-empty line in the
>    script. The line starts with `#!` (hence the name) followed
>    (without space) by the path to the program to invoke as
>    interpreter, here `/bin/bash`: `#!/bin/bash`. We can add this
>    line to the top of the file using a text editor.

What if we want to count columns in an arbitrary file? We could edit
`numcols.sh` each time to change the filename, but that would probably
take longer than just retyping the command. Instead, let's edit
`numcol.sh` and replace `surveys.csv` with a special variable
called `$1`:

~~~
expr `head -n 1 $1 | tr -c -d , | wc -c` + 1
~~~

Inside a shell script, `$1` means "the first parameter on the command
line".  We can now run our script like this:

~~~
$ bash numcols.sh surveys.csv
$ bash numcols.sh plots.csv
$ bash numcols.sh species.csv
~~~

This is already much better - we don't have to edit the script
anymore. What if the script could take any number of files as
parameters, and execute the column counting pipeline for each of them?
This is the concept of looping, one of the concepts that make scripts
truly powerful. This will also expand on variables, and variable
substitution.

We have already seen _positional variables_ such as `$1` that the
shell substitutes for the nth parameter (the first for `$1`, and so
forth). We can also assign values to variables for which we choose the
name, and use their values subsequently in places where we need
them. Variables in bash are assigned values with the `=` symbol, and
the shell substitutes the variable's value if we prefix it with `$`:

~~~
$ myfile=surveys.csv
$ echo $myfile
$ expr `head -n 1 $myfile | tr -c -d , | wc -c` + 1
~~~

One of the most frequently used loops in bash is `for`. It loops over
a specified list of values, and assigns each value in the list to a
_loop_ variable one by one.

~~~
$ for f in surveys.csv plots.csv species.csv 
> do
>    expr `head -n 1 $f | tr -c -d , | wc -c` + 1
> done
~~~

> #### Measure Twice, Run Once
> 
> A loop is a way to do many things at once&mdash;or to make many mistakes at
> once if it does the wrong thing. One way to check what a loop *would* do
> is to echo the commands it would run instead of actually running them.
> 
> _Exercise_: Change the loop above so that it echoes the command that
> would be run, but doesn't run anything.

> #### Follow the Prompt
>
> The shell prompt changes from `$` to `>` and back again as we were
> typing in our loop. The second prompt, `>`, is different to remind
> us that we haven't finished typing a complete command yet.
>

Instead of expressly enumerating files, we can also use filename expansion,
like we do on the command line (such as `ls *.csv`):

~~~
$ for f in *.csv
> do
>    expr `head -n 1 $f | tr -c -d , | wc -c` + 1
> done
~~~

> #### Spaces in Names
> 
> Filename expansion in loops is another reason you should not use
> spaces in filenames.  Suppose our data files are named:
> 
> ~~~
> plots v1.csv
> surveys v1.csv
> species v1.csv
> ~~~
> 
> If we try to process them using:
> 
> ~~~
> for f in *.csv
> do
>     ls -l $f
> done
> ~~~
> 
> then with older versions of Bash, or many other shells, `f` will
> then be assigned the following values in turn:
> 
> ~~~
> plots
> v1.csv
> surveys
> v1.csv
> species
> v1.csv
> ~~~
>
> That's a problem because there are no files named this way, and now
> the same "file" appears multiple times.

Coming back to the shell script, we can now change the command in the
`numcols.sh` script to a loop. To get the list of things to loop over from the
command line, we use `"$@"`, which expands to all parameters passed to
the script, with each parameter forming an element of the list:

~~~
$ cat numcols.sh
for f in "$@"
do
    expr `head -n 1 $f | tr -c -d , | wc -c` + 1
done
~~~

We can now call this for all .csv files:

~~~
$ bash numcols.sh *.csv
~~~

> ### Commenting scripts
>
> It may take the next person who reads `numcols.sh` a moment to
> figure out what it does.  We can improve our script by adding some
> [comments](../../gloss.html#comment) at the top. A comment starts
> with a `#` character and runs to the end of the line.  The computer
> ignores comments, but they're invaluable for helping people
> understand and use scripts.
> 
> Exercise: Add comments to the script so you know which line does what.

The undesirable part left is that we don't really know (aside from
guessing by order) which line of output is for which file.

_Exercise_: Change the script so that it also prints the name of the
file to which the column count applies.

#### Key Points
*   Save commands in files (usually called shell scripts) for re-use.
*   `bash filename` runs the commands saved in a file.
*   `$@` refers to all of a shell script's command-line parameters.
*   `$1`, `$2`, etc., refer to specified command-line parameters.
*   Letting users decide what files to process is more flexible and more
    consistent with built-in Unix commands.
*   A `for` loop repeats commands once for every thing in a list.
*   Every `for` loop needs a variable to refer to the current "thing".
*   Use `$name` to expand a variable (i.e., get its value).
*   Do not use spaces, quotes, or wildcard characters such as '*' or '?' in
    filenames, as it complicates variable expansion.
*   Give files consistent names that are easy to match with wildcard
    patterns to make it easy to select them for looping.

#### Challenges

1.  Leah has several hundred data files, each of which is formatted like this:

    ~~~
    2013-11-05,deer,5
    2013-11-05,rabbit,22
    2013-11-05,raccoon,7
    2013-11-06,rabbit,19
    2013-11-06,deer,2
    2013-11-06,fox,1
    2013-11-07,rabbit,18
    2013-11-07,bear,1
    ~~~

    Write a shell script called `species.sh` that takes any number of
    filenames as command-line parameters, and uses `cut`, `sort`, and
    `uniq` to print a list of the unique species appearing in each of
    those files separately.

2.  Let's say occasionally our survey data are updated, and we'd like
    to be able to automatically generate a quick data report so we can
    see important changes. Let's say we want for each species how many
    rows there are with and without weight data. Write a shell script
    that accomplishes this.

