init <- function(){
  if(!file.exists("./data/")){
    dir.create("./data")
  }
  if(!file.exists("./data/exdata-002/")){
    dir.create("./data/exdata-002/")  
  }
  setwd("~/data/exdata-002/")
  message("Checking project file...")
  if(!file.exists("./exdata-data-household_power_consumption.zip")){
    message("Checking project file. [NOT FOUND]")
    message("downloading project file...")
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./exdata-data-household_power_consumption.zip", method="curl")
    message("downloading project file. [DONE]")
  }else{
    message("Checking project file. [EXISTED]")
  }
  
  if(!file.exists("./household_power_consumption.txt")){
    unzip("./exdata-data-household_power_consumption.zip", exdir="./")
  }
}

load_data <- function(){
  message("Loading data...")
  #setAs("character","Date", function(from) as.Date(from, format="%d/%m/%Y"))
  #setAs("character","POSIXct", function(from) as.Date(from, format="%X"))
  
  # Date;Time;Global_active_power;Global_reactive_power;Voltage;Global_intensity;Sub_metering_1;Sub_metering_2;Sub_metering_3
  # colClasses = c("myDate", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
  result <- read.csv("./household_power_consumption.txt", sep = ";", na.strings = "?",  colClasses = c("character", "character", "real", "real", "real", "real", "real", "real", "real"), header=T)
  message("Loading data. [DONE]")
  return(result)
}

plot1 <- function(){
  init()
  d <- load_data()
  d <- d[d$Date %in% c("1/2/2007", "2/2/2007"),]
  png("./plot1.png")
  plot.new()
  par(bg="transparent")
  hist(d$Global_active_power, col="red", xlab="Global Active Power (killowatts)", main="Global Active Power")
  dev.off()
  message(paste0("Image created in ", getwd(), "/plot1.png"))
}