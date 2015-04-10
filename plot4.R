#This script will create plot2. You need to have sqldf and lubridate installed.
#install.packages("sqldf")
#install.packages("lubridate")
library(sqldf)
library(lubridate)
#check if the file exists in the working directory. If it doesn't it will try to download
if(!file.exists("household_power_consumption.txt")) {
  file_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(file_url, destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip", "household_power_consumption.txt")
}

file<-file("household_power_consumption.txt")

data_frame<-sqldf("select * from file where Date in('1/2/2007','2/2/2007')",
                  dbname = tempfile(),
                  file.format = list(header=TRUE, sep=';'))

png('plot4.png',bg = 'transparent')
par(mfcol=c(2,2))
with(data_frame, {
  plot(dmy_hms(paste(Date,Time)), Global_active_power, 
       type = 'l',
       ylab = 'Global Active Power (kilowatts)',
       xlab='')
  plot(dmy_hms(paste(Date,Time)), Sub_metering_1,
       type = 'l',
       ylab='Energy sub metering',
       xlab='')
  lines(dmy_hms(paste(Date,Time)), Sub_metering_2, 
        type = 'l', col='red')
  lines(dmy_hms(paste(Date,Time)), Sub_metering_3, 
        type = 'l', col='blue')
  legend("topright", lwd = 1, 
         col = c("black","red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(dmy_hms(paste(Date,Time)), Voltage, 
     type = 'l',
     ylab = 'Voltage',
     xlab='datetime')
  plot(dmy_hms(paste(Date,Time)), Global_reactive_power, 
     type = 'l',
     ylab = 'Global_reactive_power',
     xlab='datetime')
  })

dev.off()
