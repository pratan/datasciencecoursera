

alldata <- data.frame()

for ( dir in c("train", "test") ) {
	file_prefix <- paste("./UCI HAR Dataset/",dir,"/", sep="")
	x_data <- read.csv(paste(file_prefix, "x_", dir, ".txt", sep=""))
	y_data <- read.csv(paste(file_prefix, "y_",dir,".txt", sep=""))
	subj_data <- read.csv(paste(file_prefix, "subject_",dir,".txt", sep=""))

	colnames(x_data) <- c("obs_data")
	x_data[,"activity"] <- y_data$X5
	if ( dir == "train" ) {
		x_data[,"subject"] <- subj_data$X1
		x_data[,"training"] <- c(rep(1, nrow(x_data)))
	} else {
		x_data[,"subject"] <- subj_data$X2
		x_data[,"training"] <- c(rep(0, nrow(x_data)))
	}
	
	file_prefix <- (file_prefix, "Inertial Signals/", sep="")
	
	total_acc_z <- read.csv( paste(file_prefix, "total_acc_z_",dir, ".txt", sep="") )
	total_acc_y <- read.csv( paste(file_prefix, "total_acc_y_",dir, ".txt", sep="") )
	total_acc_x <- read.csv( paste(file_prefix, "total_acc_x_",dir, ".txt", sep="") )

	x_data[,"total_acc_z"] <-total_acc_z[1]
	x_data[,"total_acc_y"] <-total_acc_y[1]
	x_data[,"total_acc_x"] <-total_acc_x[1]
		
	body_acc_z <- read.csv( paste(file_prefix, "body_acc_z_",dir, ".txt", sep="") )
	body_acc_y <- read.csv( paste(file_prefix, "body_acc_y_",dir, ".txt", sep="") )
	body_acc_x <- read.csv( paste(file_prefix, "body_acc_x_",dir, ".txt", sep="") )

	x_data[,"body_acc_z"] <- body_acc_z[1]
	x_data[,"body_acc_y"] <- body_acc_y[1]
	x_data[,"body_acc_x"] <- body_acc_x[1]
	
	body_gyro_z <- read.csv( paste(file_prefix, "body_gyro_z_",dir, ".txt", sep="") )
	body_gyro_y <- read.csv( paste(file_prefix, "body_gyro_y_",dir, ".txt", sep="") )
	body_gyro_x <- read.csv( paste(file_prefix, "body_gyro_x_",dir, ".txt", sep="") )

	x_data[,"body_gyro_z"] <- body_gyro_z[1]
	x_data[,"body_gyro_y"] <- body_gyro_y[1]
	x_data[,"body_gyro_x"] <- body_gyro_x[1]

	alldata <- rbind(alldata, x_data)
}



