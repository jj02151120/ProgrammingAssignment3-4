setwd('C:\\Users\\kudos\\Dropbox\\course\\Coursera\\JHU_Data Science Foundation using R\\Class3_week4\\programming assignment git\\ProgrammingAssignment3-4')

dataTrainingX <- read.table('.\\data\\UCI HAR Dataset\\train\\X_train.txt')
dataTrainingY <- read.table('.\\data\\UCI HAR Dataset\\train\\Y_train.txt')
dataTestX <- read.table('.\\data\\UCI HAR Dataset\\test\\X_test.txt')
dataTestY <- read.table('.\\data\\UCI HAR Dataset\\test\\Y_test.txt')


## 1: Merges the training and the test sets to create one data set.
dataX <- rbind(dataTrainingX, dataTestX)
dataY <- rbind(dataTrainingY, dataTestY)
dataMerged <- cbind(dataX, dataY)
write.csv(dataX,'.\\01_mergedDataX.csv')
write.csv(dataY,'.\\01_mergedDataY.csv')
write.csv(dataMerged,'.\\01_mergedData.csv')

## 2: Extracts the mean and standard deviation for each measurement.
features <- read.table('.\\data\\UCI HAR Dataset\\features.txt')$V2
extractFeatures <- grep('mean|std', features)
dataExtracted <- dataX[,extractFeatures]
write.csv(dataExtracted,'.\\02_extractedData.csv')

## 3: Uses descriptive activity names to name the activities in the data set
descritiveName <- read.table('.\\data\\UCI HAR Dataset\\activity_labels.txt')$V2
descritiveActivity <- factor(dataY$V1, labels=descritiveName)
activityNamedData <- cbind(dataExtracted, descritiveActivity)
write.csv(activityNamedData,'.\\03_activityNamedData.csv')

## 4: Appropriately labels the data set with descriptive variable names.
datasetFinal <- setNames(activityNamedData, c(features[extractFeatures],'descritiveActivity'))
datasetFinal
write.csv(datasetFinal,'.\\04_datasetFinal.csv')

## 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)
#datasetFinal <- cbind(dataExtractedWithDescriptiveName, descritiveActivity)
names(datasetFinal)
g <- group_by(datasetFinal, descritiveActivity)
k <- summarize_all(g, mean)
newVariableName <- paste(names(k), rep(c('--mean'), each=ncol(datasetFinal)), sep='')
k <- setNames(k, newVariableName)
write.csv(k, '.\\05_summary.csv')
write.table(k, '.\\05_summary.txt', row.name=FALSE)


