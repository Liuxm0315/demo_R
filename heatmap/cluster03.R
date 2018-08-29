#Usage: cat cluster02.R | R --slave --args <output prefix> < file.lst >

library("gplots")

args <- commandArgs(T)
a<-read.table(args[1],header=T, row.names=1, sep="\t")
#a<-read.table(args[5],header=T, sep="\t")
#a<-a[,-1]
#a<-a[,-1]
b<-t(a)
data<-as.matrix(b)
colbar<-c(rep("green",50),rep("yellow",50))
pdf(paste(args[2],".pdf",sep = ""))
heatmap.2(data,
#col= colorRampPalette(c("navy" ,"white" , "firebrick3"))(100),revC=FALSE,
col= colorRampPalette(c("seashell", "navy", "firebrick3"))(100),revC=FALSE,
     Rowv=T, Colv=T,
     scale="none",key=TRUE,symkey=FALSE,trace="none", labRow=NULL,  labCol = NULL,
     density.info="none",cexRow=0.5,cexCol=0.7,keysize=1.2)
 dev.off()

