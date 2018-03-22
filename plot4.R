library(dplyr)
library(ggplot2)

## Read data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

coalCodes <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector), ]

coalNEI <- subset(NEI, NEI$SCC %in% coalCodes$SCC)
totalCoalPM <- coalNEI %>% group_by(year) %>% summarise(total = sum(Emissions))

ggplot(totalCoalPM, aes(x = factor(year), y = total, fill = year)) + 
        geom_bar(stat="identity") +
        xlab("Year") + 
        ylab("Total PM2.5 emittion, in tons") + 
        ggtitle("Emissions from coal combustion-related sources in USA")

dev.copy(device = png, filename = "plot4.png", width = 600)
dev.off()
