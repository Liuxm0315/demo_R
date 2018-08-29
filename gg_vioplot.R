#Usage: cat gg_vioplot.R | R --slave --args <**input.txt> <output prefix>

args <- commandArgs()
library(ggplot2)

mat <- read.table(args[4], header=TRUE, check.names=FALSE)

pdf(paste(args[5], ".gg.vioplot.pdf", sep=""), width=16, height=10)

ggplot(mat, aes(factor(Cancer), Num)) + geom_violin(aes(fill = factor(Cancer))) + geom_boxplot(width = 0.2) + scale_y_continuous(trans = "log10")

dev.off()

