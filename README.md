---
title: "README"
output: html_document
---

Author: Alnis Bajars.  Date: 2015-05-24.

## Overview

This document describes how to prepare and run the data the data analysis as per
Assignment for Coursera course getdata-014 (Getting and Cleaning Data). 

Note that the best experience is to use an interactive IDE like RStudio.

## Specification

Verbatim description of the spec.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Setting up the environment

First step is to have a working directory and set your R environment to this directory.

### Source Data

Download the [source files](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into your working directory and unzip into your working directory.

Of the unzipped files, copy these to your working directory. (Change backslashes to forward slashes in a Linux or Mac system).

* `UCI HAR Dataset\features.txt`
* `UCI HAR Dataset\activity_labels.txt`
* `UCI HAR Dataset\test\X_test.txt`
* `UCI HAR Dataset\test\Y_test.txt`
* `UCI HAR Dataset\test\subject_test.txt`
* `UCI HAR Dataset\train\X_train.txt`
* `UCI HAR Dataset\train\Y_train.txt`
* `UCI HAR Dataset\train\subject_train.txt`

### Execution code

If you are reading this markdown document you would have been made aware of this.  But for the record the code can be found at this [Github Repository](https://github.com/alnisb/getdata-014).  All the R source is in a single file `run_analysis.R`.

### Codebook

Within the [Github Repository](https://github.com/alnisb/getdata-014) you will find a codebook file features_info.txt.  This file has not been altered from the supplied source, and no attempt has been made to change any identifier names.

## Running and Testing the Code

You can run `run_analysis.R` in whatever way you wish in your R environment.  You can modify the code to suit, but at your own risk.

The code produces a tab delimited tidy data file called tidyData.txt.  Use the code below to verify this data can be consumed in a readable fashion.


```{r}
testCase <- read.table("tidyData.txt", sep = "\t", header = TRUE); View(testCase)
```

## Bugs and Assumptions

Things to note.

* Assumption. What is meant by the _mean_ and _standard deviation_ columns is open to interpretation.  This code takes a strict approach and only works with columns with names either `-mean()` or `-std()`. It would be fairly easy to modify the `grepl` statements to match other interpretations.
* Note.  Step 4 was effectively done in Step 1 as it seemed easiest to do then.
* Bug. Reading in the tidy data as per `read.table` statement above slightly distorts the column headings. eg. `tBodyAcc-mean()-X` becomes `tBodyAcc.mean...X`.  Apologies.

