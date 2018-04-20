readLines(".\\household_power_consumption.txt",n=10)
library(data.table)
housedata <- fread(".\\household_power_consumption.txt",colClasses = "character",na.strings="?")
housedata <- as.data.frame(housedata)

housedata$Date <- as.Date(housedata$Date,"%d/%m/%Y")

housedata <- housedata[format.Date(housedata$Date,"%Y-%m-%d") %in% c("2007-02-01","2007-02-02"),]



housedata$Time <- strptime(paste(format.Date(housedata$Date,"%Y-%m-%d")," ",housedata$Time), "%Y-%m-%d %H:%M:%S")
housedata = housedata[,-c(1)]
unique(format.Date(housedata$Time,"%Y-%m-%d"))

housedata <- transform(housedata,Global_active_power=as.numeric(housedata$Global_active_power))





png(filename="plot4.png")
par(mfcol=c(2,2),mar =c(4,4,4,4))
plot(housedata$Time,housedata$Global_active_power,type="l",ylab="Global Active Power",xlab="")

plot(housedata$Time,housedata$Sub_metering_1,type="l",col=1,xlab="",ylab="Energy sub metering")
lines(housedata$Time,housedata$Sub_metering_2,type="l",col=2)
lines(housedata$Time,housedata$Sub_metering_3,type="l",col=4)
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c(1,2,4),lty=1)


plot(housedata$Time,housedata$Voltage,type="l",ylab="Voltage",xlab="datetime")
plot(housedata$Time,housedata$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime")
dev.off()