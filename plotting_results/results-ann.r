# Results from ann

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
stat <- fread("results/server/2014-04-29-162922-.tsv", header=TRUE, sep="\t")
stat2 <- stat[3:62, ]

ordered <- stat2[order(stat2$RMSE, stat2$evalTime),]


