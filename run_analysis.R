#First Set the working directory accordingly

setwd("C:/Users/Neelesh/Desktop/Coursera/R")

path<-getwd()
path

#Download and unzip the dataset if not done already

filename <- "Getting and cleaning data.zip"

if(!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}

if(!file.exists("UCI HAR Dataset")) {
  unzip(filename)
}

#List the files if you want

pathIn <- file.path(path, "UCI HAR Dataset")
list.files(pathIn, recursive = TRUE)
pathIn

#Set the directory

setwd(pathIn)
getwd()

#Read the files


#Training data

trainData <- read.table("./train/X_train.txt")
head(trainData)
trainLabels <- read.table("./train/y_train.txt")
table(trainLabels)
trainSubjects <- read.table("./train/subject_train.txt")

#Testing data

testData <- read.table("./test/X_test.txt")
head(testData)
testLabels <- read.table("./test/y_test.txt")
table(testLabels)
testSubjects <- read.table("./test/subject_test.txt")



#Step 1 : Merge datasets


mergeData <- rbind(trainData, testData)
dim(mergeData)
mergeLabels <- rbind(trainLabels, testLabels)
dim(mergeLabels)
mergeSubjects <- rbind(trainSubjects, testSubjects)
dim(mergeSubjects)



#Step 2: Extract only measurements on mean and std for each measurement

features <- read.table("features.txt")
dim(features)  
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
mergeData <- mergeData[, meanStdIndices]
dim(mergeData) 
names(mergeData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(mergeData) <- gsub("mean", "Mean", names(mergeData)) # capitalize M
names(mergeData) <- gsub("std", "Std", names(mergeData)) # capitalize S
names(mergeData) <- gsub("-", "", names(mergeData)) # remove "-" in column names 





#Step 3: Use descriptive activity names to name the activities in the data set

activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_","", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabels <- activity[mergeLabels[, 1], 2]
mergeLabels[, 1] <-activityLabels
names(mergeLabels) <- "activity"


#Step 4: Appropriately label data set with descriptive variable names

names(mergeSubjects) <- "subject"
cleanedData <- cbind(mergeSubjects, mergeLabels, mergeData)
dim(cleanedData)
#write.table(cleanedData, "merged_data.txt") --> This is the 1st dataset with appropriatee labels

#The 1st data dataset is basically internal to the script, and doesn't need to be actually uploaded as part of the project

#Step 5: Create a 2nd independent tidy data set with avg of each variable for each activity & subject
subjectLen <- length((table(mergeSubjects))) 
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]

result <- matrix(NA, nrow = subjectLen*activityLen, ncol=columnLen)
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)

row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(mergeSubjects)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanedData$subject
    bool2 <- activity[j, 2] == cleanedData$activity
    result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
    row <- row + 1
    
  }
}

head(result)
write.table(result, "tidy_Data.txt")

#This is the 2nd and tidy data set



#printResult <- read.table("tidy_Data.txt")
#printResult



