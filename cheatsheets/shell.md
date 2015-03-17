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
	$ type <b>command</b>		# what does <b>command</b> refer to
	$ man <b>command</b>			# manual page for command
</pre>

### Listing, navigating, creating and moving things

Printing working directory:

	$ pwd

List contents of a directory:

	$ ls				# show all files
	$ ls -l				# show details
	$ ls *.txt     			# subset of files matching pattern *.txt
	
Change directories:
<pre>	
	$ cd  <b>directory</b>           	# change to that directory
</pre>

<b>directory</b> can be <b>absolute</b>, meaning it starts with a `/`. If it does not start with a `/`, the movement is relative to the current directory. The special directory name `..` means 'one level up'. In Unix (i.e. Linux and Mac OSX) there are no drive letters!

	$ cd ..         		# change 'one level up'
	$ cd            		# change to your home directory
	
Create and remove directories:

<pre>	$ mkdir <b>directory</b>
	$ rmdir <b>directory</b>
</pre>

Copy, move, delete:
	
<pre>	
	$ cp <b>origin</b> <b>destination</b>
	$ mv <b>origin</b> <b>destination</b>
	$ rm <b>file</b>
	$ rm -r <b>directory</b>		# deletes complete directory tree
</pre>	

*Hint: tab completion makes you more efficient and less error-prone*

Create and/or edit a file:
	
	$ nano readme.txt
	
###Working with file contents

Seeing the contents of a file:

<pre>
	$ cat <b>file</b>
	$ less <b>file</b>  		# use 'q' to leave the viewer
</pre>	

How big is this file?
	
<pre>
	$ ls -lh <b>file(s)</b>
	$ wc     <b>file(s)</b>		# count of lines, words and characters
</pre>

Sorting the contents of a file:
	
<pre>
	$ sort <b>file</b>
</pre>

Redirecting output to a file: use the '>' operator, e.g.:

	$ wc -l *.csv > number_lines.csv
	
Pipe commands together using the `|` operator, e.g.:

	$ wc -l *.csv | sort
	
Getting subset of rows:

<pre>
	$ head  <b>file</b>        		# first 10 lines of a file
	$ tail  <b>file</b>        		# last 10 lines of a file
</pre>	

Getting a subset of columns (in this case, 3rd column of a file called inputfile.csv):
	
	$ cut -f 3 -d , inputfile.csv
	
## Finding things

In files and in directories:
<pre>
	$ grep <b>regexp</b> <b>files</b>	# search pattern in files
	$ find. -name 'pattern'	        # search file matching pattern in current dir and below
</pre>		

## What did I do? 

Use the arrow-up key, or:
	
	$ history
