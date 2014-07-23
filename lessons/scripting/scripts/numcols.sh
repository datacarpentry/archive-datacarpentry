#!/bin/bash

for csvfile in "$@" ; do
    numcols=$(expr `head -n 1 $csvfile | tr -d -c , | wc -c` + 1)
    echo "$csvfile: $numcols columns"
done
