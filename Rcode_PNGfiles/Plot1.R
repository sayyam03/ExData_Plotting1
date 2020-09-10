
##R code for Plot 1


rm(list=ls())

## Downloading the Data
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<- "exdata_data_household_power_consumption.zip"
if(!file.exists(filename)){
  download.file(fileURL, filename, method ="curl")

}

if(!file.exists("household_power_consumtion.txt")){
  unzip(filename)
}

## Reading the dataset
x<- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
x$Date<- as.Date(x$Date, format = "%d/%m/%Y")
##Subsetting according to dates req
date1<- as.Date("2007-02-01")
date2<- as.Date("2007-02-02")
d<- c(date1,date2)
reqdata<-subset(x, x$Date %in% d)

##Creating png file

file<- paste0(getwd(),"/plot1.png")

png(filename = file,
    width = 480,
    height = 480, ##Setting 480 x 480
    units = "px",
    bg = "white",
    )

hist(as.numeric(reqdata$Global_active_power),
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
