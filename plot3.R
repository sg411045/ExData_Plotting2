# load additional libraries
library(dplyr)
library(ggplot2)
library(RColorBrewer)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")

# filter by baltimore
baltimoreData <- subset(NEI, fips=="24510")

# aggregrate the data by year and type
baltimoreDataSummary <- baltimoreData %>% group_by(year, type) %>% summarise_at(.vars = "Emissions", .funs= mean)

# setup the color pallete
plotColors <- brewer.pal(5,"Set1")
names(plotColors) <- levels(baltimoreDataSummary$type)
colorScale <- scale_colour_manual(name = "Source",values = plotColors)

# plot
p <- ggplot(baltimoreDataSummary,aes(baltimoreDataSummary$year,baltimoreDataSummary$Emissions,colour = as.factor(baltimoreDataSummary$type))) + geom_point() + geom_line() + colorScale

# annotate
p <- p + labs(x="Year", y="PM2.5 Emissions", title="Baltimore city PM2.5 Emissions", color="Source")

# save
ggsave("plot3.png", p)