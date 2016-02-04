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
png(filename = "plot2.png", width = 480, height = 480)
with(power_data, plot(date_time, Global_active_power, type = "l",
                      ylab = "Energy sub metering", 
                      xlab = ""))

dev.off()