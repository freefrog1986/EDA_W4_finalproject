# This script is to create a plot to show PM2.5 emissions trend of different 
# source type in the Baltimore City, Maryland use ggplot2 plotting system.
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

#### subset data in Maryland
submary<- subset(NEI, subset = (fips == "24510"), c(type,Emissions,year))
aggdata <- aggregate(Emissions ~ year + type, submary, sum)

#### plot and save to file
png(filename = "plot3.png", width = 480, height = 480)
g<-ggplot(aggdata,aes(x= year, y= Emissions, color = factor(type)))
g + geom_line() + 
  xlab("Year")+
  ylab("PM2.5 Total Emissions(tons)")+
  ggtitle("Trend of different source type in the Baltimore City")
dev.off()

