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
  result <- read.csv("./household_power_consumption.txt", sep = ";", na.strings = "?",  colClasses = c("character", "character", "real", "real", "real", "real", "real", "real", "real"), header=T)
  message("Loading data. [DONE]")
  return(result)
}

qdate <- function(date_in_text){
  return(as.Date(date_in_text, "%d-%m-%Y"))
}

plot2 <- function(){
  init()
  d <- load_data()
  d <- d[d$Date %in% c("1/2/2007", "2/2/2007"),]
  #d$Date <- as.Date(d$Date, "%d/%m/%Y")
  #d$FullDate <- as.POSIXlt(paste(d$Date, d$Time))
  
  png("./plot2.png")
  plot.new()
  par(bg="transparent")
  plot(d$Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab="", xaxt = "n")
  axis(1, at=c(1,nrow(d)/2,nrow(d)), labels=c("Thu", "Fri", "Sat"))
  # plot(d$Global_active_power, type="l", ylab="Global Active Power (killowatts)", xlab="")
  dev.off()
  message(paste0("Image created in ", getwd(), "/plot2.png"))
}