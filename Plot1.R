##Running this script will make a histogram of the Global active power for Feb 1st and 2nd
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
housepow<-read.table(filename, sep = ";", comment.char = "?", skip = 66637, nrows = 69517-66637)
colnames(housepow) <- columns

## Make sure the settings are right for plot
par(mfrow = c(1,1))

#Create the histogram in a png file.
png(filename = "Plot1.png")
hist(housepow$Global_active_power, col="red",
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()