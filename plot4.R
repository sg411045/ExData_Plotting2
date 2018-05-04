library(dplyr)
library(dplyr)
library(ggplot2)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset the monitors for coal combustion
sccCoalComb <- subset(SCC, EI.Sector == "Fuel Comb - Electric Generation - Coal")

# subset emissions for coal combustion
emissionCoalComb <- subset(NEI, SCC %in% sccCoalComb$SCC)

# aggregrate the data by year and type
coalCombDataSummary <- emissionCoalComb %>% group_by(year, type) %>% summarise_at(.vars = "Emissions", .funs= mean)

# setup the color pallete
plotColors <- brewer.pal(5,"Set1")
names(plotColors) <- levels(coalCombDataSummary$type)
colorScale <- scale_colour_manual(name = "Source",values = plotColors)

# plot
p <- ggplot(coalCombDataSummary,aes(coalCombDataSummary$year,coalCombDataSummary$Emissions,colour = as.factor(coalCombDataSummary$type))) + geom_point() + geom_line() + colorScale

# annotate
p <- p + labs(x="Year", y="PM2.5 Emissions", title="Coal Combustion PM2.5 Emissions across United States", color="Source")

# save
ggsave("plot4.png", p)