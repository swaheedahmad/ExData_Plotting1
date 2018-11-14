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



# Plot 1
attach(data)
hist(Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
detach(data)


dev.copy(png, file = "plot1.png")
dev.off()

