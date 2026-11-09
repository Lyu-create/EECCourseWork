# Observations practice
# Run from the project root:
# Rscript code/observations_practice.R data/bootcamp_observations.csv


# ============================================================
# 1. Function to read and validate observations
# ============================================================

read_observation <- function(path) {

  # Read the CSV file
  observations <- read.csv(
    path,
    colClasses = "character",
    na.strings = "",
    check.names = FALSE
  )

  # Check column names and order
  if (!identical(names(observations), c("site", "date", "count"))) {
    stop("Column must be site, date, count")
  }

  # Check for missing site or date
  if (anyNA(observations$site) || anyNA(observations$date)) {
    stop("Site and date cannot be missing")
  }

  # Extract non-missing count values
  nonmissing_count <- observations$count[!is.na(observations$count)]

  # Check that all non-missing counts are non-negative integers
  if (!all(grepl("^(0|[1-9][0-9]*)$", nonmissing_count))) {
    stop("Count values must be non-negative integers")
  }

  # Convert count into integer
  observations$count <- as.integer(observations$count)

  # Return validated dataset
  return(observations)
}


# ============================================================
# 2. Function to deduplicate and summarise observations
# ============================================================

summarise_observations <- function(data) {

  # Remove exact duplicate rows
  data <- unique(data)

  # Identify unique sites
  sites <- unique(data$site)

  # Create an empty summary table
  summary <- data.frame(
    site = sites,
    total_known = NA_integer_,
    missing_count = integer(length(sites))
  )

  # Calculate summary for each site
  for (i in seq_along(sites)) {

    site_data <- data$count[data$site == sites[i]]

    # Count missing observations
    summary$missing_count[i] <- sum(is.na(site_data))

    # Calculate total of known counts
    if (all(is.na(site_data))) {
      summary$total_known[i] <- NA_integer_
    } else {
      summary$total_known[i] <- sum(site_data, na.rm = TRUE)
    }
  }

  # Return summary table
  return(summary)
}


# ============================================================
# 3. Read command-line argument
# ============================================================

args <- commandArgs(trailingOnly = TRUE)

if (length(args) == 0) {
  stop("Please provide a CSV file path")
}


# ============================================================
# 4. Read and validate the dataset
# ============================================================

observations <- read_observation(args[1])

print(observations)
str(observations)


# ============================================================
# 5. Deduplicate and summarise
# ============================================================

site_summary <- summarise_observations(observations)

print(site_summary)


# ============================================================
# 6. Check expected results
# ============================================================

stopifnot(

  # Site A
  site_summary$total_known[site_summary$site == "A"] == 2,
  site_summary$missing_count[site_summary$site == "A"] == 1,

  # Site B
  site_summary$total_known[site_summary$site == "B"] == 0,
  site_summary$missing_count[site_summary$site == "B"] == 0,

  # Site C
  is.na(site_summary$total_known[site_summary$site == "C"]),
  site_summary$missing_count[site_summary$site == "C"] == 2,

  # Site D
  site_summary$total_known[site_summary$site == "D"] == 0,
  site_summary$missing_count[site_summary$site == "D"] == 0
)

cat("All summary checks passed!\n")

# create plot and save it to results file
dir.create("results", showWarnings = FALSE)

png("results/known_totals.png", width = 800, height = 600)

barplot(
  site_summary$total_known,
  names.arg = site_summary$site,
  main = "Known observation totals by site",
  xlab = "Site",
  ylab = "Total known count",
  col = "skyblue",
  ylim = c(0, max(site_summary$total_known, na.rm = TRUE) + 1)
)

mtext(
  "Site C: all counts missing (total unknown)",
  side = 1,
  line = 4,
  col = "red"
)

dev.off()
