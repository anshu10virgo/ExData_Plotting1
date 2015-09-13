household <- read.table("./household_power_consumption.txt",header = TRUE,sep = ";", na.strings = "?")

# Concatenate Date and Time to one column
household$DateTime <- paste(household$Date,household$Time, sep = " ")
household$DateTime <- strptime(household$DateTime,format="%d/%m/%Y %H:%M:%S")
household$DateTime <- as.POSIXct(household$DateTime)

# Converting Date to standard format
household$Date <- as.Date(household$Date, format = "%d/%m/%Y")

# Filtering Required Data
household_actual <- subset(household, Date >= "2007-02-01" & Date <= "2007-02-02")

#removing unused objects
remove(household)

# Opening the png graphics device
png(filename = "plot4.png",width = 480,height = 480)

# Setting mfrow
par(mfrow = c(2,2))

# Creating plot 1
plot(household_actual$DateTime,household_actual$Global_active_power, 
     type = "l",xlab = "",ylab = "Global Active Power")

# Creating plot 2
plot(household_actual$DateTime,household_actual$Voltage, 
     type = "l",xlab = "datetime",ylab = "Voltage")

# Creating plot 3
plot(household_actual$DateTime,household_actual$Sub_metering_1, 
     type = "l",col="Black",xlab = "",ylab = "Energy sub metering")
lines(household_actual$DateTime,household_actual$Sub_metering_2, 
      type = "l",col="Red")
lines(household_actual$DateTime,household_actual$Sub_metering_3, 
      type = "l",col="Blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("Black","Red","Blue"),lty = 1,bty = "n")

# Creating plot 4
plot(household_actual$DateTime,household_actual$Global_reactive_power, 
     type = "l",xlab = "datetime",ylab = "Global_reactive_power")

# Closing the png graphics device
dev.off()