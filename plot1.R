#plot1.R

#1 load the data and cleaning it

getwd()
setwd('../')
setwd('./Desktop/coursera R/UCI house electric data') #locate the working directory to the directory containing
                                                      # the data set

ele=read.table('household_power_consumption.txt',sep=';',header=TRUE)
names(ele)[c(3:9)]=c('gap','grp','Volt','gi','sub1','sub2','sub3') #change the names of columns of dataset
ele$Date=as.Date(ele$Date,'%d/%m/%Y')
d1=as.Date('20070201','%Y%m%d')
d2=as.Date('20070202','%Y%m%d')
ele=ele[(ele$Date>=d1 & ele$Date<=d2),] #extract the data from 20070201 to 20070202

for(i in 3:9){
  che=sum(ele[,i] %in% c('?'))
  print(che)
} #the floop here is to check if the missing values exist

for(i in 3:9){
  ele[,i]=as.numeric(ele[,i])
} #transform the character into numeric

colSums(is.na(ele)) # there is no na value and the data is ready to use

#2 plot the graph
hist(ele$gap,col='red',xlab='Global Active Power (kilowatts)',main='Global Active Power')
dev.copy(png,height=480,width=480,file='plot1.png')
dev.off()