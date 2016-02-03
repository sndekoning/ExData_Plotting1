if (!file.exists("data.zip")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="data.zip")
    unzip("data.zip")  
}

power_data <- read.csv("household_power_consumption.txt", skip=66637, nrows=2880, na.strings = "?",
                 header=FALSE, sep=";")
names(power_data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
power_data <- transform(power_data, Date = as.Date(Date, format="%d/%m/%y"))
power_data <- transform(power_data, strptime(Time, format="%H:%M:%S"))

png(filename="plot1.png", width=480, height=480)
hist(power_data$Global_active_power, 
     col="red", 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power")
dev.off()