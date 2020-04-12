# Read Hospital Data File
readHospitalData <- function() {
    library(readr)
    read.csv('./rprog_data_ProgAssignment3-data/hospital-data.csv', colClasses='character')
}

readOutcomeData <- function() {
    library(readr)
    read.csv('./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv', colClasses='character')
}

# Ingest the data
hdata <- readHospitalData()
odata <- readOutcomeData()

# Map the expected input strings to the corresponding lookup columns
col_lookup <- data.frame(
    input <- c(
        "heart attack", 
        "heart failure",
        "pneumonia"
    ),
    target_col <- c(
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
        "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
        "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
    )
)

#Q4
rankall <- function(outcome, num) {
    
    # Figure out which outcome column we need
    target_outcome <- as.character(col_lookup[input==outcome,]$target_col)
    if (length(target_outcome) < 1) {
        stop("invalid outcome")
    }
    
    # Sort the whole thing first
    ordered_data <- odata[order(
        odata$State,
        odata[,target_outcome],
        odata$Hospital.Name,
        na.last=NA
    ),]
    
    states <- levels(factor(ordered_data$State))
    hospitals <- vector(mode = "character", length = length(states))
    i <- 1
    for (s in states) {
        state_data <- ordered_data[ordered_data$State == s,]
        if (num == "best") {
            num <- 1
        } else if (num == "worst") {
            num <- nrow(state_data)
        }
        hospitals[i] <- state_data[num,]$Hospital.Name
        i <- i + 1
    }
    results <- data.frame(
        hospital = as.character(hospitals),
        state = states
    )
    rownames(results) <- states
    results
}