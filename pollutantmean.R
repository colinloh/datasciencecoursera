source("colinslib.R")

pollutantmean <- function(directory, pollutant, id=ALL_STATION_VALUES) {
    
    # Get values from the indicated stations
    station_observations <- getStationValues(directory, id)
    
    # From those values, get the ones that have pollutant values (not NA)
    valid_pollutant_vals <- as.array(!is.na(station_observations[[pollutant]]))
    population <- station_observations[valid_pollutant_vals,]
    #print(paste("Found", length(valid_pollutant_vals[valid_pollutant_vals == 1]), "applicable observations out of", length(attr(station_observations,"row.names"))))
    mean(population[[pollutant]])
}