# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# filter by baltimore
baltimoreData <- subset(NEI, fips=="24510")

# aggregrate the data by year
yearwisedata <- aggregate(baltimoreData[,"Emissions"], list(baltimoreData$year), mean)

# setup the device
png(filename = "plot2.png", width = 480, height = 480)

# plot
plot(yearwisedata, xlab="Year", ylab="PM2.5 (Mean)" , pch=19, main="Baltimore City Data")
lines(yearwisedata$Group.1, yearwisedata$x, type="l")

# close the handle
dev.off()