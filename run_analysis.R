rm(list = ls())
##Set the root directory where the zip file would be downloaded & extracted. Will use this directory to save the R code and other files needed
setwd("C:\\Users\\vadisheshan\\Desktop\\Data Scientist\\Course 3\\ProgrammingAssignmentC3WK4\\")
getwd()

##Set the URL to obtain the zip folder
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

##Download the zip folder & unzipping it if and only if it doesnt exist already
if(!file.exists("Dataset.zip")){
    download.file(url,destfile = "Dataset.zip")
}
if (!file.exists("UCI HAR Dataset")) { 
    unzip("Dataset.zip")
}
list.files("UCI HAR Dataset/")

##Obtaining the activities Labels
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt",header = FALSE,sep = " ")
activityLabels[,2] <- as.character(activityLabels[,"V2"])

##Obtaining the features & extracting only when its mean or std related
features <- read.csv("UCI HAR Dataset/features.txt",header = FALSE,sep = " ")
features[,2] <- features[,2]
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)
featuresWanted.names <- gsub('mean', 'MEAN', featuresWanted.names)
featuresWanted.names <- gsub('std', 'STD', featuresWanted.names)

##Loading training data sets
list.files("UCI HAR Dataset/train/")
trainData <- read.table("UCI HAR Dataset/train/X_train.txt") [featuresWanted]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

##Column binding the data frames above to create the training data set
train <- cbind(trainSubjects,trainActivities,trainData)

##Loading test data sets
list.files("UCI HAR Dataset/test/")
testData <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

##Column binding the data frames above to create the test data set
test <- cbind(testSubjects,testActivities,testData)

##ensuring the column dimensions of both the data frames are same for merge
dim(train)
dim(test)

##Row binding the data frames together
allData <- rbind(train,test)

##adding the column names for the new fused data frame
colnames(allData) <- c("subject","activity",featuresWanted.names)

##Ensure all columns have been names appropriately
head(allData)

allDataMelted <- melt(allData,c("subject","activity"))
allDataMean <- dcast(allDataMelted,subject+activity ~ variable, mean)
write.table(allDataMean, "tidy.txt",quote = FALSE,row.names = FALSE)
