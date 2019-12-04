## plot1.R
## version:	1.0
## author:	jin.jiangli@mayo.edu

## Load data 
if (file.exists("summarySCC_PM25.rds")){
  NEI <- readRDS("summarySCC_PM25.rds")
} else stop("File summarySCC_PM25.rds not found!")	

if (file.exists("Source_Classification_Code.rds")){
  SCC <- readRDS("Source_Classification_Code.rds")
} else stop("File Source_Classification_Code.rds not found!")	

## group by year and sum of Emissions
totalPM25 <- tapply(NEI$Emissions,NEI$year,sum)

## plot and save to file
png(filename = "plot1.png")
barplot(
  totalPM25, 
  xlab = "year", 
  ylab = "Total PM2.5 Emissions", 
  main = "Total PM2.5 Emissions over Years in US"
)
dev.off()