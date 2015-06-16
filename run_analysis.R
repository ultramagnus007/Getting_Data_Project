

data_folder = "./UCI\ HAR\ Dataset"

#getting the features from features.txt
getfeatures<-function()
{
	#reading featureNo and feature name from "features.txt"
	#resulting data frame DT has 561X2 dimension
	DT<-read.table( paste0(data_folder, "/features.txt"))
	#converting features name(2nd column) in to lowercases string 
	#and storing it into data frame 'features'
	features<-tolower(DT[,2])

	#removing '-' character in features otherwise it will confuse
	#the grepl command later
	features<-gsub("-","",features)
	features
}

#getting those features which have meanstd word in it
get_meanstd<-function(features)
{
	#mean is a vector of TRUE and FALSE 
	#depending on whether "mean()" occurs in the feature name
	mean<-grepl("mean\\(\\)", features)
	#std is a vector of TRUE and FALSE 
	#depending on whether "std()" occurs in the feature name
	std<-grepl("std\\(\\)", features)
	#meanstd is a is a vector of TRUE and FALSE 
	#which had either "mean()" or "std()" occurs in the feature name
	meanstd<-mean | std
	meanstd
}


get_test_data<-function(meanstd)
{
	#reading test data
	TEST<-read.table(paste0(data_folder, "/test/X_test.txt"))
	#test contain only those columns from TEST which has meanstd is equal to TRUE
	test <- TEST[, meanstd]
	test
}

get_train_data<-function(meanstd)
{
	#reading the train data 
	TRAIN<-read.table(paste0(data_folder, "/train/X_train.txt"))
	#train contain only those columns from TRAIN which has meanstd is equal to TRUE
	train <- TRAIN[ ,meanstd]
	train
}


combine_test_train<-function(test, train)
{
	#reading test activity number
	testact_num<-read.table(paste0(data_folder, "/test/y_test.txt"), col.names=c("activity_num"))
	#reading test subject number
	testsubject_num<-read.table(paste0(data_folder, "/test/subject_test.txt"), col.names=c("subject_num"))

	#reading train activity number
	trainact_num<-read.table(paste0(data_folder, "/train/y_train.txt"),col.names=c("activity_num"))
	#reading train subject number
	trainsubject_num<-read.table(paste0(data_folder, "/train/subject_train.txt"), col.names=c("subject_num"))

	#adding  subject_num and activity_num column in both train and test
	test$subject_num = testsubject_num$subject_num
	test$activity_num = testact_num$activity_num
	train$subject_num = trainsubject_num$subject_num
	train$activity_num = trainact_num$activity_num

	#combining test and train rowwise
	testtrain<-rbind(test,train)
	testtrain
}


add_activity_name<-function(testtrain)
{
	#reading labels which has activity number and activity name columns
	labels<-read.table(paste0(data_folder, "/activity_labels.txt"), col.names=c("activity_num", "actvity_name"))
	library(plyr)
	#joining the labels and testtrain based on common column 'activity_num'
	#so resulting data frame has 'actvity_name' column in it
	testtrain<-join(labels, testtrain)
	library(dplyr)
	#selecting all column except activity_num
	testtrain<-select(testtrain, -activity_num)
	testtrain
}

get_tidy_data<-function(testtrain)
{
	library(dplyr)
	#group the testtrain by 'acivity name' and 'subject number'
	testtrain<-group_by(testtrain, subject_num, actvity_name)

	#summarise_each column in testtrain grouped by 
	#'acivity name' and 'subject number'
	tidydata<-summarise_each(testtrain, funs(mean))

	#arrange tidy data by subject number then activity_name
	arrange(tidydata, subject_num, actvity_name)

	#adding the descriptive column names in tidy data
	COLNAMES<-read.table("./Colnames.txt")
	colnames(tidydata)<-COLNAMES$V1
	tidydata
}

library(data.table)
#features is a vector character string  of all 561 features
features<-getfeatures()
#meanstd is vector of TRUE and FALSE, with TRUE when 'mean()', 'std()' occur in features
#it has total 561 values out of which 66 TRUE values
meanstd<-get_meanstd(features)
#getting the test data
test<-get_test_data(meanstd)
#getting the train data
train<-get_train_data(meanstd)
#combining test and train data
testtrain<-combine_test_train(test, train)
#adding activity labels
testtrain<-add_activity_name(testtrain)
#summarizing the data
tidydata<-get_tidy_data(testtrain)
#writing the tidydata into "tidy_data.txt"
write.table(tidydata, "./tidy_data.txt", row.names = FALSE)

