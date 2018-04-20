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

png(filename="plot1.png")
hist(housedata$Global_active_power,col="red",xlab="Global Active Power(kilowatts)")
dev.off()
