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
subdata<-subset(NEI, subset = (fips %in% c("24510","06037")), c(fips,SCC,Emissions,year))
index<-grepl('vehicle',SCC$SCC.Level.Two, ignore.case=TRUE)
motorrel<-SCC$SCC[index]
subdata2<-subset(subdata, SCC %in% motorrel)
df <- aggregate(Emissions ~ year + fips, subdata2, sum)

#### plot and save to file
png(filename = "plot6.png", width = 960, height = 480)
g<-ggplot(df,aes(year,Emissions,color = fips))
g+geom_line() +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Total Emissions from vechicle in Baltimore and Los Angeles")
dev.off()
