# this script is to create the plot1 which is aim to show the trend of total 
# PM2.5 emission in the United States from 1999 to 2008.

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

#### subset data of different year
alldata<-with(NEI, tapply(Emissions,year,sum))
year<-names(alldata)

#### plot and save to file
png(filename = "plot1.png", width = 480, height = 480)
plot(year,alldata,type = "l", xlab = "Year", ylab = "Total Emissions(tons)",main ="PM2.5 Emission in USA from 1999 to 2008")
dev.off()
