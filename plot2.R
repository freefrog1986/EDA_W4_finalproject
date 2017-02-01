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
sub1999<- subset(NEI, subset = (fips == "24510" & year == 1999), c(SCC,Emissions,year))
sub2002<- subset(NEI, subset = (fips == "24510" & year == 2002), c(SCC,Emissions,year))
sub2005<- subset(NEI, subset = (fips == "24510" & year == 2005), c(SCC,Emissions,year))
sub2008<- subset(NEI, subset = (fips == "24510" & year == 2008), c(SCC,Emissions,year))

sum1999<- sum(sub1999$Emissions)
sum2002<- sum(sub2002$Emissions)
sum2005<- sum(sub2005$Emissions)
sum2008<- sum(sub2008$Emissions)

#### plot and save to file
year<- unique(NEI$year)
total<-c(sum1999, sum2002, sum2005, sum2008)
png(filename = "plot2.png", width = 480, height = 480)
plot(year,total,type = "l",main ="PM2.5 emission in Maryland from 1999 to 2008")
dev.off()
