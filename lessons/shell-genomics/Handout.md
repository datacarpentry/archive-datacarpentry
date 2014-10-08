##Handout for shell-genomics workshop
###Contributor: Tracy Teal

This will be many of the commands run in the workshop

Start by getting the materials for the workshop.
Go to the command line and type:

    git clone https://github.com/tracykteal/shell-genomics.git -b gh-pages

Once the lessons are downloaded, we'll go in to that directory

    cd shell-genomics

`cd` stands for 'change directory'

    ls

`ls` stands for 'list' and it lists the contents of a directory.
Let's go look in the 'data' directory.

    cd data
    ls
    ls -F

Anything with a "/" after it is a directory.  
Things with a "*" after them are programs.  
It there's nothing there it's a file.

You can access the manual using the `man` program.

    man ls

Space key goes forward  
Or use the arrow keys to scroll up and down.  
When you are done reading, just hit `q` to quit.

    pwd

This stands for 'print working directory'. The directory you're currently
working in.

Examining contents of directories
Type:

    cd

Then enter the command:

    ls shell-genomics

This will list the contents of the `shell-genomics` directory without
you having to navigate there.

    cd
    cd shell-genomics/data/hidden

and you will jump directly to `hidden` without having to go through
the intermediate directory.

Tab completion is awesome.

Full path

    cd /home/username/shell-genomics/data/hidden

Relative path

    cd shell-genomics/data/hidden

In the shell the tilde character, ~, is a shortcut
for your home directory.

    ls ~

The shortcut `..` always refers to the directory
above your current directory.

    ls ..

prints the contents of the directory one up from
where you are.

The `*` character is a shortcut for "everything". Thus, if
you enter `ls *`, you will see all of the contents of a given
directory.

    ls *fastq

You can also review your recent commands with the `history` command.  

    history

to see a numbered list of recent commands

If your history looked like this:

    259  ls *
    260  ls /usr/bin/*.sh
    261  ls *R1*fastq

then you could repeat command #260 by simply entering:

    !260

(that's an exclamation mark).

The easiest way to examine a file is to print out all of the
contents using the program `cat`. Enter the following command:

    cat F3D0_S188_L001_R1_001.fastq

This prints out the contents of the `F3D0_S188_L001_R1_001.fastq` file.

The program, `less`, is useful when files are big and
you want to be able to scroll through them.

    less F3D0_S188_L001_R1_001.fastq

`less` opens the file, and lets you navigate through it. The commands
are identical to the `man` program.

The commands `head` and `tail` let you look at
the beginning and end of a file respectively.

    head F3D0_S188_L001_R1_001.fastq
    tail F3D0_S188_L001_R1_001.fastq

The `-n` option to either of these commands can be used to print the
first or last `n` lines of a file. To print the first/last line of the
file use:

    head -n 1 F3D0_S188_L001_R1_001.fastq
    tail -n 1 F3D0_S188_L001_R1_001.fastq

We can search within files without even opening them,
using `grep`. Grep is a command-line utility for searching
plain-text data sets for lines matching a string or
regular expression.

Search for that sequence 1101:14341 in the F3D0_S188_L001_R1_001.fastq file.

    grep 1101:14341 F3D0_S188_L001_R1_001.fastq

We get back the whole line that had '1101:14341' in it. What if we wanted all
four lines, the whole part of that FASTQ sequence, back instead.

    grep -A 3 1101:14341 F3D0_S188_L001_R1_001.fastq

The `-A` flag stands for "after match" so it's returning the line that
matches plus the three after it. The `-B` flag returns that number of lines
before the match.

The redirection command for putting something in a file is `>`

Let's try it out and put all the sequences that contain 'TTATCCGGATTTATTGGGTTTAAAGGGT'
from all the files in to another file called 'good-data.txt'

    grep -B 2 TTATCCGGATTTATTGGGTTTAAAGGGT * > good-data.txt

The prompt should sit there a little bit, and then it should look like nothing
happened. But type `ls`. You should have a new file called good-data.txt. Take
a look at it and see if it has what you think it should.

The pipe command '|' takes the output of the first
thing and then puts it in to the second part

    grep TTATCCGGATTTATTGGGTTTAAAGGGT * | less

The copy command 'cp' let's you copy files

    cp stability.files stability.files_backup

The `mkdir` command is used to make a directory. Just enter `mkdir`
followed by a space, then the directory name.

    mkdir backup

We can move files around using the command `mv`. Enter this command:

    mv stability.files_backup backup/

    rm backup/stability.files_backup

The `rm` file removes the file. Be careful with this command. It doesn't
just nicely put the files in the Trash. They're really gone.

The program 'nano' can be used to write files

    nano awesome.sh

To save the file and exit. At the bottom of nano, you see the "^X Exit". That
means that we use Ctrl-X to exit. Type `Ctrl-X`. It will ask if you want to save it. Type `y` for yes.
Then it asks if you want that file name. Hit 'Enter'.

Running programs

    cd shell-genomics/data
    hello.sh

This won't work because the shell isn't looking
in the right place for it.

    ./hello.sh

This will work, becuase we told it to look in this
directory '.' for the program.

The program can also be run by using the full path

    /home/username/shell-genomics/data/hello.sh

Or by entering:

    ~/shell-genomics/data/hello.sh

To run a program, you have to set the right permissions, make it
executable rather than just a text file.

    chmod +x awesome.sh

Now we can run the program

    ./awesome.sh

Congratulations, you just created your first shell script! You're set to rule the world.
