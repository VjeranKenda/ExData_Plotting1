# plot4.R
library(sqldf)

Sys.setlocale("LC_TIME", "English")

# read data from household_power_consumption.txt
file_name <- "household_power_consumption.txt"
col_classes <- c(rep("character", 2), rep("numeric", 7))
str_sql <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
epc <- read.csv.sql(file_name, str_sql, sep = ";", colClasses = col_classes)

epc$"DateTime" <- strptime(paste(epc$Date, " ", epc$Time), "%d/%m/%Y %H:%M:%S")

par(mfcol=c(2,2))

# plot1
plot(epc$DateTime,
     epc$Global_active_power,
     type = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(epc$DateTime, epc$Global_active_power)

# plot2
plot(epc$DateTime,
     epc$Global_active_power,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering",
     ylim = c(0, 40),
     cex = 0.5)
lines(epc$DateTime, epc$Sub_metering_1)
lines(epc$DateTime, epc$Sub_metering_2, col = "red")
lines(epc$DateTime, epc$Sub_metering_3, col = "blue")
legend("topright",
       lwd = 1,
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.5)

# plot3
plot(epc$DateTime,
     epc$Voltage,
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(epc$DateTime, epc$Voltage)

# plot4
plot(epc$DateTime,
     epc$Global_reactive_power,
     type = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(epc$DateTime, epc$Global_reactive_power)

# save plot
dev.copy(png, file = "plot4.png", width =480, height =480)
dev.off()

# eof