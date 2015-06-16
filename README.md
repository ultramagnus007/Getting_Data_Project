STEPS for Generating the tidy data


1.Get the Data
	Download the Dataset from location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
extract the data so that folder "UCI HAR Dataset" is created in the current directory

2. make sure that library data.table, plyr and dplyr installed int R

3. Get the Files
download "run_analysis.R" "Colnames.txt" in to current directory from the github

4. on command prompt run R

5. type 'source("run_analysis.R")' on R command prompt
NOTE: I have tested it on linux machine

6. after some time tidy_data.txt will be generated in current directory

Colnames.txt ---> contains the descriptive names of columns for the tidy data
run_analysis.R ---> contains the R code for generating tidy data from raw data
CodeBook.pdf --->contains the meaning and type of variables(column names) in tidy data



