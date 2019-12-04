## plot3.R
## version:	1.0
## author:	jin.jiangli@mayo.edu

library(ggplot2)

## Load data 
if (file.exists("summarySCC_PM25.rds")){
  NEI <- readRDS("summarySCC_PM25.rds")
} else stop("File summarySCC_PM25.rds not found!")	

if (file.exists("Source_Classification_Code.rds")){
  SCC <- readRDS("Source_Classification_Code.rds")
} else stop("File Source_Classification_Code.rds not found!")	

## data in the Baltimore City, Maryland
subNEI <- NEI[NEI$fips == "24510",]

## plot and save to file
g <- ggplot(subNEI, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") + 
  guides(fill = FALSE) +
  facet_grid(.~type) + 
  labs(x = "year", y = "Total PM2.5 Emissions", title = "PM2.5 Emission,Baltimore City 1999-2008 by Source Type") 

ggsave("plot3.png", g)
