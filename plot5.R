library(dplyr)
library(ggplot2)

## Read data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

motorCodes <- SCC[grep(".*Vehicles", SCC$EI.Sector), ]
motorNEI <- NEI %>% subset(NEI$SCC %in% motorCodes$SCC & fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))

ggplot(motorNEI, aes(x = factor(year), y = total, fill = year)) + 
        geom_bar(stat="identity") +
        xlab("Year") + 
        ylab("Total PM2.5 emittion, in tons") + 
        ggtitle("Emissions from motor vehicle sources in Baltimore City")

dev.copy(device = png, filename = "plot5.png", width = 600)
dev.off()
