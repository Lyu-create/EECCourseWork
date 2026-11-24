## if statements
a <- TRUE
if (a) {
    print("a is TRUE")
} else {
    print("a is FALSE")
}

z <- runif(1) # Gnerate a uniformly distributed random number
if (z <= 0.5) {
    print ("Less than a half")
   }


## for loops
for (i in 1:10) { # loop through a sequence of numbers
    j <- i * i
    print(paste(i, "square is", j))
}

for (species in c('Heliodoxa rubinoides', # loop through a vector of species names
                  'Boissonneaua jardini',
                  'Sula nebouxii')) {
       print(paste('The species is', species))
}

v1 <- c("a", "bc", "def") # loop through predefined vector of strings
for (i in v1) {
    print(i)
}

## while loops
i <- 0
while (i < 10){
    i <- i + 1
    print(i^2)
}