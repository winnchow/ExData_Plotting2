# Plot 3

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, 
# nonroad) variable, which of these four sources have seen decreases in emissions 
# from 1999¡V2008 for Baltimore City? Which have seen increases in emissions from 
# 1999¡V2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum of emissions per year and type
data <- aggregate(Emissions ~ year + type, FUN=sum, na.rm=TRUE, data=NEI[NEI$fips == "24510", ])

# Generate the plot
png(file = "plot3.png")
qplot(year, Emissions, data = data, facets = . ~ type, main=expression("Total Emissions from PM"[2.5]*" in the Baltimore City, Maryland"), xlab="Year", ylab="Total Emissions (tons)")
dev.off()