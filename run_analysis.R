##Course Project - Getting and Cleaning Data

##Necessary Packages
require(dplyr)

##Download the data and unzip the file
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile = "getdata_projectfiles_UCI HAR Dataset.zip"
if(!file.exists(destfile)){
    download.file(url, destfile = destfile, method = "curl")
}
unzip(destfile)
##Merge the two datasets together
##Reading all our files
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/Y_test.txt")
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")
descriptive_names <- read.table("UCI HAR Dataset/activity_labels.txt")

##Merging train and test sets
tot_x <- rbind(xtrain, xtest)
tot_y <- rbind(ytrain, ytest)
tot_subject <- rbind(subjecttrain, subjecttest)

##Renaming columns
colnames(tot_x) <- paste(features[[1]],features[[2]])
colnames(tot_y) <- c("ActivityCode")
colnames(tot_subject) <- c("Subject")
colnames(descriptive_names) <- c("ActivityCode","ActivityName")
tot_y <- inner_join(tot_y, descriptive_names, by = "ActivityCode")

##Combining into one data frame
##Also will take care of Step 3: Descriptive activity names to name the activities in the data set
merged <- cbind(tot_subject, tot_y, tot_x)

##Extract the mean and std deviation measurements
##using dplyr select function to select subject, activitycode, and all columns containing mean and std
measurements <- select(merged, Subject, ActivityName, contains("mean"), contains("std"))

##Appropriately labels the data set with descriptive variable names.
colnames(measurements) <- gsub("^[0-9]+ ", "", colnames(measurements))
colnames(measurements) <- gsub("Acc", "Accelerometer", colnames(measurements))
colnames(measurements) <- gsub("Gyro", "Gyroscope", colnames(measurements))
colnames(measurements) <- gsub("BodyBody", "Body", colnames(measurements))
colnames(measurements) <- gsub("Mag", "Magnitude", colnames(measurements))
colnames(measurements) <- gsub("^t", "Time", colnames(measurements))
colnames(measurements) <- gsub("^f", "Frequency", colnames(measurements))
colnames(measurements) <- gsub("-mean\\(\\)", "Mean", colnames(measurements), ignore.case = TRUE)
colnames(measurements) <- gsub("-std\\(\\)", "StandardDeviation", colnames(measurements), ignore.case = TRUE)
colnames(measurements) <- gsub("freq\\(\\)", "Frequency", colnames(measurements), ignore.case = TRUE)
colnames(measurements) <- gsub("angle", "Angle", colnames(measurements))
colnames(measurements) <- gsub("gravity", "Gravity", colnames(measurements))
colnames(measurements) <- gsub("-", "", colnames(measurements))

##Creating a second, independent tidy data set with the average of each variable for each activity and each subject.
grouped_data <- group_by(measurements, Subject, ActivityName)
final_measurements <- summarize_all(grouped_data, mean)

##Writing to a txt file for submission
write.table(final_measurements, file = "UCI HAR Dataset/tidydata.txt",row.names = FALSE)


