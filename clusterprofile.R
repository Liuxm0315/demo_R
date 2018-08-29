#Usage: cat gg_vioplot.R | R --slave --args <**input.txt> <output prefix>
args <- commandArgs(T)
input  <- args[1]
output <- args[2]
library(org.Mmu.eg.db)
library(clusterProfiler)
library(ggplot2)        
library(Cairo)

keytypes(org.Mmu.eg.db) #查看基因编号系统名称
EG2Ensembl=toTable(org.Mmu.egENSEMBL) #将ENTREZID和ENSEMBL对应的数据存入该变量 #gene_id      ensembl_id  #1            ENSG00000121410
diff_m<-read.table(input, sep="\t", header=F, row.names=1)
#diff_m<-diff_m$GeneID
geneLists=data.frame(ensembl_id=row.names(diff_m))
results=merge(geneLists,EG2Ensembl,by='ensembl_id',all.x=T)
id=na.omit(results$gene_id)  
gene=id

ALL <- enrichGO(gene, "org.Mmu.eg.db", keyType = "ENTREZID",ont = 'ALL',pvalueCutoff  = 0.05, pAdjustMethod = "BH",  qvalueCutoff  = 0.1, readable=T)  #一步到位
#BP<-enrichGO(gene, "org.Mmu.eg.db", keyType = "ENTREZID",ont = "BP",pvalueCutoff  = 0.05,pAdjustMethod = "BH",qvalueCutoff  = 0.1, readable=T) #3种分开进行富集
#MF <- enrichGO(gene, "org.Mmu.eg.db", keyType = "ENTREZID",ont = "MF",pvalueCutoff  = 0.05,pAdjustMethod = "BH",qvalueCutoff  = 0.1, readable=T)
#CC <- enrichGO(gene, "org.Mmu.eg.db", keyType = "ENTREZID",ont = "CC",pvalueCutoff  = 0.05,pAdjustMethod = "BH",qvalueCutoff  = 0.1, readable=T)

write.table(as.data.frame(ALL@result), file=paste(output, "_GOALL.txt", sep=""), sep="\t", quote=FALSE)
#CC_simp <- simplify(CC, cutoff=0.7,by="p.adjust",select_fun=min) 
#BP_simp <- simplify(BP, cutoff=0.7,by="p.adjust",select_fun=min) 
#MF_simp <- simplify(MF, cutoff=0.7,by="p.adjust",select_fun=min) 

#write.table(as.data.frame(CC_simp@result), file="GO_simp.txt")
#write.table(as.data.frame(BP_simp@result), file="GO_simp.txt",append=T,col.names=F)
#write.table(as.data.frame(MF_simp@result), file="GO_simp.txt",append=T,col.names=F)

#p=dotplot(ALL,x="count",  showCategory = 14, colorBy="pvalue") #showCategory即展示几个分类，最好都展示(取ALL@result的行数)
n = length(ALL$ONTOLOGY == 'BP')
CairoPDF(paste(output,"enrichGO.pdf",sep=""),width=12,height=8) #PDF格式非常棒,可在PS中调整dpi
p=dotplot(ALL,showCategory = n,  colorBy="pvalue",font.size=18)   
p + scale_size(range=c(2, 8))  #设置点的大小
#showCategory即展示几个分类，最好都展示(取ALL@result的行数)
#font.size设置文字大小
dev.off()

