# Histogram of results

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

DT = data.table(Technique=c("Stat", "Time", "Corr", "Baseline", "MLR", "NB", "ANN", "IBK", "Clustering"),
                RMSE=c(0.983, 1.008, 0.993, 1.031, 1.046, 1.023, 1.033, 1.043, 1.034))

plot <- qplot(reorder(Technique, RMSE), RMSE, data=DT, geom="histogram", xlab="Technique", 
              ylab="RMSE", stat="identity") +
              theme(axis.title.x=element_text(size=25), axis.title.y=element_text(size=25),
                    axis.text.x=element_text(size=20), axis.text.y=element_text(size=20))
plot <- plot + scale_y_continuous(breaks=seq(0.97,1.06, 0.01)) + coord_cartesian(ylim=c(0.97,1.06))
print(plot)

ggsave(plot, file="graphs/yow-userstudy/yowResultsBestHistogram.pdf", width=10, height=8)


