# Reading the data (Pre Step: Working directory is already set and data is downloaded to working directery)
Nei <- readRDS("summarySCC_PM25.rds")
Scc <- readRDS("Source_Classification_Code.rds")

#Check to see if data is correctly read
head(Nei)
nrow(Nei)
summary(Nei)
head(Scc)
nrow(Scc)
summary(Scc)

#Extract Baltimore Data
BaltimoreData <- subset(Nei, fips == "24510")
head(BaltimoreData)
nrow(BaltimoreData)

#Extract LA County Data
LAdata <- subset(Nei, fips == "06037")
head(LAdata)
nrow(LAdata)

#Extract Motor Vehicle Data
MobileData <- Scc[grepl("Mobile - On-Road", Scc$EI.Sector, ignore.case = TRUE), ]

#Extract Baltimore and LA Motor Vehicle data

BaltimoreMbldata <- subset(BaltimoreData, SCC %in% MobileData$SCC)
nrow(BaltimoreMbldata)

LAMbldata <- subset(LAdata, SCC %in% MobileData$SCC)
nrow(LAMbldata)

#Combine both data frames
CombinedData <- rbind(BaltimoreMbldata, LAMbldata)
nrow(CombinedData)
head(CombinedData)

plotdata <-  aggregate(Emissions ~ year + fips, CombinedData, sum)

nrow(plotdata)
head(plotdata)
print(plotdata)

#Add another variable "County" to the data frame, which is later used in the plot function

plotdata$County <- NA
plotdata$County[plotdata$fips== "06037"] <- "LA County"
plotdata$County[plotdata$fips== "24510"] <- "Baltimore"
nrow(plotdata)
head(plotdata)
print(plotdata)

x <- plotdata$year
y <- plotdata$Emissions

png("plot6.png", width=480, height=480) #opening png graphic device
qplot(x,y,data = plotdata, geom = "line", color = County, main = "Baltimore vs Los Angeles County", xlab = "year", ylab = "Motor Vehicle" ~ PM[2.5] ~ "(tons)")
dev.off() #closing the device



