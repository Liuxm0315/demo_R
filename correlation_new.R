rm(list=ls())
library('pheatmap')

args <- commandArgs(trailingOnly = TRUE)

if (! is.vector(args))
{
        stop("Please input the information of arguments:
                args[1]          inputfile for cor test
                Example:
                cat correlationTest.R | R --slave --args input1 ")
}
inputfile1 <- args[1]

#input1 <- read.table(file=inputfile1, sep="\t", skip=1)
segs <- read.table(file=inputfile1, sep="\t", header=T)

for (i in 1:length(levels(segs$Sample)))
{
	tt<-subset(segs, segs$Sample==levels(segs$Sample)[i])
	tt<-droplevels(tt)
	tt<-tt[,-1]
	COV=cor(tt,use="pairwise.complete.obs", method="spearman")
	COV[is.na(COV)]<-0
	pheatmap(COV,border_color=NA, breaks=c(seq(0,0.5,0.01),seq(0.51,1,0.01)), filename=paste(levels(segs$Sample)[i],".pdf", sep=""))
	write.table(COV[,1], paste(levels(segs$Sample)[i],".cor.txt",sep=""), quote=F, sep="\t", col.names=levels(segs$Sample)[i])
}

