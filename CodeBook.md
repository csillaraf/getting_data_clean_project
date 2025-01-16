<h1> Getting Data Clean Course Project - Codebook </h1>

<p> The purpose of this project is to transform raw data into a tidy dataset using different transformations.
</p>

<p>We are working with the data collected from the accelerometers from the Samsung Galaxy S smartphone.
Full description of the data can be found here 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
</p>

<h2> Dataset description </h2>

<p>
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
</p>

<h2> Tables used in the analysis </h2>

- 'train/X_train.txt': Training set ( each row contains measurements of one activity by one person/subject)

- 'train/y_train.txt': Codes of the activities measured 

- 'train/subject_train.txt': Id of the given person/subject who performed the activities

- 'test/X_test.txt': Test set ( each row contains measurements of one activity by one person/subject)

- 'test/y_test.txt': Codes of the activities measured 

- 'test/subject_test.txt': Id of the given person/subject who performed the activities

- 'features.txt': Labels of all measurements (561)

- 'activity_labels.txt': Links the activity codes with their activity name

<h2> Transformations </h2>

<p> The code for our analysis is stored in the file run_analysis.R. Detailed description of the code can be found in readme.md.
</p>

<h2> Output </h2>

<p>
The result of our script are two tables.
<br>
The table <em>tidy_data</em> includes both training and test data, including who performed the activity and what activity the measures represent. Only measures representing mean or standard deviation are presented. This table is not exported at the end of the script.
<br>
The second table is exported to <em>tidy_data_averages.txt</em> and includes the average of each measurement for each activity and each subject.
</p>