##Running this script will make a lineplot of the globalactive power vs time for Feb 1st and 2nd
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
par(mfrow = c(1,1))

#Create the lineplot in a png file.
png(filename = "plot2.png")
plot(housepow$newTime, housepow$Global_active_power, type="n", xlab ="", 
     ylab = "Global active power (kilowats)")
lines(housepow$newTime, housepow$Global_active_power)
dev.off()