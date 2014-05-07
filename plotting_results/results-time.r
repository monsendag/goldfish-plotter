# Results from time spent reading mapping techniqe

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
stat <- fread("results/server/2014-04-28-162523-time.tsv", header=TRUE, sep="\t")

# remove average and total scores
stat <- stat[3:10, ]

ordered <- stat[order(stat$RMSE, stat$evalTime),]