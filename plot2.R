#plot2.R

#1 load the data and cleaning it

getwd()
setwd('../')
setwd('./Desktop/coursera R/UCI house electric data') #locate the working directory to the directory containing
# the data set

ele=read.table('household_power_consumption.txt',sep=';',header=TRUE)
names(ele)[c(3:9)]=c('gap','grp','Volt','gi','sub1','sub2','sub3') #change the names of columns of dataset
ele$Time=paste(ele$Date,ele$Time,sep=' ')
ele$Date=as.Date(ele$Date,'%d/%m/%Y')
d1=as.Date('20070201','%Y%m%d')
d2=as.Date('20070202','%Y%m%d')
ele=ele[(ele$Date>=d1 & ele$Date<=d2),] #extract the data from 20070201 to 20070202
library(lubridate)
ele$Time=dmy_hms(ele$Time)

for(i in 3:9){
  che=sum(ele[,i] %in% c('?'))
  print(che)
} #the floop here is to check if the missing values exist

for(i in 3:9){
  ele[,i]=as.numeric(ele[,i])
} #transform the character into numeric

colSums(is.na(ele)) # there is no na value and the data is ready to use

#2 plot the graph
plot(ele$Time,ele$gap,type="l",ylab='Global Active Power (kilowatts)',xlab='',xaxt='n',lwd=1)
axis(side=1,quantile(ele$Time,c(0,0.5,1)),labels=c('Thu','Fri','Sat')) # to set the languange to english
dev.copy(png,'plot2.png',height=480,width=480)
dev.off()
