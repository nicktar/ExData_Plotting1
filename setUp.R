setup <- function() {
    if (!require('data.table')) {
        writeLines("Need to install data.table package")
        install.packages("data.table")
        if (require('data.table')) {
            writeLines('data.table package installed')
        } else {
            stop('Could not install required package data.table.')
        }
    }
    if (!file.exists("data")) {
        dir.create("data")
    }
    if (!file.exists("data/household_power_consumption.txt")) {
        if (!file.exists("data/household_power_consumption.zip")) {
            download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data/household_power_consumption.zip")
        }
        setwd("data")
        unzip("household_power_consumption.zip")
        setwd("..")
    }
    return
}

readData1 <- function() {
    data <- read.csv(file="data/household_power_consumption.txt", na.strings=c("?"), sep=";")
    date <- subset(data, grepl("[12]/2/2007", data$Date))
    within(data, DateTime <- strptime(paste(data$Date, data$Time, sep="-"), format="%d/%m/%Y-%H:%M:%S", tz = ""))
    data <- as.data.table(data)
}
