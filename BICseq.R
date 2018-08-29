### cat BICseq.R | R --slave --args <tumor> <normal> <wdr>
rm(list=ls())
args <- commandArgs(trailingOnly = TRUE)
library(BICseq)

tumor <- args[1]
normal <- args[2]
wdr <- args[3]
setwd(wdr)
bicseq <- BICseq(sample = tumor, reference = normal)
segs <- getBICseg(object = bicseq, bin = 100, lambda = 2, winSize = 200, quant = 0.95, mult = 1)
seg.summary <- BICseq:::getSummary(segs, correction=TRUE)
write.table(seg.summary, file = paste(wdr,'/segments.BICseq',sep=""), quote = FALSE, sep = '\t', row.names = FALSE, col.names = TRUE)

