
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

library(ggplot2)

#Extract only Coal Data:
#Initially Coal related data is identified from Source_Classification_Code.rds
#and data is extracted from Nei data frame for above SCC digit strings

Temp.CoalData <- Scc[grepl("Coal", Scc$Short.Name, ignore.case = TRUE), ]
head(Temp.CoalData)
names(Temp.CoalData)
nrow(Temp.CoalData)

CoalData <- subset(Nei, SCC %in% Temp.CoalData$SCC)

head(CoalData)
nrow(CoalData)

PlotData <-  aggregate(Emissions ~ year + type, CoalData, sum)

print(PlotData)
x <- PlotData$year
y <- PlotData$Emissions

png("plot4.png", width=480, height=480) #opening png graphic device
qplot(x,y,data = PlotData, geom = "line", color = type,  main = "Emissions from Coal Combustion Sources", xlab = "year", ylab = expression("Emission" ~ PM[2.5] ~ "(tons)"))
dev.off() #closing the device

