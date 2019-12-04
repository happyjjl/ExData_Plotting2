## plot5.R
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

## Subset vehicles related NEI data
vehiclesSCC <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE), ]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC, ]

# Subset the vehicles NEI data to Baltimore's fip
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]

## plot and save to file
g <- ggplot(baltimoreVehiclesNEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "red") + 
  labs(x = "year", y = "Total PM2.5 Emissions", title = "Vehicle Emission, Baltimore 1999-2008") 

ggsave("plot5.png", g)
