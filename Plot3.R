
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

#Install necessary package
#install.packages("ggplot2")
library(ggplot2)

#Extracting Only Baltimore data
BaltimoreData <- subset(Nei, fips == "24510")
head(BaltimoreData)
nrow(BaltimoreData)


PlotData <-  aggregate(Emissions ~ year + type, BaltimoreData, sum)
print(PlotData)
#nrow(PlotData)


x <- PlotData$year
print(x)
y <- PlotData$Emissions

png("plot3.png", width=480, height=480) #opening png graphic device
qplot(x,y,data = PlotData, geom = "line", color = type, main = "Emission Comparision by Source for Baltimore", xlab = "Year", ylab = expression("Emission" ~ PM[2.5] ~ "(tons)"))
dev.off() #closing the device
