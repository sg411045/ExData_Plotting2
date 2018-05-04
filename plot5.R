library(dplyr)
library(ggplot2)

# read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# subset motor vehicle monitors
sccFuelComb <- SCC[grep("Vehicle", SCC$EI.Sector),]

# subset emissions for fuel combustion in Baltimore
emissionFuelComb <- NEI[ which( (NEI$SCC %in% sccFuelComb$SCC) & (NEI$fips == "24510")  ), ]

# aggregrate the data by year and type
fuelCombDataSummary <- emissionFuelComb %>% group_by(year, type) %>% summarise_at(.vars = "Emissions", .funs= mean)

# plot
p <- ggplot(fuelCombDataSummary,
            aes(fuelCombDataSummary$year,fuelCombDataSummary$Emissions)) + geom_point() + geom_line() 

# annotate
p <- p + labs(x="Year", y="PM2.5 Emissions", title="Motor Vehicle PM2.5 Emissions across Baltimore")

# save
ggsave("plot5.png", p)