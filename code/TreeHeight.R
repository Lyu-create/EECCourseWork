# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using the trigonometric formula
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:  The angle of elevation of tree
# distance: The distance from base of tree (e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

# import data and check header with first few lines
MyData <- read.csv("data/trees.csv")
head(MyData)
nrow(MyData)

# check for required columns
header <- names(MyData)
expected_header <- c("Species","Distance.m","Angle.degrees")
if (identical(header, expected_header) == FALSE) {
    stop("Input file wrong header")
}

# check Distance.m column for any numeric finite and range
if (!is.numeric(MyData$Distance.m)) {
    stop("Distance.m must be numeric")
}
if (!all(is.finite(MyData$Distance.m))) {
    stop("Distance.m must contain only finite values")
}
if (any(MyData$Distance.m <= 0 | MyData$Distance.m > 100)) {
    stop("Distance.m is out of range")
}

# check Angle.degree column for any numeric finite and range
if (!is.numeric(MyData$Angle.degrees)) {
    stop("Angle.degrees must be numeric")
}
if (!all(is.finite(MyData$Angle.degrees))) {
    stop("Angle.degrees must contain only finite values")
}
if (any(MyData$Angle.degrees <= 0 | MyData$Angle.degrees >= 90)) {
    stop("Angle.degrees is out of range")
}

# TreeHeight function to calculate height_m for every row
TreeHeight <- function(degrees, distance) {
    radians <- degrees * pi / 180
    height <- distance * tan(radians)
    return (height)
}

MyData$height_m <- TreeHeight(MyData$Angle.degrees, MyData$Distance.m)
head(MyData)

# save
write.csv(MyData, "results/TreeHts.csv", row.names = FALSE)