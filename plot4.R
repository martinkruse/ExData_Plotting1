#Load the dplyr package
library(dplyr)

#Download the file containing the data and unpack it in the working directory
fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "electricity.zip", method = "curl")
unzip("electricity.zip")

#Read the whole dataset
whole_dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Column 1 of the dataset is converted to class "Date"
whole_dataset[,1] <- as.Date(whole_dataset[,1], "%d/%m/%Y")

#Subset the dataset based on the requested dates
data <- subset(whole_dataset, (whole_dataset[,1]) >='2007-02-01' & (whole_dataset[,1] <= '2007-02-02'))

#Convert the columns containing the data to be plotted from character to numeric
data[,3] <- as.numeric(data[,3])
data[,4] <- as.numeric(data[,4])
data[,5] <- as.numeric(data[,5])
data[,7] <- as.numeric(data[,7])
data[,8] <- as.numeric(data[,8])
data[,9] <- as.numeric(data[,9])

#Use the mutate function to create a new column with the date and time information
data <- mutate(data, date_time = paste(data$Date, data$Time, sep = ' '))

#Convert the date and time information in the new column using the strptime function
data$date_time <- strptime(data$date_time, format = "%Y-%m-%d %H:%M:%S")

#The following code creates the requested plot and saves it as a png file
png(file = "plot4.png")
par(mfrow = c(2, 2))
with(data, {
  plot(data$date_time, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(data$date_time, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(data$date_time, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(data$date_time, data$Sub_metering_2, col = "red")
  lines(data$date_time, data$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(data$date_time, data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive-_power")
})
dev.off()
