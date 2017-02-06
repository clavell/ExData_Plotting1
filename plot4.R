##Running this script will make a series of exploratory plots for data from Feb 1st and 2nd
##in 2007. 

## First check to see if the data has already been downloaded. If not, download it.
if(!file.exists("data.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, destfile = "data.zip", method = "curl")
        rm(fileURL)
}

# Read data in to R.
unzip("data.zip")        
filename <- "household_power_consumption.txt"
columns <- as.character(read.table(filename, nrows=1,sep=";", stringsAsFactors = FALSE))
housepow<-read.table(filename, sep = ";", comment.char = "?", skip = 66637, nrows = 69517-66637,
                     stringsAsFactors = FALSE)
colnames(housepow) <- columns

## Change dates in time into useable format
housepow$Date<-as.Date(housepow$Date,format = "%d/%m/%Y")
housepow <- transform(housepow, newTime = as.POSIXct(paste(housepow$Date,housepow$Time)))

## Make sure the settings are right for plot
par(mfrow = c(2,2))

#Create the lineplots in a png file.

with(housepow, {
        
        #plot1
        plot(newTime, Global_active_power, type="n", xlab ="", ylab = "Global active power (kilowats)")
        lines(newTime, Global_active_power)
        
        #plot2
        plot(newTime,Voltage, ylab = "Voltage", xlab ="datetime", type = "n")
        lines(newTime, Voltage)
        
        #plot3
        plot(newTime, Sub_metering_1, type= "n", ann = FALSE)
        title(ylab = "Energy sub metering")
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), 
               col = c("black", "red", "blue"), bty = "n", cex=0.75, xpd =FALSE) 
        lines(newTime, Sub_metering_1)
        lines(newTime, Sub_metering_2, col = "red")
        lines(newTime, Sub_metering_3, col = "blue")
        
        #plot4
        plot(newTime, Global_reactive_power, xlab="datetime", type = "n")
        lines(newTime, Global_reactive_power)
})
dev.copy(png,file="plot4.png")
dev.off()
par(mfrow=c(1,1))