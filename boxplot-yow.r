# boxplot for yow-userstudy

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv file
yow <- fread("datasets/yow-userstudy/exdupes-like-timeonpage-timeonmouse.csv", header=TRUE, sep=",")

# remove -1 from user_like
yow <- yow[yow$user_like != -1]

# create TimeOnPage * TimeOnMouse
yow$PageTimesMouse <- yow$TimeOnPage * yow$TimeOnMouse

# write the new table to csv file <----- REMEMBER TO NOT REMOVE -1 WHEN WRITING TO FILE ----->
#write.csv(yow, file="datasets/yow-userstudy/exdupes-like-timeonpage-timeonmouse-pagetimesmouse.csv", row.names=FALSE, na="0")

# TimeOnPage boxplot
boxplotTimeOnPage <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
           ylab="Time spent on a page", outlier.shape=NA)
boxplotTimeOnPage <- boxplotTimeOnPage + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))
ggsave(boxplotTimeOnPage, file="graphs/yow-userstudy/yow-TimeOnPageBoxplot.pdf", width=10, height=8)

# TimeOnMouse boxplot
boxplotTimeOnMouse <- qplot(factor(user_like), TimeOnMouse, data=yow, geom="boxplot", xlab="Rating",
                            ylab="Time spent moving the mouse", outlier.shape=NA)
boxplotTimeOnMouse <- boxplotTimeOnMouse + scale_y_discrete(breaks=seq(0,3000, 200)) + coord_cartesian(ylim=c(0,3000))
ggsave(file="graphs/yow-userstudy/yow-TimeOnMouseBoxplot.pdf", plot=boxplotTimeOnMouse, width=10, height=8)

# TimeOnMouse boxplot
boxplotPageTimesMouse <- qplot(factor(user_like), PageTimesMouse, data=yow, geom="boxplot", xlab="Rating",
                            ylab="Time spent on a page times time spent moving the mouse", outlier.shape=NA)
boxplotPageTimesMouse <- boxplotPageTimesMouse + scale_y_continuous(breaks=seq(0,2.0e8,1.0e7)) + coord_cartesian(ylim=c(0,2.0e8))
ggsave(file="graphs/yow-userstudy/yow-PageTimesMouseBoxplot.pdf", plot=boxplotPageTimesMouse, width=10, height=8)

#print(boxplotPageTimesMouse)
print(boxplotTimeOnPage)
#print(boxplotTimeOnMouse)

# Boxplot presents a "five-number summary", which consists of these sample percentiles
#         1. the sample minimum
#         2. the lower quartile (25th percentile - splits off the lowest 25% of data from the highest 75%)
#         3. the median (middle value)
#         4. the upper quartile (75th percentile - splits off the highest 25% of data from the lowest 75%)
#         5. the sample maximum