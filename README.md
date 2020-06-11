## GettingAndCleaningDataCourseProject

The data used as part of this project comes from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This was originally collected from the accelerometers from the Samsung Galaxy S smartphone.

The purposes of this project was to modify this data set to produce a tidy data set containing the average values of a selection of variables, by subject and activity performed.

## Provided Files

# run_analysis.R

Sourcing this script into R will download the data from the link above into your working directory if it doesn't already exist, and unzip the file. From there, a series of transforms are applied to the original data set in order to produce a file tidydata.txt, which contains the tidy data set as outlined above.

Namely the transforms are from the course assignment page, outlined below:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each    variable for each activity and each subject.

# CodeBook.Md

This file contains information provided by the original researchers on the features they collected as part of their original research. From there, details on what transforms are applied to the original data set and how they are applied to create the final tidy set can be found in this file as well.



