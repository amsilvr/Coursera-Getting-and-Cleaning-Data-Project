# Coursera Getting and Cleaning Data Project
This is the project for the Coursera course Getting and cleaning data


The pertinent files included are the run_analysis.R script and the tidy_Data.txt text file.
The 'run_analysis.R' script basically does all of the work and tidy_Data.txt is basically the output file.


The R script, `run_analysis.R`, does the following:

•	Downloads the dataset if it does not already exist in the working directory.

•	Reads both the training and test datasets.

•	Merges both the datasets.

•	Extracts only values reflecting mean and standard deviation.

•	Uses descriptive activity names to name activities.

•	Labels the data set with descriptive variable names.

•	Creates an independent tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.


To run the project, follow the steps below:

•	Open the ‘run_analysis.R’ script and change the parameter in the first ‘setwd()’ command to set the working directory initially.

•	The input data set for the script is downloaded and unzipped in the current working directory by the script itself if not done already. Further path settings are also done within the script itself.

•	You can open the script in R Studio and run the code or alternatively use ‘source(run_analysis.R)’ command. This runs the script.

•	The script after successful execution produces an output file ‘tidy_Data.txt’ which contains the output tidy data set.

•	This data set can be again opened in R using the commented code (with ‘read.table’) at the end of the script.
