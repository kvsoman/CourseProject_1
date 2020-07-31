# Generate PLOT 3
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
# Start plotting
dev.new()
plot(xdtnum,x$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering",
     axes=FALSE, frame.plot = TRUE)
lines(xdtnum,x$Sub_metering_1, lwd=1) #Plot graphs one by one
lines(xdtnum,x$Sub_metering_2, lwd=1, col="red")
lines(xdtnum,x$Sub_metering_3, lwd=1, col="blue")
midpt <- length(x$Global_active_power)/2   # find tick locations
endpt <- length(x$Global_active_power)     # for the x-axis ...
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
    xdt[endpt]),tick=TRUE)
axis(2, tick=TRUE)
legend("topright", legend=c("Sub_metering_1","Sub_metering_2",
    "Sub_metering_3"), lty=1, col=c("black","red","blue"))
dev.copy(png,file="./plot3.png",width=480,height=480)
dev.off()