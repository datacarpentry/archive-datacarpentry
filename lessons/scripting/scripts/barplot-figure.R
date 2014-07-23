################################
# Prefix part: setting variables
################################
# working directory if needed, e.g.:
#setwd("~/Documents/git/new/2014-05-08-datacarpentry/lessons/R")

# data input
#   - original csv file:
#data.in <- "surveys.csv"
#   - csv file dumped from sqlite:
data.in <- "result.csv"

# plot output
plot.out <- "R_plot.pdf"

##########################################################
# Main part: execution of data loading, analysis, plotting 
##########################################################
dat  <- read.csv(data.in, header=TRUE, na.strings="")
dat2 <- dat[complete.cases(dat$wgt),]

# aggregate by species, or change to genus for joined dataset
meanvals <- aggregate(wgt~species, data=dat2, mean)

pdf(plot.out)
# change to species to genus for joined dataset
barplot(meanvals$wgt, names.arg=meanvals$species, cex.names=0.4, col=c("blue"))
dev.off()
