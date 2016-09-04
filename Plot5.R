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


#Extract Motor Vehicle related data
levels(Scc$EI.Sector)
MobileData <- Scc[grepl("Mobile - On-Road", Scc$EI.Sector, ignore.case = TRUE), ]
#Mobile - On-Road
#names(MobileData)
#nrow(MobileData)

#Extract Baltimore Mobile related data
BaltimoreMbldata <- subset(BaltimoreData, SCC %in% MobileData$SCC)
names(BaltimoreMbldata)
nrow(BaltimoreMbldata)

x <- with(BaltimoreMbldata, tapply(Emissions, year, sum))
#print(x)

png("plot5.png", width=480, height=480) #opening png graphic device
plot(names(x), x, type = "o", col = "red", ylab = expression("Emission" ~ PM[2.5] ~ "(tons)"), xlab = "Year", pch = 19, main = "Baltimore Motor Vehicle Emisson Across Years")
dev.off() #closing the device