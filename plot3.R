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

# Make the graph
with(feb1_2, {
        plot(DateTime, Sub_metering_1, type = "n", 
             xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_3, col = "blue")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_1, col = "black")})
# Add the legend
legend("topright", lwd = 2, col =c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.6)
# Copy the graph to plot3.png
dev.copy(png, file = "plot3.png")
dev.off()
