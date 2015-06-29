##
##       Exploratory Data Analysis     -  Project 1

#  Dataset used: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#  zip file downloaded and unzipped, large text file


getwd()
old.dir <- getwd()
setwd("H:/Training/Coursera/Exploratory_Data_Analysis")
setwd(old.dir)
ls()    
rm(list=ls())

Use dev.off() or plot.new() to reset to the defaults


# Data a big text file with ; seperator. without stringsAsFactor = FALSE reads in most variables as factors so
df <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactor = FALSE)
head(df)  # the nine variables as expected
str(df)  #
'data.frame':    2075259 obs. of  9 variables:
    $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
$ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
$ Global_active_power  : chr  "4.216" "5.360" "5.374" "5.388" ...
$ Global_reactive_power: chr  "0.418" "0.436" "0.498" "0.502" ...
$ Voltage              : chr  "234.840" "233.630" "233.290" "233.740" ...
$ Global_intensity     : chr  "18.400" "23.000" "23.000" "23.000" ...
$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
$ Sub_metering_2       : chr  "1.000" "1.000" "2.000" "1.000" ...
$ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

# Only interested in 1st/2nd Feb 2007 so change $Date to Date format and subset

df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
newdf <- df[df$Date >= "2007-02-01" & df$Date <= "2007-02-02",]
head(newdf)
str(newdf)
'data.frame':    2880 obs. of  9 variables:
    $ Date                 : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" ...
$ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
$ Global_active_power  : chr  "0.326" "0.326" "0.324" "0.324" ...
$ Global_reactive_power: chr  "0.128" "0.130" "0.132" "0.134" ...
$ Voltage              : chr  "243.150" "243.320" "243.510" "243.900" ...
$ Global_intensity     : chr  "1.400" "1.400" "1.400" "1.400" ...
$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
$ Sub_metering_2       : chr  "0.000" "0.000" "0.000" "0.000" ...
$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...


# Project brief suggests combining Date and Time columns and convert to a Date/Time class so
# can either either:
#  add new column by dt <- cbind(paste(mydata$Date, mydata$Time)) then
#  use lubricate dt <- dmy_hms(dt[,1]) or all in one go
library(lubridate)
newdf$date_time <- ymd_hms(paste(newdf$Date, newdf$Time))

# check what we now have
head(newdf) # now extra date_time column
class(newdf$date_time)
[1] "POSIXct" "POSIXt" 
str(newdf)  # required format
'data.frame':    2880 obs. of  10 variables:
    $ Date                 : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" ...
$ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
$ Global_active_power  : chr  "0.326" "0.326" "0.324" "0.324" ...
$ Global_reactive_power: chr  "0.128" "0.130" "0.132" "0.134" ...
$ Voltage              : chr  "243.150" "243.320" "243.510" "243.900" ...
$ Global_intensity     : chr  "1.400" "1.400" "1.400" "1.400" ...
$ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
$ Sub_metering_2       : chr  "0.000" "0.000" "0.000" "0.000" ...
$ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
$ date_time            : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" "2007-02-01 00:03:00" ...


#  PLOT 1

# To plot Global active power we need variable as numeric
newdf$Global_active_power <- as.numeric(newdf$Global_active_power)
# lets look at summary data
summary(newdf$Global_active_power)
 Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.220   0.320   1.060   1.213   1.688   7.482 

# plot histogram
hist(newdf$Global_active_power, col = "red") # looks good but need to specifcy title and x-axis label
hist(newdf$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")

# plot to png 480x480 pixels which is the default
# so assuming all prep above complete
png(file="plot1.png")
hist(newdf$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")
dev.off()

#   PLOT 2

# type = "l" for a line
with(newdf, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab = "" ))


# plot to png 480x480 pixels which is the default
# so assuming all prep above complete
png(file="plot2.png")
with(newdf, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab = "" ))
dev.off()


#    PLOT 3

# need to convert Sub_metering 1 and 2 to numberic
newdf$Sub_metering_1 <- as.numeric(newdf$Sub_metering_1)
summary(newdf$Sub_metering_1)
  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.0000  0.0000  0.0000  0.4062  0.0000 38.0000 

newdf$Sub_metering_2 <- as.numeric(newdf$Sub_metering_2)
summary(newdf$Sub_metering_2)
  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.0000  0.0000  0.0000  0.2576  0.0000  2.0000 

# Sub_metering_3 already a numeric, class(newdf$Sub_metering_3)
summary(newdf$Sub_metering_3)

# initial plot of Sub_metering_1 with x and y axes lables as required
with(newdf, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
# add Sub_metering_2
with(newdf, points(date_time, Sub_metering_2, type = "l", col = "red"))
# add Sub_metering_3
with(newdf, points(date_time, Sub_metering_3, type = "l", col  = "blue"))
#  add legend
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                                        "Sub_metering_3"))




# plot to png 480x480 pixels which is the default
# so assuming all prep above complete
png(file="plot3.png")
with(newdf, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(newdf, points(date_time, Sub_metering_2, type = "l", col = "red"))
with(newdf, points(date_time, Sub_metering_3, type = "l", col  = "blue"))
legend("topright", lty = 1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2",
                                                                        "Sub_metering_3"))
dev.off()




# dev.off()
# vec1 <- as.numeric(newdf$Sub_metering_1)
# vec2 <- as.numeric(newdf$Sub_metering_2)
# vec3 <- newdf$Sub_metering_3


#     PLOT 4


# set up plot window with default margins


par(mfrow = c(2,2))

#           Top left is plot 2 above so assuming data prep already done

with(newdf, plot(date_time, Global_active_power, type = "l", ylab = "Global Active Power (kilowats)", xlab = "" ))

#           Top right is a new so

newdf$Voltage <- as.numeric(newdf$Voltage)
with(newdf, plot(date_time, Voltage, type = "l", ylab = "Voltage", xlab = "datetime" ))

# vec4 <- as.numeric(newdf$Voltage)


#         Bottom left is plot 3 above so assuming data prep already done


with(newdf, plot(date_time, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(newdf, points(date_time, Sub_metering_2, type = "l", col = "red"))
with(newdf, points(date_time, Sub_metering_3, type = "l", col  = "blue"))
# as above but want to remove border around legends
# can set bty = "n" 
# could set box.col to "white" but lose top corner plot border
# could use inset??

legend("topright", lty = 1, col = c("black", "blue", "red"), bty = "n", legend = c("Sub_metering_1", "Sub_metering_2",
                                                                        "Sub_metering_3"))



#         Bottom right is new so


newdf$Global_reactive_power <- as.numeric(newdf$Global_reactive_power)
with(newdf, plot(date_time, Global_reactive_power, type = "l", xlab = "datatime"))



# plot to png 480x480 pixels which is the default
# so assuming all prep above complete
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
dev.off()




# vec5 <- as.numeric(newdf$Global_reactive_power)

# par(mfrow = c(1, 3), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

# Margins are specified as 4-long vectors of integers. Each number tells how many lines of text to leave at each side.
# The numbers are assigned clockwise starting at the bottom. The default for the inner margin is c(5.1, 4.1, 4.1, 2.1)
# so you can see we reduced each of these so we'll have room for some outer text.








