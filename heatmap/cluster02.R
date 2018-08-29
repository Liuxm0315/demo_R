#Usage: cat cluster02.R | R --slave --args <output prefix> < file.lst >

library("gplots")

args <- commandArgs(T)
a<-read.table(args[1],header=T, row.names=1, sep="\t")
#a<-read.table(args[5],header=T, sep="\t")
#a<-a[,-1]
data<-as.matrix(a)
colbar<-c(rep("green",50),rep("yellow",50))
pdf(paste(args[2],".pdf",sep = ""))

heatmap.2(data,
#col= colorRampPalette(c("navy" ,"white" , "firebrick3"))(100),revC=FALSE,
col= colorRampPalette(c("blue", "white","red"))(100),revC=FALSE,
    breaks = seq(0.5, 1, length.out = 101),
     #Rowv=F,Colv=F,
     scale="none",key=TRUE,symkey=FALSE,trace="none", labRow=NULL,  labCol = NULL,
     density.info="none",cexRow=0.5,cexCol=0.7,keysize=1.2)
 dev.off()
