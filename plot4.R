# This script is to create a plot to show how have emissions 
# from coal combustion-related sources changed from 1999–2008?
library(ggplot2)

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

#### subset data of coal combustion-related sources
index<-(grep('Coal',SCC$Short.Name))
coalrel<-SCC$SCC[index]
coaldata<-subset(NEI, SCC %in% coalrel)

#### plot and save to file
ydata<-with(coaldata,tapply(Emissions,year,sum,na.rm = T))
year<- names(ydata)
png(filename = "plot4.png", width = 480, height = 480)
plot(year,ydata,type = "l", xlab = "Year", ylab = "Total Emissions(tons)", main ="Coal-related PM2.5 Emission changed from 1999–2008")
dev.off()
