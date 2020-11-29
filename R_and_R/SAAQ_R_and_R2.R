################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Logistic and linear probability models of numbers of tickets awarded by the
# number of points per ticket.
#
#
#
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# November 20, 2020
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
# This version calculates marginal effects for logistic regressions.
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
# data_in_path <- '~/Research/SAAQ/SAAQdata_full/'
data_in_path <- 'C:/Users/le279259/Documents/Research/SAAQ/SAAQdata_full/'

# The data of demerit point counts are stored in 'SAAQdata/seqData/'.
# dataOutPath <- 'SAAQspeeding/SAAQspeeding/'
# data_out_path <- '~/Research/SAAQ/SAAQspeeding/SAAQspeeding/'
data_out_path <- 'C:/Users/le279259/Documents/Research/SAAQ/SAAQspeeding/SAAQspeeding/'

# Set directory for results in GitHub repo.
# git_path <- "~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R"
git_path <- "C:/Users/le279259/Documents/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R"
md_dir <- sprintf("%s/results", git_path)

# Set version of input file.
# ptsVersion <- 2 # With current points but not past active.
pts_version <- 3 # With current points and past active.


# Set version of output file.
estn_version <- 99
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)


################################################################################
# Load Daily Driver Counts and Events
################################################################################


in_file_name <- sprintf('saaq_agg_%d.csv', pts_version)
in_path_file_name <- sprintf('%s%s', data_in_path, in_file_name)
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


# age_grp_list <- levels(saaq_data[, 'age_grp'])
age_grp_list <- unique(saaq_data[, 'age_grp'])
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


# Load functions for regressions with aggregated data.
agg_reg_path <- "C:/Users/le279259/Documents/Research/aggregress/aggregress/R"
agg_reg_file <- sprintf("%s/aggregress.R", agg_reg_path)
source(agg_reg_file)
agg_reg_het_file <- sprintf("%s/aggregress_het.R", agg_reg_path)
source(agg_reg_het_file)


################################################################################
# Generate New Variables to be defined within loop
################################################################################


# Generate variables for regressions.
saaq_data[, 'policy'] <- NA
saaq_data[, 'window'] <- NA
saaq_data[, 'events'] <- NA


# First version of models with seasonality.
# saaq_data[, 'month'] <- month(saaq_data[, 'dinf'])
saaq_data[, 'month'] <- substr(saaq_data[, 'dinf'], 6, 7)
table(saaq_data[, 'month'], useNA = "ifany")


# Second version has monthly seasonality and weekday indicator.
saaq_data[, 'weekday'] <- weekdays(saaq_data[, 'dinf'])
table(saaq_data[, 'weekday'], useNA = "ifany")
class(saaq_data[, 'weekday'])
saaq_data[, 'weekday'] <- factor(saaq_data[, 'weekday'],
                                 levels = c('Sunday',
                                            'Monday',
                                            'Tuesday',
                                            'Wednesday',
                                            'Thursday',
                                            'Friday',
                                            'Saturday'))
class(saaq_data[, 'weekday'])


################################################################################
# Estimation
################################################################################


# Set the combinations of model specifications to be estimated.

# These are in different folders.
# past_pts_list <- c('all', 'high')
past_pts_list <- c('all')
# window_list <- c('4 yr.', 'Placebo')
window_list <- c('4 yr.')
# seasonality_list <- c('included', 'excluded')
seasonality_list <- c('excluded')

# These are file-specific.
reg_list <- c('LPM', 'Logit')
# reg_list <- c('LPM')
# reg_list <- c('Logit')
# sex_list <- c('Both Sexes', 'Males', 'Females')
sex_list <- c('All', 'Male', 'Female')

# These combination are explored within a file.
pts_target_list <- c('all',
                     '1', '2', '3', '4', '5', '7',
                     '9+')
age_int_list <- c('no', 'with') # ..  age interactions


# Specify headings for each point level.
pts_headings <- data.frame(pts_target = pts_target_list,
                           heading = NA)
