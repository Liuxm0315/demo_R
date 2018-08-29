#Usage: cat gg_vioplot.R | R --slave --args <**input.txt> <output prefix>

args <- commandArgs(T)
library(ggplot2)

mat <- read.table(args[1],sep="\t", header=TRUE, check.names=FALSE)
pdf(paste(args[2], ".gg.boxplot.pdf", sep=""), width=16, height=10)
#mat$Expression<- log2(mat$Expression)
ggplot(mat, aes(factor(CNV), Expression)) + geom_boxplot(aes(fill=factor(CNV)))# +  scale_y_continuous(limits=c(0,1000))
#te<-t.test(subset(mat, CNV==0)[,4], subset(mat, CNV==-1)[,4], alternative = c("two.sided"), paired = FALSE, var.equal = FALSE)
#text<-te$p.value
#mtext(text=paste("cor=",cor$estimate,"p=",cor$p.value))


#ggplot(mat, aes(factor(Cancer), Num)) + geom_violin(aes(fill = factor(Cancer))) + geom_boxplot(width = 0.2) + scale_y_continuous(trans = "log10")

dev.off()

