# This script is to create a plot to show the trend of total PM2.5 emissions 
# in the Baltimore City, Maryland.

#### set working directory
setwd('/Users/freefrog/Studing/DataScience/gitrepo/EDA_W4_finalproject')
rm(list = ls())

#### download and read files
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
localfile <- file.path(getwd(),'original_file')
download.file(url, localfile)
unzip(localfile)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#### subset data in Maryland of different year
subdata<- subset(NEI, subset = (fips == "24510"))
baldata<-with(subdata,tapply(Emissions,year,sum))
year<- names(baldata)

#### plot and save to file
png(filename = "plot2.png", width = 540, height = 480)
plot(year,baldata,type = "l",xlab = "Year", ylab = "Total Emissions(tons)", main ="PM2.5 Emission in Maryland from 1999 to 2008")
dev.off()
