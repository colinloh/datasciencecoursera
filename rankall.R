source("assignment3_lib.R")

#Q4
rankall <- function(outcome, num) {
    
    outcome_col <- col_lookup(outcome)

    # Instead of calling rankhospital, we will do a full sort first on the dataset,
    # so no more per-state sorting is needed. Hence more efficient.
    ordered_data <- odata[order(
        odata$State,
        suppressWarnings(as.numeric(odata[,outcome_col])),
        odata$Hospital.Name,
        na.last=NA
    ),]
    
    states <- levels(factor(ordered_data$State))
    hospitals <- vector(mode = "character", length = length(states))
    i <- 1
    for (s in states) {
        
        state_data <- ordered_data[ordered_data$State == s,]
        if (num == "best") {
            desired_rank <- 1
        } else if (num == "worst") {
            desired_rank <- nrow(state_data)
        } else {
            desired_rank <- num
        }
        hospitals[i] <- state_data[desired_rank,]$Hospital.Name
        i <- i + 1
    }
    results <- data.frame(
        hospital = as.character(hospitals),
        state = states
    )
    rownames(results) <- states
    results
}