library("gplots")

MAT<-read.table("/ifs4/BC_COM_P4/F13HTSSCKF2679/HUMwyyR/Analysis/9pair_Transcriptome/Analysis/Data_process/bam-0615-9pairs/diff-exp/raw_rpkm_anno_all-samples_expressed.cor", header=TRUE)

colbar <- rep(c("wheat","gray39"), each=1, len=18)
#colbar <- rep(c("wheat","gray39"), each=9, len=18)
#colors = c(seq(0,50,length=100),seq(51,150,length=100))

pdf("exp_clu_cor_sort.pdf")
heatmap.2(as.matrix(MAT), col=colorRampPalette(c("navy" ,"white" , "firebrick3"))(199),revC=FALSE,Colv=F,key=TRUE,symkey=FALSE,trace="none",dendrogram="col",ColSideColors=colbar,Rowv=F)
legend("left", c("Tumor", "Normal"),  bty="n",pch=15, cex=1.2, col=c("gray39", "wheat"))
dev.off()

pdf("exp_clu_cor_sort_clu.pdf")
heatmap.2(as.matrix(MAT), col=colorRampPalette(c("navy" ,"white" , "firebrick3"))(199),revC=FALSE,Colv=T,key=TRUE,symkey=FALSE,trace="none",dendrogram="col",ColSideColors=colbar,Rowv=T)
legend("left", c("Tumor", "Normal"),  bty="n",pch=15, cex=1.2, col=c("gray39", "wheat"))
dev.off()

