# Wrangle the Pound Hill dataset using dplyr and tidyr.
# Run from the coursework project root with:
# Rscript code/data_wrang_tidy.R

library(tidyverse) # load dplyr and tidyr for data wrangling

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
head(TempData)

# Convert from wide to long form ----------------------------------------
# Use tidyr::pivot_longer().

MyWrangledData1 <- TempData |>
  tidyr::pivot_longer(
    cols = -c(Cultivation, Block, Plot, Quadrat), # exclude these columns from pivoting
    names_to = "Species", # column name for the new column that will hold the species names 
    values_to = "Count" # column values become the new column that will hold the counts
  ) # columns of species (wide form) become rows of species (long form)
head(MyWrangledData)
tail(MyWrangledData)

# categorising into levels for categorical values
MyWrangledData1 <- MyWrangledData1 |>
  dplyr::mutate(
    Cultivation = as.factor(Cultivation),
    Block = as.factor(Block),
    Plot = as.factor(Plot),
    Quadrat = as.factor(Quadrat),
    Species = factor(Species, levels = names(TempData)[-c(1:4)]),
    Count = as.integer(Count)
  )

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)


# Save a derived table while leaving the raw files unchanged.
dir.create("results", showWarnings = FALSE)
write.csv(MyWrangledData1, "results/pound_hill_long1.csv", row.names = FALSE)