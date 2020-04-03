source("colinslib.R")

corr <- function(directory, threshold = 0) {
    cor_vect <- vector(mode="numeric", length=0)
    
    population <- getStationValues(directory) # Get all
    
    # Get Correlations for all stations that meet the threshold.
    for (id in ALL_STATION_VALUES) {
        station_obs <- population[
                population$ID==id & 
                !is.na(population$sulfate) &
                !is.na(population$nitrate)
                ,]
        #print(paste("station",id,"num complete obs:",nrow(station_obs)))
        if (nrow(station_obs) > threshold) {
            # This station applies. Get correlation.
            correlation <- cor(station_obs$sulfate, station_obs$nitrate)
            #print(paste("correlation", correlation))
            cor_vect <- c(cor_vect, correlation)
        }
        # else station doesn't have enough observations to meet threshold. Skip.
        
    }
    print(paste("correlations collected:",length(cor_vect)))
    cor_vect
}