library(plyr)
feat<-read.csv("features.txt",sep=" ",stringsAsFactors = FALSE,header=FALSE)
labls<-feat[,2]
activities<-read.csv("activity_labels.txt",sep=" ",stringsAsFactors = TRUE,header=FALSE,col.names = c("Activity","Activity_desc"))

#Read test set
data_test = scan('./test/X_test.txt', what=numeric())
# Set columns number by labels
data_test = matrix(data_test, ncol=length(labls), byrow=T, dimnames=list(NULL, labls))
#Read Y
y_test = read.csv('./test/y_test.txt',header=FALSE,colClasses = c(factor()),col.names = c('Activity'))
#Assign to Y activity names
y_test<-join(y_test,activities,type="inner")
#Read Subject
subject_test = read.csv('./test/subject_test.txt',header=FALSE,col.names = c('Subject'))

data_test<-cbind(subject_test,y_test[2],data_test)



#Read trainset
data_train = scan('./train/X_train.txt', what=numeric())
# Set columns number by labels
data_train = matrix(data_train, ncol=length(labls), byrow=T, dimnames=list(NULL, labls))
#Read Y
y_train = read.csv('./train/y_train.txt',header=FALSE,colClasses = c(factor()),col.names = c('Activity'))
#Assign to Y activity names
y_train<-join(y_train,activities,type="inner")
#Read Subject
subject_train = read.csv('./train/subject_train.txt',header=FALSE,col.names = c('Subject'))

data_train<-cbind(subject_train,y_train[2],data_train)


# Merge data sets
full_dataset<-rbind(data_train,data_test)

#Mean of measures
means<-lapply(full_dataset[2:ncol(full_dataset)],mean)
#Standard Deviation of measures
sds<-lapply(full_dataset[2:ncol(full_dataset)],sd)

#Means by activity and subject
activity_mean<-aggregate(.~Activity_desc+Subject, data=full_dataset, mean)
#SD by activity
activity_sd<-aggregate(.~Activity_desc, data=full_dataset, sd)

#Save the file with means by activity
write.table(activity_mean,"mean by activity.txt",row.names=FALSE)