# Name the input file "household_power_consumption.txt" 
# It contains only the data requirerd for this assignment
# place it in the same folder where the *.R files are. 
# I have explanatory comments for Plot1.R and Plot2.R

# Generate PLOT 2
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
par(mar=c(5,4,4,2))             # Defaults: 5,4,4,2
plot(xdtnum,x$Global_active_power, type="n",
     xlab="", ylab="Global Active Power (kilowatts)",
     axes=FALSE, frame.plot = TRUE)        # Set up plot
lines(xdtnum,x$Global_active_power, lwd=1) # Generate graph
midpt <- length(x$Global_active_power)/2   # find tick locations
endpt <- length(x$Global_active_power)     # for the x-axis ...
axis(1,labels = DayNames,at=c(xdt[1],xdt[midpt],
    xdt[endpt]),tick=TRUE)                 # ... and mark them
axis(2, tick=TRUE)  #Y-axis markings are straightforward
dev.copy(png,file="./plot2.png",width=480,height=480)
dev.off()           # After copying to png, turn off device