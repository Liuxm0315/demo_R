args <- commandArgs(trailingOnly = TRUE)
library(ggplot2)
##cat weight.R |R --slave --args weight.input test.pdf

input <- args[1]
outputfile <- args[2]

data=read.table(file=input,header=T)

data$patient<-as.factor(data$patient) ###NOTE,do remember make this step 
pdf(file=outputfile,width=20)
ggplot(data,aes(signature, weight, group=patient)) + 
labs(y="relative weight") +
geom_point(aes(colour = patient, shape = patient )) +
scale_shape_manual(values=1:nlevels(data$patient)) +  ###nlevels levels to numberic
geom_point(data, mapping=aes(signature, mean), shape = 45, colour = "black", size = 8)

dev.off()

