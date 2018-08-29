args <- commandArgs(T)
library(ggplot2)

input <- args[1]
output<- args[2]

data <- read.table(file = input, sep = "\t", header = TRUE)

#Age
age_mut  <- data$Age[data$mut == 1]
age_wild <- data$Age[data$mut == 0]

#Location
loc_mut  <- data$Location[data$mut == 1]
loc_wild <- data$Location[data$mut == 0]

#Survival
surv_mut  <- data$Survival[data$mut == 1]
surv_wild <- data$Survival[data$mut == 0]

#Stage
stage_mut  <- data$Stage[data$mut == 1]
stage_wild <- data$Stage[data$mut == 0]

#Plot the distribution!
# gp <- ggplot(df, aes(x = expression, fill = gender)) + geom_bar()
# gp + geom_point() + geom_smooth()
# gp + stat_smooth(method='lm')
# model <- lm(expression ~ genotype + condition + gender, data = df)
# summary(model)

# look at diagnostic plots
# plot(model)

# df2 <- df
# df2$expression <- log2(df2$expression)
# filterOut <- which(is.infinite(df2$expression))
# df2 <- df2[-filterOut,]
# model <- lm(expression ~ genotype + condition + gender , data = df2)
# plot(model)
# ggsave('myplot.pdf') 

#Student t-test
#Student t-test is used to determine if two sets of values are significantly different. - Assumptions are data has a normal distribution and is continuous.
# ttest <- t.test(age_mut, age_wild)
# pVal <- ttest$p.value


#Kolmogorov-Smirnov
#This test determines if two distributions of data are similar.
#  Data does not have to have a normal distribution.
#  Data can be used continuous or discrete (count data).
#ksTest <- ks.test(age_mut, age_wild)
#ksTest$p.value
 
#Wilcoxon¡¯s Test
#This test is used on two groups of data where the samples are somehow related.
wilcTest <- wilcox.test(age_mut, age_wild, na.omit = T)
age_p<-wilcTest$p.value

wilcTest <- wilcox.test(loc_mut, loc_wild, na.omit = T)
loc_p<-wilcTest$p.value

wilcTest <- wilcox.test(surv_mut, surv_wild, na.omit = T)
surv_p<-wilcTest$p.value

wilcTest <- wilcox.test(stage_mut, stage_wild, na.omit = T)
stage_p<-wilcTest$p.value


#Fisher¡¯s Exact Test
#Contingency tables are matrices that describe the frequency of variables. - Determine if variable ¡°a¡± occurs at a higher frequency compared to variable ¡°b¡±. - Fisher¡¯s Exact Test is used to determine the statistical significance.
# generate contingency table
mf  <- length(which((data$mut == 1 & data$Smoking == 1) == TRUE))
mNf <- length(which((data$mut == 1 & data$Smoking == 0) == TRUE))
cf  <- length(which((data$mut == 0 & data$Smoking == 1) == TRUE))
cNf <- length(which((data$mut == 0 & data$Smoking == 0) == TRUE))
con <- matrix(c(mf,mNf,cf,cNf), nrow = 2, ncol = 2, byrow = FALSE)

# perform Fisher's exact test on contingency table
fisherTest <- fisher.test(con)
smok_pVal <- fisherTest$p.value

mf  <- length(which((data$mut == 1 & data$Drinking == 1) == TRUE))
mNf <- length(which((data$mut == 1 & data$Drinking == 0) == TRUE))
cf  <- length(which((data$mut == 0 & data$Drinking == 1) == TRUE))
cNf <- length(which((data$mut == 0 & data$Drinking == 0) == TRUE))
con <- matrix(c(mf,mNf,cf,cNf), nrow = 2, ncol = 2, byrow = FALSE)
 
fisherTest <- fisher.test(con)
drin_pVal <- fisherTest$p.value

mf  <- length(which((data$mut == 1 & data$Gender == 1) == TRUE))
mNf <- length(which((data$mut == 1 & data$Gender == 0) == TRUE))
cf  <- length(which((data$mut == 0 & data$Gender == 1) == TRUE))
cNf <- length(which((data$mut == 0 & data$Gender == 0) == TRUE))
con <- matrix(c(mf,mNf,cf,cNf), nrow = 2, ncol = 2, byrow = FALSE)

fisherTest <- fisher.test(con)
gend_pVal <- fisherTest$p.value

mf  <- length(which((data$mut == 1 & data$Family == 1) == TRUE))
mNf <- length(which((data$mut == 1 & data$Family == 0) == TRUE))
cf  <- length(which((data$mut == 0 & data$Family == 1) == TRUE))
cNf <- length(which((data$mut == 0 & data$Family == 0) == TRUE))
con <- matrix(c(mf,mNf,cf,cNf), nrow = 2, ncol = 2, byrow = FALSE)

fisherTest <- fisher.test(con)
fam_pVal <- fisherTest$p.value

names <- c("Age", "Location", "Surval", "Stage", "Smoking", "Dringking", "Gender", "Family")
res   <- matrix(c(age_p, loc_p, surv_p, stage_p, smok_pVal, drin_pVal, gend_pVal ,fam_pVal), nrow=1, byrow = TRUE)
colnames(res) <-names
write.table(res, file=output, quote = F, sep = "\t", col.names = T)
