# Working directory path, the data url and file names. We will use this
# values to check if the data exists or not
homedir <- getwd()
data_url <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
txt_file <- "household_power_consumption.txt"
zip_file <- "exdata-data-household_power_consumption.zip"
full_txt <- paste(homedir, txt_file, sep = "/")
full_zip <- paste(homedir, zip_file, sep = "/")

# Check if the data file (txt) not existed search for the compressed (zip)
# one, if it is not existed too download the data set, or extract (unzip) the
# compressed file if it is existed
if (!file.exists(full_txt)) {
    if (!file.exists(full_zip)) {
        download.file(url = data_url, destfile = full_zip)
    } else {
        unzip(zipfile = full_zip)
    }
}
# Read the data file, that will need about 150 Megabytes of RAM
# the separator is semicolon ";" and the 'not available' values symbol
# is question mark "?" all columns are numeric except Date and Time --> character
Full_Data <-
    read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                na.strings = "?", colClasses = c("character", "character", 
                "numeric", "numeric", "numeric", "numeric", "numeric", "numeric",
                "numeric"))
# Extract/subset the data that we need, i.e., from dates 2007-02-01 and 2007-02-02
data_set <-
    subset(Full_Data, as.Date(Full_Data$Date, "%d/%m/%Y") >= as.Date("01/02/2007",
           "%d/%m/%Y") & as.Date(Full_Data$Date, "%d/%m/%Y") <= as.Date("02/02/2007",
                                                                        "%d/%m/%Y"))
# Cleaning, free more memory from unnecessary objects
rm(Full_Data, homedir, data_url, txt_file, zip_file, full_txt, full_zip)
# Rename rows, rows name will not change after subset so it is better to rename it
rownames(data_set) = 1:nrow(data_set)
# Open png device for output
png(filename = "plot1.png", width = 480, height = 480, 
    units = "px", bg = "transparent")
# Create the histogram
hist(data_set$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
# Close the device
dev.off()
# We can remove the remaining data set too
rm(data_set)
