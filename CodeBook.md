### CodeBook

## Intro

The data utilized for the purposes of this project was originally collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the data used as part of this project comes from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Original Feature Selection

The original researchers described their feature selection in the features_info.txt file found in the downloaded file. This is also described below:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

## Our Transformations

From this downloaded data set, the run_analysis.R script performs a series of transformations to this data in order to produce a final file which is written as tidydata.txt. The list of these transformations is below.

# Merging Training and Test Data into one data frame.

The original dataset separated the data into training and test sets. After reading in all the provided text files into R with read.table function, I merged each set together using the rbind function, namely:

subject_test.txt + subject_train.txt
X_test.txt + X_train.txt
y_test.txt + y_train.txt

To give descriptive names to the activity labels, I used the dplyr inner_join function to match the activity codes in the Y data files to the activity names mapping located in activity_labels.txt

Finally, I combined all these columns using cbind to create one data frame

Exact code can be found in run_analysis.R file

# Extracts only the measurements on the mean and standard deviation for each measurement.

We only focused on the measurements for mean and standard deviation, so we extracted them from this using the select function in the dplyr function, selecting our subject, ActivityName and all columns containing -mean() or -std() as these indicated mean and standard deviation measurements

Exact code can be found in run_analysis.R file

# Appropriately labels the data set with descriptive variable names

I wanted to rename the column headers in order to allow for more readability. To this end, a series of gsub() functions were applied to substitute special characters and clear up abbreviations.

Essentially:
All special characters removed
Column Names beginning with f and t were changed to begin with "Frequency"" and "Time" respectively
"Acc" was replaced with "Accelerometer"
"Gyro" was replaced with "Gyroscope"
"Mag was replaced with "Magnitude"
"BodyBody" was replaced with "Body"
"std" was replaced with "StandardDeviation"

Exact code can be found in run_analysis.R file

# Create a second independent tidy data set with the average of each variable for each activity and each subject

Finally our last transformation provided averages for each variable grouped by subject and activity name. This was accomplished via the group_by and summarize_all functions in the dplyr package.

group_by took in the current data and Subject and ActivityName columns as arguments.
summarize_all took in the grouped data and mean function as arguments.

The output of this summarize_all function was written to a txt file placed in the same directory as the unzipped data file named tidydata.txt using write.table function with a row.names = FALSE argument.




