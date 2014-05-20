# Results Stat

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
stat <- fread("results/server/2014-04-28-221554-stat-2.tsv", header=TRUE, sep="\t")
stat2 <- stat[3:62, ]

stattop <- fread("results/server/2014-04-29-161657-stat-1.tsv", header=TRUE, sep="\t")
stattop2 <- stattop[3:50, ]

merged <- rbind(stattop2, stat2)
ordered <- merged[order(merged$RMSE),]


