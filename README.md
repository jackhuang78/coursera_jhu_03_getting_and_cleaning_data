# Getting and Cleaning Data Course Project

## How to Use This Script
Run the script ```run_analysis.R``` in the directory containing the data directory ```UCI HAR Dataset```.
It will create the output file ```combined_average.txt```.

## How This Script Works

Step 1: With ```read.table()``` and ```rbind()```, read in **x**, **y**, and **subject** for training and test data, and combine them.
```
#
# Step 1: Merges the training and the test sets to create one data set.
#
# import and merge X
x.train = read.table('UCI HAR Dataset/train/X_train.txt')
x.test = read.table('UCI HAR Dataset/test/X_test.txt')
x = rbind(x.train, x.test)

# import and merge Y
y.train = read.table('UCI HAR Dataset/train/Y_train.txt')
y.test = read.table('UCI HAR Dataset/test/Y_test.txt')
y = rbind(y.train, y.test)

# improt and merge subject
subject.train = read.table('UCI HAR Dataset/train/subject_train.txt')
subject.test = read.table('UCI HAR Dataset/test/subject_test.txt')
subject = rbind(subject.train, subject.test)
```

Step 2: Read in **features**. Use ```grep``` to look through **features** for varaibles with "mean" or "std" in their names. Extract those columns from **x**.
```
#
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#
features = read.table('UCI HAR Dataset/features.txt')
names(x) = features[,2]
x.extract = x[,grep('([Mm][Ee][Aa][Nn]|[Ss][Tt][Dd])', features[,2])]
```

Step 3: Read in **activity_labels**. Merge it with **y** to match activity names with their coding.
```
#
# Step 3: Uses descriptive activity names to name the activities in the data set
#
label = read.table('UCI HAR Dataset/activity_labels.txt')
y.labeled = merge(y, label, by.x='V1', by.y='V1', sort=F)
```

Step 4: Combine **y** (labeled), **subject** and **x** (extracted). Name each column.
```
#
# Step 4: Appropriately labels the data set with descriptive variable names.
#
combined = cbind(y.labeled$V2, subject, x.extract)
names(combined) = c('activity', 'subject', names(x.extract))
```

Step 5: Using ```group_by``` and ```summarize_each``` from the library ```dplyr```, group all measurements by (activity,subject) and calculate the mean of each.
```
#
# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
library(dplyr)
combined_average = summarize_each(group_by(combined, activity, subject), funs(mean))
write.table(combined_average, 'combined_average.txt', row.names=F)
```

## Codebook for ```combined_average.txt```
This dataset contains the average of various measurements for each (activity,subject) combination. The file is a space-delimited text file containing a total of 88 columns. The first two columns are:

1. **activity**: factor; the activity for which the average measurement is calculated; can be one of WALKING, WALKING_UPSTAIR, WALKING_DOWNSTAIN, SITTING, STANDING, and LAYING
1. **subject**: factor; the subject from whom the data is collected; can be 1, 2, 3, ..., 30

The remaining 86 columns are the mean measurements for each particular (activity, subject) combination, as givne by the first two columns. All these measurements are the either mean or std of some data series collected by the smartphone. They are all numeric data type. Here is a complete list of them:

1. tBodyAcc-mean()-X
1. tBodyAcc-mean()-Y
1. tBodyAcc-mean()-Z
1. tBodyAcc-std()-X
1. tBodyAcc-std()-Y
1. tBodyAcc-std()-Z
1. tGravityAcc-mean()-X
1. tGravityAcc-mean()-Y
1. tGravityAcc-mean()-Z
1. tGravityAcc-std()-X
1. tGravityAcc-std()-Y
1. tGravityAcc-std()-Z
1. tBodyAccJerk-mean()-X
1. tBodyAccJerk-mean()-Y
1. tBodyAccJerk-mean()-Z
1. tBodyAccJerk-std()-X
1. tBodyAccJerk-std()-Y
1. tBodyAccJerk-std()-Z
1. tBodyGyro-mean()-X
1. tBodyGyro-mean()-Y
1. tBodyGyro-mean()-Z
1. tBodyGyro-std()-X
1. tBodyGyro-std()-Y
1. tBodyGyro-std()-Z
1. tBodyGyroJerk-mean()-X
1. tBodyGyroJerk-mean()-Y
1. tBodyGyroJerk-mean()-Z
1. tBodyGyroJerk-std()-X
1. tBodyGyroJerk-std()-Y
1. tBodyGyroJerk-std()-Z
1. tBodyAccMag-mean()
1. tBodyAccMag-std()
1. tGravityAccMag-mean()
1. tGravityAccMag-std()
1. tBodyAccJerkMag-mean()
1. tBodyAccJerkMag-std()
1. tBodyGyroMag-mean()
1. tBodyGyroMag-std()
1. tBodyGyroJerkMag-mean()
1. tBodyGyroJerkMag-std()
1. fBodyAcc-mean()-X
1. fBodyAcc-mean()-Y
1. fBodyAcc-mean()-Z
1. fBodyAcc-std()-X
1. fBodyAcc-std()-Y
1. fBodyAcc-std()-Z
1. fBodyAcc-meanFreq()-X
1. fBodyAcc-meanFreq()-Y
1. fBodyAcc-meanFreq()-Z
1. fBodyAccJerk-mean()-X
1. fBodyAccJerk-mean()-Y
1. fBodyAccJerk-mean()-Z
1. fBodyAccJerk-std()-X
1. fBodyAccJerk-std()-Y
1. fBodyAccJerk-std()-Z
1. fBodyAccJerk-meanFreq()-X
1. fBodyAccJerk-meanFreq()-Y
1. fBodyAccJerk-meanFreq()-Z
1. fBodyGyro-mean()-X
1. fBodyGyro-mean()-Y
1. fBodyGyro-mean()-Z
1. fBodyGyro-std()-X
1. fBodyGyro-std()-Y
1. fBodyGyro-std()-Z
1. fBodyGyro-meanFreq()-X
1. fBodyGyro-meanFreq()-Y
1. fBodyGyro-meanFreq()-Z
1. fBodyAccMag-mean()
1. fBodyAccMag-std()
1. fBodyAccMag-meanFreq()
1. fBodyBodyAccJerkMag-mean()
1. fBodyBodyAccJerkMag-std()
1. fBodyBodyAccJerkMag-meanFreq()
1. fBodyBodyGyroMag-mean()
1. fBodyBodyGyroMag-std()
1. fBodyBodyGyroMag-meanFreq()
1. fBodyBodyGyroJerkMag-mean()
1. fBodyBodyGyroJerkMag-std()
1. fBodyBodyGyroJerkMag-meanFreq()
1. angle(tBodyAccMean,gravity)
1. angle(tBodyAccJerkMean),gravityMean)
1. angle(tBodyGyroMean,gravityMean)
1. angle(tBodyGyroJerkMean,gravityMean)
1. angle(X,gravityMean)
1. angle(Y,gravityMean)
1. angle(Z,gravityMean)
