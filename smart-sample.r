# randomizes a dataset where we select a few articles of articles with multiple ratings
# this ensure that the total number of articles does not decrease in the explicit dataset

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')
library(plyr)
library(reshape)

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv file
yow <- fread("datasets/yow-userstudy/exdupes-like-timeonpage-timeonmouse.csv", header=TRUE, sep=",")
setnames(yow,"#user_id", "user_id")

# TimeOnPage boxplot yowSample
yowPlot <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
                     ylab="Time spent on a page", outlier.shape=NA, main="Yow")
yowPlot <- yowPlot + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))
print(yowPlot)

# remove -1 ratings that already exists in the dataset
yow <- yow[yow$user_like != -1]

# write occurences to file to be modified in python
write.csv(yow, file="datasets/yow-userstudy/python/yow-data.csv", row.names=FALSE, na="0", quote=FALSE)

# add a new column with combines DOC_ID and user_id to one key
yow$combined <- paste(yow$user_id,paste("_",yow$DOC_ID, sep=""), sep="")

# count how many ratings each articles have and order the list descending
occ <- count(yow, "DOC_ID")
occ <- occ[order(-occ$freq),]

# write occurences to file to be modified in python
write.csv(occ, file="datasets/yow-userstudy/python/yow-docid-occurences.csv", row.names=FALSE, na="0", quote=FALSE)

# select the first # articles with multiple ratings
occ <- occ[1:1000,]

# find all rows in yow with the DOC_IDs in occ
yowOcc <- yow[yow$DOC_ID %in% occ$DOC_ID]
yowOcc <- yowOcc[order(yowOcc$DOC_ID)]

# select only the uniqe rows where uniqe feature is based on DOC_ID
uniq <- subset(yowOcc, !duplicated(yowOcc$DOC_ID))
uniq$combined <- paste(uniq$user_id,paste("_",uniq$DOC_ID, sep=""), sep="")

# make feedback implicit
yow[yow$combined %in% uniq$combined, user_like := -1]
yow <- yow[, 1:5, with=FALSE]

# TimeOnPage boxplot yowSample
smartSample <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
                                    ylab="Time spent on a page", outlier.shape=NA, main="Yow smart sample")
smartSample <- smartSample + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))
print(smartSample)

# add comment char again and write to file
setnames(yow,"user_id", "#user_id")
write.csv(yow, file="datasets/yow-userstudy/yow-smart-sample-implicit.csv", row.names=FALSE, na="0", quote=FALSE)

# remove -1 from user_like/rating
yowExplicit <- yow[yow$user_like != -1]
yowExplicit <- yowExplicit[, 1:3, with=FALSE]

# write to file
write.csv(yowExplicit, file="datasets/yow-userstudy/yow-smart-sample-explicit.csv", row.names=FALSE, na="0", quote=FALSE)



