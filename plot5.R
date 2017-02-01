# This script is to create a plot to show how have emissions 
# from motor vehicle sources changed from 1999–2008 in Baltimore City.
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
submary<- subset(NEI, subset = (fips == "24510"), c(SCC,Emissions,year))
index<-grepl('Vehicle',SCC$Short.Name)
motorrel<-SCC$SCC[index]
motordata<-subset(submary, SCC %in% motorrel)

#### plot and save to file
year<- unique(NEI$year)
xdata<-with(motordata,tapply(Emissions,year,sum,na.rm = T))
png(filename = "plot5.png", width = 480, height = 480)
plot(year,xdata,type = "l",xlab = "Year", ylab = "Total Emissions(tons)",main ="Motor Vehical PM2.5 changed from 1999–2008")
dev.off()


