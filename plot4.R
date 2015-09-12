# This script was created for the Coursera "Exploratory Data Analysis" course
# Plotting Assignment 1.
#
# The script reads data from the "Electric Power Consumption" dataset provided
# for this programming assignment and will create several plots based on power 
# readings measured on the 1st and 2nd of February 2007:
# 1) Global active power against time;
# 2) Voltage against time;
# 3) Energy submetering against time; and
# 4) Global reactive power against time.
# The plot will be saved in a file named "plot4.png".
#
# The dataset will be loaded from a txt file in the current working directory.
# If the expected text file does not exist, then it will be downloaded and
# and extracted from the zip archive provided for the programming assignment.
#
# This script relies on the "sqldf" library, which is used to filter our large
# data file as it is being read (to only load the data for 2 days).

require(sqldf)

# 1. Download our data file, if required.
if (!file.exists("household_power_consumption.txt")) {
        print("Data file not found. Downloading and extracting...")
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      "exdata-data-household_power_consumption.zip", mode="wb")
        unzip("exdata-data-household_power_consumption.zip")
}

# 2. Read in the data we care about (1st and 2nd February, 2007).
print("Reading data for 1st and 2nd February 2007")
sel.data <- read.csv.sql("household_power_consumption.txt",
                         sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
                         header = TRUE, sep = ";")
sel.data$Date.Time <- strptime(paste(sel.data$Date, sel.data$Time), 
                               format="%d/%m/%Y %H:%M:%S")

# 2. Create our "Plot 4", saving it to a 480x480 png image file.
print("Creating Plot 4")
png("plot4.png", 480, 480)
par(mfrow = c(2,2))

# 3. Plot Global Active Power (same command as in "Plot 2", except ylab)
plot(sel.data$Date.Time, sel.data$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power")

# 4. Plot Voltage
plot(sel.data$Date.Time, sel.data$Voltage,
     type="l", xlab="datetime", ylab="Voltage")

# 5. Plot Energy Sub Metering (same commands as in "Plot 3", except suppress
# the box around the legend)
plot(sel.data$Date.Time, sel.data$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")
lines(sel.data$Date.Time, sel.data$Sub_metering_2, type="l", col="orangered3")
lines(sel.data$Date.Time, sel.data$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_1", "Sub_metering_3"), 
       lty=c(1,1,1), col=c("black","orangered3", "blue"), bty = "n")

# 6. Plot Global reactive power
plot(sel.data$Date.Time, sel.data$Global_reactive_power,
     type="l", xlab="datetime", ylab="Global_reactive_power")

# 3. Clean up.
dev.off()
print("Finished.")

