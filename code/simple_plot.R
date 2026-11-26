MyDF <- read.csv("data/ecol_archives_e_089_51_d_1.csv")
dim(MyDF) #check the size of the data frame I load
str(MyDF)
head(MyDF)
require(tidyverse)
glimpse(MyDF)


MyDF$Type.of.feeding.interaction <- as.factor (MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)
str(MyDF)

unique(MyDF$Prey.mass.unit)
# convert mg to g and adjust mass values
MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"] <- MyDF$Prey.mass[MyDF$Prey.mass.unit == "mg"]/1000
MyDF$Prey.mass.unit[MyDF$Prey.mass.unit == "mg"] <- "g"

#scatter plot
plot(MyDF$Predator.mass, MyDF$Prey.mass)
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass))
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass),pch=20) # change marker
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch=20, xlab = "Predator Mass (g)", ylab = "Prey Mass (g)") # add labels

#histogram