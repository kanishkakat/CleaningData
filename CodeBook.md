----------------------------------------------
Key Data Sets and Variables 
----------------------------------------------
The script contains seven functions which are interlinked and use various data sets and variables

-----------------------------
1.RunAnalysis()
-----------------------------
1. TestData : Data set for test subject, activity and estimated readings merged.
2. TrainData : Data set for training subject, activity and estimated readings merged.
3. JoinData : Training and test data merged together in this data set
4. TidyData : The final output, the tidy data set
5. Tidy_Data.txt : The output file to which tidy data set is written to

-------------------------------
2.MergeData()
-------------------------------
1. DataPath : The input parameter containing path for test/train data files
2. Type : Type specifies if it is for test or train
3. Path : Creates the full path for test/train files
4. Data : Contains the estimated reading after reading the test/train files
5. Label : Contains the labels for the estimated readings from features file
6. Subject: Contans the subject IDs for the estimated readings
7. Activity: Contains the activity IDs for estimated readings
 
---------------------------------
3. FilterData()
---------------------------------
1. Input : Input parameter data set containing merged data set
2. Filter1: Contains filtering criteria "mean" in this case
3. Filter2: Another filtering criteria "std" in this case
4. Col : Column names in input file
5. filter: Contains filtering condition using Filter1 and Filter2
6. ColIdx: Contains all the filtered column indexes
  
-----------------------------------
4. ActivityName()
-----------------------------------
1. Input: Input parameter data set containing filtered data set
2. Activity: Containing activity IDs along with activities description

------------------------------------
5. CleanLabels()
------------------------------------
1. Input : Input parameter containing the filtered data set labels

-------------------------------------
6. AverageActivity()
-------------------------------------
1. Input : Contains the filtered data set
2. TidyData:The final output, the tidy data set
 
--------------------------------------
7. FormatWords()
--------------------------------------
1. txt: The input text string which has to be formatted
2. theletters : Contains all the letters in the text string
3. wh: the index of first alphabet of the letter
 

------------------------
Uderstanding the Data
------------------------
Before proceeding with the course project, it is very important to understand the data we have been provided with. 
1. The experiments have been carried out with a group of 30 volunteers out of which 30% were selected for test data and 70% for training data. This means 9 volunteers were observed for test data and 21 for training data.
2. activity_labels.txt (6Rows, 2Columns).
	This text file contains the list of activities which was performed by the volunteers along with the corresponding activity code. This file contains six activities performed with their respective codes from one to six.
3. features.txt (561Rows, 2Columns).
	The reading from the accelerometer and gyroscope od Samsug Galaxy SII was captured and estimated variables like mean, standard deviation, correlation, skewness etc. was created for each reading category in direction x,y and z. For each of these estimated variables from the readings, the column label/description is stored in this file.
4. X_train.txt (7352Rows, 561Columns).
	This file contains the actual data for the labels stored in the file features.txt for training volunteers.
5. y_train.txt (7352Rows, 1Column).
	This file contains the activity code against each observation in file X_train.txt for training volunteers.
6. subject_train.txt (7352Rows, 1Column).
	This file contains the training volunteer's number against each observation in file X_train.txt.
7. X_test.txt (2947Rows, 561Columns).
	This file contains the actual data for the labels stored in the file features.txt for test volunteers.
8. y_test.txt (2947Rows, 1Column).
	This file contains the activity code against each observation in file X_train.txt for test volunteers.
9. subject_test.txt (2947Rows, 1Column).
	This file contains the test volunteer's number against each observation in file X_train.txt.	

---------------------------------------------------------
The things which needs to be observed before proceeding:
---------------------------------------------------------
1. The files X_train.txt, y_train.txt and subject_train.txt can be merged together by binding the columns. This would make the data meaningful as it would now contain the details of volunteers, activity performed and the estimated readings.
2. The data could be made more meaningful by putting the description of activities from file activity_labels.txt using the data from file y_train.txt.
3. The column headings for the estimated readings could be taken from file features.txt.
4. The above three steps can be repeated for test data as well and can then be merged with training data.

--------------------------------
Approach to the requirement
--------------------------------
Lets move on to the implementation part by creating code in R:
You should create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
	a) Read X_train.txt file into a variable
	b) Assign label to that variable using the file features.txt
	c) Add volunteer details by using file subject_train.txt 
	d) Add activity number using files y_train.txt
	c) Repeat the above steps for test data as well
	e) Merge the training and test data
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	a) Use the data created from step 1
	b) Identify the columns containing mean() and std() to filer out the records further
	c) Retain only data for each of the columns identified in step2
3. Uses descriptive activity names to name the activities in the data set
	a) Add label to the activity codes using file activity_labels.txt
	b) The file activity_labels.txt can be easily joined to the file created in step 2 using activity code
4. Appropriately labels the data set with descriptive variable names. 
	a) Clean the column heading of the report by removing special character
	b) Perform the same operaion on activity labels as well
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	a) Create a seperate file using write.table() 
