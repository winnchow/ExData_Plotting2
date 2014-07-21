# Plot 5

# 5. How have emissions from motor vehicle sources changed from 1999¡V2008 
# in Baltimore City?

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# SCC of all motor vehicle sources
# All sources with data category = 'Onroad'
SCC.onroad <- SCC[SCC$Data.Category == "Onroad", ]

# All emissions from motor vehicle sources
NEI.onroad <- NEI[NEI$SCC %in% SCC.onroad$SCC, ]

# Calculate the sum of emissions per year
data <- aggregate(Emissions ~ year, FUN=sum, na.rm=TRUE, data=NEI.onroad[NEI.onroad$fips == "24510", ])
model <- lm(Emissions ~ year, data)

# Generate the plot
png(file = "plot5.png")
with(data, plot(year, Emissions, main=expression("Total Emissions from PM"[2.5]*" from Motor Vehicles in the Baltimore City"), xlab="Year", ylab="Total Emissions (tons)"))
abline(model)
dev.off()
