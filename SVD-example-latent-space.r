# Plotting SVD points

# Clear all existing variables from memory
rm(list=ls())

# import ggplot2
library(ggplot2)
library('data.table')

# Set working directory for the csv file
setwd("~/Projects/goldfish-plotter/")

d <- data.frame(x = c(-0.4912,-0.5324,-0.5357, -0.4327, -0.3500, -0.5798, -0.5193, -0.5213, -0.500), 
                y = c(0.5042, -0.5123, 0.4641, -0.5177, -0.6063, -0.1741, -0.1593, 0.7594, -0.2500), 
                names = c("The Matrix", "E.T.", "iRobot", "Hercules", "Amy","Bob","Charlie", "Dina", "Mark"),
                type = c( "Movie", "Movie", "Movie", "Movie", "User", "User", "User", "User", "User"))
plot <- ggplot(d, aes(x,y)) + geom_point() + geom_text(aes(label=names), hjust=-0.2, size=7) + theme_bw() + 
  xlim(-0.7,0.1) + ylim(-0.7,0.8) + 
  geom_hline(aes(y = 0)) + geom_vline(aes(x = 0)) + 
  theme(axis.title.x=element_text(size=25, hjust=0.85), axis.title.y=element_text(size=25, hjust=0.47),
        axis.text.x=element_text(size=20), axis.text.y=element_text(size=20), 
        strip.text=element_text(size=20))
# add legend
plot <- plot + geom_point(aes(shape=factor(type)), size = 4) + 
  theme(legend.text=element_text(size=25), legend.title=element_text(size=0))

print(plot)
ggsave(plot, file="graphs/SVD/latentSpaceExample.pdf", width=10, height=8)