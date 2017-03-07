# Getting and Cleaning Data Course Project

## How This Script Works
Run the script ```run_analysis.R``` in the directory containing the following data files
* ```X_train.txt```
* ```X_test.txt```
* ```Y_train.txt```
* ```Y_test.txt```
* ```activity_labels.txt```

It will create the following output files:
* ```data_all.csv```
* ```data_grouped.csv```

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
