# Set the language
Sys.setlocale("LC_TIME", "English")

# Import the data
rawdata <- read.table(file = "exdata-data-household_power_consumption/household_power_consumption.txt", 
           header = TRUE, sep = ";", na.strings = "?")
str(rawdata)
head(rawdata)

# Load the dplyr library
library(dplyr)

# Create the DateTime column
feb1_2 <- filter(rawdata, Date == "1/2/2007" | Date == "2/2/2007")
feb1_2 <- mutate(feb1_2, DateTime = paste(Date, Time, sep = " "))
feb1_2$DateTime <- strptime(feb1_2$DateTime, "%d/%m/%Y %H:%M:%S")

feb1_2$Date <- as.Date(feb1_2$Date, "%d/%m/%Y")
feb1_2$Time <- format(strptime(feb1_2$Time, "%H:%M:%S"), "%H:%M:%S")

# Make the line graph
with(feb1_2, plot(DateTime, Global_active_power, 
                  xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
with(feb1_2, lines(DateTime, Global_active_power))

# Copy the line graph to plot2.png
dev.copy(png, file = "plot2.png")
dev.off()
