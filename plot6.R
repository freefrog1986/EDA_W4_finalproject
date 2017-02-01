# Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, 
# Which city has seen greater changes over time in motor vehicle emissions?
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

#### subset data
submary<- subset(NEI, subset = (fips == "24510"), c(SCC,Emissions,year))
subcal<- subset(NEI, subset = (fips == "06037"), c(SCC,Emissions,year))
index<-grepl('Vehicle',SCC$Short.Name)
motorrel<-SCC$SCC[index]
motordata1<-subset(submary, SCC %in% motorrel)
motordata2<-subset(subcal, SCC %in% motorrel)

#### plot and save to file
year<- unique(NEI$year)
xdata1<-with(motordata1,tapply(Emissions,year,sum,na.rm = T))
xdata2<-with(motordata2,tapply(Emissions,year,sum,na.rm = T))
df<-data.frame(year = year, marypm2.5 = xdata1, calpm2.5 = xdata2)
df$calpm<-(df$calpm2.5-min(df$calpm2.5))/(max(df$calpm2.5)-min(df$calpm2.5))
df$marypm<-(df$marypm2.5-min(df$marypm2.5))/(max(df$marypm2.5)-min(df$marypm2.5))
png(filename = "plot6.png", width = 960, height = 480)
par(mfrow = c(1,2))
with(df, plot(year,df$marypm,type = 'n'))
title(main = 'Baltimore City emissions')
lines(year,df$marypm)
with(df, plot(year,df$calpm,type = 'n'))
title(main = 'Los Angeles emissions')
lines(year,df$calpm)
dev.off()