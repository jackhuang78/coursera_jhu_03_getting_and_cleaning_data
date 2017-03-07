library(dplyr)

# import and merge X
x.train = read.table('X_train.txt')
x.test = read.table('X_test.txt')
x = rbind(x.train, x.test)

# import and merge Y
y.train = read.table('Y_train.txt')
y.test = read.table('Y_test.txt')
y = rbind(y.train, y.test)

label = read.table('activity_labels.txt')
y.labeled = merge(y, label, by.x='V1', by.y='V1', sort=F)

data.all = data.frame(activity=y.labeled$V2, mean=apply(x, 1, mean), sd=apply(x, 1, sd))

data.grouped = summarize(group_by(data.all, activity), mean=mean(mean), sd=mean(sd))

write.table(data.all, 'data_all.txt', row.names=F)
write.table(data.grouped, 'data_grouped.txt', row.names=F)