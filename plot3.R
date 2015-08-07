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


# Draw the third plot 

png(file = "plot3.png", width = 480, height = 480)
with(data, plot(Datetime, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Datetime, Sub_metering_2, col = "red"))
with(data, lines(Datetime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= c(1,1,1), col= c("black", "red", "blue"))
dev.off()



