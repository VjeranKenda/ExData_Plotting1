# plot2.R
library(sqldf)

Sys.setlocale("LC_TIME", "English")

# read data from household_power_consumption.txt

file_name <- "household_power_consumption.txt"
col_classes <- c(rep("character", 2), rep("numeric", 7))
str_sql <- "select * from file where Date = '1/2/2007' or Date = '2/2/2007'"
epc <- read.csv.sql(file_name, str_sql, sep = ";", colClasses = col_classes)

epc$"DateTime" <- strptime(paste(epc$Date, " ", epc$Time), "%d/%m/%Y %H:%M:%S")

# image

plot(epc$DateTime,
     epc$Global_active_power,
     type = "n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(epc$DateTime, epc$Global_active_power)

dev.copy(png, file = "plot2.png", width =480, height =480)
dev.off()

# eof