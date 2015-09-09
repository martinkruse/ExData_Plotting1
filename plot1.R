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

#Convert the column containing the data to be plotted from character to numeric
data[,3] <- as.numeric(data[,3])

#Use the mutate function to create a new column with the date and time information
data <- mutate(data, date_time = paste(data$Date, data$Time, sep = ' '))

#Convert the date and time information in the new column using the strptime function
data$date_time <- strptime(data$date_time, format = "%Y-%m-%d %H:%M:%S")

#The following code creates the requested plot and saves it as a png file
png(file = "plot1.png")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()
