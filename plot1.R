#This script will create plot1. You need to have sqldf installed.
#install.packages("sqldf")
library(sqldf)

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

png('plot1.png',bg = 'transparent')
hist(data_frame$Global_active_power, 
     col='orangered', 
     main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)')
dev.off()