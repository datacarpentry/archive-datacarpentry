#!/bin/bash

# paths to programs
sqlite=/usr/local/opt/sqlite/bin/sqlite3
R=R

# Load the data into database, combine, filter, export
cat sqlite-import.sql | $sqlite > result.csv

# for old versions of sqlite
# cat sqlite-select-from-db.sql | $sqlite portal_mammals.sqlite > result.csv

# Load into R for analysis and plotting
$R CMD BATCH barplot-figure.R
