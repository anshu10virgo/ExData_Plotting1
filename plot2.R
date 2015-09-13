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
png(filename = "plot2.png",width = 480,height = 480)

# Creating plot
plot(household_actual$DateTime,household_actual$Global_active_power, 
     type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")

# Closing the png graphics device
dev.off()
