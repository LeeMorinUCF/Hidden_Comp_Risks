################################################################################
# 
# Investigation of SAAQ Traffic Ticket Violations
# 
# Linear probability models of numbers of tickets awarded by the 
# number of points per ticket.
# Datasets hold observations for sets of sequential id codes.
# 
# 
# 
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# February 6, 2020
# 
################################################################################
# 
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Estimate linear probability models for sets of offenses. 
# Identify discontinuity from policy change on April 1, 2008. 
# Excessive speeding offenses were assigned double demerit points.
# 
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list=ls(all=TRUE))


################################################################################
# Set parameters for file IO
################################################################################

# Set working directory.
# setwd('/home/ec2-user/saaq')
setwd('~/Research/SAAQ/')

# The original data are stored in 'SAAQdata/origData/'.
dataInPath <- 'SAAQdata_full/'

# The data of demerit point counts are stored in 'SAAQdata/seqData/'.
dataOutPath <- 'SAAQspeeding/SAAQspeeding/'

# Set version of output file.
ptsVersion <- 2



################################################################################
# Load Annual Driver Counts
################################################################################


in_file_name <- sprintf('saaq_agg_%d.csv', ptsVersion)
in_path_file_name <- sprintf('%s%s', dataInPath, in_file_name)
# Yes, keep it in dataInPath since it is yet to be joined. 
saaq_data <- read.csv(file = in_path_file_name)

colnames(saaq_data)

sapply(saaq_data, class)

# Rewrite dinf as date format.
saaq_data[, 'dinf'] <- as.Date(saaq_data[, 'dinf'])

# Order the current points categories for better interpretability. 
table(saaq_data[, 'curr_pts_grp'])

curr_pts_grp_list <- c(as.character(seq(0, 10)), '11-20', '21-30', '30-150')
saaq_data[, 'curr_pts_grp'] <- factor(saaq_data[, 'curr_pts_grp'], 
                                      levels <- curr_pts_grp_list)

table(saaq_data[, 'curr_pts_grp'])


summary(saaq_data)

#--------------------------------------------------------------------------------
# Create new factors by consolidating some categories 
#--------------------------------------------------------------------------------

# Age groups. 
table(saaq_data[, 'age_grp'], useNA = 'ifany')


age_grp_list <- levels(saaq_data[, 'age_grp'])
saaq_data[, 'age_grp_orig'] <- saaq_data[, 'age_grp']
new_age_grp_list <- c(age_grp_list[seq(7)], '65-199')

saaq_data[, 'age_grp'] <- as.factor(NA)
levels(saaq_data[, 'age_grp']) <- new_age_grp_list
age_group_sel <- saaq_data[, 'age_grp_orig'] %in% age_grp_list[seq(7)]
saaq_data[age_group_sel, 'age_grp'] <- saaq_data[age_group_sel, 'age_grp_orig']
saaq_data[!age_group_sel, 'age_grp'] <- new_age_grp_list[8]


# Trust but verify.
table(saaq_data[, 'age_grp'], 
      saaq_data[, 'age_grp_orig'], useNA = 'ifany')
# Check. 


# Current point balance groups. 
table(saaq_data[, 'curr_pts_grp'], useNA = 'ifany')


curr_pts_grp_list <- levels(saaq_data[, 'curr_pts_grp'])
saaq_data[, 'curr_pts_grp_orig'] <- saaq_data[, 'curr_pts_grp']
new_curr_pts_grp_list <- c(curr_pts_grp_list[seq(10)], '10-150')

saaq_data[, 'curr_pts_grp'] <- as.factor(NA)
levels(saaq_data[, 'curr_pts_grp']) <- new_curr_pts_grp_list
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[seq(10)]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- saaq_data[curr_pts_grp_sel, 'curr_pts_grp_orig']
saaq_data[!curr_pts_grp_sel, 'curr_pts_grp'] <- new_curr_pts_grp_list[11]



# Trust but verify.
table(saaq_data[, 'curr_pts_grp'], 
      saaq_data[, 'curr_pts_grp_orig'], useNA = 'ifany')
# Check. 


################################################################################
# Define Functions
################################################################################

#--------------------------------------------------------------------------------
# Define a function to adjust regression results
# for correct weighting with aggregated data. 
#--------------------------------------------------------------------------------

adj_wtd_lm_summary <- function(wtd_lm) {
  
  # Copy the lm object. 
  adj_wtd_lm <- wtd_lm
  
  # Replace the df for the residual (n - k).
  adj_wtd_lm$df.residual <- sum(adj_wtd_lm$weights) - length(coef(adj_wtd_lm))
  
  # Make a copy of the summary to adjust the R-bar_squared. 
  sum_adj_wtd_lm <- summary(adj_wtd_lm)
  
  # Replace the value of the R-bar-squared. 
  sum_adj_wtd_lm$adj.r.squared <- 
    1 - (1 - sum_adj_wtd_lm$r.squared) * 
    (sum(adj_wtd_lm$weights) - 1) / 
    (sum(adj_wtd_lm$weights) - length(coef(adj_wtd_lm)))
  
  # Return the summary with the adjusted weighted regression  
  # to replace the original individual-level data.
  return(sum_adj_wtd_lm)
  
}

#--------------------------------------------------------------------------------

