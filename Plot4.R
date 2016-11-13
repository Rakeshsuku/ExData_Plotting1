############### Exploratoty Data Analysis Project - Plot4.R ###############

## Read first 100 rows to a temporary dataframe temp to determine the class of 
## each column in the dataset. Specifying the class helps the read operation to 
## run faster when the complete data set is read.

temp <- read.table(file = "household_power_consumption.txt", 
                   header = TRUE,
                   sep = ";",
                   na.string = "?",
                   nrow = 100)

classVector <- sapply(temp, class)


## Read the complete data set without nrow argument but by specifying class for 
## each column.

fullData <- read.table(file = "household_power_consumption.txt", 
                       header = TRUE,
                       sep = ";",
                       na.string = "?",
                       colClasses = classVector)

## Remove temp and classVector.
rm("temp", "classVector")

## Check the variable names and classes.
names(fullData)
str(fullData)


## Change Date into correct format:
fullData$Date <- as.Date(fullData$Date, format = "%d/%m/%Y")
head(fullData$Date)

## Copy Data for dates 2007-02-01 and 2007-02-02 to a new dataframe 
## householdData and remove fullData.

householdData <- subset(fullData, 
                        Date %in% as.Date(c("2007-02-01", "2007-02-02"), 
                                          format = "%Y-%m-%d"))

rm(fullData) ## Remove fullData

## Examine householdData
head(householdData)
str(householdData)

## Convert Time to correct format:
householdData$Time <- strptime(paste(householdData$Date, 
                                     householdData$Time, 
                                     sep = " "), 
                               format = "%Y-%m-%d %H:%M:%S")

######################### Plot 4 #########################
## Plotting to Plot4.png:

png(filename = "Plot4.png",
    width = 480,
    height = 480)

par(mfrow = c(2, 2)) 
## 1 ##
plot(householdData$Time, householdData$Global_active_power, 
     xlab = "",
     ylab =  "Global Active Power(kilowatts)",
     type ="n")
lines(householdData$Time, householdData$Global_active_power)

## 2 ## 
plot(householdData$Time, householdData$Voltage, 
     xlab = "datetime",
     ylab =  "Voltage",
     type ="n")
lines(householdData$Time, householdData$Voltage)

## 3 ##
plot(householdData$Time, householdData$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(householdData$Time, householdData$Sub_metering_1)
lines(householdData$Time, householdData$Sub_metering_2, col ="red")
lines(householdData$Time, householdData$Sub_metering_3, col ="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       lwd = c(1, 1, 1),
       col = c("black", "red", "blue"))

## 4 ##
plot(householdData$Time, householdData$Global_reactive_power, 
     xlab = "datetime",
     ylab =  "Global_reactive_power",
     type ="n")
lines(householdData$Time, householdData$Global_reactive_power)

dev.off()

################################################################################
