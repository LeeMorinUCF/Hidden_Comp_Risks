################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Logistic and linear probability models of numbers of tickets awarded by the
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
# October 6, 2020
#
################################################################################
#
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Estimate linear probability models for sets of offenses.
# Identify discontinuity from policy change on April 1, 2008.
# Excessive speeding offenses were assigned double demerit points.
#
# This version includes a number of modifications for a revise and resubmit decision.
# It contains the full estimation results to appear in the manuscript.
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
# setwd('~/Research/SAAQ/')

# The original data are stored in 'SAAQdata/origData/'.
# dataInPath <- 'SAAQdata_full/'
dataInPath <- '~/Research/SAAQ/SAAQdata_full/'

# The data of demerit point counts are stored in 'SAAQdata/seqData/'.
# dataOutPath <- 'SAAQspeeding/SAAQspeeding/'
dataOutPath <- '~/Research/SAAQ/SAAQspeeding/SAAQspeeding/'

# Set version of output file.
# ptsVersion <- 2 # With current points but not past active.
ptsVersion <- 3 # With current points and past active.


# Set the combinations of model specifications to be estimated.


# Set the full list of model specification combinations.
model_list


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

# Consolidate categories of current points balances.
# curr_pts_grp_list <- levels(saaq_data[, 'curr_pts_grp'])
saaq_data[, 'curr_pts_grp_orig'] <- saaq_data[, 'curr_pts_grp']
new_curr_pts_grp_list <- c('0', '1-3', '4-6', '7-9', '10-150')

# Create the new factor.
saaq_data[, 'curr_pts_grp'] <- as.factor(NA)
levels(saaq_data[, 'curr_pts_grp']) <- new_curr_pts_grp_list

# Add the zero points group first.
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[1]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- saaq_data[curr_pts_grp_sel, 'curr_pts_grp_orig']
# Add groups 1-3.
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[2:4]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- new_curr_pts_grp_list[2]
# Add groups 4-6.
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[5:7]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- new_curr_pts_grp_list[3]
# Add groups 7-9.
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[8:10]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- new_curr_pts_grp_list[4]
# Add the rest: 10-150.
curr_pts_grp_sel <- saaq_data[, 'curr_pts_grp_orig'] %in% curr_pts_grp_list[11:14]
saaq_data[curr_pts_grp_sel, 'curr_pts_grp'] <- new_curr_pts_grp_list[5]


# Trust but verify.
table(saaq_data[, 'curr_pts_grp'],
      saaq_data[, 'curr_pts_grp_orig'], useNA = 'ifany')
# Check.


################################################################################
# Define Functions
################################################################################


lpm_neg_check <- function(lm_model) {
  # Checking for negative LPM predictions.
  saaq_data[, 'pred'] <- NA
  saaq_data[sel_obs , 'pred'] <- predict(lm_model)
  print('Observations with negative predictions:')
  print(unique(saaq_data[sel_obs & saaq_data[, 'pred'] < 0,
                   c('sex', 'age_grp', 'curr_pts_grp', 'policy', 'pred')]))
  print('Summary of predictions:')
  print(summary(saaq_data[sel_obs , 'pred']))
  print('Number of negative predictions:')
  pct_neg_pred <- sum(saaq_data[sel_obs , 'pred'] < 0)/sum(sel_obs)
  print(pct_neg_pred)
}


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
saaq_data[, 'policy'] <- saaq_data[, 'dinf'] >= april_fools_2008


# Set placebo indicator.
saaq_data[, 'placebo'] <- saaq_data[, 'dinf'] >= '2007-04-01'



##################################################
# Sample Selection
##################################################

#--------------------------------------------------
# Symmetric four-year window around policy change.
#--------------------------------------------------

# Select symmetric window around the policy change.
saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
  saaq_data[, 'dinf'] <= '2010-03-31'

# summary(saaq_data[saaq_data[, 'window'], 'dinf'])



#--------------------------------------------------
# Symmetric two-year window around the policy change.
#--------------------------------------------------

# Select symmetric window around the policy change.
saaq_data[, 'window_short'] <- saaq_data[, 'dinf'] >= '2007-04-01' &
  saaq_data[, 'dinf'] <= '2009-03-31'


#--------------------------------------------------
# Symmetric two-year window around placebo event
#--------------------------------------------------

