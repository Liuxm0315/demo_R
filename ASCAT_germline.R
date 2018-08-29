rm(list=ls())
args <- commandArgs(trailingOnly = TRUE)

library(ASCAT)

TumorlogR<-args[1]
Tumorbaf<-args[2]
#NormallogR<-args[3]
#Normalbaf<-args[4]
output<-args[3]
samplename<-args[4]

setwd(output)

ascat.bc = ascat.loadData(TumorlogR,Tumorbaf,chrs = c(1:22))
ascat.plotRawData(ascat.bc)
ascat.gg = ascat.predictGermlineGenotypes(ascat.bc, 'Affy250k_nsp') 
ascat.bc = ascat.aspcf(ascat.bc,ascat.gg=ascat.gg) 
ascat.plotSegmentedData(ascat.bc)
ascat.output = ascat.runAscat(ascat.bc)
write.table(ascat.output$segments, file = paste(output,"/",samplename,".segments.txt",sep=""), quote = FALSE, sep = '\t', row.names = FALSE, col.names = TRUE)
write.table(ascat.output$segments_raw, file = paste(output,"/",samplename,".segments_raw.txt",sep=""), quote = FALSE, sep = '\t', row.names = FALSE, col.names = TRUE)


