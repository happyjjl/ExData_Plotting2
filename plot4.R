## plot4.R
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

## Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, ]$SCC
combustionNEI <- NEI[NEI$SCC %in% combustionSCC,]

## plot and save to file
g <- ggplot(combustionNEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "red") + 
  labs(x = "year", y = "Total PM2.5 Emissions", title = "Coal Combustion Source Emission, US 1999-2008") 

ggsave("plot4.png", g)
