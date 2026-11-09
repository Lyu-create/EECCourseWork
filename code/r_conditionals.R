## Checks if an integer is even
is.even <- function(n) {
  if (n %% 2 == 0) {
    return(paste(n, 'is even!'))
  } else {
  return(paste(n, 'is odd!'))
  }
}
is.even(6)
# is.even() missing argument n

# setting a default of n using function (n = 2),
# but only when meaningful and use named arguments to override the default


## Checks if a number is a power of 2
is.power2 <- function(n) {
  if (log2(n) %% 1 == 0) {
    return(paste(n, 'is a power of 2!'))
  } else {
  return(paste(n, 'is not a power of 2!'))
    }
}
is.power2(4)


## Checks if a number is prime
is.prime <- function(n) {
  if (n == 0) {
    return(paste(n,'is a zero!'))
  } else if (n == 1){
    return(paste(n, 'is not a unit!'))
  }

  ints <- 2:(n - 1)

  if (all(n %% ints != 0)) {
    return(paste(n, 'is a prime!'))
  } else {
  return(paste(n, 'is a composite!'))
  }
}

is.prime(3)