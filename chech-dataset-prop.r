# check boxplot

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
yow <- fread("datasets/yow-userstudy/python/yow-smart-sample-implicit-3.csv", header=TRUE, sep=",")

yow <- yow[, 1:5, with=FALSE]

yowEx <- yow[yow$user_like != -1]
yowImpl <- yow[yow$TimeOnPage > 0 | yow$TimeOnMouse > 0]

# plot rating frequencies
ratings <- yowEx[, 3, with=FALSE]
ratings_freq <- qplot(factor(user_like), data=ratings, geom="bar", xlab="Rating", ylab="Frequency") +
                        theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25),
                              axis.text.x=element_text(size=20), axis.text.y=element_text(size=20))
ratings_freq <- ratings_freq + scale_y_continuous(breaks=seq(0,3000, 500)) + coord_cartesian(ylim=c(0,3000))
plot(ratings_freq)

ggsave(ratings_freq, file="graphs/yow-userstudy/yowRatingsFrequency.pdf", width=10, height=8)

# TimeOnPage boxplot yowSample
smartPlot <- qplot(factor(user_like), TimeOnPage, data=yowEx, geom="boxplot", xlab="Rating",
                   ylab="Time spent on a page", outlier.shape=NA) + 
  theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25),
        axis.text.x=element_text(size=20), axis.text.y=element_text(size=20))
smartPlot <- smartPlot + scale_y_discrete(breaks=seq(0,150000, 15000)) + coord_cartesian(ylim=c(0,150000))
print(smartPlot)
ggsave(smartPlot, file="graphs/yow-userstudy/yowSmartTimeOnPageBoxplotExplicit.pdf", width=10, height=8)
