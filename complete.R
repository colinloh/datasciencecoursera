complete <- function(directory, id=1:332) {
    source("colinslib.R")
    
    population <- getStationValues(directory, id)
    
    # Turn the first column into a factor
    histogram <- as.factor(population[1])
    setwd(origd)
    histogram
}