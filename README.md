# run_analysis.R

This explains how the run_analysis.R script works.

* The run_analysis.R script assumes that the dataset zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip has been downloaded and installed in your working directory.
* The first step is to read in all of the files and assign them to variables
* The next step is to merge the "test" and "train" files from their respective folders.  The "subject" files are merged into a data frame called "subject", the "y" files are merged into a data frame called "activity", and the "X" files are merged into a data frame called "featuresdata". (The files from the "Inertial Signals" folders are not included in this analysis).   
* The next step is to name the variables of each merged data frame - "subject", "activity", and using the "features.txt"" file to name the "featuresdata" variables.
* The next step is to select only the "mean()" and "std()" variables from "featuresdata"
* The next step is to combine all data into one table "dataCombine"
* The next step is to change the activity coded numbers to labels defined in activity_labels.txt file
* The next step is to make more descriptive variable names for the "featuresdata" part of the the data frame
* The next step is to sort the dataCombine table by subject and activity, respectively
* The next steps are to group the dataCombine dataframe by subject and activity and then summarize the data with the average of each variable for each activity and each subject.
