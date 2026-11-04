observations <- read.csv(
    "data/bootcamp_observations.csv",
    colClasses="character", na.string = "", check.names = FALSE
)
str(observations)
print(observations)


## step by step outline
# Check exact match for column name order
identical(names(observations), c("site", "date", "count")) # TRUE means the order is exactly "site,date,count"

# Check for missing value for each column
is.na(observations$site)
is.na(observations$date)
is.na(observations$count) # TRUE means there is a missing value

# extract the count values that are present
nonmissing_count<-observations$count[!is.na(observations$count)]

# checking whether it is a non-negative integer
grepl("^[0-9]+$", nonmissing_count)

# check repeats and show the line
observations[duplicated(observations),]


## write a Function combining all previous checks
def read_observation <- function(path) {
    if (!identical(names(observations), c("site", "date", "count"))) {
        stop("Column must be site,date,count")
    elif is.na(observations$) == TRUE
        stop(missing value)
    elif 
    }
}

# summarise the count using function
def summarise_observation(data) {

}