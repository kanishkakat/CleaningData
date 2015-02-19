This repository contains solution for the Course Project Assignment for Cleaning Data

========================================================================================================
run_analysis.R is the script which performs the functionality as stated in the requirements below:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The script contains seven functions which are interlinked. 
1.RunAnalysis      : This is the main function and it needs to be called to invoke the entire functionality
2.MergeData        : This function merges the activity and subject to the test/train data
3.FilterData       : Filter the data columns for mean() and std()
4.ActivityName     : Add descriptive activity label in place of activity ID
5.CleanLabel       : Clean the label names with more descritive and meaningful labels
6.AverageActivity  : Average out the activity readings on basis of subject and activity
7.FormatWords      : Formats the words

-------------------------------------------------------------------------------------------------------
RunAnalysis()
Input Parameter 	: None
Output Parameter 	: None
Algorithm:
Invoke the function MergeData for test and train data sets
Merge the data sets returned by MergeData function
Invoke the function FilterData to filter the columns on basis of mean and standard deviation
Add descriptive label for activity using the function ActivityName
Invoke CleanLabels to make the column names more readible and descriptive
Invoke function AverageActivity to get the averages on basis of activity and subject for each readings
Write the finally created data set to a text file called Tidy_Data.txt
-------------------------------------------------------------------------------------------------------
MergeData()
Input Parameter		: Path, Type(train/test)
Output Parameter	: Merged Data Set for train/test
Algorithm:
Create the path for reading the activitiy readings
Read the data set as specified in input parameter (train/test)
Get the column names from the file features.txt
Assign column names to the data set
Read the subjects data and assign column name
Read the activity data and assign the column name
Merge the subject, activity and the activity readings
Return the merged data set
--------------------------------------------------------------------------------------------------------
FilterData()
Input Parameter		: Merged Data Set, Filter keyword1, Filter keyword2
Output Parameter	: Filtered Data Set
Algorithm:
Retrieve the column names of the input data set
Prepare the input filtering criteria
Get the indexes for the filtered columns identified
Add the subject and activity index to the filtered indexes
Filter the data set based on filtered index
Return the filtered data set
---------------------------------------------------------------------------------------------------------
ActivityName()
Input Parameter		: Filtered Data Set
Output Parameter	: Data Set with Activity Labels
Algorithm:
Read the activity labels file
Clean the activity label using the function FormatWords
Create activity label for the input Filtered Data Set
Replace the activity ID withe activity label in the Filtered Data Set
Return the Data Set with Activity Labels
----------------------------------------------------------------------------------------------------------
CleanLabels()
Input Parameter		: Data Set Labels
Output	Parameter	: Clean Data Set Labels
Algorithm:
Remove "()" from the column names
Capitalize M in "mean"
Capitalize S in "std"
Remove "-" from the column names
Return clean data set labels
----------------------------------------------------------------------------------------------------------
AverageActivity()
Input Parameter		: Data Set
Output Parameter	: Data Set with Averages
Algorithm:
Aggregate the data set on basis of subject and activity for mean, one column at a time
Repeat the activity for each column and keep it merging to the data set
Assign column names
Return the Data Set with Averages
----------------------------------------------------------------------------------------------------------
FormatWords()
Input Parameter		: Character String
Output Parameter	: Formatted Character String
Algorithm:
Convert the complete text to lower case
Identify the indexes of the positions requiring capital character
Convert the required positions to capital
Return the converted string
============================================================================================================

CodeBook.md contains the approach followed to fulfill the requirements specified in the assignment. It also list down the key variables used and the purpose.


