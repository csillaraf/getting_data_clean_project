---
output:
  html_document: default
  pdf_document: default
---

<h1> Getting Data Clean Course Project </h1>

<p> The purpose of this project is to transform raw data into a tidy dataset using different transformations.
</p>

<p>We are working with the data collected from the accelerometers from the Samsung Galaxy S smartphone.
Full description of the data can be found here 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
</p>

<br>
<h2>The decription of the transformations in run_analysis.R </h2>

<br>
<h3>1. Loaing and merging the data </h3>

<p>
Our original data are in two datasets: the training data and the test data. In both cases, tha main data set contains only the meauserements. The subject and the activity are in different tables. Our first step is to load the data into R. 
</p>

<p> Loading the training set.</p>

```
set_trained <- read.table("./UCI HAR Dataset/train/X_train.txt")
subject_trained <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names="subject")
activity_trained <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names ="activity_code")

train_table <- cbind(subject_trained,activity_trained, set_trained)
rm(set_trained, activity_trained, subject_trained)
```
<p> Loading the test set </p>

```
set_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names="subject")
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names ="activity_code")

test_table <- cbind(subject_test, activity_test, set_test)
rm(set_test, activity_test, subject_test )
```

<p> Binding the two datasets </p>
```
data0 <- rbind(train_table, test_table)
rm(train_table, test_table)
```
<p> Since the loaded tables are quite big, it is worth to remove the unnecessary tables from R. </p>

<br>
<h3>2. Extracting only the measurements on the mean and standard deviation for each measurement </h3>

<p> First we read the list of measurements, the select the ones on mean and standard deviation.</p>
```
measurements <- read.table("./UCI HAR Dataset/features.txt")
measures_meanstd <- grepl("mean|std", measurements$V2)
```

<p> Then we create a new dataset using only the desired measures
``` 
data <- data0[,measures_meanstd]
rm(data0)
```
<br>
<h3>3. Using descriptive activity names </h3>

<p>In our dataset the activities are represented with codes. In the file activity_labels.txt we can find the description of each code. First we load the decriptions then we merge them with our dataset and name it activity.
</p>
```
activity_names <- read.table("./UCI HAR Dataset/activity_labels.txt")
tidy_data0 <- merge(data, activity_names, by.x="activity_code", by.y="V1")
tidy_data0 <- rename(tidy_data0, activity=V2)
```

<p> In this dataset, the activity column ended up being the last one. It is nice to have the qualitative variables at the beginning, so we reordered the table. </p>
```
tidy_data <- tidy_data0[,c(82,2:81)]
```
<br>
<h3>4. Renaming columns </h3>
<p> Our dataset is missing desciptive column names. Those can be found in the file features.txt, loaded in the second section. To rename the columns we use the following code:
</p>
```
new_col_names <-c("subject", "activity", measurements$V2[measures_meanstd])
colnames(tidy_data) <- new_col_names
```

<br>
<h3>5. Creating an independent tidy data set with the average of each variable for each activity and each subject</h3>
<p> First, we reshape or dataset using the melt function. Then we cast it in the desired form.
</p>
```
skinny_dataset <- melt(tidy_data, id=c("activity","subject"))
tidy_data_averages <- dcast(skinny_dataset, activity + subject ~ variable,mean)
```

<p>Finally, we export our final dataset. </p>

```write.table(tidy_data_averages, file="tidy_data_averages.txt", row.names = FALSE)```