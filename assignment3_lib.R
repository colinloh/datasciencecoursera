# Read Hospital Data File
readHospitalData <- function() {
    library(readr)
    read.csv('./rprog_data_ProgAssignment3-data/hospital-data.csv', colClasses='character')
}

readOutcomeData <- function() {
    library(readr)
    read.csv('./rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv', colClasses='character')
}

# Ingest the data into global
hdata <- readHospitalData()
odata <- readOutcomeData()

# Map the expected input strings to the corresponding lookup columns
col_lookup <- function(lookup_term) {
    lookup_map <- data.frame(
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
    
    # Figure out which outcome column we need
    outcome_col <- as.character(lookup_map[input==lookup_term,]$target_col)
    if (length(outcome_col) < 1) {
        stop("invalid outcome")
    }
    outcome_col
}

get_state_data <- function(state) {
    # Get the subset for the given state
    state_data <- odata[odata$State == state,]
    if (nrow(state_data) < 1) {
        stop("invalid state")
    }
    state_data
}
