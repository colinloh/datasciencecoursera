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

#Q1
doQ1 <- function() {hist(as.numeric(odata[,11]))}

#Q2
best <- function(state, outcome) {
    
    # Map the expected input strings to the corresponding lookup columns
    col_lookup <- data.frame(
        input <- c(
            "heart attack", 
            "heart failure",
            "pneumonia"
        ),
        target_col <- c(
            "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
            "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
            "Number.of.Patients...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
        )
    )
    
    # Get the subset for the given state
    state_data <- odata[odata$State == state,]
    
    # Figure out which outcome column we need
    target_outcome <- as.character(col_lookup[input==outcome,]$target_col)
    
    # Get all the joint best hospitals
    beststat <- min(state_data[,target_outcome])
    bestgroup <- state_data[state_data[,target_outcome]==beststat,]
    
    # Order them by hospital name and return the first one
    bestgroup <- bestgroup[order(bestgroup$Hospital.Name),]
    bestgroup[1,]$Hospital.Name
}




