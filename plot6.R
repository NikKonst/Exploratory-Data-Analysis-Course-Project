library(dplyr)
library(ggplot2)

## Read data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

motorCodes <- SCC[grep(".*Vehicles", SCC$EI.Sector), ]
sub <- NEI %>% subset(NEI$SCC %in% motorCodes$SCC & (fips == "24510" | fips == "06037")) %>% group_by(year, fips) %>% summarise(total = sum(Emissions))
sub$County = ""
sub$County[sub$fips == "24510"] <- "Baltimore City"
sub$County[sub$fips == "06037"] <- "Los Angeles County"

ggplot(sub, aes(x = factor(year), y = total, fill = County)) + 
        geom_bar(position = "dodge", stat="identity") +
        xlab("Year") + 
        ylab("Total PM2.5 emittion, in tons") + 
        ggtitle("Emissions from motor vehicle in Baltimore City and Los Angeles County")

dev.copy(device = png, filename = "plot6.png", width = 600)
dev.off()