Getting-and-Cleaning-Data
=========================
The R-code in this repository reads the 'Human Activity Recognition Using Smartphones Data Set'.
The original source of the data set is https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

##The R-script
The script `run_analysis.R`:
1. Merges the training and test sets to create one data set.
 
2. Reads the file `features.txt` and only uses the measurements on the mean and standard deviation for each measurement.

3. Reads the file `activity_labels.txt`.

4. Uses descriptive activity names to name the activities in the data set.

5. Labels the data set with descriptive variable names.

6. Merges the features with activity labels and subject IDs into a tidy data set.

The average of each measurement for each activity and each subject is then put into a second data set. The second tidy data set based on the `tidyData` is saved as `tidyData.txt`.

###Variables
* `testData` - data read from `test/X_test.txt`
* `trainData` - data read from `train/X_train.txt`
* `X_data` - merged data from test and train data sets
* `subTest` - data read from `test/subject_test.txt`
* `subTrain` - data read from `test/subject_train.txt`
* `Subject` - merged subject data, both test and train
* `test_y` - data read from `test/y_test.txt`
* `train_y` - data read from `train/y_train.txt`
* `y` - merged label data, both test and train
* `Features` - data read from `features.txt`
* `Features_sub` - Names for columns derived from the `Features` variable
* `Features_M_SD` - logical vector of which features have to be used in the tidy data set
* `activities` - data read from `activity_labels.txt`. The names are already human readable
* `tidyData` - data requested as requested at the end of step 4
* `subj` - unique subjects from Subject
* `numSub` - number of unique subjects
* `numAct` - number of activities
* `numCol` - number of columns in `tidyData`
* `tidydata` - second tidy data set with average of each variable for each activity and subject

###Output
The output of the script consists in one file `tidyData.txt`. This file contains the definitive data set with the average of each variable for each activity and each subject.
