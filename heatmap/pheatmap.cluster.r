args <- commandArgs(T)
library(pheatmap)
data<-read.table(args[1], head=T, sep="\t")
data<- data[,-1]
data.mat<-data.matrix(data)
pdf(paste(args[2],".pdf",sep = ""))
#pheatmap(data,border_color=NA)
pheatmap(data.mat,color=colorRampPalette(c("navy", "white", "firebrick3"))(100), border_color=NA, cluster_rows = T)
dev.off()
