# retreive argument
args <- commandArgs(trailingOnly = TRUE) # TRUE exclude arguments starting up R

# no argument
if (length(args) == 0) {
    stop("Please provide an input csv file")
}
# extra arguments
if (length(args) > 1) {
    stop("Please provide only one input csv file")
}
# a missing file
input_path <- args[1]
if (!file.exists(input_path)) {
    stop("Input file not found")
}

# a wrong header
MyData <- read.csv(input_path)
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
output_name <- tools::file_path_sans_ext(basename(input_path))
output_path <- file.path("results", paste0(output_name, "_treeheights.csv"))
write.csv(MyData, output_path, row.names = FALSE)

# comparing fixed and command-line input