
if(!file.exists("data")){
  dir.create("data")
}
#create directory if none

            #downloading extracting and loading files
flurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(flurl, dest="samsungdata.zip", mode="wb") 
unzip ("samsungdata.zip", exdir = "./data")
xtest<-read.table("./X_test.txt",header=FALSE,sep = "")
ytest<-read.table("./y_test.txt",header=FALSE,sep = "")
subtest<-read.table("./subject_test.txt",header=FALSE,sep = "")
xtrain<-read.table("./X_train.txt",header=FALSE,sep = "")
ytrain<-read.table("./y_train.txt",header=FALSE,sep = "")
subtrain<-read.table("./subject_train.txt",header=FALSE,sep = "")
    #collecting activity names and column names
activNames<-read.table("./features.txt",header=FALSE,sep = "")
cols<-grep("mean()|std()",activNames$V2)
names<-activNames[cols,2]
xtestcln<-xtest[,cols]
colnames(xtestcln)<-names
#getting test and train data ready for merge
traindata<-cbind(subtrain,ytrain,xtraincln)
testdata<-cbind(subtest,ytest,xtestcln)
names(testdata)[1]<-"subject"
names(traindata)[1]<-"subject"
#mergeddata
mergeddata<-merge(testdata,traindata, all = TRUE )
names(mergeddata)[2]<-"activity"
lookupvector<-c("Walking","WalkingUpstairs","WalkingDownstairs","Sitting","Standing","Laying")
colwithnames<-lookupvector[mergeddata[,2]]
mergeddata[,2]<-colwithnames
tidygrp<-group_by(mergeddata,subject,activity)
#tidydata
tidydf<-summarise_each(test,funs(mean))
#exporting text file
write.table(tidydf,"tidydata.txt",row.names=FALSE)

