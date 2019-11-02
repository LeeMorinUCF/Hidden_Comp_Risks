################################################################################
# 
# Investigation of SAAQ Traffic Ticket Violations
# 
# Simulation of a hidden competing risk model,
# in which outcomes are confounded.
# 
# 
# 
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# November 2, 2019
# 
################################################################################
# 
# Simulation of a hidden competing risk model,
# in which outcomes are confounded.
# 
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list=ls(all=TRUE))


################################################################################
# Set parameters
################################################################################

# Outcomes and probabilities of individual events.
outcome_list <- c(1, 2, 3)
outcome_name_list <- c('S_1', 'S_2', 'S_3')
outcome_prob_list <- c(0.1, 0.1, 0.1)

# Number of observations
num_obs <- 1000






################################################################################
# Generate Data
################################################################################

# Initialize data frame.
hcr_data <- data.frame(event = numeric(num_obs))

# Generate realizations from each potential outcome.
for (outcome_num in 1:length(outcome_list)) {
  
  outcome_name <- outcome_name_list[outcome_num]
  outcome <- outcome_list[outcome_num]
  outcome_prob <- outcome_prob_list[outcome_num]
  
  hcr_data[, outcome_name] <- (runif(num_obs) <= outcome_prob)*outcome
  
  
}

# Generate cumulative event, with hidden individual outcomes. 
hcr_data[, 'event'] <- rowSums(hcr_data[, outcome_name_list])


summary(hcr_data)

hist(hcr_data[, 'event'], 
     xlim = c(-1, sum(outcome_list)), 
     breaks = seq(0, sum(outcome_list)))


################################################################################
# Draw up likelihood function
################################################################################

hcr_like <- function(outcome_prob_list, outcome_list, y) {
  
  
  
}


################################################################################
# Estimate to recover parameters
################################################################################



################################################################################
# Calculate standard errors
################################################################################



################################################################################
# End
################################################################################
