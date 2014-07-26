
run_analysis <- function ( data_dir = "UCI HAR Dataset" ) {

	alldata <- data.frame()

	## read structure data
	features <- read.table(paste(data_dir,"/features.txt",sep=""),sep=" ",col.names=c("feature_id","feature"))
	activities <- read.table(paste(data_dir,"/activity_labels.txt",sep=""),sep=" ",col.names=c("activity_id","activity"))
 
    test_subj <- read.table(paste(data_dir,"/test/subject_test.txt",sep=""),sep=" ",col.names=c("id")) 
    train_subj <- read.table(paste(data_dir,"/train/subject_train.txt",sep=""),sep=" ",col.names=c("id")) 

    test_act <- read.table(paste(data_dir,"/test/y_test.txt",sep=""),sep=" ",col.names=c("id"))
    train_act <- read.table(paste(data_dir,"/train/y_train.txt",sep=""),sep=" ",col.names=c("id"))
	
	## need to read only the mean and std deviation features
	## the files containing the measurements is a fixed-width file, with each field being 16 chars wide
	## so in order to extract only the mean and std deviation fields we need to know their positions
	## Note that -16 indicates a field that needs to be skipped
	fpos <- rep(-16,nrow(features))
	features_sub <- subset(features, grepl("mean|std",feature,ignore.case=TRUE))
	fpos[features_sub$feature_id] = 16;
	test_meas <- read.fwf(paste(data_dir,"/test/x_test.txt",sep=""),widths=fpos,col.names=features_sub$feature) 
    train_meas <- read.fwf(paste(data_dir,"/train/x_train.txt",sep=""),widths=fpos,col.names=features_sub$feature) 

	## combine all data into one dataframe "alldata". 
    alldata <- rbind(test_meas,train_meas)
	
	## Use the combined activity data to compute mean by activity
    activity_data <- rbind(test_act,train_act)
	b <- by(alldata, activity_data$id, colMeans)  ## returns an object of class "b" which is a list of dataframes
	
	## combine all the means from the dataframes into one dataframe
	tidydata <- data.frame( b[[1]] )  ## initializing with the first dataframe
	for ( n in 2:length(b) ) {
		tidydata <- cbind( tidydata, data.frame(b[[n]]) )
	}

	
	## Use the combined subject data to compute mean by subject
	subject_data <- rbind(test_subj,train_subj)
	b <- by(alldata, subject_data$id, colMeans)  ## returns an object of class "b" which is a list of dataframes

	## combine all the means from the dataframes into one dataframe
	for ( n in 1:length(b) ) {
	    tidydata <- cbind( tidydata, data.frame(b[[n]]) )
	}
	
	# give user-friendly columns names
	subject_names <- paste( "subject", unique(subject_data$id), sep="" ) ## in order to preserve the order
	activity_names <- tolower( activities$activity[unique(activity_data$id)] ) ## in order to preserve the order
	colnames(tidydata) <- c(activity_names, subject_names)	

	## write the tidy data to a file
	write.table(format(tidydata,digits=5),"tidydata.txt",sep=",",row.names=FALSE)
}

