rm(list=ls())
library("gplots")

args <- commandArgs(trailingOnly = TRUE)
if (! is.vector(args))
{
        stop("Please input the information of arguments:
                args[1]          inputfile for driver gene expression file
                args[2]          inputfile for mRNA expression file
		args[3]		 outputfile
                Example:
                cat correlationTest.R | R --slave --args input1 input2 outfile")
}

inputfile1 <- args[1]
inputfile2 <- args[2]
outputfile <- args[3]

#input1 <- read.table(file=inputfile1, sep="\t", skip=1)
input1 <- read.table(file=inputfile1, sep="\t", header=T, row.names=1)
#input2 <- read.table(file=inputfile2, skip=1,fill=T)
input2 <- read.table(file=inputfile2, sep="\t", header=T, row.names=1)
outfile <- file(paste(outputfile,".cor",sep=""), "w")
res <- matrix(0, nrow=length(input1[1,]), ncol=3) 
#rownames(res) <- colnames(input1)[c(1:length(input1[1,]))]
#colnames(res) <- colnames(input2)[c(1:length(input2[1,]))]
for (i in 1:length(input1[1,]))
{
	x=input1[,i]
	for (j in 1:length(input2[1,]))
	{
	   	if(i == j){
			y=input2[,j]
			cor_test <- cor.test(x, y, method="pearson")
			cor <- cor(x, y, method="pearson")
			res[i,1] <- colnames(input1)[i]
			res[i,2] <- colnames(input2)[i]
	        	res[i,3] <- cor
	 	}
	}
}
write.table(res, file=outfile, sep="\t", quote=F)
close(outfile)

colors = c(seq(0,0.40,length=50),seq(0.41,1,length=50))
#pdf(file=paste(outputfile,"pdf", sep="."),height=10,width=10)
#heatmap.2(as.matrix(res), breaks=colors, col=colorpanel(99,"navy", "mistyrose", "firebrick3"),revC=FALSE,key=TRUE,symkey=FALSE,trace="none",dendrogram="none")
#dev.off()

