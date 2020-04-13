source("assignment3_lib.R")

#Q3
rankhospital <- function(state, outcome, num) {

    outcome_col <- col_lookup(outcome)
    state_data <- get_state_data(state)
        
    sorted <- state_data[order(
        suppressWarnings(as.numeric(state_data[,outcome_col])),
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
