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

### Finding help
	
	$ type *command*		# what does command refer to
	$ man *command*			# manual page for command

### Navigating, creating and moving things

Printing working directory:
	
	$ pwd
	
List contents of a directory:
	
	$ ls
	$ ls *.txt     			# subset of files matching pattern *.txt
	
Change directories:
	
	$ cd  *directory*           	# change to that directory

*directory* can be *absolute*, meaning it starts with a `/`. If it does not start with a `/`, the movement is relative to the current directory. The special directory name `..` means 'one level up'. In Unix (i.e. Linux and Mac OSX) there are no drive letters!

	$ cd ..         		# change 'one level up'
	$ cd            		# change to your home directory
	
Create and remove directories:

	$ mkdir *directory*
	$ rmdir *directory*

Copy, move, delete:
	
	$ cp  *origin* *destination*
	$ mv  *origin* *destination*
	$ rm  *file*
        $ rm -r *directory*		# deletes complete directory tree
	
*Hint: tab completion makes you more efficient and less error-prone*

Create and/or edit a file:
	
	$ nano readme.txt
	
###Working with file contents

Seeing the contents of a file:

	$ cat *filename*
	$ less *filename*  		# use 'q' to leave the viewer
	
How big is this file?
	
	$ ls -lh *filename*
	$ wc     *filename*  		# count of lines, words and characters

Sorting the contents of a file:
	
	$ sort number_lines.csv

Redirecting output to a file: use the '>' operator, e.g.:

	$ wc -l *.csv > number_lines.csv
	
Pipe commands together using the `|` operator, e.g.:

	$ wc -l *.csv | sort
	
Getting subset of rows:

	$ head  *file*        		# first 10 lines of a file
	$ tail  *file*        		# last 10 lines of a file
	
Getting subset of columns (in this case, 3rd column of a file called inputfile.csv):
	
	$ cut -f 3 -d , inputfile.csv
	
## Finding things

In files and in directories:

	$ find				# for details see the man page
	$ grep *regexp* *files*
		
## What did I do? 

Use the arrow-up key, or:
	
	$ history
