## The run_analysis function does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## The data set from step 5 is returned.

library("plyr")

run_analysis <- function () {
    ## Load Column Names
    xNames <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
    xNames <- xNames$V2
    
    ## 1. Merges the training and the test sets to create one data set.
    
    ## Test Data
    subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
    names(subject) <- c("subject")
    y <- read.table("UCI HAR Dataset/test/Y_test.txt")
    names(y) <- c("activity")
    x <- read.table("UCI HAR Dataset/test/X_test.txt")
    names(x) <- xNames ## Import column names
    test <- cbind(subject, y, x) ## The test data set
    
    ## Training Data
    subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
    names(subject) <- c("subject")
    y <- read.table("UCI HAR Dataset/train/Y_train.txt")
    names(y) <- c("activity")
    x <- read.table("UCI HAR Dataset/train/X_train.txt")
    names(x) <- xNames ## Import column names
    train <- cbind(subject, y, x) ## The training data set
    
    ## Merge All Data
    all <- rbind(test, train); ## All data
    
    ## Clean up data usage by removing unneeded values
    remove(subject, y, x, test, train, xNames);
    
    ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    
    ## Find the columns with mean and std functions (We also want columns 1 and 2, the subject id and activity)
    keep <- c(1, 2, grep("(mean|std)\\(\\)", names(all)))
    
    ## Reduce the data
    reduced <- all[ , keep]
    
    ## Clean Up to save RAM
    remove(all, keep)
    
    ## 3. Uses descriptive activity names to name the activities in the data set
    activities <- read.table("UCI HAR Dataset/activity_labels.txt") ## Read in the labels
    names(activities) <- c("activity", "activityLabel") ## Add column names
    
    reduced <- merge(reduced, activities)  ## Merge them in
    reduced$activity <- NULL ## Drop the activity column
    
    ## 4. Appropriately labels the data set with descriptive variable names
    ## This has been mostly done above
    ## We'll remove the parens and dashes and camel case the function names
    names(reduced) <- sub("-mean()", "Mean", names(reduced))
    names(reduced) <- sub("-std()", "Std", names(reduced))
    names(reduced) <- gsub("\\(|\\)|\\-", "", names(reduced))
    
    ## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    tidy <- ddply(reduced, .(subject, activityLabel), numcolwise(mean))
}