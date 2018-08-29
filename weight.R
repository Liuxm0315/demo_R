args <- commandArgs(trailingOnly = TRUE)
library(ggplot2)
print("For example:cat weight.R |R --slave --args /ifs1/ST_SYSBIO/USER/wangyujue1/HCC/signature.20170321/deconstructSigs/result/without_P/weights.txt contributions_of_muta_sigs /ifs1/ST_SYSBIO/USER/wangyujue1/HCC/signature.20170321/deconstructSigs/result/without_P/weights.pdf /ifs1/ST_SYSBIO/USER/wangyujue1/HCC/signature.20170321/deconstructSigs/result/without_P/weights.txt.mean\n")

input <- args[1]
outputfile <- args[2]

data=read.table(file=input,header=T)

#p=data.frame(data$shape_in)

pdf(file=outputfile,width=20)
ggplot(data,aes(signature, meanval)) + 
labs(y="relative weight") +
geom_point(shape = 45, colour = "black", fill = "white", size = 12) + 
scale_shape_identity() +  
geom_point(data, mapping=aes(signature, weight, colour = factor(shape),  shape = shape, size=3 ))

#geom_point(p, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red")
#ggplot() +
#ggplot(data,aes(signature, weight)) + 
#labs(y="relative weight") + 
#scale_x_continuous(breaks=seq(1, 30, 1))  + 
#theme(panel.grid =element_blank()) + 
#geom_point(position=position_jitter(width=0.3,height=0)) + 
#geom_point(aes(shape = factor(patient))) +
#geom_point(aes(colour = factor(patient))) #+ 
#geom_point(data, mapping=aes(signature, mean), size=12  ) + 
#scale_shape_identity() +
#geom_point(data, mapping=aes(signature, weight, colour = factor(patient),shape =factor(gsub("P","",patient)), size=3 ))  

dev.off()

