STEPS for Generating the tidy data

1. R version 3.2.0 it tested on Linux ubuntu 14.04 machine

2. make sure that library data.table, plyr and dplyr installed int R

3. Get the Data
	Download the Dataset from location
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
extract the data so that folder "UCI HAR Dataset" is created in the current directory

4. Get the Files
download "run_analysis.R" "Colnames.txt" in to current directory from the github

5. on command prompt run R

6. type 'source("run_analysis.R")' on R command prompt

7. after some time tidy_data.txt will be generated in current directory

8. Colnames.txt ---> contains the descriptive names of columns for the tidy data

9. run_analysis.R ---> contains the R code for generating tidy data from raw data

10. CodeBook.pdf --->contains the meaning and type of variables(column names) in tidy data




