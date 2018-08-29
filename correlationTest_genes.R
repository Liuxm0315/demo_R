rm(list=ls())

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
input1 <- read.table(file=inputfile1, sep="\t", header=T)
#input2 <- read.table(file=inputfile2, skip=1,fill=T)
input2 <- read.table(file=inputfile2, sep="\t", header=T)
outfile <- file(outputfile, "w")

for (i in 1:length(input1[,1]))
{
	x <- c()
	y <- c()
	for (k in 6:length(input1[1,]))
	{
		x <- c(x, input1[i,k])
		y <- c(y, input2[i,k])
                # print(length(x))
                #print(length(y))
	}
		cor <- cor(as.matrix(x),as.matrix(y), method="pearson")
		#print(cor)
		cor_test <- cor.test(x, y, method="pearson")
		t_test <- t.test(x, y)
		pdf(file=paste(as.character(input1[i,5]),"pdf", sep="."))
		plot(x,y, xlim=c(min(min(x), min(y)), max(max(x), max(y))), ylab="Exon", xlab="Chip", main= paste(as.character(input1[i,5]),"LogR", sep=" "))
		abline(lm(y~x));
		cor_test$estimate=round(cor_test$estimate,3)
		cor_test$p.value=round(cor_test$p.value,3)
		mtext(text=paste("cor=",cor_test$estimate,"pvalue=",cor_test$p.value))
		dev.off()
		#cat(input1[i,1], "\t" input2[j,1], "\t", cor$statistic, "\t", cor$p.value, "\n", file=outfile, append=TRUE)
		cat(as.character(input1[i,5]), "\t", as.character(input2[i,5]), "\t", cor, "\t", cor_test$p.value, "\n", file=outfile, append=TRUE)
}
close(outfile)