# Test:
# Compare the adjusted weighted regression with 
# the original individual-level data.
# summary(ind_lm)
# adj_wtd_lm_summary(wtd_lm)

#--------------------------------------------------------------------------------




################################################################################
# Generate New Variables
################################################################################


#--------------------------------------------------------------------------------
# Create indicator for policy change
#--------------------------------------------------------------------------------

# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!

# Generate an indicator for the policy change. 
saaq_data[, 'policy'] <- saaq_data[, 'dinf'] > april_fools_2008


#--------------------------------------------------------------------------------
# Create variables for past behaviour
#--------------------------------------------------------------------------------

# Done in the data prep stage. 

#--------------------------------------------------------------------------------
# Analyse Groups of Related Offences
#--------------------------------------------------------------------------------


# Generate a count of the number of events. 
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 1
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 2
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 3
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 4
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 5
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 6


# Compare the distributions of variables 
# for classes of the dependent variable. 
# summary(saaq_data[saaq_data[, 'events'] == 0, ])
# summary(saaq_data[saaq_data[, 'events'] == 1, ])



##################################################
# Sample Selection
##################################################

# Select symmetric window around the policy change.
saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' & 
  saaq_data[, 'dinf'] <= '2010-03-31'

summary(saaq_data[saaq_data[, 'window'], 'dinf'])

# Consider entire population. 
# saaq_data[, 'sel_obsn'] <- saaq_data[, 'window']

# Run separate models by sex. 
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == 'M' &
  saaq_data[, 'window']
# Because there are more than enough male dummies to model separately. 
# saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == 'F' &
#   saaq_data[, 'window']


summary(saaq_data[saaq_data[, 'sel_obsn'], 'dinf'])

table(saaq_data[saaq_data[, 'sel_obsn'], 'sex'])

# Count number of observations.
sum(saaq_data[saaq_data[, 'sel_obsn'], 'num'])
# 10 billion. That sounds like a lot.
# There ar 4.5-5.5 million \emph{licenced} drivers over the sample window.
# The data set includes \emph{all} tickets, 
# including those given to unlicenced drivers
# and tourists from other jurisdictions. 

# There are 1461 days in the  symmetric sample window 2006-2010. 
length(unique(saaq_data[saaq_data[, 'sel_obsn'], 'dinf']))

# If tickets from unlicenced drivers and tourists were excluded, 
# the sample size should be closer to 
# 5 million x 1461 - 7.3 billion, 
# which means the denominator (non-event count) 
# is slightly higher by a factor of 32%:
sum(saaq_data[saaq_data[, 'sel_obsn'], 'num']) / 
  (5000000 * length(unique(saaq_data[saaq_data[, 'sel_obsn'], 'dinf'])))
# We can make a decision on this later, but for now, 
# we should keep in mind that the figures below may be an 
# underestimate of the true incidence of tickets. 


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

table(saaq_data[sel_obs, c('events', 'points')])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)

table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

# summary(predict(lm_model_1))


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# One point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 1

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Two point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 2

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Three point violations 
# (or 6-point violations that used to be 3-point violations). 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 6

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Four point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 4

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Five point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 5

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


table(saaq_data[, 'points'] == 10, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] == 5, 
      saaq_data[, 'policy'], useNA = 'ifany')


# Five and ten point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(5, 10)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_data[, 'points'] == 6, 
      saaq_data[, 'policy'], useNA = 'ifany')

# Six point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 6

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

# Combined event with 3 or 6 points. 

table(saaq_data[, 'points'] %in% c(3, 6), 
      saaq_data[, 'policy'], useNA = 'ifany')


# Six and three point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(3, 6)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_data[, 'points'] == 7, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] == 14, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] %in% c(7, 14), 
      saaq_data[, 'policy'], useNA = 'ifany')

# Seven and fourteen point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(7, 14)
# Showing them alone is not as useful. 
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(7)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(14)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_data[, 'points'] == 9, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] == 18, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] %in% c(9, 18), 
      saaq_data[, 'policy'], useNA = 'ifany')

# Nine and eighteen point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 18)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_data[, 'points'] == 12, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] == 24, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] %in% c(12, 24), 
      saaq_data[, 'policy'], useNA = 'ifany')


# Twelve and twenty-four point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(12, 24)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']


summary(saaq_data[sel_obs, ])

sum(saaq_data[sel_obs & saaq_data[, 'events'] == TRUE, 'num'])
sum(saaq_data[sel_obs & saaq_data[, 'events'] == FALSE, 'num'])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 15, 18,
                                                     30, 36)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])


sum(saaq_data[sel_obs & saaq_data[, 'events'] == TRUE, 'num'])
sum(saaq_data[sel_obs & saaq_data[, 'events'] == FALSE, 'num'])


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 12, 15, 18,
                                                     24, 30, 36)

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

sum(saaq_data[sel_obs & saaq_data[, 'events'] == TRUE, 'num'])
sum(saaq_data[sel_obs & saaq_data[, 'events'] == FALSE, 'num'])


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 9, 12, 15, 18,
                                                     18, 24, 30, 36)



# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

sum(saaq_data[sel_obs & saaq_data[, 'events'] == TRUE, 'num'])
sum(saaq_data[sel_obs & saaq_data[, 'events'] == FALSE, 'num'])

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)


table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'], 
      saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')






################################################################################
# End
################################################################################

