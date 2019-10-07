# read data in
X_train <- read.table("train/X_train.txt")
Y_train <- read.table("train/Y_train.txt")
Sub_train <- read.table("train/subject_train.txt")
X_test <- read.table("test/X_test.txt")
Y_test <- read.table("test/Y_test.txt")
Sub_test <- read.table("test/subject_test.txt")
variable_names <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# merge the data sets
X <- rbind(X_train, X_test)
Y <- rbind(Y_train, Y_test)
sub_all <- rbind(Sub_train, Sub_test)

# extracts the mean and standard deviation
selected_var <- variable_names[grep("mean\\(\\)|std\\(\\)",variable_names[,2]),]
X <- X[,selected_var[,1]]

# uses activity names to name the activities in the data set
colnames(Y) <- "activity"
Y$activitylabel <- factor(Y$activity, labels = as.character(activity_labels[,2]))
activitylabel <- Y[,-1]

# labels the data set with descriptive variable names
colnames(X) <- variable_names[selected_var[,1],2]

# creates a seperate tidy data set
colnames(sub_all) <- "subject"
combine <- cbind(X, activitylabel, sub_all)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))

# write final tidy data
write.table(total_mean, file = "tidydata.txt", row.names = FALSE, col.names = TRUE)
