Getting and Cleaning Data Project
==============

The script run\_analysis.R creates the function run\_analysis() which does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data from step 5 will be returned as the result from the function call.  (For ease of reading, all column names are in camel case.)

The function expects that the data folder (UCI HAR Dataset) is in the working directory.