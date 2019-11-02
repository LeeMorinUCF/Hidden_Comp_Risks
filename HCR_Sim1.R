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


# Enumerate the possible combinations for each event observed.
y_outcome_ref <- unique(hcr_data)
y_outcome_ref <- y_outcome_ref[order(y_outcome_ref[, 'event']), ]

# y <- hcr_data[, 'event']

hcr_like <- function(outcome_prob_list, 
                     outcome_list, outcome_name_list, 
                     y, y_outcome_ref) {
  
  # Calculate the probabilities for each combination of outcomes.
  y_outcome_ref[, 'prob'] <- 0
  for (row_num in 1:nrow(y_outcome_ref)) {
    
    y_out_row <- y_outcome_ref[row_num, outcome_name_list]
    
    prob_events_that_happened <- outcome_prob_list[y_out_row != 0]
    prob_events_that_didnt_happen <- 1 - outcome_prob_list[y_out_row == 0]
    
    prob_event <- prod(c(prob_events_that_happened, 
                         prob_events_that_didnt_happen))
    
    y_outcome_ref[row_num, 'prob'] <- prob_event
    
    
  }
  
  # Calculate the probabilities for each event observed.
  y_list <- unique(y) # Only compute for y that actually occurred. 
  y_list <- y_list[order(y_list)]
  y_prob_list <- data.frame(event = y_list, 
                            prob = numeric(length(y_list)))
  
  # Get a list of associated rows. 
  # Yeah, yeah, there's a faster way. 
  for (row_num in 1:nrow(y_prob_list)) {
    
    y_event <- y_prob_list[row_num, 'event']
    
    # Select the sets of outcomes that lead to that event. 
    y_outcome_row_nums <- which(y_outcome_ref[, 'event'] == y_event)
    
    # For each potential set of outcomes, add that probability to the total.
    y_prob_list[row_num, 'prob'] <- sum(y_outcome_ref[y_outcome_row_nums, 'prob'])
    
  }
  
  # Allocate those probabilities to the events in the sample.
  y_table <- table(y)
  like <- 0
  for (y_num in 1:length(y_table)) {
    
    # Pick an event.
    y_name <- names(y_table)[y_num]
    
    # Get the probability of that event. 
    y_prob <- y_prob_list[y_prob_list[, 'event'] == y_name, 'prob']
    
    # Get the frequency of that event. 
    y_freq <- y_table[y_num]
    
    # Accumulate the log-probability.
    like <- like + log(y_prob)*y_freq
    
  }
  
  return(- like)
  
}

hcr_like_logit_params <- function(outcome_logit_prob_list, 
                     outcome_list, outcome_name_list, 
                     y, y_outcome_ref) {
  
  outcome_prob_list <- exp(outcome_logit_prob_list) / (1 + exp(outcome_logit_prob_list))
  
  like <- hcr_like(outcome_prob_list, 
                   outcome_list, outcome_name_list, 
                   y, y_outcome_ref)
  
  
  return(like)
  
}


################################################################################
# Estimate to recover parameters
################################################################################

# Evaluate at the true values.
like_true <- hcr_like(outcome_prob_list, 
                      outcome_list, outcome_name_list, 
                      y, y_outcome_ref)

# Convert true probabilities into log-odds.
outcome_logit_prob_list <- log(outcome_prob_list/(1 - outcome_prob_list))

# Evaluate at the true values.
like_true_logit <- hcr_like_logit_params(outcome_logit_prob_list, 
                                   outcome_list, outcome_name_list, 
                                   y, y_outcome_ref)



prob_hat_optim <- optim(par = outcome_prob_list,
                        fn = hcr_like,
                        # lower = rep(0, length(outcome_prob_list)),
                        # upper = rep(1, length(outcome_prob_list)),
                        method = 'BFGS',
                        outcome_list = outcome_list,
                        outcome_name_list = outcome_name_list,
                        y = hcr_data[, 'event'],
                        y_outcome_ref = y_outcome_ref)

prob_hat_logit_optim <- optim(par = outcome_logit_prob_list, 
                              fn = hcr_like_logit_params, 
                              # lower = rep(0, length(outcome_prob_list)), 
                              # upper = rep(1, length(outcome_prob_list)), 
                              method = 'BFGS', 
                              outcome_list = outcome_list, 
                              outcome_name_list = outcome_name_list, 
                              y = hcr_data[, 'event'], 
                              y_outcome_ref = y_outcome_ref)



prob_hat_optim
prob_hat_logit_optim
# Logit version ws faster.

print(like_true)
print(like_true_logit)
print(like_true_opt)

# Compare estimated parameters. 
print(outcome_prob_list)
print(prob_hat_optim$par)
print(exp(prob_hat_logit_optim$par) / (1 + exp(prob_hat_logit_optim$par)))
# Estimates look good. 




################################################################################
# Calculate standard errors
################################################################################



################################################################################
# End
################################################################################
