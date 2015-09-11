# Set the language
Sys.setlocale("LC_TIME", "English")
rawdata <- read.table(file = "exdata-data-household_power_consumption/household_power_consumption.txt", 
           header = TRUE, sep = ";", na.strings = "?")
str(rawdata)
head(rawdata)

library(dplyr)

feb1_2 <- filter(rawdata, Date == "1/2/2007" | Date == "2/2/2007")
feb1_2 <- mutate(feb1_2, DateTime = paste(Date, Time, sep = " "))
feb1_2$DateTime <- strptime(feb1_2$DateTime, "%d/%m/%Y %H:%M:%S")

feb1_2$Date <- as.Date(feb1_2$Date, "%d/%m/%Y")
feb1_2$Time <- format(strptime(feb1_2$Time, "%H:%M:%S"), "%H:%M:%S")

png(file = "plot4.png")

# Set the layout of Plot4
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1), oma = c(0, 0, 2, 0))

# Plot the first graph
with(feb1_2, {plot(DateTime, Global_active_power, 
                  xlab = "", ylab = "Global Active Power", type = "n", cex = 0.8)
        lines(DateTime, Global_active_power)})
# Plot the second graph
with(feb1_2, {plot(DateTime, Voltage, 
                  xlab = "datetime", ylab = "Voltage", type = "n", cex = 0.8)
        lines(DateTime, Voltage)})
# Plot the third graph
with(feb1_2, {
        plot(DateTime, Sub_metering_1, type = "n", 
             xlab = "", ylab = "Energy sub metering")
        lines(DateTime, Sub_metering_3, col = "blue")
        lines(DateTime, Sub_metering_2, col = "red")
        lines(DateTime, Sub_metering_1, col = "black")})
# Add a legend for the third graph
legend("topright", lwd = 2, col =c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n", cex = 0.6)
# Plot the forth graph
with(feb1_2, {plot(DateTime, Global_reactive_power, 
                   xlab = "datetime", ylab = "Global_reactive_power", type = "n")
        lines(DateTime, Global_reactive_power)})

dev.off()

