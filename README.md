# Getting and Cleaning Data Course Project

## How to Use This Script
Run the script ```run_analysis.R``` in the directory containing the following data files
* ```X_train.txt```
* ```X_test.txt```
* ```Y_train.txt```
* ```Y_test.txt```
* ```activity_labels.txt```

It will create the following output files:
* ```data_all.csv```
* ```data_grouped.csv```

## How This Script Works

Import X_train and X_test with read.table() and merge them with rbind(). Do the same to Y_train and Y_test. (Step 1)
```
x.train = read.table('X_train.txt')
x.test = read.table('X_test.txt')
x = rbind(x.train, x.test)
y.train = read.table('Y_train.txt')
y.test = read.table('Y_test.txt')
y = rbind(y.train, y.test)
```

Get the activity names from activity_labels.txt and merge with Y by each activity's code. (Step 3)
```
label = read.table('activity_labels.txt')
y.labeled = merge(y, label, by.x='V1', by.y='V1', sort=F)
```

Calculate the mean and standard deviation for each measurements. Create a new dataset with appropriate labels. (Step 2 & 4)
```
data.all = data.frame(activity=y.labeled$V2, mean=apply(x, 1, mean), sd=apply(x, 1, sd))
```

Use dplyr library to calculate the average mean and standard devation for each activity. (Step 5)
```
library(dplyr)
data.grouped = summarize(group_by(data.all, activity), mean=mean(mean), sd=mean(sd))
```
Output the results.
```
write.table(data.all, 'data_all.txt', row.names=F)
write.table(data.grouped, 'data_grouped.txt', row.names=F)
```



## Codebook
### data_all.txt
This dataset contains the smartphone measurement for various sample of activities. The file is a space-delimited text file containing 3 column

1. **activity**: factor; the activity for which the measurement is taken; can be one of WALKING, WALKING_UPSTAIR, WALKING_DOWNSTAIN, SITTING, STANDING, and LAYING
2. **mean**: numeric; mean of the smartphone measurement of the activity
3. **sd**: numeric; standard deviation of the smartphone measurement of the activity

### data_grouped.txt
This dataset contains the average smartphone measurement for each activity. The file is a space-delimited text file containing 3 columns:

1. **activity**: factor; the activity for which the average measurement is calculated; can be one of WALKING, WALKING_UPSTAIR, WALKING_DOWNSTAIN, SITTING, STANDING, and LAYING
2. **mean**: numeric; average mean of the smartphone measurement for that activity
3. **sd**: numeric; average standard deviation of the smartphone measurement for that activity
