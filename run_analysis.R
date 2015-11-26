#Step 1
test <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
train <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
subject_test <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
subject_train <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
testactivity <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")
trainactivity <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")
mergedata <- rbind(cbind(subject_test, testactivity, test), cbind(subject_train, trainactivity, train))

#Step 2
features <- read.table("C:/Users/Edward Wang/Desktop/UCI HAR Dataset/features.txt", quote="\"", comment.char="")
colnames(mergedata) <- c("subject", "activity", tolower(as.character(features$V2)))
mergedata.m.std <- mergedata[,sort(c(grep("mean", colnames(mergedata)), grep("std", colnames(mergedata))))]

#Step 3
mergedata$activity[mergedata$activity == 1] <- "Walking"
mergedata$activity[mergedata$activity == 2] <- "Walking Upstairs"
mergedata$activity[mergedata$activity == 3] <- "Walking Downstairs"
mergedata$activity[mergedata$activity == 4] <- "Sitting"
mergedata$activity[mergedata$activity == 5] <- "Standing"
mergedata$activity[mergedata$activity == 6] <- "Laying"

#Step 4
names(mergedata) <- gsub("acc", "accelerator", names(mergedata))
names(mergedata) <- gsub("mag", "magnitude", names(mergedata))
names(mergedata) <- gsub("gyro", "gyroscope", names(mergedata))
names(mergedata) <- gsub("^t", "time", names(mergedata))
names(mergedata) <- gsub("^f", "frequency", names(mergedata))
names(mergedata) <- gsub("V1", "activity", names(mergedata))

#Step 5
seconddata <- aggregate(mergedata[, 3:ncol(mergedata)], by=list(subject = mergedata$subject, activity = mergedata$activity), FUN = mean)