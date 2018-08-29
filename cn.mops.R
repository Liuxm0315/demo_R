rm(list=ls())
args <- commandArgs(trailingOnly = TRUE)

Tumorbam<-args[1]
Normalbam<-args[2]
tumorname<-args[3]
normalname<-args[4]
output<-args[5]

library('cn.mops')

BAMFiles <- c(Tumorbam, Normalbam)
bamDataRanges <- getReadCountsFromBAM(BAMFiles,sampleNames=c(tumorname,normalname),mode='paired',WL=50000,refSeqName=paste("chr",1:22,sep=""))
#resCNMOPS <- cn.mops(XRanges)
#resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)
resRef <- referencecn.mops(bamDataRanges[,1], bamDataRanges[,2], I = c(0.025, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4,
        8, 16, 32, 64), classes = paste("CN", c(0:8, 16, 32, 64, 128), sep = ""),
        priorImpact = 1, cyc = 20, parallel = 0, normType = "mean",
        normQu = 0.25, norm = 1, upperThreshold = 0.5, lowerThreshold = -0.9,
        minWidth = 4, segAlgorithm = "DNAcopy", minReadCount = 1, verbose = 1,
        returnPosterior = FALSE)
pdf(paste(output,"/",tumorname,".pdf",sep=""))
segplot(resRef,sampleIdx=1)
dev.off()
segm <- as.data.frame(segmentation(resRef))
CNVs <- as.data.frame(cnvs(resRef))
write.table(segm, file = paste(output,"/",tumorname,".segments.txt",sep=""), quote = FALSE, sep = '\t', row.names = FALSE, col.names = TRUE)
write.table(CNVs, file = paste(output,"/",tumorname,".cnv.txt",sep=""), quote = FALSE, sep = '\t', row.names = FALSE, col.names = TRUE)


