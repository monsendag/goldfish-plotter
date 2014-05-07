# Clustering results

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
stat <- fread("results/server/2014-04-30-113933-clustering.tsv", header=TRUE, sep="\t")
stat2 <- stat[3:32, ]

ordered <- stat2[order(stat2$RMSE),]



