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
data_in_path <- '~/Research/SAAQ/SAAQdata_full/'

# The data of demerit point counts are stored in 'SAAQdata/seqData/'.
# dataOutPath <- 'SAAQspeeding/SAAQspeeding/'
data_out_path <- '~/Research/SAAQ/SAAQspeeding/SAAQspeeding/'
md_dir <- 'results'

# Set version of input file.
# ptsVersion <- 2 # With current points but not past active.
pts_version <- 3 # With current points and past active.


# Set version of output file.
# Optional.

# Set the combinations of model specifications to be estimated.

# These are in different folders.
# past_pts_list <- c('all', 'high')
past_pts_list <- c('all')
# window_list <- c('4 yr.', 'Placebo')
window_list <- c('4 yr.')
# seasonality_list <- c('included', 'excluded')
seasonality_list <- c('excluded')

# These are file-specific.
# model_list <- c('LPM', 'Logit')
model_list <- c('LPM')
sex_list <- c('Both Sexes', 'Males', 'Females')

# These combination are explored within a file.
pts_target_list <- c('all',
                     '1', '2', '3', '4', '5', '7',
                     '9+')
age_int_list <- c('no', 'with') # ..  age interactions


# Set the full list of model specification combinations.
model_list <- expand.grid(past_pts = past_pts_list,
                          window = window_list,
                          seasonality = seasonality_list,
                          model = model_list,
                          sex = sex_list,
                          pts_target = pts_target_list,
                          age_int = age_int_list)

