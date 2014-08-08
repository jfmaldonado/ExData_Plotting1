# Download file.
# fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download.file(fileUrl, destfile="2Fhousehold_power_consumption.zip")

if(!exists("raw_data")) {
  # Read file.
  raw_data <- read.csv("household_power_consumption.txt", colClasses = "character", header = TRUE, sep = ";")
}

if(!exists("my_data")) {
  # Filter values.
  my_data <- raw_data[raw_data[,"Date"] == "1/2/2007" | raw_data[,"Date"] == "2/2/2007",]
  
  # Convert dates and times.
  my_data$Time <- paste(my_data$Date,my_data$Time, sep = ' ') 
  auxTimes <- strptime(my_data[,"Time"], "%d/%m/%Y %H:%M:%S")
  my_data$Time <- auxTimes
  my_data$Date <- as.Date(my_data[,"Date"], "%d/%m/%Y")
  
  # Convert numbers.
  my_data$Global_active_power <- as.numeric(my_data$Global_active_power)
  my_data$Sub_metering_1 <- as.numeric(my_data$Sub_metering_1)
  my_data$Sub_metering_2 <- as.numeric(my_data$Sub_metering_2)
  my_data$Sub_metering_3 <- as.numeric(my_data$Sub_metering_3)
}

# Plot 2.
par(mfrow=c(1,1))
png(filename='plot2.png', width=480, height=480, units='px')
with(faithful, plot(my_data$Time, my_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()
