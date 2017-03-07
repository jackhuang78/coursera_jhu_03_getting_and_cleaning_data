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

#
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
#
features = read.table('UCI HAR Dataset/features.txt')
names(x) = features[,2]
x.extract = x[,grep('([Mm][Ee][Aa][Nn]|[Ss][Tt][Dd])', features[,2])]

#
# Step 3: Uses descriptive activity names to name the activities in the data set
#
label = read.table('UCI HAR Dataset/activity_labels.txt')
y.labeled = merge(y, label, by.x='V1', by.y='V1', sort=F)

#
# Step 4: Appropriately labels the data set with descriptive variable names.
#
combined = cbind(y.labeled$V2, subject, x.extract)
names(combined) = c('activity', 'subject', names(x.extract))

#
# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
library(dplyr)
combined_average = summarize_each(group_by(combined, activity, subject), funs(mean))
write.table(combined_average, 'combined_average.txt', row.names=F)