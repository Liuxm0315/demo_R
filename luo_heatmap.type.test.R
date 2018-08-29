#Usage: cat heatmap.type.test.R | R --slave --args <output prefix> <sample.list> <mut.matrix> 

args <- commandArgs()
library("NMF")
library("RColorBrewer")

F <- read.table(args[5], header=FALSE, check.names=FALSE)
MAT <- read.table(args[6], header=TRUE, check.names=FALSE)
rownames(MAT) <- MAT$Type
MAT <- MAT[,-1]

S <- read.table("/ifs1/ST_SYSBIO/PMO/F13ZOOYJSY1415/LELC/Analysis/CancerCompare/bin/result/01mutation.rate.Mb.xls", header=TRUE, sep="\t")
row.names(S) <- S$Sample
#Ss <- S[!rownames(S) %in% F$V1, ]
Ss <- S[rownames(S) %in% F$V1, ]

MATs <- MAT[,as.character(Ss$Sample)]

#annC <- data.frame(Fragment=Ss$Fragment, SeqType=Ss$SeqType, Cluster=Ss$Cluster)

annC <- data.frame(Cancer=Ss$Cancer, mutRate=Ss$MutFre)
annC <- droplevels(annC)
#ann_colors <- list(Cancer=c("#006699","#CCCCCC","#990033","#006600"))
ann_colors <- list(Cancer=c("#99CC33","#006699","#CC66FF","#990033","#006600","#FF9900","#FFCC00"), mutRate=c("#CCCCCC","#999999","#666666","#333333","#000000"))

# "#FFFFF","#CCCCCC"
# "#999999","#666666","#333333","#000000"
cm <- "ward"
dm <- "euclidean"

#annColors=ann_colors

#res <- aheatmap(MATs, color=colorRampPalette(c("navy", "white", "firebrick3"))(50),
res <- aheatmap(MATs,
annCol=annC, annColors=ann_colors, breaks=0.5,
	distfun=dm, hclustfun=cm, Rowv=TRUE, Colv=TRUE, labCol=NA,
	width=8,height=6,
	filename=paste(args[4], ".Mismut.", cm, "_", dm ,".pdf", sep=""))

#filename=paste(args[4], ".Mismut.", cm, "_", dm ,".png", sep=""))