pts_headings[1, 'heading'] <- 'All violations combined'
pts_headings[2, 'heading'] <- 'One-point violations (for speeding 11-20 over)'
pts_headings[3, 'heading'] <- 'Two-point violations (speeding 21-30 over or 7 other violations)'
pts_headings[4, 'heading'] <- 'Three-point violations (speeding 31-60 over or 9 other violations)'
pts_headings[5, 'heading'] <- 'Four-point violations (speeding 31-45 over or 9 other violations)'
pts_headings[6, 'heading'] <- 'Five-point violations (speeding 46-60 over or a handheld device violation)'
pts_headings[7, 'heading'] <- 'Seven-point violations (speeding 61-80 over or combinations)'
pts_headings[8, 'heading'] <- 'All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)'



# Categories of variables for marginal effects.
# mfx_month_list <- unique(saaq_data[, 'month'])
# mfx_weekday_list <- unique(saaq_data[, 'weekday'])
# mfx_curr_pts_list <- unique(saaq_data[, 'curr_pts_grp'])
mfx_age_list <- unique(saaq_data[, 'age_grp'])


#------------------------------------------------------------
# Definition using full lists above.
#------------------------------------------------------------

estn_version <- 99
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)

# Set the full list of model specification combinations.
model_list <- expand.grid(past_pts = past_pts_list,
                          window = window_list,
                          seasonality = seasonality_list,
                          age_int = age_int_list,
                          pts_target = pts_target_list,
                          sex = sex_list,
                          reg_type = reg_list)


#------------------------------------------------------------
# Base case: All drivers.
#------------------------------------------------------------


# estn_version <- 1
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the full list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('excluded'),
#                           age_int = age_int_list,
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)



#------------------------------------------------------------
# Sensitivity Analysis: High-point drivers.
#------------------------------------------------------------

# # Set file name for alternate estimation.
# estn_version <- 2
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the partial list of model specification combinations.
# model_list <- expand.grid(past_pts = c('high'),
#                           # past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('excluded'),
#                           age_int = age_int_list,
#                           # pts_target = c('all'),
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)

#------------------------------------------------------------
# Sensitivity Analysis: Placebo regression.
#------------------------------------------------------------


# # Set file name for alternate estimation.
# estn_version <- 3
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the partial list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('Placebo'),
#                           # window = c('4 yr.'),
#                           seasonality = c('excluded'),
#                           age_int = age_int_list,
#                           pts_target = c('all'),
#                           # pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)


#------------------------------------------------------------
# Sensitivity Analysis: Monthly seasonality
#------------------------------------------------------------


# estn_version <- 4
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the full list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('monthly'),
#                           age_int = age_int_list,
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)

#------------------------------------------------------------
# Sensitivity Analysis: Monthly and weekday seasonality
#------------------------------------------------------------


# estn_version <- 5
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the full list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('mnwk'),
#                           age_int = age_int_list,
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)


#------------------------------------------------------------
# Sensitivity Analysis: REAL event study with seasonality
#------------------------------------------------------------

estn_version <- 6
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)

# Set the full list of model specification combinations.
model_list <- expand.grid(past_pts = c('all'),
                          window = c('Monthly 4 yr.'),
                          seasonality = c('mnwk'),
                          age_int = age_int_list,
                          pts_target = pts_target_list,
                          sex = sex_list,
                          reg_type = reg_list)

# # Consider two rows.
# model_list <- model_list[49:50, ]
# # Consider selected rows.
# model_list <- model_list[model_list[, 'pts_target'] == 'all' &
#                            model_list[, 'age_int'] == 'no' &
#                            model_list[, 'reg_type'] == 'Logit' &
#                            model_list[, 'sex'] %in% c('Male', 'Female'), ]

#------------------------------------------------------------
# Sensitivity Analysis: High-point drivers.
# (with monthly and weekday seasonality)
#------------------------------------------------------------

# # Set file name for alternate estimation.
# estn_version <- 7
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the partial list of model specification combinations.
# model_list <- expand.grid(past_pts = c('high'),
#                           # past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('mnwk'),
#                           age_int = age_int_list,
#                           # pts_target = c('all'),
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)

#------------------------------------------------------------
# Sensitivity Analysis: Placebo regression.
# (with monthly and weekday seasonality)
#------------------------------------------------------------


# # Set file name for alternate estimation.
# estn_version <- 8
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the partial list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('Placebo'),
#                           # window = c('4 yr.'),
#                           seasonality = c('mnwk'),
#                           age_int = age_int_list,
#                           pts_target = c('all'),
#                           # pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)


