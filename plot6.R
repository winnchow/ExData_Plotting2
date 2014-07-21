# Plot 6

# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# SCC of all motor vehicle sources
# All sources with data category = 'Onroad'
SCC.onroad <- SCC[SCC$Data.Category == "Onroad", ]

# All emissions from motor vehicle sources
NEI.onroad <- NEI[NEI$SCC %in% SCC.onroad$SCC, ]

# Calculate the sum of emissions per year
data <- aggregate(Emissions ~ year + fips, FUN=sum, na.rm=TRUE, data=NEI.onroad[NEI.onroad$fips == "24510" | NEI.onroad$fips == "06037", ])

# Country names
county <- data.frame(county = c("Los Angeles", "Baltimore City"), fips = c("06037", "24510"))
# Add the county names to data
mdata <- merge(data, county, by.x = "fips", by.y = "fips")

# Generate the plot
png(file = "plot6.png")
qplot(year, Emissions, data=mdata, geom=c("point", "smooth"), method="lm", facets=.~county, main=expression("Total Emissions from PM"[2.5]*" from Motor Vehicles"), xlab="Year", ylab="Total Emissions (tons)")
dev.off()
