# Wrangle the Pound Hill dataset.
# Run from the coursework project root with:
# Rscript code/data_wrang.R

# Load the data ----------------------------------------------------------
# The first rows describe the sampling design, so do not use one as a header yet.
MyData <- as.matrix(read.csv("data/pound_hill_data.csv", header = FALSE))

# The metadata file does have a header and uses semicolons as separators.
MyMetaData <- read.csv("data/pound_hill_meta_data.csv", header = TRUE, sep = ";")

# Inspect the data -------------------------------------------------------
head(MyData)
dim(MyData)
str(MyData)
head(MyMetaData)

# Transpose so species become columns and sampled quadrats become rows.
MyData <- t(MyData) 
head(MyData)
dim(MyData)

# For this dataset, we have been told that blanks are observed absences.
# That knowledge is what allows us to record them as zero rather than NA.
MyData[MyData == ""] <- 0

# Convert the raw matrix to a data frame --------------------------------

TempData <- as.data.frame(MyData[-1, ], stringsAsFactors = FALSE) # remove first row of column names
colnames(TempData) <- MyData[1, ] # assign column names back
rownames(TempData) <- NULL

# Convert from wide to long form ----------------------------------------
# This script keeps the older reshape2 route because it is still common in
# ecological code. For n?mew work, the chapter introduces tidyr::pivot_longer().
library(reshape2)

MyWrangledData <- melt(
  TempData,
  id = c("Cultivation", "Block", "Plot", "Quadrat"),
  variable.name = "Species",
  value.name = "Count"
) # columns of species (wide form) become rows of species (long form)
head(MyWrangledData)
tail(MyWrangledData)

# categorising into levels for categorical values
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.integer(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

# Save a derived table while leaving the raw files unchanged.
dir.create("results", showWarnings = FALSE)
write.csv(MyWrangledData, "results/pound_hill_long.csv", row.names = FALSE)

# Explore the data below this line.
library(dplyr)
MyWrangledData <- dplyr::as_tibble(MyWrangledData)
# or when no naming conflict MyWrangledData <- as_tibble(MyWrangledData)
MyWrangledData
class(MyWrangledData) #tibble similar to data.frame

glimpse(MyWrangledData) # like str(), but neater

utils::View(MyWrangledData) #same as fix()

filter(MyWrangledData,Count>100)
# like subset(), but can integrate with other select functions

slice(MyWrangledData, 10:15) # look at a particular range of data rows

MyWrangledData %>%
    group_by(Species) %>%
      summarise(avg = mean(Count))
aggregate(MyWrangledData$Count, list(MyWrangledData$Species), FUN=mean)
