#Getting and Cleaning Data Programming Assignment
#Author: Periklis Giannakis

##You should create one R script called run_analysis.R that does the following. 
## 1.Merges the training and the test sets to create one data set.
## 2.Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Download the data from the link provided in the programming assignment description
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(URL, "dataFiles.zip", method = "curl")

##Time to unzip the dataFiles file
install.packages("reshape2")
library(reshape2)
unzip(zipfile = "dataFiles.zip")

##We want to load the activity labes and features files (for some reason I couldn't specify colnames within fread so I did it separately)
install.packages("data.table")
library(data.table)
actlabels <- fread(file.path("UCI HAR Dataset/activity_labels.txt"))
colnames(actlabels) <- c("classlabels","activityname")
features <- fread(file.path("UCI HAR Dataset/features.txt"))
colnames(features) <- c("index", "featurename")

##Write code to extract the mean (mean()) and SD(std()) for each measurement
measurements <- grep("(mean|std)\\(\\)", features[ ,featurename])
featwant <- grep("(mean|std)\\(\\)", features[ ,featurename], value = TRUE)

##I want to get rid of the () and - as well as lower case everything to avoid confusion while writing my code + better practice for names in general
featwant <- gsub('[()]', '', featwant)
featwant <- gsub('[-]', '', featwant)
featwant <- tolower(featwant)

##Load test datasets
test <- fread(file.path("UCI HAR Dataset/test/X_test.txt"))
test <- test[, measurements, with = FALSE] ##get rid of the unwanted measurements (keep only the specified)
data.table::setnames(test, colnames(test), featwant) ##name columns of test as the wanted features
testact <- fread(file.path("UCI HAR Dataset/test/y_test.txt"))
colnames(testact) <- c("activitylabel")
testsub <- fread(file.path("UCI HAR Dataset/test/subject_test.txt"))
colnames(testsub) <- c("subid")
test <- cbind(testsub, testact, test)

##Load train datasets (copy paste above and change names)
train <- fread(file.path("UCI HAR Dataset/train/X_train.txt"))
train <- train[, measurements, with = FALSE] ##get rid of the unwanted measurements (keep only the specified)
data.table::setnames(train, colnames(train), featwant) ##name columns of test as the wanted features
trainact <- fread(file.path("UCI HAR Dataset/train/y_train.txt"))
colnames(trainact) <- c("activitylabel")
trainsub <- fread(file.path("UCI HAR Dataset/train/subject_train.txt"))
colnames(trainsub) <- c("subid")
train <- cbind(trainsub, trainact, train)

##Merge test + train
mergedtt <- rbind(train, test)

##Give descriptive activity names to the dataset (switch activitylabel to activityname)
mergedtt[["activitylabel"]] <- factor(mergedtt[, activitylabel], levels = actlabels[["classlabels"]], labels = actlabels[["activityname"]])
mergedtt[["subid"]] <- as.factor(mergedtt[ , subid])

##Create a second independent tidy data set with the average of each variable for each activity and each subject.
mergedtt <- reshape2::melt(data = mergedtt, id = c("subid", "activitylabel"))
mergedtt <- reshape2::dcast(data = mergedtt, subid + activitylabel ~ variable, fun.aggregate = mean)
data.table::fwrite(x = mergedtt, file = "tidyData.txt", quote = FALSE)
