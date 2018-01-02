#Getting and Cleaning Data - Course Project CodeBook


##Data Source
The original data for this project comes from [Human Activity Recognition Using Smartphones Dataset V1.0](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#) and was downloaded from [Original Data Files](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Detailed information of the original data set can be found at [Original Data Description](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names)


##Original Data Overview
The experiments were carried out with a group of 30 volunteers. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

The set of variables that were estimated from these signals was: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

- gravityMean
- tBodyAccMean
- tBodyAccJerkMean
- tBodyGyroMean
- tBodyGyroJerkMean


##Project Data
Only a subset of the mean() and std() from the original variables was needed to be considered in order to complete this project:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

Variables ending XYZ have 3 components, one for each axis (x,y and z), that makes them have a mean and an std for each of the axis. Since the amount of variables to consider is 17, and 8 have two extra channels (y and z), total variables count is 33. Considering that the mean and std of those 33 variables was extracted, the total count of experiment's output variables extracted was 66. Two fixed variables were also extracted, the subject and the activity identifier. That makes 68 the total amount of variables extracted from original data set.

All other original variables were ignored for the purpose of this project. You can refer to code on script 'run_analysis.R' for details on how data subset was extracted.


##Tidy Data Description
The tidy data set was constructed after manually downloading the UCI HAR DataSet. Linux OS commands were used to uncompress the files from the original zip format. Then the R script named 'run_analysis.R' was executed in order to take the data to a tidy format and also to generate the requested average computations. More details on the actual steps are detailed in the script code.

A data frame containing the necessary variables for the analysis was stored in the folder named 'TidyData' on a file named 'HAR_Data.rds'. On the following table you can find the names and measurement units of all tidy data frame columns. You can also find a reference for each variable to the original HAR data set.


Tidy Column Number | Tidy Variable Name | HAR Column Number | HAR Variable Name | Measurement Unit
:---:|--- |:--:|---|:---:
1|activity|N/A|activity|N/A
2|subject|N/A|subject|N/A
3|tbodyaccmeanx|1|tBodyAcc-mean()-X|g
4|tbodyaccmeany|2|tBodyAcc-mean()-Y|g
5|tbodyaccmeanz|3|tBodyAcc-mean()-Z|g
6|tbodyaccstdx|4|tBodyAcc-std()-X|g
7|tbodyaccstdy|5|tBodyAcc-std()-Y|g
8|tbodyaccstdz|6|tBodyAcc-std()-Z|g
9|tgravityaccmeanx|41|tGravityAcc-mean()-X|g
10|tgravityaccmeany|42|tGravityAcc-mean()-Y|g
11|tgravityaccmeanz|43|tGravityAcc-mean()-Z|g
12|tgravityaccstdx|44|tGravityAcc-std()-X|g
13|tgravityaccstdy|45|tGravityAcc-std()-Y|g
14|tgravityaccstdz|46|tGravityAcc-std()-Z|g
15|tbodyaccjerkmeanx|81|tBodyAccJerk-mean()-X|g
16|tbodyaccjerkmeany|82|tBodyAccJerk-mean()-Y|g
17|tbodyaccjerkmeanz|83|tBodyAccJerk-mean()-Z|g
18|tbodyaccjerkstdx|84|tBodyAccJerk-std()-X|g
19|tbodyaccjerkstdy|85|tBodyAccJerk-std()-Y|g
20|tbodyaccjerkstdz|86|tBodyAccJerk-std()-Z|g
21|tbodygyromeanx|121|tBodyGyro-mean()-X|g
22|tbodygyromeany|122|tBodyGyro-mean()-Y|g
23|tbodygyromeanz|123|tBodyGyro-mean()-Z|g
24|tbodygyrostdx|124|tBodyGyro-std()-X|g
25|tbodygyrostdy|125|tBodyGyro-std()-Y|g
26|tbodygyrostdz|126|tBodyGyro-std()-Z|g
27|tbodygyrojerkmeanx|161|tBodyGyroJerk-mean()-X|g
28|tbodygyrojerkmeany|162|tBodyGyroJerk-mean()-Y|g
29|tbodygyrojerkmeanz|163|tBodyGyroJerk-mean()-Z|g
30|tbodygyrojerkstdx|164|tBodyGyroJerk-std()-X|g
31|tbodygyrojerkstdy|165|tBodyGyroJerk-std()-Y|g
32|tbodygyrojerkstdz|166|tBodyGyroJerk-std()-Z|g
33|tbodyaccmagmean|201|tBodyAccMag-mean()|g
34|tbodyaccmagstd|202|tBodyAccMag-std()|g
35|tgravityaccmagmean|214|tGravityAccMag-mean()|g
36|tgravityaccmagstd|215|tGravityAccMag-std()|g
37|tbodyaccjerkmagmean|227|tBodyAccJerkMag-mean()|g
38|tbodyaccjerkmagstd|228|tBodyAccJerkMag-std()|g
39|tbodygyromagmean|240|tBodyGyroMag-mean()|radians/second
40|tbodygyromagstd|241|tBodyGyroMag-std()|radians/second
41|tbodygyrojerkmagmean|253|tBodyGyroJerkMag-mean()|radians/second
42|tbodygyrojerkmagstd|254|tBodyGyroJerkMag-std()|radians/second
43|fbodyaccmeanx|266|fBodyAcc-mean()-X|g
44|fbodyaccmeany|267|fBodyAcc-mean()-Y|g
45|fbodyaccmeanz|268|fBodyAcc-mean()-Z|g
46|fbodyaccstdx|269|fBodyAcc-std()-X|g
47|fbodyaccstdy|270|fBodyAcc-std()-Y|g
48|fbodyaccstdz|271|fBodyAcc-std()-Z|g
49|fbodyaccjerkmeanx|345|fBodyAccJerk-mean()-X|g
50|fbodyaccjerkmeany|346|fBodyAccJerk-mean()-Y|g
51|fbodyaccjerkmeanz|347|fBodyAccJerk-mean()-Z|g
52|fbodyaccjerkstdx|348|fBodyAccJerk-std()-X|g
53|fbodyaccjerkstdy|349|fBodyAccJerk-std()-Y|g
54|fbodyaccjerkstdz|350|fBodyAccJerk-std()-Z|g
55|fbodygyromeanx|424|fBodyGyro-mean()-X|g
56|fbodygyromeany|425|fBodyGyro-mean()-Y|g
57|fbodygyromeanz|426|fBodyGyro-mean()-Z|g
58|fbodygyrostdx|427|fBodyGyro-std()-X|g
59|fbodygyrostdy|428|fBodyGyro-std()-Y|g
60|fbodygyrostdz|429|fBodyGyro-std()-Z|g
61|fbodyaccmagmean|503|fBodyAccMag-mean()|g
62|fbodyaccmagstd|504|fBodyAccMag-std()|g
63|fbodybodyaccjerkmagmean|516|fBodyBodyAccJerkMag-mean()|g
64|fbodybodyaccjerkmagstd|517|fBodyBodyAccJerkMag-std()|g
65|fbodybodygyromagmean|529|fBodyBodyGyroMag-mean()|radians/second
66|fbodybodygyromagstd|530|fBodyBodyGyroMag-std()|radians/second
67|fbodybodygyrojerkmagmean|542|fBodyBodyGyroJerkMag-mean()|radians/second
68|fbodybodygyrojerkmagstd|543|fBodyBodyGyroJerkMag-std()|radians/second


## Data Set of Variables' Averages by Groups
A secondary data set was created by the code in 'run_analysis.R'. This data set contains averages for 66 of the 68 variables in the Tidy data set. Averages computations were grouped by 'activity', by 'subject' and by 'activity + subject'. The three resulting data frames were saved on folder 'VariableAverages' in three RDS format files named 'Activity_Averages.rds', 'Subject_Averages.rds' and 'Activity_Subject_Averages.rds' respectively.

You can refer to 'Tidy Data Description' for the names and units of each column of the averages data frames. You may also refer to the script 'run_analysis.R' for details on how variables were grouped and averages computed.



