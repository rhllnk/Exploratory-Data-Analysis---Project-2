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

x <- with(Nei, tapply(Emissions, year, sum))
#print(x)
#?plot

png("plot1.png", width=480, height=480) #opening png graphic device
plot(names(x), x, type = "o", col = "red", ylab = expression("Total" ~ PM[2.5] ~ "Emission (tons)"), xlab = "Year", pch = 19, main = expression("Total" ~ PM[2.5] ~ "Emission in United States"))
dev.off() #closing the device
