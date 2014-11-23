# read the X_test and X_train data sets into R
XtestData <- read.table("courseProjectDataset/test/X_test.txt")
XtrainData <- read.table("courseProjectDataset/train/X_train.txt")
#read test and train subject data into R
testSubjectData <- read.table("courseProjectDataset/test/subject_test.txt")
trainSubjectData <- read.table("courseProjectDataset/train/subject_train.txt")
#read test and train activity data into R
testActivityData <- read.table("courseProjectDataset/test/y_test.txt")
trainActivityData <- read.table("courseProjectDataset/train/y_train.txt")
#change the column names of the test and train subject and activity data.
names(testSubjectData) <- "Subject"
names(trainSubjectData) <- "Subject"
names(testActivityData) <- "Activity"
names(trainActivityData) <- "Activity"
#add the subject and activity data to their corresponding datasets
XtestData <- cbind(XtestData, c(testSubjectData, testActivityData))
XtrainData <- cbind(XtrainData, c(trainSubjectData, trainActivityData))
#merge the train and test datasets
mergedData <- rbind(XtrainData, XtestData)
#extract mean and standard deviation for each measurement
meanStdData <- mergedData[, c(1:6, 42:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:428, 503:504, 516:517, 529:530, 542:543, 562:563)]
#name the activities in teh dataset according to their value labels
meanStdData$Activity[meanStdData$Activity == 1] <- "Walking"
meanStdData$Activity[meanStdData$Activity == 2] <- "Walk_Upstairs"
meanStdData$Activity[meanStdData$Activity == 3] <- "Walk_Downstairs"
meanStdData$Activity[meanStdData$Activity == 4] <- "Sitting"
meanStdData$Activity[meanStdData$Activity == 5] <- "Standing"
meanStdData$Activity[meanStdData$Activity == 6] <- "Laying"
#label data with descriptive variable names
names(meanStdData) <- c("MeanX_tBdyAcc", "MeanY_tBdyAcc", "MeanZ_tBdyAcc", "SDX_tBdyAcc", "SDY_tBdyAcc", "SDZ_tBdyAcc", "MeanX_tGrvtAcc", "MeanY_tGrvtAcc", "MeanZ_tGrvtAcc", "SDX_tGrvtAcc", "SDY_tGrvtAcc", "SDZ_tGrvtAcc", "MeanX_tBdyAccJrk", "MeanY_tBdyAccJrk", "MeanZ_tBdyAccJrk", "SDX_tBdyAccJrk", "SDY_tBdyAccJrk", "SDZ_tBdyAccJrk", "MeanX_tBdyGyr", "MeanY_tBdyGyr", "MeanZ_tBdyGyr", "SDX_tBdyGyr", "SDY_tBdyGyr", "SDZ_tBdyGyr", "MeanX_tBdyGyrJrk", "MeanY_tBdyGyrJrk", "MeanZ_tBdyGyrJrk", "SDX_tBdyGyrJrk_", "SDY_tBdyGyrJrk_", "SDZ_tBdyGyrJrk", "Mean_tBdyAccMag", "SD_tBdyAccMag", "Mean_tGrvtAccMag", "SD_tGrvtAccMag", "Mean_tBdyAccJrkMag", "SD_tBdyAccJrkMag", "Mean_tBdyGyrMag", "SD_tBdyGyrMag", "Mean_tBdyGyrJrkMag", "SD_tBdyGyrJrkMag", "MeanX_fBdyAcc", "MeanY_fBdyAcc", "MeanZ_fBdyAcc", "SDX_fBdyAcc", "SDY_fBdyAcc", "SDZ_fBdyAcc", "MeanX_fBdyAccJrk", "MeanY_fBdyAccJrk", "MeanZ_fBdyAccJrk", "SDX_fBdyAccJrk", "SDY_fBdyAccJrk", "SDZ_fBdyAccJrk", "MeanX_fBdyGyr", "MeanY_fBdyGyr", "MeanZ_fBdyGyr", "SDX_fBdyGyr", "SDY_fBdyGyr", "SDZ_fBdyGyr", "Mean_fBdyAccMag", "SD_fBdyAccMag", "Mean_fBdyAccJrkMag", "SD_fBdyAccJrkMag", "Mean_fBdyAccGyrMag", "SD_fBdyAccGyrMag", "Mean_fBdyAccGyrJrkMag", "SD_fBdyAccGyrJrkMag", "Subject", "Activity")
#change into a data.table
meanStdDT <- data.table(meanStdData)
#create a list along Subjects (i.e. each element of list represents all the data from a single subject) 
meanStdList <-split(meanStdDT, meanStdDT$Subject)
#find the mean values for every activity
finMeanList <- lapply(meanStdList, function(x) x[, list(Subject=mean(Subject), MeanX_tBdyAcc=mean(MeanX_tBdyAcc), MeanY_tBdyAcc=mean(MeanY_tBdyAcc), MeanZ_tBdyAcc=mean(MeanZ_tBdyAcc), SDX_tBdyAcc=mean(SDX_tBdyAcc), SDY_tBdyAcc=mean(SDY_tBdyAcc), SDZ_tBdyAcc=mean(SDZ_tBdyAcc), MeanX_tGrvtAcc=mean(MeanX_tGrvtAcc), MeanY_tGrvtAcc=mean(MeanY_tGrvtAcc), MeanZ_tGrvtAcc=mean(MeanZ_tGrvtAcc), SDX_tGrvtAcc=mean(SDX_tGrvtAcc), SDY_tGrvtAcc=mean(SDY_tGrvtAcc), SDZ_tGrvtAcc=mean(SDZ_tGrvtAcc), MeanX_tBdyAccJrk=mean(MeanX_tBdyAccJrk), MeanY_tBdyAccJrk=mean(MeanY_tBdyAccJrk), MeanZ_tBdyAccJrk=mean(MeanZ_tBdyAccJrk), SDX_tBdyAccJrk=mean(SDX_tBdyAccJrk), SDY_tBdyAccJrk=mean(SDY_tBdyAccJrk), SDZ_tBdyAccJrk=mean(SDZ_tBdyAccJrk), MeanX_tBdyGyr=mean(MeanX_tBdyGyr), MeanY_tBdyGyr=mean(MeanY_tBdyGyr), MeanZ_tBdyGyr=mean(MeanZ_tBdyGyr), SDX_tBdyGyr=mean(SDX_tBdyGyr), SDY_tBdyGyr=mean(SDY_tBdyGyr), SDZ_tBdyGyr=mean(SDZ_tBdyGyr), MeanX_tBdyGyrJrk=mean(MeanX_tBdyGyrJrk), MeanY_tBdyGyrJrk=mean(MeanY_tBdyGyrJrk), MeanZ_tBdyGyrJrk=mean(MeanZ_tBdyGyrJrk), SDX_tBdyGyrJrk=mean(SDX_tBdyGyrJrk_), SDY_tBdyGyrJrk=mean(SDY_tBdyGyrJrk_), SDZ_tBdyGyrJrk=mean(SDZ_tBdyGyrJrk), Mean_tBdyAccMag=mean(Mean_tBdyAccMag), SD_tBdyAccMag=mean(SD_tBdyAccMag), Mean_tGrvtAccMag=mean(Mean_tGrvtAccMag), SD_tGrvtAccMag=mean(SD_tGrvtAccMag), Mean_tBdyAccJrkMag=mean(Mean_tBdyAccJrkMag), SD_tBdyAccJrkMag=mean(SD_tBdyAccJrkMag), Mean_tBdyGyrMag=mean(Mean_tBdyGyrMag), SD_tBdyGyrMag=mean(SD_tBdyGyrMag), Mean_tBdyGyrJrkMag=mean(Mean_tBdyGyrJrkMag), SD_tBdyGyrJrkMag=mean(SD_tBdyGyrJrkMag), MeanX_fBdyAcc=mean(MeanX_fBdyAcc), MeanY_fBdyAcc=mean(MeanY_fBdyAcc), MeanZ_fBdyAcc=mean(MeanZ_fBdyAcc), SDX_fBdyAcc=mean(SDX_fBdyAcc), SDY_fBdyAcc=mean(SDY_fBdyAcc), SDZ_fBdyAcc=mean(SDZ_fBdyAcc), MeanX_fBdyAccJrk=mean(MeanX_fBdyAccJrk), MeanY_fBdyAccJrk=mean(MeanY_fBdyAccJrk), MeanZ_fBdyAccJrk=mean(MeanZ_fBdyAccJrk), SDX_fBdyAccJrk=mean(SDX_fBdyAccJrk), SDY_fBdyAccJrk=mean(SDY_fBdyAccJrk), SDZ_fBdyAccJrk=mean(SDZ_fBdyAccJrk), MeanX_fBdyGyr=mean(MeanX_fBdyGyr), MeanY_fBdyGyr=mean(MeanY_fBdyGyr), MeanZ_fBdyGyr=mean(MeanZ_fBdyGyr), SDX_fBdyGyr=mean(SDX_fBdyGyr), SDY_fBdyGyr=mean(SDY_fBdyGyr), SDZ_fBdyGyr=mean(SDZ_fBdyGyr), Mean_fBdyAccMag=mean(Mean_fBdyAccMag), SD_fBdyAccMag=mean(SD_fBdyAccMag), Mean_fBdyAccJrkMag=mean(Mean_fBdyAccJrkMag), SD_fBdyAccJrkMag=mean(SD_fBdyAccJrkMag), Mean_fBdyAccGyrMag=mean(Mean_fBdyAccGyrMag), SD_fBdyAccGyrMag=mean(SD_fBdyAccGyrMag), Mean_fBdyAccGyrJrkMag=mean(Mean_fBdyAccGyrJrkMag), SD_fBdyAccGyrJrkMag=mean(SD_fBdyAccGyrJrkMag)), by = Activity])
#combine all the elements in the list created above back into a data table
finFrameDT <- rbindlist(finMeanList, use.names=T)