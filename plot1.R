# This script was created for the Coursera "Exploratory Data Analysis" course
# Plotting Assignment 1.
#
# The script reads data from the "Electric Power Consumption" dataset provided
# for this programming assignment and will create a histogram based on the 
# global active power readings measured on the 1st and 2nd of February 2007.
# The histogram will be saved in a file named "plot1.png".
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

# 2. Create our "Plot 1", saving it to a 480x480 png image file.
print("Creating Plot 1")
png("plot1.png", 480, 480)
hist(sel.data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", 
     col="orangered3")


# 3. Clean up.
dev.off()
print("Finished.")

