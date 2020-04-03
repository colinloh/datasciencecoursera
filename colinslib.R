ALL_STATION_VALUES <- c(1:332)

getStationValues <- function(dir,id=ALL_STATION_VALUES) {
    library(readr)
    origd<-getwd()
    setwd(dir)
    
    # Go through all the files in the directory to find the subset we need.
    population <- data.frame()
    print(paste("Checking all files in",dir))
    for (f in list.files()) {
      # print(paste("Checking", f))
      fdata <- read.csv(file(f), colClasses = c("Date","numeric","numeric","integer"))
      
      valid_station_ids <- fdata[["ID"]] %in% id

      population <- rbind(population,fdata[valid_station_ids,])
    }
    #print(paste("Total observations from selected Stations:", length(attr(population,"row.names"))))
    setwd(origd)    
    population
}

