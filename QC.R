library("vioplot")
rc <- read.table("/ifs5/ST_ANNO/USER/liuxingmin/projects/ESCC/bam-0615-9pairs/SCEC_9_pairs.readscount", header=T, sep="\t")
vioplot(rc[,1], col="mediumpurple4", horizontal=FALSE, border=F, drawRect=T, rectCol="mediumpurple3", names="Total reads-count")
pdf("total-clean-readscount_vioplot.pdf")
vioplot(rc[,1], col="mediumpurple4", horizontal=FALSE, border=F, drawRect=T, rectCol="mediumpurple3", names="Total reads-count")
dev.off()


map <- read.table("/ifs5/ST_ANNO/USER/liuxingmin/projects/ESCC/bam-0615-9pairs/SCEC_9_pairs.map_stat.txt", header=T, sep="\t")

name_col <- c("map_rate", "pair_map_rate", "unmap.rate","mulmap.rate")
vioplot(map[,2],map[,3],map[,4],map[,5], col="mediumpurple4", horizontal=FALSE, border=F, drawRect=T, rectCol="mediumpurple3",names=name_col)
pdf("mapping_stat_vioplot.pdf")
vioplot(map[,2],map[,3],map[,4],map[,5], col="mediumpurple4", horizontal=FALSE, border=F, drawRect=T, rectCol="mediumpurple3",names=name_col)
dev.off()

pdf("mapping_stat_barplot.pdf",width=16, height=10)
barplot(as.matrix(map_t), beside=T, col=c("orangered", "orange", "yellow", "cyan"))
legend("topright", legend=c("map_rate", "pair_map_rate", "unmap.rate", "mulmap.rate"), col=c("orangered", "orange", "yellow", "cyan"), pch=15,cex=1.2,bty="n")
dev.off()

 pdf("Genome-dist_total.pdf", width=13, height=10 )
 boxplot(DIS, names=names)
 dev.off()

pdf("ADAR-exp.pdf", width=12, height=10)
boxplot(EXP, ylab="RPKM", col=c("royalblue3", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
dev.off()

pdf("Reads_Support.pdf")
boxplot(SUP, ylab="Reads-ratio", col=c("royalblue3", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
dev.off()

pdf(file = "Editing_summary.pdf", width=13, height=13)
par( mfrow=c(2,2))
boxplot(env, ylab="Editing Envents", col=c("royalblue3", "orangered3"))
barplot(as.matrix(ENV), beside=T, ylab="Editing Envents", col=c("royalblue", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
barplot(as.matrix(cre_site), beside=T, ylab="Creditable Sites", col=c("royalblue3", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
dev.off()

###sort
m <- apply(ADAR, MARGIN=2, FUN=median, na.rm=T)
o <-order(m, decreasing=F)
boxplot(ADAR[,o], ylab="ADAR Expression(RPKM)", cex=1.5)


pdf(file = "Editing_level_summary.pdf", width=13, height=13)
par( mfrow=c(2,2))
boxplot(EXP_N, ylab="RPKM", col=c("royalblue3", "orangered3"))
boxplot(sup[,4]/sup[,3], sup[,2]/sup[,1], col=c("royalblue3", "orangered3"), names=c("Normal", "Tumor"), ylab="Editing level")
barplot(as.matrix(TOL), beside=T, ylab="Total Reads NO.", col=c("royalblue", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
barplot(as.matrix(cre_site), beside=T, ylab="Creditable Sites", col=c("royalblue", "orangered3"))
legend("topright", c("Normal", "Tumor"), pch=15,cex=1.2,bty="n",col=c("royalblue3", "orangered3"))
dev.off()

ann_colors <- list(CancerType=c("forestgreen","violetred","orange","black","grey","cyan3","brown1","darkorchid1","darkgoldenrod2","lightgreen","plum","powderblue"))
legend.text = c("A", "B"),
             args.legend = list(x = "topleft"))

nc<-max(count.fields("Pan_GenomeDist.result.txt", sep="\t")
Ge_dis<-read.table("Pan_GenomeDist.result.txt", sep="\t", fill=T, col.names=paste("v",1:nc,sep="."), row.names=1 )

x<-vector(length=28)
for (i in 1:length(tt[1,])) { temp(i)<-median(tt[,i], na.rm=T);  }

library("ggplot2")
qplot(sample.No., Editing.No., data=sam_no, colour=name)

