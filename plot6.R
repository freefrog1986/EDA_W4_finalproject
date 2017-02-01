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
subdata<-subset(NEI, subset = (fips == c("24510","06037")), c(fips,SCC,Emissions,year))
index<-grepl('Vehicle',SCC$Short.Name)
motorrel<-SCC$SCC[index]
subdata2<-subset(subdata, SCC %in% motorrel)
spldata<-split(subdata2, subdata2$fips)
sumdata1<-with(spldata$`06037`,tapply(Emissions,year,sum,na.rm = T))
sumdata2<-with(spldata$`24510`,tapply(Emissions,year,sum,na.rm = T))
df<-data.frame(city=c(rep('LA',4),rep('Bal',4)),Emissions=c(sumdata1,sumdata2),year= rep(names(sumdata2),2))

#### plot and save to file
png(filename = "plot6.png", width = 960, height = 480)
g<-ggplot(df,aes(year,Emissions))
g+geom_point(alpha=1)+facet_grid(.~city)
dev.off()
