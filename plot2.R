library(dplyr)

## Read data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

totalPM <- NEI %>% subset(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))

barplot(height = totalPM$total, names = totalPM$year, col = totalPM$year, xlab = "Years", 
        ylab = "Total PM2.5 emittion, in tons", 
        main = "Total PM2.5 emittion in the Baltimore City")

dev.copy(device = png, filename = "plot2.png")
dev.off()