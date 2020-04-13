source("assignment3_lib.R")

#Q1
doQ1 <- function() {hist(as.numeric(odata[,11]))}

#Q2
best <- function(state, outcome) {
    
    outcome_col <- col_lookup(outcome)
    state_data <- get_state_data(state)

    # Order them by stats then by hospital name and return the first one
    state_data <- state_data[
        order(
            suppressWarnings(as.numeric(state_data[,outcome_col])),
            state_data$Hospital.Name, 
            na.last=NA
            )
        ,]
    state_data[1,]$Hospital.Name
}

