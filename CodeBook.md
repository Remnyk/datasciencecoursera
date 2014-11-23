---
title: "run_analysis.R CodeBook"

---
I unzipped the data in a directory called courseProjectDataset inside my working directory.

```XtestData``` is the variable that contains X test data.
```XtrainData``` is the variable that contains X train data.
```testSubjectData``` variable has data from subject_test.txt.
```trainSubjectData``` variable has data from subject_train.txt.
```testActivityData``` variable has the data from y_test.txt.
```trainActivityData``` variable has the data from y_train.txt.
```mergedData``` is the combined XtestData and XtrainData.
```meanStdData``` is a data frame with only mean and standard deviation columns from ```mergedData```.
```meanStdDT``` is a data table with the same data as ```meanStdData```.
```meanStdList`` is a list of data tables sorted according to "Subject" column. Each element contains a data table for a single subject.
```finMeanList``` is a list of data tables, where each subject data table contains records showing the average feature values for every activity. Each row in a data table contains mean values for a single activity.
```finFrameDT``` is the final data table from the combined data tables in finMeanList. Each row contains mean values for each activity for each subject.

To obtain ```XtestData```, I used ```cbind()``` to merge data from the X test .txt with ```testSubjectData``` and ```testActivityData``` . Similarly, for full ```XtrainData``` I used ```cbind()``` to merge data from the X train .txt file with ```trainSubjectData``` and ```trainActivityData```.

For ```mergedData```, I used ```rbind()``` with  ```XtestData``` and ```XtrainData```. I did a subset of all columns of ```mergedData``` which conatined mean and standard deviation data to get ```meanStdData```. I used a text editor during this process, mainly to match the correct columnn numbers.

To isolate data for each subject, I used ```split()``` on ```meanStdDT``` with "subject" as an index to create the list ```meanStdList```. I then calculated the mean of columns in each element of ```meanStdList``` using "Activity" as an index to get ```finMeanList```. Finally I used ```rbindlist()``` to concatenate ```finMeanList``` into the final data frame containg my tidy data.