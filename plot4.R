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


png(filename="./exdataproj1/plot4.png", height=480, width=480, bg="transparent")

par(mfrow=c(2,2))



plot(df.power.2days$Timestamp,
     df.power.2days$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")



plot(df.power.2days$Timestamp,
     df.power.2days$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")


# Plot 1st
plot(df.power.2days$Timestamp,
     df.power.2days$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

# Plot 2nd
lines(df.power.2days$Timestamp,
      df.power.2days$Sub_metering_2,
      type="l",
      col="red")

# Plot 3rd
lines(df.power.2days$Timestamp,
      df.power.2days$Sub_metering_3,
      type="l",
      col="blue")


legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1),lwd=2,col=c("black","red","blue"),bty="n")

#plot part 4

plot(df.power.2days$Timestamp,
     df.power.2days$Global_reactive_power,
     type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()