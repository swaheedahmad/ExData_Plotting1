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
#data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert dates and times


data <- data %>%  mutate(datetime = ymd_hms(paste(data$Date, data$Time)))

# Plot 2
data$datetime <- as.POSIXct(data$datetime)
attach(data)
plot(Global_active_power ~ datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()
detach(data)
