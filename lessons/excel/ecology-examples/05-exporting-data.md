# Exporting data from spreadsheets #

Materials by: **Jeffrey Hollister**, **Alexander Duryee**, **Jennifer Bryan**, **Daisie Huang**, **Ben Marwick**, **Christie Bahlai**, **Owen Jones**, **Aleksandra Pawlik**

Storing data in Excel is a bad idea. Why? Because it is a proprietary format, and it is possible that in the future, technology won’t exist (or will become sufficiently rare)  to make it inconvenient, if not impossible, to open the file. 

Think about zipdisks. How many old theses in your lab are “backed up” and stored on zipdisks? Ever wanted to pull out the raw data from one of those?
Exactly.

But more insidious- different versions of Excel may be changed so they handle data differently, leading to inconsistencies.

As an example, do you remember how we talked about how Excel stores dates earlier? Turns out there are multiple defaults for different versions of the software. And you can switch between them all willy-nilly. So… say you’re compiling Excel-stored data from multiple sources. There’s dates in each file- Excel interprets them as their own internally consistent serial numbers. When you combine the data, Excel will take the serial number from the place you’re importing it from, and interpret it using the rule set for the version of Excel you’re using. Essentially, you could be adding a huge error to your data, and it wouldn’t necessarily be flagged by any data cleaning methods if your ranges overlap.

Storing data in a universal, open, static format will help deal with this problem. Try tab-delimited  or csv ( more common). CSV files are plain text files where the columns are separated by commas, hence 'comma separated variables' or csv. The advantage of a csv over an Excel/SPSS/etc. file is that we can open and read a csv file using just about any software, including a simple text editor. Data in a CSV can also be easily imported into other formats and environments, such as SQLite and R. We're not tied to a certain version of a certain expensive program when we work with csv, so it's a good format to work with for maximum portability and endurance. Most spreadsheet programs can save to delimited text formats like csv easily, although they complain and make you feel like you’re doing something wrong along the way.

[Walk through an example of saving an Excel file to CSV]

An important note for backwards compatibility: you can open CSVs in Excel!

## A Note on Cross-platform Operability##
(or, how typewriters are ruining your work)

By default, most coding and statistical environments expect UNIX-style line endings (\n) as representing line breaks.  However, Windows uses an alternate line ending signifier (\r\n) by default for legacy compatibility with Teletype-based systems.  As such, when exporting to CSV using Excel, your data will look like this:

>data1,data2\r\n1,2\r\n4,5\r\n…

which, upon passing into most environments (which split on \n), will parse as:

>data1<br>
>data2\r<br>
>1<br>
>2\r<br>
>...

thus causing terrible things to happen to your data.  For example, “2\r” is not a valid integer, and thus will throw an error (if you’re lucky) when you attempt to operate on it in R or Python.  Note that this happens on Excel for OSX as well as Windows, due to legacy Windows compatibility.

There are a handful of solutions for enforcing uniform UNIX-style line endings on your exported CSVs:

- When exporting from Excel, save as a “Windows comma separated (.csv)” file
- Edit the .git/config file in your repository to automatically translate \r\n line endings into \n, via this process: http://nicercode.github.io/blog/2013-04-30-excel-and-line-endings/
- Use dos2unix (available on OSX, *nix, and Cygwin) on local files to standardize line endings.

Previous: [Basic quality control and data manipulation in spreadsheets.](04-quality-control.md) 