#------------------------------------------------------------
# Testing with Marginal Effects (Monthly and weekday seasonality)
#------------------------------------------------------------


# estn_version <- 99
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
#
# # Set the full list of model specification combinations.
# model_list <- expand.grid(past_pts = c('all'),
#                           window = c('4 yr.'),
#                           seasonality = c('mnwk'),
#                           age_int = age_int_list,
#                           pts_target = pts_target_list,
#                           sex = sex_list,
#                           reg_type = reg_list)
#
# # Consider two rows.
# model_list <- model_list[65:66, ]


#------------------------------------------------------------
# Run estimation in a loop on the model specifications.
#------------------------------------------------------------


# Initialize data frame to store estimation results.
estn_results <- NULL


# Initialize path.
md_path_last <- "empty"
# Sample block of code for inserting after data prep.
# for (estn_num in 50:nrow(model_list)) {
for (estn_num in 1:nrow(model_list)) {

  # Extract parameters for this estimated model.
  past_pts_sel <- model_list[estn_num, 'past_pts']
  window_sel <- model_list[estn_num, 'window']
  season_incl <- model_list[estn_num, 'seasonality']
  reg_type <- model_list[estn_num, 'reg_type']
  sex_sel <- model_list[estn_num, 'sex']
  pts_target <- model_list[estn_num, 'pts_target']
  age_int <- model_list[estn_num, 'age_int']

  # Create the path and file name for the markdown file.
  md_sub_dir <- sprintf('past_pts_%s_%s_window_seas_%s',
                        past_pts_sel,
                        substr(window_sel, 1, 1),
                        substr(season_incl, 1, 4))
  md_file_name <- sprintf('results_%s_%s.md',
                          reg_type,
                          # substr(sex_sel, 1, 1),
                          sex_sel)
  md_path <- sprintf('%s/%s/%s', md_dir, md_sub_dir, md_file_name)


  # Create a message to describe this model.
  out_msg <- sprintf("Estimating model for %s drivers, %s point tickets.",
                     sex_sel, pts_target)

  # If a new path is created, open a new output file.
  if (md_path != md_path_last) {

    print(sprintf("Estimating for folder %s.", md_sub_dir))
    print(sprintf("Estimating for file %s.", md_file_name))

    # title_str <- sprintf('%s Estimates for %s Drivers',
    #                      reg_type, sex_sel)
    if (reg_type == 'LPM') {
      cat(sprintf('# Linear Probability Models - %s Drivers\n\n', sex_sel),
          file = md_path, append = FALSE)
      cat('## Linear Regression Results (Standard Errors with HCCME) \n\n',
          file = md_path, append = TRUE)
    } else if (reg_type == 'Logit') {
      cat(sprintf('# Logistic Regression Models - %s Drivers\n\n', sex_sel),
          file = md_path, append = FALSE)
      cat('## Logistic Regression Results \n\n',
          file = md_path, append = TRUE)
    }

    if (window_sel == 'Placebo') {
      cat('## Placebo Regressions \n\n',
          file = md_path, append = TRUE)
    } else if (window_sel == 'Monthly 4 yr.') {
      cat('## Regressions with Monthly Policy Dummies \n\n',
          file = md_path, append = TRUE)
    }

  }
  md_path_last <- md_path
  print(out_msg)


  #--------------------------------------------------
  # Set event window around policy indicator.
  #--------------------------------------------------
  if (window_sel == '4 yr.' | window_sel == 'Monthly 4 yr.') {

    # Select symmetric window around the policy change.
    saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
      saaq_data[, 'dinf'] <= '2010-03-31'

    # Set date of policy change.
    april_fools_date <- '2008-04-01'
    # No joke: policy change on April Fool's Day!

  } else if (window_sel == '2 yr.') {

    # Select two-year symmetric window around the policy change.
    saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2007-04-01' &
      saaq_data[, 'dinf'] <= '2009-03-31'

    # Set date of policy change.
    april_fools_date <- '2008-04-01'
    # No joke: policy change on April Fool's Day!

  } else if (window_sel == 'Placebo') {

    # Select symmetric window around the placebo change.
    # Year before (2007):
    saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
      saaq_data[, 'dinf'] <= '2008-03-31'

    # Set date of placebo policy change.
    april_fools_date <- '2007-04-01'
    # No joke: policy change on April Fool's Day!

  } else {
    stop(sprintf("Window setting '%s' not recognized.", window_sel))
  }
  # Generate the indicator for the policy change.
  saaq_data[, 'policy'] <- saaq_data[, 'dinf'] >= april_fools_date


  # Generate monthly indicators after the policy change (for learning rate).
  if (window_sel == 'Monthly 4 yr.') {
    # Two definitions:
    saaq_data[, 'policy_month'] <- NA
    saaq_data[saaq_data[, 'dinf'] < april_fools_date, 'policy_month'] <- "policyFALSE"
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] >= as.Date('2009-04-01'), 'policy_month'] <- "policyFALSE"
    # First definition: Policy and month of year (yes, confusing but easy).
    # saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
    #             saaq_data[, 'dinf'] < as.Date('2009-04-01'), 'policy_month'] <-
    #   sprintf("policy%s", saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
    #                                   saaq_data[, 'dinf'] < as.Date('2009-04-01'), 'month'])
    # Second definition: Policy and month of year (yes, confusing but easy).
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '04', 'policy_month'] <- 'policy01'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '05', 'policy_month'] <- 'policy02'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '06', 'policy_month'] <- 'policy03'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '07', 'policy_month'] <- 'policy04'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '08', 'policy_month'] <- 'policy05'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '09', 'policy_month'] <- 'policy06'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '10', 'policy_month'] <- 'policy07'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '11', 'policy_month'] <- 'policy08'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '12', 'policy_month'] <- 'policy09'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '01', 'policy_month'] <- 'policy10'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '02', 'policy_month'] <- 'policy11'
    saaq_data[saaq_data[, 'dinf'] >= april_fools_date &
                saaq_data[, 'dinf'] < as.Date('2009-04-01') &
                saaq_data[, 'month'] == '03', 'policy_month'] <- 'policy12'
    # In either case, transform it into factor.
    saaq_data[, 'policy_month'] <- factor(saaq_data[, 'policy_month'],
                                    levels = c('policyFALSE',
                                               sprintf('policy0%d', 1:9),
                                               sprintf('policy%d', 10:12)))
  }



  #--------------------------------------------------
  # Default event window around policy change
  # and impose any sample selection.
  #--------------------------------------------------
  if (past_pts_sel == 'all') {

    # All relevant observations.
    saaq_data[, 'sel_window'] <- saaq_data[, 'window']

  } else if (past_pts_sel == 'high') {

    # Additional subsetting for drivers with past
    # point balances between 6 and 10 points
    # in the pre-policy-change period.
    saaq_data[, 'sel_window'] <- saaq_data[, 'window'] &
      saaq_data[, 'past_active']

  } else {
    stop(sprintf("Past points setting '%s' not recognized.", past_pts_sel))
  }


  #--------------------------------------------------
  # Select subset of observations.
  #--------------------------------------------------
  if (sex_sel == 'All') {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_window']

  } else if (sex_sel %in% c('Male', 'Female')) {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == substr(sex_sel, 1, 1) &
      saaq_data[, 'sel_window']

  } else {
    stop(sprintf("Sex selection '%s' not recognized.", sex_sel))
  }
  sel_obs <- saaq_data[, 'sel_obsn']


  #--------------------------------------------------
  # Define event as a combination of point balances.
  #--------------------------------------------------
  if (pts_target == 'all') {

    # All violations combined.
    saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

  } else if (pts_target == '1') {

    # One point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 1

  } else if (pts_target == '2') {

    # Two point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 2

  } else if (pts_target == '3') {

    # Three point violations
    # (or 6-point violations that used to be 3-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 6

  } else if (pts_target == '4') {

    # Four point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 4

  } else if (pts_target == '5') {

    # Five point violations.
    # (or 10-point violations that used to be 5-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 5 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 10

  } else if (pts_target == '7') {

    # Seven and fourteen point violations.
    # Seven point violations.
    # (or 14-point violations that used to be 7-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 7 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 14

  } else if (pts_target == '9+') {

    # Nine point speeding violations and up (excluding the 10s and 14s above).
    saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 12, 15, 18, 21,
                                                          24, 30, 36)

  } else {
    stop(sprintf("Point balance target '%s' not recognized.", pts_target_list))
  }


  #--------------------------------------------------
  # Set formula for regression model
  #--------------------------------------------------

  if (sex_sel == 'All') {
    # If sex variables included.
    # var_list <- c('policy', 'sex', 'sex*policy')
    # If same model estimated as that with subsamples separated by sex.
    var_list <- c('policy')
  } else if (sex_sel %in% c('Male', 'Female')) {
    var_list <- c('policy')
  } else {
    stop(sprintf("Sex selection '%s' not recognized.", sex_sel))
  }
  if (window_sel == 'Monthly 4 yr.') {
    var_list <- c(var_list, 'policy_month')
  }
  if (age_int == 'with') {
    var_list <- c(var_list, 'policy*age_grp')
  } else if (age_int == 'no') {
    # no variables added.
    var_list <- var_list
  } else {
    stop(sprintf("Age indicator selector '%s' not recognized.", age_int))
  }
  var_list <- c(var_list, 'age_grp', 'curr_pts_grp')
  if (season_incl == 'monthly') {
    var_list <- c(var_list, 'month')
  } else if (season_incl == 'mnwk') {
    var_list <- c(var_list, 'month', 'weekday')
  } else if (season_incl == 'excluded') {
    # No variables added.
    var_list <- var_list
  } else {
    stop(sprintf("Seasonality indicator selector '%s' not recognized.", season_incl))
  }

  fmla <- as.formula(sprintf('events ~ %s',
                             paste(var_list, collapse = " + ")))



  #--------------------------------------------------
  # Run regressions
  #--------------------------------------------------
  if (reg_type == 'LPM') {

    # Estimating a Linear Probability Model


    # Estimate the model accounting for the aggregated nature of the data.
    agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                             formula = fmla, x = TRUE)
    summ_agg_lm <- summary_agg_lm(agg_lm_model_1)

    # Adjust standard errors for heteroskedasticity.
    agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
    summ_model <- agg_lpm_hccme_1
    # print(agg_lpm_hccme_1$coef_hccme)

    est_coefs <- summ_model$coef_hccme

    # # Checking for negative LPM predictions.
    # lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
    #                  formula = chosen_model))

  } else if (reg_type == 'Logit') {

    # Estimate logistic regression model.
    log_model_1 <- glm(data = saaq_data[sel_obs, ], weights = num,
                       formula = fmla,
                       family = 'binomial')
    summ_model <- summary(log_model_1)

    est_coefs <- summ_model$coefficients

  } else {
    stop(sprintf("Model type '%s' not recognized.", reg_type))
  }


  #--------------------------------------------------
  # Calculate marginal effects, if appropriate.
  #--------------------------------------------------
  if (reg_type == 'Logit') {

    # Set up a dataset for predictions.
    if ((age_int == 'no') & (window_sel == 'Monthly 4 yr.')) {
      # mfx_fmla_list <- c("sex", "age_grp", "curr_pts_grp", "month", "weekday")
      mfx_fmla_list <- var_list
    } else {
      mfx_fmla_list <- c("sex", "age_grp", "curr_pts_grp", "month", "weekday")
    }

    mfx_fmla <- as.formula(sprintf('num ~ %s',
                                   paste(mfx_fmla_list, collapse = ' + ')))
    saaq_data_pred <- aggregate(formula = mfx_fmla,
                                data = saaq_data[sel_obs, ],
                                FUN = sum)

    if ((age_int == 'no') & (window_sel == 'Monthly 4 yr.')) {
      # Predict probabilities.
      saaq_data_pred[, 'pred_prob'] <- predict(log_model_1,
                                               newdata = saaq_data_pred,
                                               type="response")
    } else {
      # Predict for policy == FALSE.
      saaq_data_pred[, 'policy'] <- FALSE
      saaq_data_pred[, 'pred_prob_before'] <- predict(log_model_1,
                                                      newdata = saaq_data_pred,
                                                      type="response")

      # Predict for policy == TRUE.
      saaq_data_pred[, 'policy'] <- TRUE
      saaq_data_pred[, 'pred_prob_after'] <- predict(log_model_1,
                                                     newdata = saaq_data_pred,
                                                     type="response")
    }


    # Calculate single policy effect or policy age interactions.
    if (age_int == 'with') {

      # # Predict for all observations.
      # saaq_data[, 'pred_prob'] <- NA
      # saaq_data[sel_obs, 'pred_prob'] <- predict(log_model_1,
      #                                            # newdata = saaq_data[sel_obs, ],
      #                                            type="response")
      # summary(saaq_data[sel_obs, 'pred_prob'])

      mfx_mat <- data.frame(age_grp = levels(mfx_age_list),
                            pred_prob = NA)

      for (mfx_row in 1:nrow(mfx_mat)) {
        age_grp_sel <- mfx_mat[mfx_row, 'age_grp']

        # # Take differences between with and without policy.
        # mfx_sel_T <- saaq_data[, 'policy'] == TRUE & sel_obs &
        #   saaq_data[, 'age_grp'] == age_grp_sel
        # mfx_sel_F <- saaq_data[, 'policy'] == FALSE & sel_obs &
        #   saaq_data[, 'age_grp'] == age_grp_sel
        # # mfx <- mean(saaq_data[mfx_sel, 'pred_prob']) -
        # #   mean(saaq_data[mfx_sel, 'pred_prob'])
        # mfx <- sum(saaq_data[mfx_sel_T, 'pred_prob'] *
        #              saaq_data[mfx_sel_T, 'num']) /
        #   sum(saaq_data[mfx_sel_T, 'num']) -
        #   sum(saaq_data[mfx_sel_F, 'pred_prob'] *
        #         saaq_data[mfx_sel_F, 'num']) /
        #   sum(saaq_data[mfx_sel_F, 'num'])


        # # Take differences between before and after policy change.
        mfx_sel <- saaq_data_pred[, 'age_grp'] == age_grp_sel
        # mfx <- sum(saaq_data_pred[mfx_sel, 'pred_prob_after'] *
        #              saaq_data_pred[mfx_sel, 'num']) /
        #   sum(saaq_data_pred[mfx_sel, 'num']) -
        #   sum(saaq_data_pred[mfx_sel, 'pred_prob_before'] *
        #         saaq_data_pred[mfx_sel, 'num']) /
        #   sum(saaq_data_pred[mfx_sel, 'num'])


        # Calculate derivative as beta_i*p_hat*(1 - p_hat).
        if (age_grp_sel == '0-15') {
          beta_i_str <- 'policyTRUE'
        } else {
          beta_i_str <- sprintf('policyTRUE:age_grp%s', age_grp_sel)
        }
        beta_i <- est_coefs[beta_i_str, 'Estimate']
        # Probability before policy change (an overestimate).
        # p_hat <- sum(saaq_data_pred[mfx_sel, 'pred_prob_before'] *
        #                saaq_data_pred[mfx_sel, 'num']) /
        #   sum(saaq_data_pred[mfx_sel, 'num'])
        # Average of probability before and after policy change.
        p_hat <- sum((saaq_data_pred[mfx_sel, 'pred_prob_before'] +
                    saaq_data_pred[mfx_sel, 'pred_prob_after']) *
                    saaq_data_pred[mfx_sel, 'num'] ) /
          sum(saaq_data_pred[mfx_sel, 'num'])/2
        mfx <- beta_i*p_hat*(1 - p_hat)

        mfx_mat[mfx_row, 'pred_prob'] <- mfx*100000
      }

    } else if ((age_int == 'no') & (window_sel == 'Monthly 4 yr.')) {

      mfx_mat <- data.frame(policy_month = levels(saaq_data[, 'policy_month']),
                            pred_prob = NA)
      # Change first rowname to match coefficients.
      mfx_mat[1, 'policy_month'] <- 'policyTRUE'

      for (mfx_row in 1:nrow(mfx_mat)) {
        policy_month_sel <- mfx_mat[mfx_row, 'policy_month']
        month_sel <- substr(policy_month_sel, 7, nchar(policy_month_sel))

        if (month_sel == 'TRUE') {
          mfx_sel <- TRUE
          beta_i_str <- sprintf('policy%s', month_sel)
        } else {
          mfx_sel <- saaq_data_pred[, 'month'] == month_sel
          beta_i_str <- sprintf('policy_monthpolicy%s', month_sel)
        }


        # Calculate derivative as beta_i*p_hat*(1 - p_hat).
        beta_i <- est_coefs[beta_i_str, 'Estimate']
        # Average of probability before and after policy change.
        p_hat <- sum(saaq_data_pred[mfx_sel, 'pred_prob'] *
                       saaq_data_pred[mfx_sel, 'num'] ) /
          sum(saaq_data_pred[mfx_sel, 'num'])
        mfx <- beta_i*p_hat*(1 - p_hat)

        mfx_mat[mfx_row, 'pred_prob'] <- mfx*100000


      }


    } else if ((age_int == 'no') & !(window_sel == 'Monthly 4 yr.')) {

      # # Predict for all observations.
      # saaq_data[, 'pred_prob'] <- NA
      # saaq_data[sel_obs, 'pred_prob'] <- predict(log_model_1,
      #                                            # newdata = saaq_data[sel_obs, ],
      #                                            type="response")
      # # summary(saaq_data[sel_obs, 'pred_prob'])
      #
      # mfx_sel_T <- saaq_data[, 'policy'] == TRUE & sel_obs
      # mfx_sel_F <- saaq_data[, 'policy'] == FALSE & sel_obs
      # # mfx <- mean(saaq_data[mfx_sel, 'pred_prob']) -
      # #   mean(saaq_data[mfx_sel, 'pred_prob'])
      # mfx <- sum(saaq_data[mfx_sel_T, 'pred_prob'] *
      #              saaq_data[mfx_sel_T, 'num']) /
      #   sum(saaq_data[mfx_sel_T, 'num']) -
      #   sum(saaq_data[mfx_sel_F, 'pred_prob'] *
      #         saaq_data[mfx_sel_F, 'num']) /
      #   sum(saaq_data[mfx_sel_F, 'num'])

      # # Take differences between before and after policy change.
      # mfx <- sum(saaq_data_pred[, 'pred_prob_after'] *
      #              saaq_data_pred[, 'num']) /
      #   sum(saaq_data_pred[, 'num']) -
      #   sum(saaq_data_pred[, 'pred_prob_before'] *
      #         saaq_data_pred[, 'num']) /
      #   sum(saaq_data_pred[, 'num'])

      # Calculate derivative as beta_i*p_hat*(1 - p_hat).
      beta_i_str <- 'policyTRUE'
      beta_i <- est_coefs[beta_i_str, 'Estimate']
      # Probability before policy change (an overestimate).
      # p_hat <- sum(saaq_data_pred[, 'pred_prob_before'] *
      #                saaq_data_pred[, 'num']) /
      #   sum(saaq_data_pred[, 'num'])
      # Average of probability before and after policy change.
      p_hat <- sum((saaq_data_pred[, 'pred_prob_before'] +
                      saaq_data_pred[, 'pred_prob_after']) *
                     saaq_data_pred[, 'num'] ) /
        sum(saaq_data_pred[, 'num'])/2
      mfx <- beta_i*p_hat*(1 - p_hat)

      mfx_mat <- data.frame(age_grp = levels(mfx_age_list)[1],
                            pred_prob = mfx*100000)

    }
  }


  #--------------------------------------------------
  # Print the results.
  #--------------------------------------------------

  # Print section headings in README file.
  pts_heading_sel <- pts_headings[
    pts_headings[, 'pts_target'] == pts_target, 'heading']
  cat(sprintf('\n\n### %s\n\n', pts_heading_sel),
      file = md_path, append = TRUE)


  # Print regression output.
  cat('\n```', file = md_path, append = TRUE)
  var_label <- sprintf("%s                         ", "Variable")
  cat(sprintf(" \n%s", substr(var_label, 1, 25)),
      file = md_path, append = TRUE)
  cat(paste(sprintf("     %s    ", colnames(est_coefs)), collapse = ""),
      file = md_path, append = TRUE)
  for (print_row in 1:nrow(est_coefs)) {
    var_label <- sprintf("%s                         ", rownames(est_coefs)[print_row])
    cat(sprintf(" \n%s", substr(var_label, 1, 25)),
        file = md_path, append = TRUE)
    cat(sprintf("     % 9.6g  ", est_coefs[print_row, ]),
        file = md_path, append = TRUE)
  }
  cat('\n```\n', file = md_path, append = TRUE)


  # Print marginal effects, if appropriate.
  if (reg_type == 'Logit') {
    cat('\n\n\n```\n', file = md_path, append = TRUE)
    # cat(mfx_mat, file = md_path, append = TRUE)
    cat(sprintf('%s          %s\n',
                colnames(mfx_mat)[1], colnames(mfx_mat)[2]),
        file = md_path, append = TRUE)
    for (mfx_row in 1:nrow(mfx_mat)) {
      cat(sprintf('%s          %f\n',
                  mfx_mat[mfx_row, 1], mfx_mat[mfx_row, 2]),
          file = md_path, append = TRUE)
    }
    cat('\n```\n\n', file = md_path, append = TRUE)
  }


  #--------------------------------------------------
  # Store the results for tables.
  #--------------------------------------------------

  # Rearrange coefficient matrix to add a column for row names.
  est_coefs_df <- data.frame(est_coefs)
  est_coefs_df[, 'Variable'] <- rownames(est_coefs)
  est_coefs_df <- est_coefs_df[, c(5, 1:4)]
  colnames(est_coefs_df) <- c('Variable', 'Estimate', 'Std_Error',
                              'z_stat', 'p_value')

  estn_results_sub <- cbind(model_list[rep(estn_num, nrow(est_coefs_df)), ],
                            est_coefs_df)

  # Append a column for marginal effects.
  estn_results_sub[, 'mfx'] <- NA
  # Insert values for marginal effects, if appropriate.
  if (reg_type == 'Logit') {
    if (age_int == 'with') {

      estn_results_sub[estn_results_sub[, 'Variable'] == 'policyTRUE',
                       'mfx'] <- mfx_mat[1, 'pred_prob']
      # State remaining marginal differences in same units as LPM:
      # additional policy effect beyond benchmark age group.
      # estn_results_sub[
      #   substr(estn_results_sub[, 'Variable'], 1, 18) == 'policyTRUE:age_grp',
      #   'mfx'] <- mfx_mat[2:nrow(mfx_mat), 'pred_prob'] -
      #   mfx_mat[1, 'pred_prob']
      estn_results_sub[
        substr(estn_results_sub[, 'Variable'], 1, 18) == 'policyTRUE:age_grp',
        'mfx'] <- mfx_mat[2:nrow(mfx_mat), 'pred_prob']

    } else if ((age_int == 'no') & (window_sel == 'Monthly 4 yr.')) {

      estn_results_sub[estn_results_sub[, 'Variable'] == 'policyTRUE',
                       'mfx'] <- mfx_mat[1, 'pred_prob']

      estn_results_sub[
        substr(estn_results_sub[, 'Variable'], 1, 12) == 'policy_month',
        'mfx'] <- mfx_mat[2:nrow(mfx_mat), 'pred_prob']

    } else if ((age_int == 'no') & !(window_sel == 'Monthly 4 yr.')) {

      estn_results_sub[estn_results_sub[, 'Variable'] == 'policyTRUE',
                       'mfx'] <- mfx_mat[, 'pred_prob']
    }

  }


  # Bind it to the full data frame of results.
  estn_results <- rbind(estn_results, estn_results_sub)

}

# Save the data frame of estimates.
write.csv(estn_results, file = estn_file_path)


# # Save another copy for comparison.
# estn_version <- 5
# estn_file_name_2 <- sprintf('estimates_v%d_2.csv', estn_version)
# estn_file_path_2 <- sprintf('%s/%s', md_dir, estn_file_name_2)
#
# write.csv(estn_results, file = estn_file_path_2)


# # Read in previous dataset to compare.
# # Monthly and weekday seasonality
# estn_version <- 5
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
# estn_results_5 <- read.csv(file = estn_file_path)
# summary(estn_results_5)
#
#
# summary(estn_results)
#
# comp_cols <- colnames(estn_results_5)[2:ncol(estn_results_5)]
# summary(estn_results_5[, comp_cols] == estn_results[, comp_cols])
#
# comp_cols <- colnames(estn_results_5)[10:ncol(estn_results_5)]
# summary(estn_results_5[, comp_cols] - estn_results[, comp_cols])
# # Numerically the same.


################################################################################
# End
################################################################################

