# create a function to sample the data and calculate the mean of the sample
doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)
    if(length(unique(temp_x)) > 30) {#only take mean if sample was sufficient
         print(paste("Mean of this sample was:", as.character(mean(temp_x))))
        }
    else {
        stop("Couldn't calculate mean: too few unique values!")
    }
}

# generate population
set.seed(1345) # again, to get the same result for illustration
popn <- rnorm(50)
hist(popn)

# run the function 15 times, showing error messages when they occur
# lapply(1:15, function(i) doit(popn)) 

# continue the iteraction even if an error occurs
# result <- lapply(1:15, function(i) try(doit(popn), FALSE))
# class(result)

# save the results to a list
result <- vector("list", 15) #Preallocate/Initialize
for(i in 1:15) {
    result[[i]] <- try(doit(popn), FALSE)
    }