# Create a two-year window around the placebo.
# Year before (2007):
saaq_data[, 'window_placebo'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
  saaq_data[, 'dinf'] <= '2008-03-31'


#--------------------------------------------------
# Select a subset of drivers with high point balances
# before the policy change
#--------------------------------------------------

# I will have to add it to a data table with individual data.
# table(saaq_data[, 'curr_pts_grp'], useNA = 'ifany')
#
#
#
#
# # Select this subset.
# saaq_data[, 'sel_drivers'] <- TRUE
#
#
#
# # Otherwise: Select all drivers.
# saaq_data[, 'sel_drivers'] <- TRUE


# Include gender-specific sample selection by model.






##################################################
# Estimating a Linear Probability Model
# Pooled Regression with Policy Indicator
# and interaction with age_grp
#--------------------------------------------------
# Default event window is four-year symmetric window
# around policy change.
saaq_data[, 'sel_window'] <- saaq_data[, 'window']
#--------------------------------------------------
# Additional subsetting for drivers with past
# point balances between 6 and 10 points
# in the pre-policy-change period.
saaq_data[, 'sel_window'] <- saaq_data[, 'window'] &
  saaq_data[, 'past_active']
#--------------------------------------------------
# All violations combined.
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0
#--------------------------------------------------
# One point violations.
saaq_data[, 'events'] <- saaq_data[, 'points'] == 1
#--------------------------------------------------
# Two point violations.
saaq_data[, 'events'] <- saaq_data[, 'points'] == 2
#--------------------------------------------------
# Three point violations
# (or 6-point violations that used to be 3-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 6
#--------------------------------------------------
# Four point violations.
saaq_data[, 'events'] <- saaq_data[, 'points'] == 4
#--------------------------------------------------
# Five point violations.
# (or 10-point violations that used to be 5-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 5 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 10
#--------------------------------------------------
# Seven and fourteen point violations.
# Seven point violations.
# (or 14-point violations that used to be 7-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 7 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 14
#--------------------------------------------------
# Nine point speeding violations and up (excluding the 10s and 14s above).
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 12, 15, 18, 21,
                                                      24, 30, 36)
##################################################


##################################################
# Estimating a Linear Probability Model
# Regression with Policy Indicator
# and interaction with age_grp
# Short regression window to remove photo radar
#--------------------------------------------------
# Default event window is two-year symmetric window
# around policy change.
saaq_data[, 'sel_window'] <- saaq_data[, 'window_short']
#--------------------------------------------------
# All violations combined.
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0
#--------------------------------------------------
# Three point violations
# (or 6-point violations that used to be 3-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 6
#--------------------------------------------------
# Five point violations.
# (or 10-point violations that used to be 5-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 5 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 10
#--------------------------------------------------
# Seven and fourteen point violations.
# Seven point violations.
# (or 14-point violations that used to be 7-point violations).
saaq_data[, 'events'] <- saaq_data[, 'points'] == 7 |
  saaq_data[, 'policy'] & saaq_data[, 'points'] == 14
#--------------------------------------------------


#--------------------------------------------------
# Set regression fomulae for base model
#--------------------------------------------------

full_model <- as.formula(events ~
                           policy + policy*age_grp +
                           age_grp +
                           curr_pts_grp)

no_age_int_model <- as.formula(events ~
                                 policy +
                                 age_grp +
                                 curr_pts_grp)



##################################################
# Placebo Regressions:
# Estimating a Linear Probability Model
# Pooled Regression with Policy Indicator
# and interaction with age_grp
#--------------------------------------------------
# Select one-year symmetric window in the two years
# before the policy change.
saaq_data[, 'sel_window'] <- saaq_data[, 'window_placebo']
#--------------------------------------------------
# All violations combined.
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0
##################################################

#--------------------------------------------------
# Set regression fomulae for placebo regressions
#--------------------------------------------------

full_model <- as.formula(events ~
                           placebo + placebo*age_grp +
                           age_grp +
                           curr_pts_grp)

no_age_int_model <- as.formula(events ~
                                 placebo +
                                 age_grp +
                                 curr_pts_grp)




##################################################
# Run regressions
##################################################



#--------------------------------------------------
# All drivers
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Full model
chosen_model <- full_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))




#--------------------------------------------------
# All drivers
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Policy indicator only.
chosen_model <- no_age_int_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))


#--------------------------------------------------
# Male drivers
sex_sel <- 'M'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Full model
chosen_model <- full_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))



#--------------------------------------------------
# Male drivers
sex_sel <- 'M'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Policy indicator only.
chosen_model <- no_age_int_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))




#--------------------------------------------------
# Female drivers
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Full model
chosen_model <- full_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))


#--------------------------------------------------
# Female drivers
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'sel_window']
sel_obs <- saaq_data[, 'sel_obsn']

# Policy indicator only.
chosen_model <- no_age_int_model
#--------------------------------------------------

# Estimate the model accounting for the aggregated nature of the data.
agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                         formula = chosen_model, x = TRUE)
summary_agg_lm(agg_lm_model_1)

# Adjust standard errors for heteroskedasticity.
agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
print(agg_lpm_hccme_1$coef_hccme)

# Checking for negative LPM predictions.
lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
                 formula = chosen_model))






##################################################
# End
##################################################
