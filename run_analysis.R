library(dplyr)

# import and merge X
x.train = read.table('X_train.txt')
x.test = read.table('X_test.txt')
x = rbind(x.train, x.test)

# import and merge Y
y.train = read.table('Y_train.txt')
y.test = read.table('Y_test.txt')
y = rbind(y.train, y.test)

# improt and merge subject
subject.train = read.table('subject_train.txt')
subject.test = read.table('subject_test.txt')
subject = rbind(subject.train, subject.test)

label = read.table('activity_labels.txt')
y.labeled = merge(y, label, by.x='V1', by.y='V1', sort=F)

data.all = data.frame(activity=y.labeled$V2, subject=subject$V1, mean=apply(x, 1, mean), sd=apply(x, 1, sd))
write.table(data.all, 'data.all', row.names=F)

data.average = summarize(group_by(data.all, activity, subject), mean=mean(mean), sd=mean(sd))
write.table(data.average, 'data_average.txt', row.names=F)