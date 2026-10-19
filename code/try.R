doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if (length(unique(temp_x)) > 30 ) {# only take mean if sample was sufficient
          print(paste("Mean of this sample was:", as.character(mean(temp_x))))
         }
    else {
        stop("Couldn't calculate the mean: too few unique values!")
        }
    }

set.seed(1345)

popn <- rnorm(50)

hist(popn)
doit <-function(x) {
    temp_x <- sample(x, replace = TRUE)
    if (length(unique(temp_x)) > 30 ) {# only take mean if sample was sufficient
          print(paste("Mean of this sample was:", as.character(mean(temp_x))))
         }
    else {
        stop("Couldn't calculate the mean: too few unique values!")
        }
    }

set.seed(1345)

popn <- rnorm(50)

hist(popn)
lapply(1:15, function(i) doit(popn))

result <- vector("list", 15) #Preallocate/Initialise
for (i in 1:15) {
    result[[i]] <- tryCatch(doit(popn), FALSE)
    }