# Initialize path.
md_path_last <- "empty"
# Sample block of code for inserting after data prep.
for (estn_num in 1:nrow(model_list)) {

  # Extract parameters for this estimated model.
  past_pts_sel <- model_list[estn_num, 'past_pts']
  window_sel <- model_list[estn_num, 'window']
  season_incl <- model_list[estn_num, 'seasonality']
  model_type <- model_list[estn_num, 'model']
  sex_sel <- model_list[estn_num, 'sex']
  pts_target <- model_list[estn_num, 'pts_target']
  age_int <- model_list[estn_num, 'age_int']

  # Create the path and file name for the markdown file.
  md_sub_dir <- sprintf('%s/past_pts_%S_%s_window_seas_%s/', md_dir,
                        past_pts_sel,
                        substr(window_list, 1, 1),
                        substr(season_incl, 1, 4))
  md_file_name <- sprintf('results_%s_%s.md',
                          model_type,
                          substr(sex_sel, 1, 1))
  md_path <- sprintf('%s/%s/%s', data_out_path, md_sub_dir, md_file_name)


  print(md_sub_dir)
  print(md_file_name)

  # If a new path is created, open a new output file.
  if (md_path != md_path_last) {
    title_str <- sprintf('%s Estimaes for %s',
                         model_type, sex_sel)
    cat('', md_path, append = FALSE)
  }
  md_path_last <- md_path


  #--------------------------------------------------
  # Set event window around policy indicator.
  #--------------------------------------------------
  if (window_sel == '4 yr.') {

    # Select symmetric window around the policy change.
    saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-04-01' &
      saaq_data[, 'dinf'] <= '2010-03-31'

    # Set date of policy change.
    april_fools_date <- '2008-04-01'
    # No joke: policy change on April Fool's Day!

  } else if (window_sel == '2 yr.') {

    # Select two-year symmetric window around the policy change.
    saaq_data[, 'window_short'] <- saaq_data[, 'dinf'] >= '2007-04-01' &
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
    saaq_data[, 'sel_obsn'] <- saaq_data[, 'window'] &
      saaq_data[, 'past_active']

  } else {
    stop(sprintf("Past points setting '%s' not recognized.", past_pts_sel))
  }


  #--------------------------------------------------
  # Select subset of observations.
  #--------------------------------------------------
  if (sex_sel == 'Both Sexes') {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_window']

  } else if (sex_sel %in% c('M', 'F')) {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == sex_sel &
      saaq_data[, 'sel_window']

  } else {
    stop(sprintf("Sex selection '%s' not recognized.", sex_sel))
  }
  sel_obs <- saaq_data[, 'sel_obsn']


  #--------------------------------------------------
  # Define event as a combination of point balances.
  #--------------------------------------------------
  if (pts_target_list == 'all') {

    # All violations combined.
    saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

  } else if (pts_target_list == '1') {

    # One point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 1

  } else if (pts_target_list == '2') {

    # Two point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 2

  } else if (pts_target_list == '3') {

    # Three point violations
    # (or 6-point violations that used to be 3-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 3 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 6

  } else if (pts_target_list == '4') {

    # Four point violations.
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 4

  } else if (pts_target_list == '5') {

    # Five point violations.
    # (or 10-point violations that used to be 5-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 5 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 10

  } else if (pts_target_list == '7') {

    # Seven and fourteen point violations.
    # Seven point violations.
    # (or 14-point violations that used to be 7-point violations).
    saaq_data[, 'events'] <- saaq_data[, 'points'] == 7 |
      saaq_data[, 'policy'] & saaq_data[, 'points'] == 14

  } else if (pts_target_list == '9+') {

    # Nine point speeding violations and up (excluding the 10s and 14s above).
    saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 12, 15, 18, 21,
                                                          24, 30, 36)

  } else {
    stop(sprintf("Point balance target '%s' not recognized.", pts_target_list))
  }


  #--------------------------------------------------
  # Set formula for regression model
  #--------------------------------------------------

  if (sex_sel == 'Both Sexes') {
    var_list <- c('policy', 'sex', 'sex*policy')
  } else if (sex_sel %in% c('M', 'F')) {
    var_list <- c('policy')
  } else {
    stop(sprintf("Sex selection '%s' not recognized.", sex_sel))
  }
  if (age_int == 'with') {
    var_list <- c(var_list, 'policy*age_grp')
  } else if (age_int == 'no') {
    # no variables added.
  } else {
    stop(sprintf("Age indicator selector '%s' not recognized.", age_int))
  }
  var_list <- c(var_list, 'age_grp', 'curr_pts_grp')
  if (season_incl == 'included') {
    var_list <- c(var_list, 'month')
  } else if (season_incl == 'excluded') {
    # No variables added.
  } else {
    stop(sprintf("Seasonality indicator selector '%s' not recognized.", season_incl))
  }

  fmla <- as.formula(sprintf('events ~ %s',
                             paste('var_list', collapse = " + ")))



  #--------------------------------------------------
  # Run regressions
  #--------------------------------------------------
  if (model_type == 'LPM') {

    # Estimating a Linear Probability Model


    # Estimate the model accounting for the aggregated nature of the data.
    agg_lm_model_1 <- agg_lm(data = saaq_data[sel_obs, ], weights = num,
                             formula = fmla, x = TRUE)
    summ_agg_lm <- summary_agg_lm(agg_lm_model_1)

    # Adjust standard errors for heteroskedasticity.
    agg_lpm_hccme_1 <- white_hccme_med(agg_lm_model_1)
    summ_model <- agg_lpm_hccme_1
    # print(agg_lpm_hccme_1$coef_hccme)

    # # Checking for negative LPM predictions.
    # lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
    #                  formula = chosen_model))

  } else if (model_type == 'Logit') {
    stop(sprintf("Model type '%s' not recognized.", model_type))
  } else {
    stop(sprintf("Model type '%s' not recognized.", model_type))
  }

  # Print section headings in README file.
  cat('', file = md_path, append = TRUE)


  # Print regression output.
  cat('```', file = md_path, append = TRUE)
  cat(summ_model, file = md_path, append = TRUE)
  cat('```', file = md_path, append = TRUE)

}


################################################################################
# Load Annual Driver Counts
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


# Generate variables for regressions.
saaq_data[, 'policy'] <- NA
saaq_data[, 'window'] <- NA
saaq_data[, 'events'] <- NA




##################################################
# End
##################################################
