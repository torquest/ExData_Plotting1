library(lubridate)

if (!file.exists("./exdataproj1/household_power_consumption.zip")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, destfile = "./exdataproj1/household_power_consumption.zip", method="curl")
  unzip("./exdataproj1/household_power_consumption.zip", exdir = "./exdataproj1/")
}

df.power <- read.csv(file="./exdataproj1/household_power_consumption.txt",header=TRUE,sep=";",na.strings="?", check.names=F, stringsAsFactors=F, comment.char="",quote='\"')
df.power$Timestamp <- strptime(paste(df.power$Date,df.power$Time),format="%d/%m/%Y %H:%M:%S")
df.power.2days <- subset(df.power, as.Date(df.power$Timestamp) >= "2007-02-01" 
                         & as.Date(df.power$Timestamp) <= "2007-02-02")


png(filename="./exdataproj1/plot1.png", height=480, width=480, bg="transparent")
hist(df.power.2days$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off()