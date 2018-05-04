# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# aggregrate the data by year
yearwisedata <- aggregate(NEI[,"Emissions"], list(NEI$year), mean)

# setup the device
png(filename = "plot1.png", width = 480, height = 480)

# plot
plot(yearwisedata, xlab="Year", ylab="PM2.5 (Mean)" , pch=19)
lines(yearwisedata$Group.1, yearwisedata$x, type="l")

# close the handle
dev.off()