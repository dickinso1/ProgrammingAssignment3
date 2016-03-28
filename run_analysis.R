library(tidyr)
library(dplyr)
library(tidyr)

## Read in activity variable name file and descriptive feature file.
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

## Read in Test Files
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)

## Read in Train Files
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)

## Merge Test and Training Files to create one data set
subject <- rbind(subject_test, subject_train)
activity <- rbind(y_test, y_train)
featuresdata <- rbind(X_test, X_train)

## Name the variables
names(subject) <- c("subject")
names(activity) <- c("activity")
names(featuresdata) <- features$V2

## Select only the mean and standard deviation columns from featuresdata
names(featuresdata) <- gsub("-", "", names(featuresdata))
names(featuresdata) <- gsub(",", "", names(featuresdata))
names(featuresdata) <- make.names(names=names(featuresdata), unique = TRUE, allow_ = TRUE)
featuresdata <- select(featuresdata, grep("mean\\.\\.", names(featuresdata)), grep("stdmean\\.\\.", names(featuresdata)))
names(featuresdata) <- gsub("\\.\\.", "", names(featuresdata))

## Combine all data into one table
dataCombine <- cbind(subject, activity, featuresdata)


## Change activity coded numbers to labels defined in activity_labels.txt file
dataCombine$activity <- factor(dataCombine$activity, labels = activity_labels$V2)

## Make descriptive variable names
names(dataCombine)<-gsub("^t", "time", names(dataCombine))
names(dataCombine)<-gsub("^f", "frequency", names(dataCombine))
names(dataCombine)<-gsub("Acc", "Accelerometer", names(dataCombine))
names(dataCombine)<-gsub("Gyro", "Gyroscope", names(dataCombine))
names(dataCombine)<-gsub("Mag", "Magnitude", names(dataCombine))
names(dataCombine)<-gsub("BodyBody", "Body", names(dataCombine))

## Sort order by subject and activity
dataCombine <- arrange(dataCombine, subject, activity)

## Create independent data set with the average of each variable for each activity and each subject
tidydataset <- group_by(dataCombine, subject, activity)
datasummary <- summarize_each(tidydataset, funs(mean))
write.table(datasummary, file = "./UCI HAR Dataset/tidydataset.txt", row.names = FALSE)