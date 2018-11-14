library(readr)
library(dplyr)
library(lubridate)
library(data.table)



download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              , destfile = "data.zip")

unzip(zipfile = "data.zip")

data <- fread("household_power_consumption.txt"
              , header = T
              , sep = ";"
              , na.strings = "?")

data$Date <- dmy(data$Date)
data <- data[(data$Date >= "2007-02-01" & data$Date <= "2007-02-02"),]

# Convert dates and times

data <- data %>%  mutate(datetime = ymd_hms(paste(data$Date, data$Time)))

# Plot 4
data$datetime <- as.POSIXct(data$datetime)
par(mfrow = c(2, 2))
attach(data)
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", 
     xlab = "")
plot(Voltage ~ datetime, type = "l")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", 
     xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

plot(Global_reactive_power ~ datetime, type = "l")

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(data)