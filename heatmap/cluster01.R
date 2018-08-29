#Usage: cat cluster01.R | R --slave --args <output prefix> < file.lst >

library("gplots")

args <- commandArgs()
a<-read.table(args[5],head=T,row.names = 1,sep="\t")

colbar<-c(rep("blue",41),rep("green3",25),rep("darkorange",56),rep("gray18",25))

pdf(paste(args[4],".pdf",sep = ""),width=10,height=7)

colors = c(seq(0,2,length=100),seq(4,10,length=100))
my_palette <- colorRampPalette(c("navy", "mistyrose", "firebrick3"))(199)

heatmap.2(as.matrix(a),
col=my_palette,revC=FALSE,ColSideColors=colbar,breaks=colors,
     scale="none",key=TRUE,symkey=FALSE,symbreaks=TRUE,trace="none",labCol=FALSE,
     density.info="none",cexRow=0.5 , keysize=1)

legend("left",legend=c("LELC","NKT","NPC","STDA_EBV"),pch=15,cex=0.7,bty="n",col=c(rep("blue"),rep("green3"),rep("darkorange"),rep("gray18")))
dev.off()
