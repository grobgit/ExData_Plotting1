##
##
## Exploratory Data Analysis, Project 1    -   Plot 4
##
##
## Author: Graham Robertson
## Date: 30th June 2015
##

# Dataset used: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Script assumes  zip file downloaded and unzipped and saved in ..data/ folder

# Note: script takes ~20 sec to run on a fairly up to date Win7 PC


# Data a big text file with ; seperator. Without stringsAsFactor = FALSE reads in most variables as factors so
df <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactor = FALSE)

# Only interested in 1st/2nd Feb 2007 so change $Date to Date format and subset
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
newdf <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]

# Project brief suggests combining Date and Time columns and convert to a Date/Time class so will use lubricate package
library(lubridate)
newdf$date_time <- ymd_hms(paste(newdf$Date, newdf$Time))


#  PLOT 4 specific code

# set up plot window with default margins
par(mfrow = c(2,2))

# Top left is plot 2
# creat plot with required type ("l" for a line) and y/x axis labels
with(newdf, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab = "" ))

# Top right is a new so
# Need to convert Voltage to numeric.
newdf$Voltage <- as.numeric(newdf$Voltage)
# creat plot with required type ("l" for a line) and y/x axis labels
with(newdf, plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime" ))


# Bottom left is plot 3

# initial plot of Sub_metering_1 with x and y axes lables as required
with(newdf, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
# add Sub_metering_2 with required type and colour
with(newdf, points(date_time, Sub_metering_2, type = "l", col = "red"))
# add Sub_metering_3 with required type and colour
with(newdf, points(date_time, Sub_metering_3, type = "l", col  = "blue"))
#  add legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                                        "Sub_metering_3"))

# Bottom right is new so
# Need to convert Global_reactive_power to numeric.
newdf$Global_reactive_power <- as.numeric(newdf$Global_reactive_power)
# create with required type ("l" for a line) and x axis label
with(newdf, plot(date_time, Global_reactive_power, type = "l", xlab = "datatime"))

# save plot to png
png(file="plot4.png")
par(mfrow = c(2,2))
with(newdf, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab = "" ))
with(newdf, plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime" ))
with(newdf, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(newdf, points(date_time, Sub_metering_2, type = "l", col = "red"))
with(newdf, points(date_time, Sub_metering_3, type = "l", col  = "blue"))

legend("topright", lty = 1, col = c("black", "blue", "red"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2",
                                                                                   "Sub_metering_3"))
with(newdf, plot(date_time, Global_reactive_power, type = "l", xlab = "datatime"))

# shut down device
dev.off() 



