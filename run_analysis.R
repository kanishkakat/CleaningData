## Programmer       : Kanishka Kartikeya
## Date             : 18-Feb-15
#############################################################################################
## This script contains following functions:
## RunAnalysis      : This is the main function and it needs to be called to invoke 
##                    the entire functionality
## MergeData        : This function merges the activity and subject to the test/train data
## FilterData       : Filter the data columns for mean() and std()
## ActivityName     : Add descriptive activity label in place of activity ID
## CleanLabel       : Clean the label names with more descritive and meaningful labels
## AverageActivity  : Average out the activity readings on basis of subject and activity
## FormatWords      : Formats the words
#############################################################################################

## This is the main function of this script which binds the complete functionality
## Uses the functions for each of the steps provided in the assignment
## Writes the tidy data to a text file 
## Don't forget to set the working directory containing the data before using this script
## Use RunAnalysis() to invoke the program
RunAnalysis <- function(){
  ## Format the test data set
  TestData <- MergeData("./data/test", "test")
  ## Format the train data set
  TrainData <- MergeData("./data/train", "train")
  ## Merge the train and test data sets
  JoinData <- rbind(TestData, TrainData)
  JoinData <- as.data.frame(JoinData)
  ## Filter the columns on basis of mean and standard deviation
  JoinData <- FilterData(JoinData, "mean", "std")
  ## Add descrptive activity name in place of activity code
  JoinData <- ActivityName(JoinData)
  ## Clean the column names to make it more descriptive
  colnames(JoinData) <- CleanLabels( colnames(JoinData))
  ## Calculate averages on basis of activity and subject for each readings
  TidyData <- AverageActivity(JoinData)
  ## Write the finally created data set to a text file without column heading
  write.table(TidyData, "Tidy_Data.txt")
}

## Step1: This function performs step one of the assignment. 
## Accepts Data Path and Type (train or test) and would be called twice for test and train
## Merges the activity, subject and test/train (activity readings) data for test/train
## Returns the merged data set for train/test
MergeData <- function(DataPath, Type) {
  ## Create the path for readings of activities
  Path <- paste(DataPath, "/X_", Type, ".txt", sep = "")
  Data <- read.table(Path) 
  Data <- as.data.frame(Data)
  ## Retrieve the column names for the readings 
  Label <- read.table("./data/features.txt") 
  Label <- as.vector(Label[,2])
  colnames(Data) <- c(Label)
  ## Create the path for the subject
  Path <- paste(DataPath, "/subject_", Type, ".txt", sep = "")
  Subject <- read.table(Path) 
  colnames(Subject) <- c("Subject ID")
  ## Create the path for activity
  Path <- paste(DataPath, "/y_", Type, ".txt", sep = "")
  Activity <- read.table(Path) 
  colnames(Activity) <- c("Activity")
  ## Merge the activity, subject and readings with column description
  Data <- cbind(Subject,Activity, Data)
  return(Data)
}

## Step2: This function performs step two of the assignment
## Accepts the merged data and filter parameters 'mean' and 'standard deviation'
## Filters the columns for mean and standard deviation
## Returns the filtered columns for mean and standard deviation
FilterData <- function(Input, Filter1, Filter2) {
  ## Get the column names of the data set
  Col <- colnames(Input)
  ## Prepare filtering criteria "mean()|std()" in this case
  filter <- paste(Filter1,"\\(\\)|", Filter2, "\\(\\)", sep = "")
  ## Get the column index of matching columns
  ColIdx <- grep(filter, Col, fixed=FALSE)
  ## Add the subject and activity columns to the column index
  ColIdx <- c(1,2,ColIdx)
  ## Filter out the required columns
  Input <- Input[,ColIdx]
  return(Input)
}

## Step3: This function performs step three of the assignment
## Accepts the data set as input parameter
## Adds descriptive labels for the activities performed by each subject
## Returns the data set with descriptive activity names
ActivityName <- function(Input){
  ## Read the activity file
  Activity <- read.table("./data/activity_labels.txt") 
  ## Format the activity description
  Activity[,2] <- tolower(gsub("_", " ", Activity[, 2]))
  for (i in 1:nrow(Activity)){ 
    Activity[i,2] <- FormatWords(Activity[i,2])
  }
  ## Create the activity label for the complete data set using activity file
  ActivityLabel <- Activity[Input[, 2], 2] 
  ## Modify activity IDs to activities label in the data set
  Input[, 2] <- ActivityLabel
  return(Input)
}

## Step4: This function performs step four of the assignment
## Accepts column names as input parameter
## Cleans the labels by removing special characters and making them meaningful
## Returns the cleaned labels
CleanLabels <- function(Input){
  Input <- gsub("\\(\\)", "", Input)    # remove "()" 
  Input <- gsub("mean", "Mean", Input)  # capitalize M 
  Input <- gsub("std", "Std", Input)    # capitalize S 
  Input <- gsub("-", "", Input)         # remove "-" in column names
  return(Input)
}

## Step5: This function performs the step five of the assignment
## Accepts the data set as input parameter
## Calculates the means average of each variable for each activity and each subject
## Combines all the averages into a data set
## Returns the data set
AverageActivity <- function(Input){
  ## Start from column three as first two columns are subject and activity
  for (i in 3:ncol(Input)){ 
    if (i == 3){
      ## Store the first three columns first time
      TidyData <- aggregate(Input[,i] ~ Input[,1] + Input[,2], data = Input, mean)
    }
    else{
      ## Add additional columns for each variable
      TidyData <- cbind(TidyData,aggregate(Input[,i] ~ Input[,1] + Input[,2], data = Input, mean)[,3])
    }
  }
  ## Add column Names
  colnames(TidyData) <- colnames(Input)
  return(TidyData)
}

## This function is used for formatting text called in Step Three
## Accepts character string as input parameter
## Formats the string for first charcter of the first word and word after spaces to caps
FormatWords <- function(txt){
  txt <- tolower(txt)
  theletters <- strsplit(txt,'')[[1]]
  wh <- c(1,which(theletters  == ' ') + 1)
  theletters[wh] <- toupper(theletters[wh])
  paste(theletters,collapse='')
}
