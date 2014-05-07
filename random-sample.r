# selects a random subset of the datasets

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv file
yow <- fread("datasets/yow-userstudy/exdupes-like-timeonpage-timeonmouse.csv", header=TRUE, sep=",")
claypool <- fread("datasets/claypool/claypool-exdupes.csv", header=TRUE, sep=",")

# create TimeOnPage * TimeOnMouse
yow$PageTimesMouse <- yow$TimeOnPage * yow$TimeOnMouse
claypool <- claypool[, 1:5, with=FALSE]
claypool$PageTimesMouse <- claypool$TimeOnPage * claypool$TimeMovingMouse

# TimeOnPage boxplot yow
boxplotTimeOnPageYow <- qplot(factor(user_like), TimeOnPage, data=yow, geom="boxplot", xlab="Rating",
                           ylab="Time spent on a page", outlier.shape=NA, main="Yow")
boxplotTimeOnPageYow <- boxplotTimeOnPageYow + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))

# TimeOnPage boxplot claypool
boxplotTimeOnPageClaypool <- qplot(factor(rating), TimeOnPage, data=claypool, geom="boxplot", xlab="Rating",
                           ylab="Time spent on a page", outlier.shape=NA, main="Claypool")
boxplotTimeOnPageClaypool <- boxplotTimeOnPageClaypool + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,60000))

print(boxplotTimeOnPageYow)
#print(boxplotTimeOnPageClaypool)

# create a sample of yow dataset with more unkown ratings

# pick random rows in dataset and change the user_like to -1
v <- sample(1:8430,400, replace=F)
yowSample <- yow
yowSample[v,3] <- -1

c <- sample(1:2207,300, replace=FALSE)
claypoolSample <- claypool
claypoolSample[c,3] <- 0

# TimeOnPage boxplot yowSample
boxplotTimeOnPageYowSample <- qplot(factor(user_like), TimeOnPage, data=yowSample, geom="boxplot", xlab="Rating",
                                    ylab="Time spent on a page", outlier.shape=NA, main="Yow sample")
boxplotTimeOnPageYowSample <- boxplotTimeOnPageYowSample + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,150000))

boxplotTimeOnPageClaypoolSample <- qplot(factor(rating), TimeOnPage, data=claypoolSample, geom="boxplot", xlab="Rating",
                                    ylab="Time spent on a page", outlier.shape=NA, main="Claypool sample")
boxplotTimeOnPageClaypoolSample <- boxplotTimeOnPageClaypoolSample + scale_y_discrete(breaks=seq(0,150000, 10000)) + coord_cartesian(ylim=c(0,60000))

#print(boxplotTimeOnPageClaypoolSample)
print(boxplotTimeOnPageYowSample)

# write to file
write.csv(yowSample, file="datasets/yow-userstudy/yow-sample-exdupes-like-timeonpage-timeonmouse-pagetimesmouse.csv", 
          row.names=FALSE, na="0", quote=FALSE)

write.csv(claypoolSample, file="datasets/claypool/claypool-sample-exdupes-rating-timeonpage-timeonmouse-pagetimesmouse.csv", 
          row.names=FALSE, na="0", quote=FALSE)

# remove -1 from user_like/rating
yowExplicit <- yowSample[yowSample$user_like != -1]
yowExplicit <- yowExplicit[, 1:3, with=FALSE]

claypoolExplicit <- claypoolSample[claypoolSample$rating != 0]
claypoolExplicit <- claypoolExplicit[, 1:3, with=FALSE]

# write to file
write.csv(yowExplicit, file="datasets/yow-userstudy/yow-sample-exdupes-exinvalid-like.csv", row.names=FALSE, na="0", quote=FALSE)

write.csv(claypoolExplicit, file="datasets/claypool/claypool-sample-exdupes-exinvalid-rating.csv", row.names=FALSE, na="0", quote=FALSE)



