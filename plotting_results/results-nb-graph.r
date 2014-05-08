# Naive Bayes results graph RMSE by threshold

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
results <- fread("results/server/2014-05-05-160424-naivebayes.tsv", header=TRUE, sep="\t")

graph <- qplot(x=threshold, y=RMSE, data=results, geom="line", xlab="Threshold") +
  theme(axis.title.x=element_text(size=30), axis.title.y=element_text(size=30),
        axis.text.x=element_text(size=25), axis.text.y=element_text(size=25))
graph <- graph + scale_y_continuous(breaks=seq(1.02,1.045, 0.005)) + coord_cartesian(ylim=c(1.02,1.045), xlim=c(0,0.82)) +
  scale_x_continuous(breaks=seq(0,0.8, 0.1)) 
graph <- graph + geom_hline(yintercept=1.031)
plot(graph)

ggsave(graph, file="graphs/yow-userstudy/yowNaiveBayesVsBaseline.pdf", width=10, height=8)



