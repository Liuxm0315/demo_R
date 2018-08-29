args <- commandArgs(T)
pdf(args[3])
mul=read.table(args[1],sep="\t", header=F)
x<-mul[,4]
y<-mul[,8]
cor=cor.test(x,y)
plot(x,y,col=c("blue"),pch=20,xlim=c(-3,3),ylim=c(-3,3),xlab="Chip",ylab="Exon", main=args[2])
lm.sol=lm(mul[,8]~mul[,4],data=mul)
abline(lm.sol)
lines(density(abs(y-x)),col=c("red"))
cor 
lm.sol
mtext(text=paste("cor=",cor$estimate,"p=",cor$p.value))
paste("Signature",args[2],cor$estimate,cor$p.value, sep="\t")
write.table(as.matrix(cor), paste(args[2],".cor"), quote=F)
box()
dev.off()
	
