## step 1: Merges the training and the test sets to create one data set.

#Test Group 
TestSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject")
TestLabels <- read.table("UCI HAR Dataset/test/y_test.txt", col.names="Label")
TestData <- read.table("UCI HAR Dataset/test/X_test.txt")
TestBind <- cbind(TestSubjects, TestLabels, TestData)

#Train Group
TrainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject")
TrainLabels <- read.table("UCI HAR Dataset/train/y_train.txt", col.names="Label")
TrainData <- read.table("UCI HAR Dataset/train/X_train.txt")
TrainBind <- cbind(TrainSubjects, TrainLabels, TrainData)


data <- rbind(TestBind,TrainBind)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
Features <- read.table("UCI HAR Dataset/features.txt", strip.white=TRUE, stringsAsFactors=FALSE)
Features <- Features[grep("mean\\()|std\\()", Features$V2), ]

# select only the means and standard deviations from data
data <- data[, c(1, 2, Features$V1+2)]

## step 3: Uses descriptive activity names to name the activities in the data set.

labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors=FALSE)
data$Label <- labels[data$Label, 2]

## step 4: Appropriately label the data set with descriptive variable names.

AppColNames <- c("Subject", "Label", Features$V2)

colnames(data) <- AppColNames

## step 5:From the data set in step 4, creates a second, independent tidy data set 

numCol<-ncol(data)
by=list(subject = data$Subject, label = data$Label)

DataMeans <- aggregate(data[, 3:numCol],by=by, mean)

write.table(format(DataMeans), "tidyData.txt",row.names=FALSE, quote=FALSE) 


