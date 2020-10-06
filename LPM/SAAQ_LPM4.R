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
# February 7, 2020
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
saaq_data[, 'policy'] <- saaq_data[, 'dinf'] >= april_fools_2008


# Set placebo indicator. 
saaq_data[, 'placebo'] <- saaq_data[, 'dinf'] >= '2007-04-01'



##################################################
# Sample Selection
##################################################

# Select symmetric window around the policy change.
saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' & 
  saaq_data[, 'dinf'] <= '2010-03-31'

# summary(saaq_data[saaq_data[, 'window'], 'dinf'])


# Create a two-year window around the placebo. 
# Year before (2007):
saaq_data[, 'window_placebo'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
  saaq_data[, 'dinf'] <= '2008-03-31'

# Include specific sample selection by model. 



##################################################
# Estimating a Linear Probability Model
# Pooled Regression with Policy Indicator
##################################################


# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Pooled Regression: entire population. 
saaq_data[, 'sel_obsn'] <- saaq_data[, 'window']

sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   policy +
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)

# Checking for negative LPM predictions. 
saaq_data[, 'pred'] <- NA
saaq_data[sel_obs , 'pred'] <- predict(lm_model_1)
unique(saaq_data[sel_obs & saaq_data[, 'pred'] < 0, 
                 c('sex', 'age_grp', 'curr_pts_grp', 'policy', 'pred')])
summary(saaq_data[sel_obs , 'pred'])

pct_neg_pred <- sum(saaq_data[sel_obs , 'pred'] < 0)/sum(sel_obs)
print(pct_neg_pred)


##################################################
# Estimating a Linear Probability Model
# Pooled Regression with Policy Indicator
# and interaction with age_grp
##################################################


# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Pooled Regression: entire population. 
saaq_data[, 'sel_obsn'] <- saaq_data[, 'window']

sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   policy + policy*age_grp + 
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)

# Checking for negative LPM predictions. 
saaq_data[, 'pred'] <- NA
saaq_data[sel_obs , 'pred'] <- predict(lm_model_1)
unique(saaq_data[sel_obs & saaq_data[, 'pred'] < 0, 
                 c('sex', 'age_grp', 'curr_pts_grp', 'policy', 'pred')])
summary(saaq_data[sel_obs , 'pred'])

pct_neg_pred <- sum(saaq_data[sel_obs , 'pred'] < 0)/sum(sel_obs)
print(pct_neg_pred)



##################################################
# Estimating a Linear Probability Model
# Separate Regression by Gender with Policy Indicator
##################################################

# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select subset for selected sex. 
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'window']


sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   policy +
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)

# Checking for negative LPM predictions. 
saaq_data[, 'pred'] <- NA
saaq_data[sel_obs , 'pred'] <- predict(lm_model_1)
unique(saaq_data[sel_obs & saaq_data[, 'pred'] < 0, 
                 c('sex', 'age_grp', 'curr_pts_grp', 'policy', 'pred')])
summary(saaq_data[sel_obs , 'pred'])

pct_neg_pred <- sum(saaq_data[sel_obs , 'pred'] < 0)/sum(sel_obs)
print(pct_neg_pred)


##################################################
# Estimating a Linear Probability Model
# Separate Regression by Gender with Policy Indicator
# and interaction with age_grp
##################################################


# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select subset for selected sex. 
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'window']

sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   policy + policy*age_grp + 
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)

# Checking for negative LPM predictions. 
saaq_data[, 'pred'] <- NA
saaq_data[sel_obs , 'pred'] <- predict(lm_model_1)
unique(saaq_data[sel_obs & saaq_data[, 'pred'] < 0, 
                 c('sex', 'age_grp', 'curr_pts_grp', 'policy', 'pred')])
summary(saaq_data[sel_obs , 'pred'])

pct_neg_pred <- sum(saaq_data[sel_obs , 'pred'] < 0)/sum(sel_obs)
print(pct_neg_pred)


################################################################################
# Placebo regressions
################################################################################



##################################################
# Estimating a Linear Probability Model
# Separate Regression by Gender with Placebo Indicator
# All violations combined: 2-year window, 
# Full model with placebo for policy indicator
# year before (2007). 
##################################################


# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select subset for selected sex. 
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'window_placebo']


sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   placebo +
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)




##################################################
# Estimating a Linear Probability Model
# Separate Regression by Gender with Placebo Indicator
# and interaction with age_grp
# All violations combined: 2-year window, 
# Full model with placebo for policy indicator
# year before (2007). 
##################################################


# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select subset for selected sex. 
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'window_placebo']

sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   placebo + placebo*age_grp + 
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)



################################################################################
# Regressions for specific point combinations
################################################################################



##################################################
# Estimating a Linear Probability Model
# Separate Regression by Gender with Policy Indicator
##################################################


# # One point violations. 
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 1
# # Two point violations.
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 2
# # Three point violations
# # (or 6-point violations that used to be 3-point violations).
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
#   saaq_data[, 'policy'] & saaq_data[, 'points'] == 6
# # Four point violations.
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 4
# # Five point violations.
# # (or 10-point violations that used to be 5-point violations).
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 5 |
#   saaq_data[, 'policy'] & saaq_data[, 'points'] == 10
# # Seven and fourteen point violations.
# # Seven point violations.
# # (or 14-point violations that used to be 7-point violations).
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 7 |
#   saaq_data[, 'policy'] & saaq_data[, 'points'] == 14
# Nine point speeding violations and up (excluding the 10s and 14s above).
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 12, 15, 18, 21,
                                                      24, 30, 36)



# Select subset for selected sex. 
sex_sel <- 'F'
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
  saaq_data[, 'window']


sel_obs <- saaq_data[, 'sel_obsn']


# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ 
                   policy +
                   age_grp + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate results for sampling weights, not (inverse) GLS weights.
adj_wtd_lm_summary(lm_model_1)







################################################################################
# End
################################################################################


