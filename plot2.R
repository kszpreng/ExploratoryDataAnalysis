#read the file, convert the "?" character to "NA"
data <- read.table(file.choose(), header = TRUE, sep = ";", na.strings = "?")

# replaced the "Date" colum with merged "Date" and "Time" columns
data$Date <- paste(data$Date, data$Time, sep = " ")

# rename the first colum "Datetime"
colnames(data)[1] <- "Datetime"

#remove the now superfluous Time column from the original dataset
data <- subset(data, select = -c(Time))

#convert the Datetime column to POSIX
data$Datetime <- strptime(data$Datetime, "%d/%m/%Y %H:%M:%S")

# This subsets just the two days needed
data <- data[as.Date(data$Datetime) >= as.Date("2007-02-01") 
             & as.Date(data$Datetime) <= as.Date("2007-02-02"),]



# Draw the second plot
plot(data$Datetime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()

