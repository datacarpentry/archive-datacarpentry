#Introduction to the shell

Based on the very detailed material at [http://software-carpentry.org/v5/novice/shell/index.html](http://software-carpentry.org/v5/novice/shell/index.html).

##Objectives

* Introduce concept of command-line interface
* Understand the advantages of text files over other file types
* Explain how to navigate your computer's directory structures and understand paths
* Bash commands: using flags, finding documentation
* Move, copy and delete files
* Using tab completion for efficiency
* Use of wildcards for pattern matching


##Commands and hints

### Navigating, creating and moving things

Printing working directory:
	
	$ pwd
	
List contents of a directory:
	
	$ ls
	
Change directories:
	
	$ cd
	$ cd ..
	
Create and remove directories:

	$ mkdir
	$ rmdir

Copy, move, delete:
	
	$ cp
	$ mv
	$ rm
	
*Hint: tab completion makes you more efficient and less error-prone*

Create and edit a file:
	
	$ touch readme.txt
	$ nano readme.txt
	
###Working with file contents

Seeing the contents of a file:

	$ cat
	$ less
	$ head
	$ tail
	
How big is this file?
	
	$ ls -lh
	$ wc

Redirecting output to a file:

	$ wc -l *.csv > number_lines.csv
	
Sorting the contents of a file:
	
	$ sort number_lines.csv
	
Pipe commands together:

	$ wc -l *.csv | sort
	
Getting subset of rows:

	$head
	$tail
	
Getting subset of columns (in this case, 3rd column of a file called inputfile.csv):
	
	$ cut -f 3 -d , inputfile.csv
	
## Finding things

In files and in directories:

	$find
	$grep

Finding help (manual, or 'man' pages):
	
	$man <command>
		
## What did I do?
	
	$history
	






