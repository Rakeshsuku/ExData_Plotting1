############### Exploratoty Data Analysis Project - Plot1.R ###############

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

######################### Plot 1 ######################### 
## Plotting to Screen:

hist(householdData$Global_active_power,
     col = "red",
     xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")

## Ploting to Plot1.png file:

png(filename = "Plot1.png",
    width = 480,
    height = 480)

hist(householdData$Global_active_power,
     col = "red",
     xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power")

dev.off()

################################################################################