rm(list=ls())
args <- commandArgs(trailingOnly = TRUE)
library('DESeq2')
library('tximport')
library("RColorBrewer") # Load a package giving more colors
library("gplots")
library("pheatmap") # load a package for making heatmaps

rsemdir <- args[1]
sample  <- args[2]
outdir  <- args[3]
dir.create(outdir)
#dir<-"/hwfssz1/ST_OCEAN/USER/liuxingmin/projects/Astronauts/Analysis/lymph_monkey/process/GeneExp_RSEM"
samples <- read.table(file.path(rsemdir, sample), header = TRUE)
files <- file.path(rsemdir, samples$sample, paste0(samples$sample, ".genes.results"))
names(files) <- samples$sample
txi.rsem <- tximport(files, type = "rsem", txIn = FALSE, txOut = FALSE)

sampleTable <- data.frame(condition =samples$Time)
rownames(sampleTable) <- colnames(txi.rsem$counts)
ddsTC <- DESeqDataSetFromTximport(txi.rsem, sampleTable, ~condition)

rld = rlogTransformation(ddsTC)
distsRL <- dist(t(assay(rld))) # Calculate distances using transformed (and normalized) counts
mat <- as.matrix(distsRL) # convert to matrix
#rownames(mat) <- colnames(mat) <- with(colData(ddsTC), paste(condition)) # set rownames in the matrix
#colnames(mat) = NULL # remove column names
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255) # set colors
pdf(file=paste(outdir,"/cor.pdf", sep=""))
pheatmap(mat, clustering_distance_rows=distsRL, clustering_distance_cols=distsRL, col=colors)
dev.off()
#dds_diif<-DESeq(dds)
ddsTC <- DESeq(ddsTC, test="LRT", reduced= ~ 1)

#vsd <- vst(ddsTC, blind=FALSE)
#rld <- rlog(ddsTC, blind=FALSE)

#res <- results(ddsTC, contrast=c("condition","B","A"))
#res<-results(ddsTC)
#res<-res[order(res$padj),]
#resultsNames(ddsTC)

a<-c('A', 'C', 'D', 'E', 'F', 'G')
for (i in a){ 
    for (j in a){
	if(j>i){
	    res <- results(ddsTC, contrast=c("condition", j, i))
	    res<-res[order(res$padj),]
	    write.table(as.data.frame(res),file=paste(outdir,"/lymph_monkey_DESeq2_",j,'_',i,'.deseq2.txt',sep=''), sep="\t", quote=F)
	}
    }
}

#res0.05 <- subset(res, res$padj < 0.05)
#sigGenes <- rownames(res0.05)
#sigGenes <- read.table("/hwfssz1/ST_OCEAN/USER/liuxingmin/projects/Astronauts/Analysis/lymph_monkey/process/GeneExp_RSEM/DESeq2/diff_fc1_p0.05.all.gene", sep="\t", header=F)
#rows <- match(sigGenes$V1, row.names(vsd))
#mat <- assay(vsd)[rows,]
#pdf("plot_all_diff.pdf")
#heatmap.2(mat, col= colorRampPalette(c("blue", "white","red"))(100),revC=FALSE, Colv=F,  scale="row", key=TRUE, symkey=FALSE, trace="none", labRow=NULL,  labCol = NULLWarning message:"none",cexRow=0.5,cexCol=0.7,keysize=1.2)
#dev.off()

#write.table(as.data.frame(res),file=paste("lymph_human_DESeq2",'sim_condition_treated_results_deseq2.txt',sep='.'), sep="\t", quote=F)
#write.table(assay(vsd), "/hwfssz1/ST_OCEAN/USER/liuxingmin/projects/Astronauts/Analysis/lymph_monkey/process/GeneExp_RSEM/D")
#plotMA(res, ylim=c(-7,7))

