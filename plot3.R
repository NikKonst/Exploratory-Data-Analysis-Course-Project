library(dplyr)
library(ggplot2)

## Read data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

baltimoreByType <- NEI %>% subset(fips == "24510") %>% group_by(year, type) %>%
        summarise(total = sum(Emissions))

ggplot(baltimoreByType, aes(x = factor(year), y = total, fill = type)) +
        #scale_size_identity() +
        geom_bar(stat="identity") + 
        facet_grid(.~type, scales = "free_x") + 
        xlab("Year") + 
        ylab("Total PM2.5 emittion, in tons") +
        ggtitle("PM2.5 emittion in the Baltimore City by type")

dev.copy(device = png, filename = "plot3.png", width = 600)
dev.off()

