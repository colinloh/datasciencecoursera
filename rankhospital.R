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

#Q3
rankhospital <- function(state, outcome, num) {
    
    # Get the subset for the given state
    state_data <- odata[odata$State == state,]
    if (nrow(state_data) < 1) {
        stop("invalid state")
    }
    
    # Figure out which outcome column we need
    target_outcome <- as.character(col_lookup[input==outcome,]$target_col)
    if (length(target_outcome) < 1) {
        stop("invalid outcome")
    }
    
    sorted <- state_data[order(
        state_data[,target_outcome], 
        state_data$Hospital.Name,
        na.last=NA
    ),]
    
    if (num == "best") {
        num <- 1
    } else if (num == "worst") {
        num <- nrow(sorted)
    }
    
    sorted[num,]$Hospital.Name
}
