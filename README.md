README for Course Project in the Getting and Cleaning Data course
===================

The script run_analysis.R assumes that the working directory contains the unzipped data provided in this course. It assumes that the currect working directory contains a sub-directory called "UCI HAR Dataset" which is unzipped from the data provided.

The script creates a data frame "alldata" containing data for both test and training sets.

alldata contains one additional column "training". If training=1, means that that row is part of the training set.

