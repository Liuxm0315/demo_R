library("gplots")

#MAT<-read.table("pathway_DNA-replication.diff-exp_forplot.txt", header=TRUE)
MAT<-read.table("/ifs4/BC_COM_P4/F13HTSSCKF2679/HUMwyyR/Analysis/9pair_Transcriptome/Analysis/Data_process/bam-0615-9pairs/diff-exp/raw_rpkm_anno_all-samples_expressed.txt", header=TRUE)
rownames(MAT) <- MAT$Gene_symbol
MAT <- MAT[,-1]
MAT <- MAT[,-1]

colbar <- rep(c("wheat","gray39"), each=1, len=18)
colors = c(seq(0,35,length=100),seq(36,150,length=100))

pdf("exp_clu_all.pdf")
heatmap.2(as.matrix(MAT), col=colorRampPalette(c("navy" ,"white" , "firebrick3"))(199),revC=FALSE,Colv=T,key=TRUE,symkey=FALSE,trace="none",dendrogram="col",ColSideColors=colbar,Rowv=T, breaks=colors)
legend("left", c("Normal", "Tumor"),  bty="n",pch=15, cex=1.2, col=c("wheat","gray39"))
dev.off()

DAT <- log(MAT+1)/log(2)
colors = c(seq(0,4,length=100),seq(4.001,18,length=100))
pdf("exp_normalized_clu_all.pdf")
heatmap.2(as.matrix(DAT), col=colorRampPalette(c("navy" ,"white" , "firebrick3"))(30),revC=FALSE,Colv=T,key=TRUE,symkey=FALSE,trace="none",dendrogram="col",ColSideColors=colbar,Rowv=T)
legend("left", c("Normal", "Tumor"),  bty="n",pch=15, cex=1.2, col=c("wheat","gray39"))
dev.off()

