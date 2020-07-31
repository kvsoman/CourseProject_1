# Name the input file "household_power_consumption.txt" 
# It contains only the data requirerd for this assignment
# place it in the same folder where the *.R files are. 
# I have explanatory comments in plot1.R & plot2.R

# Generate PLOT 1
x <- read.table("household_power_consumption.txt", sep=";",
    header = TRUE)
dev.new() #Initiate the device, plot histogram, and copy to png
hist(x$Global_active_power,col = "red",main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.copy(png,file="./plot1.png",width=480,height=480)
dev.off()
