##Rcode for plot 3

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
rm(x,d,date1,date2,filename,fileURL)
## Creating time variable for x axis
date<- reqdata$Date
time<- reqdata$Time
dt<- paste(date, time, sep = " ")
dt1<- strptime(dt, format ="%Y-%m-%d %H:%M:%S")
rm(date, time, dt)

##Creating png file

file<- paste0(getwd(),"/plot3.png")

png(filename = file,
    width = 480,
    height = 480, ##Setting 480 x 480
    units = "px",
    bg = "white",
)

##Generating the line graph.
plot(dt1,reqdata$Sub_metering_1,
     type = "l",
     lty = 1,
     lwd = 0.1,
     pch = 18,
     ylab = "Energy sub meeting",
     xlab = ""
     )
lines(dt1, reqdata$Sub_metering_2,
      lty = 1,
      type = "l",
      lwd = 1,
      pch = 18,
      col = "red" )
lines(dt1, reqdata$Sub_metering_3,
      lty = 1,
      type = "l",
      lwd = 0.01,
      pch = 18,
      col = "blue" )
legend("topright",
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       col= c("black", "red", "blue"),
       lty=1
       )

dev.off()
