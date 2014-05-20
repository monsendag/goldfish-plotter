# Histogram of results

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

DT = data.table(Technique=c("Corr. and time thr.", "Time Threshold", "Correlation", "Baseline", "MLR", "Naive Bayes", "ANN", "KNN", "Clustering", "SVM"),
                RMSE=c(0.978, 1.008, 0.993, 1.031, 1.046, 1.023, 1.031, 1.029, 1.034, 1.029))

plot <- qplot(reorder(Technique, RMSE), RMSE, data=DT, geom="histogram", xlab="", 
              ylab="RMSE", stat="identity") +
              theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25, vjust=0.4),
                    axis.text.x=element_text(size=20, angle=270, hjust=0, vjust=0.5), axis.text.y=element_text(size=20))
plot <- plot + scale_y_continuous(breaks=seq(0.97,1.06, 0.01)) + coord_cartesian(ylim=c(0.97,1.06))
print(plot)

ggsave(plot, file="graphs/yow-userstudy/yowResultsBestHistogram.pdf", width=10, height=8)


