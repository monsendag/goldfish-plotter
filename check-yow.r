# check boxplot

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
yow <- fread("datasets/yow-userstudy/exdupes-like-timeonpage-timeonmouse.csv", header=TRUE, sep=",")
smart <- fread("datasets/yow-userstudy/python/yow-smart-sample-implicit-2.csv", header=TRUE, sep=",")

# TimeOnPage boxplot yowSample
yowPlot <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
                 ylab="Time spent on a page", outlier.shape=NA, main="Yow")
yowPlot <- yowPlot + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))
print(yowPlot)

# TimeOnPage boxplot yowSample
smartPlot <- qplot(factor(user_like), TimeOnPage, data=smart, geom="boxplot", xlab="Rating",
                 ylab="Time spent on a page", outlier.shape=NA, main="Yow smart")
smartPlot <- smartPlot + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))
print(smartPlot)
