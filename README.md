# ProgrammingAssignmentC3WK4

## Getting & Cleaning Data - Course Project

The R Script run_analysis.R file does the following processes:

* Sets the working directory where the R file along with the data would be stored
* Downloads the dataset zip folder if it doesnt already exist
* Unzips the folder into "UCI HAR Dataset" if it doesnt already exist
* Obtains the activity labels from UCI HAR Dataset/activity_labels.txt
* Obtains the features from UCI HAR Dataset/features.txt
* Creates a featuresWanted.names character vector that consists of only mean/std related measurements along with cleaning up the labels to remove
  * []
  * ()
  * -
  * substitutes mean to MEAN
  * substitutes std to STD 
* Reads the following training data files from UCI HAR Dataset/train and column binds them into data frame called "train"
  * X_train.txt - measurements related to featuresWanted.names are only extracted
  * y_train.txt
  * subject_train.txt
* Reads the following test data files from UCI HAR Dataset/test and column binds them into data frame called "test"
  * X_test.txt - measurements related to featuresWanted.names are only extracted
  * y_test.txt
  * subject_test.txt
* After ensuring that both the data frames have same number of columns, the two data frames are merged into "allData" frame
* The allData is then melted to create a new data frame that has subject, activity & all the measurements under 'variable' column   and the corresponding values under 'value' column - pivot table
* Using the dcast function, create a second, independent tidy data set with the average of each variable for each activity and each subject.
