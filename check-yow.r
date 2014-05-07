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
smart <- fread("datasets/yow-userstudy/python/yow-smart-sample-implicit-3.csv", header=TRUE, sep=",")

# TimeOnPage boxplot yowSample
yowPlot <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
                 ylab="Time spent on a page", outlier.shape=NA) + 
            theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25),
                  axis.text.x=element_text(size=20), axis.text.y=element_text(size=20))
yowPlot <- yowPlot + scale_y_discrete(breaks=seq(0,150000, 15000)) + coord_cartesian(ylim=c(0,150000))
print(yowPlot)
ggsave(yowPlot, file="graphs/yow-userstudy/yowTimeOnPageBoxplotCompare.pdf", width=10, height=8)

# TimeOnPage boxplot yowSample
smartPlot <- qplot(factor(user_like), TimeOnPage, data=smart, geom="boxplot", xlab="Rating",
                 ylab="Time spent on a page", outlier.shape=NA) + 
            theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25),
                  axis.text.x=element_text(size=20), axis.text.y=element_text(size=20))
smartPlot <- smartPlot + scale_y_discrete(breaks=seq(0,150000, 15000)) + coord_cartesian(ylim=c(0,150000))
print(smartPlot)
ggsave(smartPlot, file="graphs/yow-userstudy/yowSmartTimeOnPageBoxplotCompare.pdf", width=10, height=8)
