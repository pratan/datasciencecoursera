README for Course Project in the Getting and Cleaning Data course
===================

The script run_analysis.R assumes that the working directory contains the unzipped data provided in this course. It assumes that the currect working directory contains a sub-directory called "UCI HAR Dataset" which is unzipped from the data provided.

The script creates a data frame "alldata" containing data for both test and training sets.

In order to compute the mean of each variable, the function colMeans is used on each column, by subject or by activity. The result is a list of dataframes, where each dataframe holds the means for one subject or activity.

I use a loop to collect all the means into one tidy data set.
