#Usage: cat heatmap_purity.R | R --slave --args <output prefix> <mut.matrix> 

args <- commandArgs(T)
library("NMF")
library("RColorBrewer")

#F <- read.table(args[5], header=FALSE, check.names=FALSE)
MAT <- read.table(args[2], header=TRUE, check.names=FALSE)

#Ss <- read.table("clinical_chip.txt", header=TRUE, sep="\t")
Ss <- read.table(args[3], header=TRUE, sep="\t")
#row.names(S) <- S$Sample
#Ss <- S[rownames(S) %in% F$V1, ]

MATs <- MAT[,as.character(Ss$Sample)]

#annC <- data.frame(MUT=Ss$TP53_Somatic,Plat=Ss$Platform, Stage=Ss$Stage, Purity=Ss$Tumor_cellary)
annC <- data.frame(MUT=Ss$TP53_Somatic,Age=Ss$Age, Stage=Ss$Stage, Purity=Ss$Tumor_cellary,Plat=Ss$Platform)
annC <- droplevels(annC)
cm <- "ward"
dm <- "euclidean"

res <- aheatmap(MATs, color=colorRampPalette(c("navy", "white", "firebrick3"))(50),
	annCol=annC, breaks=0,
	distfun=dm, hclustfun=cm, Rowv=TRUE, Colv=TRUE,
	width=8,height=6,
	filename=paste(args[1], ".", cm, "_", dm ,".pdf", sep=""))

