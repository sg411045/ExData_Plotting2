library(dplyr)
library(ggplot2)
library(RColorBrewer)


# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset motor vehicle monitors
sccFuelComb <- SCC[grep("Vehicle", SCC$EI.Sector),]

# subset emissions for fuel combustion in Baltimore & LA
emissionFuelComb <- NEI[ which( (NEI$SCC %in% sccFuelComb$SCC) & (NEI$fips == "24510" | NEI$fips == "06037")  ), ]

# aggregrate the data by year and city
fuelCombDataSummary <- emissionFuelComb %>% group_by(year, fips) %>% summarise_at(.vars = "Emissions", .funs= mean)

# setup the lookup for city codes


# setup the color pallete
plotColors <- brewer.pal(3,"Set1")
names(plotColors) <- levels(fuelCombDataSummary$fips)
colorScale <- scale_colour_manual(name = "City", labels=c("Los Angeles", "Baltimore"), values = plotColors)


# plot
p <- ggplot(fuelCombDataSummary,
            aes(fuelCombDataSummary$year,fuelCombDataSummary$Emissions,colour = as.factor(fuelCombDataSummary$fips))) + geom_point() + geom_line() + colorScale 

# annotate
p <- p + labs(x="Year", y="PM2.5 Emissions", title="Motor Vehicle PM2.5 Emissions Baltimore vs Los Angeles") 

# save
ggsave("plot6.png", p)