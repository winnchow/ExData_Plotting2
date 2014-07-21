# Plot 2

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Calculate the sum of emissions per year
data <- aggregate(Emissions ~ year, FUN=sum, na.rm=TRUE, data=NEI[NEI$fips == "24510", ])

# Generate the plot
png(file = "plot2.png")
with(data, plot(year, Emissions, main=expression("Total Emissions from PM"[2.5]*" in the Baltimore City, Maryland"), xlab="Year", ylab="Total Emissions (tons)"))
dev.off()