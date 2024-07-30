Getting and Cleaning Data Project
This repository contains the R script run_analysis.R which performs data cleaning and transformation on the UCI HAR Dataset. 

The script achieves the following:

Merges the training and test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set.
Appropriately labels the data set with descriptive variable names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Files
run_analysis.R: The R script that performs the data cleaning and transformation.
tidy_data.txt: The resulting tidy data set.
tidy_data.csv: The resulting tidy data set in CSV format.
CodeBook.md: Describes the variables in the data set.

Instructions
Download and unzip the UCI HAR Dataset in your working directory.
Place the run_analysis.R script in the same directory.
Run the script using an R environment.
The script will generate tidy_data.txt and tidy_data.csv files as outputs.

Dependencies
The script requires the dplyr package. Install it using install.packages("dplyr") if you haven't already.
