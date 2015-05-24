# run_analysis.R
# Alnis Bajars. 2015-05-24

# Data analysis on data set from
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Source data in working directory as per requested upload instructions.

# Specification.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Make life easier in step 5
library(dplyr)

## 1. Read data sets and merge.

## First the reference data that does not need combining.

# features for these measurements
features <- read.table("features.txt", fill = TRUE)
names(features) <- c("featureID", "Feature")

# labels for these activities
activityLabels <- read.table("activity_labels.txt", fill = TRUE)
names(activityLabels) <- c("activityID", "Activity") 

## Now the test and training data that does need combining.

# measurements
testX <- read.table("X_test.txt", fill = TRUE)
trainX <- read.table("X_train.txt", fill = TRUE)
totalX <- rbind(testX, trainX)
# Step 4 ahead of time, easier to do it now
names(totalX) <- features$Feature

# activities
testY <- read.table("Y_test.txt", fill = TRUE)
trainY <- read.table("Y_train.txt", fill = TRUE)
totalY <- rbind(testY, trainY)
names(totalY) <- "activityID"

# subjects
testSubject <- read.table("subject_test.txt", fill = TRUE)
trainSubject <- read.table("subject_train.txt", fill = TRUE)
totalSubject <- rbind(testSubject, trainSubject)
names(totalSubject) <- "subjectID"

# spec says one data set, so be it.  Makes merge function feasible step 3.
# Measurements, then activities, then subjects
dataSet <- cbind(totalX, totalY, totalSubject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Use grep to extract lines with "-std()" or "-mean()",
# as my interpretation of the spec is that we only want these features
meanOrStd <- grepl('-mean()', features[,2], fixed = TRUE) | grepl('-std()', features[,2], fixed = TRUE)
# Make sure the activites and subjects are included
meanOrStd <- c(meanOrStd, TRUE, TRUE)

# as meanOrStd is a logical vector, use to subset measure columns we want
dataSet <- dataSet[,meanOrStd]

## 3. Uses descriptive activity names to name the activities in the data set
dataSet <- merge(x=dataSet, y=activityLabels, by="activityID")
# Don't need activityID anymore, might be a way to execute merge so this is not necessary
dataSet$activityID <- NULL

## 4. Appropriately labels the data set with descriptive variable names. 
# N/A completed in step 5

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
groupBy <- group_by(dataSet, Activity, subjectID)
tidyData <- summarise_each(groupBy, funs(mean))

# Write file out to give to the world
write.table(tidyData, file="tidyData.txt", sep = "\t", row.names = FALSE)

