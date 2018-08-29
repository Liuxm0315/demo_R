library("NMF")
library("RColorBrewer")


MAT <- read.table("mutCount/all.cancer.matrix", header=TRUE, check.names=FALSE)
rownames(MAT) <- MAT$Type
MAT <- MAT[,-1]

annC <- data.frame(CancerType=colnames(MAT))
annC <- droplevels(annC)
ann_colors <- list(CancerType=c("forestgreen","violetred","orange","black","grey","cyan3","brown1","darkorchid1","darkgoldenrod2","lightgreen","plum","powderblue"))

cm <- "ward"
dm <- "euclidean"

res <- aheatmap(MAT, color=colorRampPalette(c("navy" ,"white" , "firebrick3"))(50),
	        annCol=annC, annColors=ann_colors, breaks=0,
	        distfun=dm, hclustfun=cm, Rowv=TRUE, Colv=TRUE, labCol=NA,
	        filename=paste("lELC.", cm, "_", dm ,".png", sep=""))
