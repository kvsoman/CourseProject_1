# Name the input file "household_power_consumption.txt" 
# It contains only the data requirerd for this assignment
# place it in the same folder where the *.R files are. 
# I have explanatory comments for Plot1.R and Plot2.R

# Generate PLOT 4
if(!require("lubridate"))         #if not already installed
    install.packages("lubridate") #install 'lubridate'
library(lubridate)                # then load it
x <- read.table("household_power_consumption.txt", sep=";",
                header = TRUE)
xdate <- parse_date_time(x$Date, c('dmy'))
xdate <- as.Date(xdate)           #Convert to "Date" class
xtime <- x$Time
xdate_time <- paste(xdate,xtime, sep=" ") #Concat date & time
xdt <- as.POSIXct(xdate_time)   # Convert to POSIX class, and
xdtnum <- unclass(xdt)          # further into numerics
DayNames <- unique(weekdays(xdt, abbreviate=TRUE))
DayNames[3] <- "Sat"            # Adding Sat for tick labels

# Start plot commands
dev.new()
par(mfrow=c(2,2))     #Set up multiple (4) subplots
# Subplot 1:
plot(xdtnum,x$Global_active_power, type="n",
     xlab="", ylab="Global Active Power",
     axes=FALSE, frame.plot = TRUE)
lines(xdtnum,x$Global_active_power, lwd=1)
midpt <- length(x$Global_active_power)/2
endpt <- length(x$Global_active_power)
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
    xdt[endpt]),tick=TRUE)
axis(2, tick=TRUE)

# Subplot 2:
plot(xdtnum,x$Voltage,type="n", xlab="datetime",ylab="Voltage",
     axes=FALSE, frame.plot = TRUE)
lines(xdtnum,x$Voltage, lwd=1)
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
    xdt[endpt]),tick=TRUE)
axis(2, tick=TRUE)

# Subplot 3
plot(xdtnum,x$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering",
     axes=FALSE, frame.plot = TRUE)
lines(xdtnum,x$Sub_metering_1, lwd=1)
lines(xdtnum,x$Sub_metering_2, lwd=1, col="red")
lines(xdtnum,x$Sub_metering_3, lwd=1, col="blue")
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
     xdt[endpt]),tick=TRUE)
axis(2, tick=TRUE)
legend("topright", legend=c("Sub_metering_1","Sub_metering_2",
    "Sub_metering_3"), lty=1, col=c("black","red","blue"))

# Subplot 4:
plot(xdtnum,x$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power",
     axes=FALSE, frame.plot = TRUE)
lines(xdtnum,x$Global_reactive_power)
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
    xdt[endpt]),tick=TRUE)
axis(2, tick=TRUE)
dev.copy(png,file="./plot4.png",width=480,height=480)
dev.off()