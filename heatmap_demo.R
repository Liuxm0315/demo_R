#Usage: cat heatmap_purity.R | R --slave --args <mut.matrix>  <output prefix> 
args <- commandArgs(T)
library("NMF")
library("RColorBrewer")

#F <- read.table(args[5], header=FALSE, check.names=FALSE)
MAT <- read.table(args[1], header=TRUE, check.names=F, sep="\t")
#MAT<-MAT[,-1]
#Ss <- read.table("clinical_chip.txt", header=TRUE, sep="\t")
#Ss <- read.table(args[3], header=TRUE, sep="\t")
#row.names(S) <- S$Sample
#Ss <- S[rownames(S) %in% F$V1, ]

#MATs <- MAT[,as.character(Ss$Sample)]

#annC <- data.frame(MUT=Ss$TP53_Somatic,Plat=Ss$Platform, Stage=Ss$Stage, Purity=Ss$Tumor_cellary)
#annC <- data.frame(MUT=Ss$TP53_Somatic,Age=Ss$Age, Stage=Ss$Stage, Purity=Ss$Tumor_cellary,Plat=Ss$Platform)
#annC <- droplevels(annC)
#cm <- "ward"
dm <- "euclidean"
dm <- "manhattan"
dm <- "minkowski"
dm <- "chebyshev"
dm <- "mahalanobis"
dm <- "canberra"
cm <- "single"
cm <- "average"
cm <- "mcquitty"
cm <- "centroid"
cm <- "median"

res <- aheatmap(MAT, color=colorRampPalette(c("navy", "white", "firebrick3"))(100),
	breaks=0,
#	distfun=dm, hclustfun=cm, Rowv=NA, Colv=T,
	distfun=dm, hclustfun=cm, Rowv=T, Colv=T,
	width=8,height=6,
	filename=paste(args[2], ".", cm, "_", dm ,".pdf", sep=""))

