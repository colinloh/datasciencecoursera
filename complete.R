complete <- function(directory, id=1:332) {
    source("colinslib.R")
    
    population <- getStationValues(directory, id)
    # Init a data frame with the keys and NA for counts.
    df <- data.frame(id=id, nobs=rep(NA, length(id)))
    # Update the counts for each key
    for (station_id in id) {
        station_obs <- (population[
            population$ID == station_id & 
            !is.na(population$sulfate) &
            !is.na(population$nitrate),
            ])
        count <- length(as.vector(attr(station_obs, "row.names")))
        df[df$id==station_id, 2] <- count
        #print(paste(station_id, "has", count, "observations"))
    }
    df
}