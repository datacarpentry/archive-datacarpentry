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
<pre>	
	$ type <em>command</em>		# what does command refer to
	$ man <em>command</em>		# manual page for command
</pre>

### Listing, navigating, creating and moving things

Printing working directory:

	$ pwd

List contents of a directory:

	$ ls				# show all files
	$ ls -l				# show details
	$ ls *.txt     			# just files matching pattern *.txt
	
Change directories:
<pre>	
	$ cd  <em>directory</em>		# change to that directory
</pre>

*directory* can be *absolute*, meaning it starts with a `/`. If it does not start with a `/`, the movement is relative to the current directory. The special directory name `..` means 'one level up'. In Unix (i.e. Linux and Mac OSX) there are no drive letters!

	$ cd ..         		# change 'one level up'
	$ cd            		# change to your home directory
	
Create and remove directories:

<pre>
	$ mkdir <em>directory</em>
	$ rmdir <em>directory</em>
</pre>

Copy, rename, move, delete:
	
<pre>	
	$ cp <em>origin</em> <em>destination</em>
	$ mv <em>origin</em> <em>destination</em>  # used for both renaming and moving
	$ rm <em>file</em>
	$ rm -r <em>directory</em>		# deletes complete directory tree
</pre>	
If  *destination* is not a directory, `mv` renames, and `cp` copies.
If *destination* is a directory, `mv` moves file *origin* into that directory, and `cp` makes a copy of file *origin* into that directory.

*Hint: tab completion makes you more efficient and less error-prone*

###Working with file contents

Seeing the contents of a file:

<pre>
	$ cat <em>file</em>
	$ less <em>file</em>  		# use 'q' to leave the viewer
</pre>	

Create and/or edit a file:
	
	$ nano <em>file</em>

How big is this file?
	
<pre>
	$ ls -lh <em>file(s)</em>
	$ wc     <em>file(s)</em>		# count of lines, words and characters
</pre>

Sorting the contents of a file:
	
<pre>
	$ sort <em>file</em>
</pre>

Redirecting output to a file: use the '>' operator, e.g.:

	$ wc -l *.csv > number_lines.csv
	
Pipe commands together using the `|` operator, e.g.:

	$ wc -l *.csv | sort
	
Getting subset of rows:

<pre>
	$ head  <em>file</em>        		# first 10 lines of a file
	$ tail  <em>file</em>        		# last 10 lines of a file
</pre>	

Getting a subset of columns (in this case, 3rd column of a file called inputfile.csv):
	
	$ cut -f 3 -d , inputfile.csv
	
## Finding things

In files and in directories:
<pre>
	$ grep <em>regexp</em> <em>file(s)</em>		# search pattern in files
	$ find. -name 'pattern'		# search file matching pattern in current dir and below
</pre>		

## What did I do? 

Use the arrow-up key, or:
	
	$ history
