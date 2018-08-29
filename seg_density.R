### cat seg_density.R| R --slave --args <seg> <out> 
rm(list=ls())
args <- commandArgs(trailingOnly = TRUE)

segments = args[1]
out = args[2]

segs <- read.table(segments, sep="\t", header=T)
pdf(paste(out, "_segs_density.pdf", sep=""), width=16, height=10)
plot(density(segs[,length(segs[1,])]), xlim=c(-1.5,1.5), main="logR density")
qua=quantile(quantile(segs[,length(segs[1,])]))
mtext(text=paste("Quantline:",qua[1],"\t",qua[2],"\t",qua[3],"\t",qua[4],"\t",qua[5]))
dev.off()

