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


# Draw the fourth plot

png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) # draws a two by two plot set

# 1
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# 2
plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# 3 (note that in the legend line, the cex parameter controls the scaling of the lengend box, and the bty parameter controls the border around the legend)
with(data, plot(Datetime, Sub_metering_1, col = "black", type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Datetime, Sub_metering_2, col = "red"))
with(data, lines(Datetime, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = .7, bty = "n", lty= c(1,1,1), col= c("black", "red", "blue"))

# 4
plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()


