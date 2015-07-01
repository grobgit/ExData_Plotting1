##
##
## Exploratory Data Analysis, Project 1    -   Plot 1
##
##
## Author: Graham Robertson
## Date: 30th June 2015
##

# Dataset used: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Script assumes  zip file downloaded and unzipped and saved in ..data/ folder in your working directory

# Note: script takes ~20 sec to run on a fairly up to date Win7 PC


# Data a big text file with ; seperator. Without stringsAsFactor = FALSE reads in most variables as factors so
df <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactor = FALSE)

# Only interested in 1st/2nd Feb 2007 so change $Date to Date format and subset
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
newdf <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]

# Project brief suggests combining Date and Time columns and convert to a Date/Time class so will use lubricate package
library(lubridate)
newdf$date_time <- ymd_hms(paste(newdf$Date, newdf$Time))


#  PLOT 1 specific code

# To plot Global active power we need variable as numeric
newdf$Global_active_power <- as.numeric(newdf$Global_active_power)

# Plot histogram with required colour, title and x-axis label 
hist(newdf$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")

# save plot to png
# plot to png 480x480 pixels which is the default
png(file="plot1.png")
hist(newdf$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")

# shut down device
dev.off() 

