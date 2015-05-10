# create 'data' directory if one doesn't exist
if (!file.exists("./data")) {dir.create("./data")}

# download the zip file containing the data
fileUrl <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileUrl, './data/power_consumption.zip')

# unzip the files into the 'data' directory
unzip('./data/power_consumption.zip', exdir='./data')

# read in the data
data <- read.table("./data/household_power_consumption.txt", 
                   header = TRUE, sep = ";", 
                   stringsAsFactors = FALSE);

data$Date <- as.Date(data$Date,"%d/%m/%Y")                              # convert date string to date objects
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]    # filter dates to only 2007-02-01 and 2007-02-02
data$DateTime <- paste(data$Date, data$Time, sep = " ")                 # create new column that includes date and time
data$DateTime <- as.POSIXct(data$DateTime)                              # convert DateTime column to POSIXct object

# open png device and create 'plot2.png' in working directory
png(file = "plot2.png")

# create plot
plot(
  data$DateTime, data$Global_active_power, 
  type="l", 
  xlab="", 
  ylab="Global Active Power (kilowatts)", 
  bg = "transparent"
  )

# close the png device
dev.off()