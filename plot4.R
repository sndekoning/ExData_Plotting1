## Downloads neccesary data if not present.
if (!file.exists("data.zip")) {
    short_url <- paste("https://d396qusza40orc.cloudfront.net/",
                       "exdata%2Fdata%2Fhousehold_power_consumption.zip", sep = "")
    download.file(url=short_url, destfile="data.zip")
    unzip("data.zip")  
}

## Extracts the dates utilized in the plots, adds the date_time column to the DataFrame
## and transforms the Date and Time variables to their proper classes.
power_data <- read.csv("household_power_consumption.txt", skip=66637, nrows=2880, 
                       na.strings = "?", header=FALSE, sep=";")
names(power_data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
power_data$date_time <- as.POSIXct(paste(power_data$Date, power_data$Time, sep = ""), 
                                   format = "%d/%m/%Y %H:%M:%S")
power_data <- transform(power_data, Date = as.Date(Date, format="%d/%m/%Y"))
power_data <- transform(power_data, strptime(Time, format="%H:%M:%S"))

##Plots the data.
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(power_data, plot(date_time, Global_active_power, type = "l",
                      ylab = "Global Active Power", 
                      xlab = ""))

with(power_data, plot(date_time, Voltage, type = "l",
                      ylab = "Voltage", 
                      xlab = "datetime"))

with(power_data, plot(date_time, Sub_metering_1, type = "l",
                      ylab = "Energy sub metering", 
                      xlab = ""))
with(power_data, lines(date_time, Sub_metering_2, col = "red"))
with(power_data, lines(date_time, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(power_data, plot(date_time, Global_reactive_power, type = "l",
                      ylab = "Global_reactive_power", 
                      xlab = "datetime"))

dev.off()