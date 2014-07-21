# Plot 4

# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999¡V2008?

# This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# SCC of all coal combustion-related sources
# All short names with 'Coal' and 'Comb' are identified as coal combustion-related sources
SCC.coalcomb <- SCC[grepl("Comb.*Coal|Coal.*Comb", SCC$Short.Name), ]

# All emissions from coal combustion-related sources
NEI.coalcomb <- NEI[NEI$SCC %in% SCC.coalcomb$SCC, ]

# Calculate the sum of emissions per year
data <- aggregate(Emissions ~ year, FUN=sum, na.rm=TRUE, data=NEI.coalcomb)

# Generate the plot
png(file = "plot4.png")
with(data, plot(year, Emissions, main=expression("Total Emissions from PM"[2.5]*" from Coal Combustion-related Sources"), xlab="Year", ylab="Total Emissions (tons)"))
dev.off()

