## Exercises for the shell genomics workshop
### Contributor: Tracy Teal

###EXERCISE

- Using `cd` and `ls`, go in to the 'shell-genomics/data' directory
and list its contents.
- How many files, how many directories and how many programs are there?

###EXERCISE

Now, we're going on a file hunt.
- Move around in the 'hidden' directory and try to find the file 'youfoundit.txt'

###EXERCISE

- Try finding the 'anotherfile.txt' file without changing directories.

###EXERCISE

- List the contents of the /bin directory. Do you see anything
familiar in there?

###EXERCISE

- What happens if you do `R1*fastq`?
- Do each of the following using a single `ls` command without
navigating to a different directory.

1.  List all of the files in `/bin` that start with the letter 'c
2.  List all of the files in `/bin` that contain the letter 'a'
3.  List all of the files in `/bin` that end with the letter 'o'

BONUS: List all of the files in '/bin' that contain the letter 'a' or 'c'

###EXERCISE

- Find the line number in your history for the last exercise (listing
files in /bin) and reissue that command.

###EXERCISE

-  Print out the contents of the `~/shell-genomics/data/MiSeq/stability.files`
    file. What does this file contain?

-  Without changing directories, (you should still be in `edamame-data`),
    use one short command to print the contents of all of the files in
    the `/home/username/shell-genomics/data/MiSeq` directory.

###EXERCISE

- Search for the sequence 'TTATCCGGATTTATTGGGTTTAAAGGGT' in the
F3D0_S188_L001_R1_001.fastq file and in the output have the
sequence name and the sequence. e.g.  
@M00967:43:000000000-A3JHG:1:2114:11799:28499 1:N:0:188  
TACGGAGGATGCGAGCGTTATCCGGATTTATTGGGTTTAAAGGGTGCGTAGGCGGGATGCAG

- Search for that sequence in all the FASTQ files.

###EXERCISE

Do the following:

1.  Rename the `stability.files_IMPORTANT` file to `stability.files`.
2.  Create a directory in the `MiSeq` directory called `new`
3.  Then, copy the `stability.files` file into `new`

###EXERCISE

Open 'awesome.sh' and add "echo AWESOME!" after the grep command and save the file.

We're going to come back and use this file in just a bit.
