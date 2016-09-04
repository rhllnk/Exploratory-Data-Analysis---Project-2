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

#Extracting Only Baltimore data
BaltimoreData <- subset(Nei, fips == "24510")
head(BaltimoreData)
nrow(BaltimoreData)

x <- with(BaltimoreData, tapply(Emissions, year, sum))
print(x)

png("plot2.png", width=480, height=480) #opening png graphic device
plot(names(x), x, type = "o", col = "red", ylab = expression("Emission" ~ PM[2.5] ~ "(tons)"), xlab = "Year", pch = 19, main = expression("Total" ~ PM[2.5] ~ "Emission in Baltimore"))
dev.off() #closing the device

