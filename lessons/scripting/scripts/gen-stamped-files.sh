#!/bin/bash

# create directory in which to create the renamed files
mkdir exc1

# for each file on the command line, grab basename up to first dot
for f in `ls $* | cut -d . -f 1` ; do
    # copy to new directory, time-stamping and changing extension to .xls
    cp -p $f.*csv exc1/$f-`date +%Y%m`.xls
done
