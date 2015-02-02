OUTS := $(patsubst %.Rmd,%.md,$(wildcard *.Rmd)) # figure/

all: $(OUTS)

clean:
	rm -rf $(OUTS)

%.md: %.Rmd
	## knit the file to create a markdown file
	Rscript -e 'knitr::knit("$*.Rmd")'

	## change the syntax highlighting to coffee instead of r
	# gsed -i 's/```r/```coffee/g' $*.md

	## Uncomment below if your code generates figures
	## Because jekyll creates a new directory with an index.html file,
	## You'll need to reference the parent directory when including figures.
	# gsed -i 's~figure/~../figure/~g' $*.md
