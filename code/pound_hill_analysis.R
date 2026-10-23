# Wrangle the Pound Hill dataset.
# Run from the coursework project root with:
# Rscript code/pound_hill_analysis.R

getwd()

# load data
MyData <- as.matrix(read.csv("data/pound_hill_data.csv", header = FALSE))
dim(MyData) # dimension
str(MyData) # column types
head(MyData) # first few rows

#load meta data
MyMetaData <- read.csv("data/pound_hill_meta_data.csv", header = TRUE, sep = ";")
dim(MyMetaData) # dimension
str(MyMetaData) # column types
head(MyMetaData) # first few rows

# convert blank species count to observed zero
MyData[MyData == ""] <- 0

# reshape MyData to long form
# transpose to swap columns and rows
MyData <- t(MyData)
colnames(MyData) # null
TempData <- as.data.frame(MyData[-1,], stringsAsFactors = FALSE) # without coloumn names
head(TempData)
# assign back originla column names
colnames(TempData) <- MyData [1,]
head(TempData)
# get rid of row names
rownames(TempData) <- NULL
head(TempData)
require(reshape2) # load the reshape2 package
MyWrangledData <- melt(TempData, id= c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

# assigning data types
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])
# speices already converted into factor in melt function

# check results
View(MyWrangledData)
all(is.finite(MyWrangledData$Count)) # numeric and non-negative
length(unique(MyWrangledData$Species)) # number of distinct species
length(unique(paste(MyWrangledData$Cultivation, MyWrangledData$Block, MyWrangledData$Quadrat,MyWrangledData$Plot ))) # distinct quadrats
# 12 different plots

# make a quadrat-level table with richness
# subset the cultivation block, plot, quadrat
# make a loop counting if the count of species is greater than zero
# add it to the subset
require(tidyverse)
richnessdata<-filter(MyWrangledData, Count > 0)
head(richnessdata)

Richnesstable <-richnessdata %>%
    group_by (Cultivation, Block, Plot, Quadrat) %>%
        summarise(Richness = n_distinct(Species))
head(Richnesstable)

# plot-level summary sorting by plot
levels(Richnesstable$Plot)
Richnesstable$Plot <-factor(Richnesstable$Plot, levels = c(1:12))
Plotmeanrichness <- Richnesstable %>%
    group_by (Plot, Cultivation, Block) %>%
        summarise(MeanRichness = mean(Richness), .groups = "drop") 

write.csv(Plotmeanrichness, "results/pound_hill_plot_richness.csv", row.names = FALSE)    
head(Plotmeanrichness) 

# drawing figure of plot-level mean across cultivation treatments
require(ggplot2)
pdf("results/pound_hill_plot_richness.pdf")
ggplot(Plotmeanrichness,
       aes(x = Cultivation, y = MeanRichness)) +
  geom_boxplot() +
  geom_point()


# interpretation of the figure
# May have the highest typical richness shown by the median of the box plot.
# The points are wide spread so there is high variability within treatments.
# The figure alone does not show causal relationship between cultivation time and mean species richness. 
# More information is needed e.g. whether cultivation treatments are randomly assigned to plots.


# readme: source script, inputs, brief run/check note

# Repeat the plot-level summary for total abundance, calculated as the sum of species counts in each quadrat. 
# Compare its pattern with richness. 
# Why might the two responses tell different ecological stories?

## total abundance plot-level
Abundance <-richnessdata %>%
    group_by (Cultivation, Block, Plot, Quadrat) %>%
        summarise(Abundance = sum(Count))
head(Abundance)

# plot-level summary sorting by plot
levels(Abundance$Plot)
Abundance$Plot <-factor(Abundance$Plot, levels = c(1:12))
Plotmeanabundance <- Abundance %>%
    group_by (Plot, Cultivation, Block) %>%
        summarise(MeanAbundance = mean(Abundance), .groups = "drop") 

require(ggplot2)
pdf("results/pound_hill_plot_abundance.pdf")
ggplot(Plotmeanabundance,
       aes(x = Cultivation, y = MeanAbundance)) +
  geom_boxplot() +
  geom_point()
dev.off()

# October have the highest typical abundance shown by the median of the box plot
# but there is high variety of mean species abundance among plots within treatments
# high richness and high abundance do not necessarily corelate with each other.
# high richness lower abundance: many type of species but each species have few individuals
# high abundance low richness: some dominant species