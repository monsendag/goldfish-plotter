# Results clustering - multiple linear regression - ibk

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

# load the csv files
stat <- fread("results/server/2014-04-22-035724-clustering-mlr-ibk.tsv", header=TRUE, sep="\t")

clustering <- stat[3:32, ]
clustering[,IVs:=NULL]
clusteringOrdered <- clustering[order(clustering$RMSE, clustering$evalTime),]

mlr <- stat[33:35, ]
mlr[,clusterer:=NULL]
mlr[,clusterDataset:=NULL]
mlrOrdered <- mlr[order(mlr$RMSE, mlr$evalTime),]