setwd("D:/csilla/data course/course materials/03_getting_data_clean/05_project/")
library(dplyr)

## 1. MERGING TRAINING AND TEST DATA SETS

## loading the training subject, activity and data into one table
set_trained <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_trained <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")
activity_trained <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names ="activity_code")

train_table <- cbind(subject_trained,activity_trained, set_trained)
rm(set_trained, activity_trained, subject_trained)

## loading the test subject, activity and data into one table
set_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names ="activity_code")

test_table <- cbind(subject_test, activity_test, set_test)
rm(set_test, activity_test, subject_test )

## train and test data in one table
data0 <- rbind(train_table, test_table)
rm(train_table, test_table)


## 2. EXTRACT ONLY THE MEASUREMENTS ON MEAN OR STD

## selecting measurements with mean and standard deviation
measurements <- read.table("./UCI HAR Dataset/features.txt")
measures_meanstd <- grepl("mean|std", measurements$V2)

## creating a dataset with the desired measurements
data <- data0[,measures_meanstd]
rm(data0)


## 3. USING DESCRIPTIVE ACTIVITY NAMES
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
tidy_data0 <- merge(data, activity_names, by.x="activity_code", by.y="V1")
tidy_data0 <- rename(tidy_data0, activity=V2)
## since the activity names are the last column, we can rearrange the data set, having
## the activity names at the beginning and leaving the activity code (col 1) out
tidy_data <- tidy_data0[,c(82,2:81)]

## 4. Renaming the column names
new_col_names <-c("subject", "activity", measurements$V2[measures_meanstd])
colnames(tidy_data) <- new_col_names


## 5. RESHAPING THE DATASET

##install.packages("reshape2")
library(reshape2)
skinny_dataset <- melt(tidy_data, id=c("activity","subject"))
tidy_data_averages <- dcast(skinny_dataset, activity + subject ~ variable,mean)

write.table(tidy_data_averages, file="tidy_data_averages.txt", row.names = FALSE)
