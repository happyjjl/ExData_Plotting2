## plot6.R
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

# Subset the vehicles NEI data by each city's fip and add city name.
baltimoreVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "24510", ]
city <- data.frame(city = rep("Baltimore", nrow(baltimoreVehiclesNEI)))
baltimoreVehiclesNEI <- cbind(baltimoreVehiclesNEI, city)

laVehiclesNEI <- vehiclesNEI[vehiclesNEI$fips == "06037", ]
city <- data.frame(city = rep("Los Angeles", nrow(laVehiclesNEI)))
laVehiclesNEI <- cbind(laVehiclesNEI, city)

# Combine data frames
bothNEI <- rbind(baltimoreVehiclesNEI,laVehiclesNEI)

## plot and save to file
g <- ggplot(bothNEI, aes(factor(year), Emissions, fill = city)) +
  geom_bar(stat = "identity") + 
  guides(fill = FALSE) +
  facet_grid(.~city) + 
  labs(x = "year", y = "Total PM2.5 Emissions", title = "Vehicle Emission, Baltimore vs Los Angeles 1999-2008") 

ggsave("plot6.png", g)
