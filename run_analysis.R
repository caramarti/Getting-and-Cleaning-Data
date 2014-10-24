### Read and merge the training and test sets to create one data set
## Read the X data sets and combine them
testData <- read.table('test/X_test.txt')
trainData <- read.table('train/X_train.txt')
X_data <- rbind(testData, trainData)

## Read the Subject data sets and combine them
subTest <- read.table('test/subject_test.txt')
subTrain <- read.table('train/subject_train.txt')
Subject <- rbind(subTest, subTrain)
colnames(Subject)[1] <- 'Subject'

## Read the y data sets and combine them
test_y <- read.table('test/y_test.txt')
train_y <- read.table('train/y_train.txt')
y <- rbind(test_y, train_y)
colnames(y)[1] <- 'Activity'

## Remove unused variables
rm(testData, trainData, subTest, subTrain, test_y, train_y)

### Read features file
Features <- read.table('features.txt')

#Get the names from the features and keep only standard deviation and mean
Features_sub <- Features$V2
Features_M_SD <- grepl('(std|mean[^F])', Features_sub, perl=TRUE)

#Keep only needed data
X_data <- X_data[,Features_M_SD]
names(X_data) <- Features_sub[Features_M_SD]
names(X_data)<-gsub('\\(|\\)', '', names(X_data)) #removed brackets from the names of the columns

##Read activity list to get the activity names to add to the data set
activities <- read.table('activity_labels.txt')
activities[,2] = gsub("_", "", tolower(as.character(activities[,2])))
y[,1]=activities[y[,1],2]

##Create tidy data set
tidyData <- cbind(Subject, y, X_data)

### Create second tidy data set with the average of each variable for each activity and each subject
subj <- unique(Subject)[,1]
numSub <- length(subj)
numAct <- length(activities[,1])
numCol <- length(names(tidyData))
tidydata <- tidyData[1:(numSub*numAct),]

#Get the average values
row <- 1
for (s in 1:numSub){
  for (a in 1:numAct){
    tidydata[row,1] <- subj[s]
    tidydata[row,2] <- activities[a, 2]
    temp <- tidyData[tidyData$Subject==s & tidyData$Activity==activities[a,2],]
    tidydata[row, 3:numCol] <- colMeans(temp[,3:numCol])
    row <- row+1
  }
}

#Write the dataset to a file
write.table(tidydata, 'tidyData.txt', row.name=FALSE)