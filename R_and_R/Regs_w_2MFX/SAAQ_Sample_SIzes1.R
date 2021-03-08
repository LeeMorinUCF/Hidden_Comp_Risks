################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Logistic and linear probability models of numbers of tickets awarded by the
# number of points per ticket.
#
#
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# March 5, 2021
#
################################################################################
#
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Estimate linear probability models for sets of offenses.
# Identify discontinuity from policy change on April 1, 2008.
# Excessive speeding offenses were assigned double demerit points.
#
# This script records the sample sizes for regressions.
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
estn_version <- 1
estn_file_name <- sprintf('sampl_sizes_v%d.csv', estn_version)
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
orig_age_grp_list <- unique(saaq_data[, 'age_grp'])
saaq_data[, 'age_grp_orig'] <- saaq_data[, 'age_grp']
age_grp_list <- c(orig_age_grp_list[seq(7)], '65-199')

saaq_data[, 'age_grp'] <- as.factor(NA)
levels(saaq_data[, 'age_grp']) <- age_grp_list
age_group_sel <- saaq_data[, 'age_grp_orig'] %in% orig_age_grp_list[seq(7)]
saaq_data[age_group_sel, 'age_grp'] <- saaq_data[age_group_sel, 'age_grp_orig']
saaq_data[!age_group_sel, 'age_grp'] <- age_grp_list[8]


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

# These results are stored in different folders.
# past_pts_list <- c('all', 'high')
past_pts_list <- c('all')
# window_list <- c('4 yr.', 'Placebo')
# window_list <- c('4 yr.')
# seasonality_list <- c('included', 'excluded')
# seasonality_list <- c('excluded')

# These are stored in different files within the folders.
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



############################################################
# Set List of Regression Specifications
############################################################

# Pick any of the four specification groups for the analysis.
# spec_group <- 'pooled'
# spec_group <- 'all' # 8 NAs w QMLE
# spec_group <- 'high_pts' # 3 NAs w QMLE
# spec_group <- 'placebo'
# spec_group <- 'events'

spec_group_list <- c('pooled', 'all', 'high_pts', 'placebo', 'events')

model_list_full <- NULL

for (spec_group in spec_group_list) {


  if (spec_group == 'pooled') {

    #------------------------------------------------------------
    # Pooled regressions with separation by age group.
    #------------------------------------------------------------

    # Set the full list of model specification combinations.
    model_list <- expand.grid(past_pts = c('all'),
                              window = c('4 yr.'),
                              seasonality = c('mnwk'),
                              age_int = c('no', age_grp_list),
                              pts_target = c('all'),
                              sex = c('All'),
                              reg_type = c('LPM', 'Logit'))





  } else if (spec_group == 'all') {

    #------------------------------------------------------------
    # Specification: All Drivers with Monthly and weekday seasonality
    #------------------------------------------------------------

    # Set the full list of model specification combinations.
    model_list <- expand.grid(past_pts = c('all'),
                              window = c('4 yr.'),
                              seasonality = c('mnwk'),
                              age_int = age_int_list,
                              pts_target = pts_target_list,
                              sex = c('Male', 'Female'),
                              # sex = sex_list,
                              reg_type = reg_list)

  } else if (spec_group == 'high_pts') {

    #------------------------------------------------------------
    # Sensitivity Analysis: High-point drivers.
    # (with monthly and weekday seasonality)
    #------------------------------------------------------------

    # Set the partial list of model specification combinations.
    model_list <- expand.grid(past_pts = c('high'),
                              # past_pts = c('all'),
                              window = c('4 yr.'),
                              seasonality = c('mnwk'),
                              age_int = age_int_list,
                              # pts_target = c('all'),
                              pts_target = pts_target_list,
                              sex = c('Male', 'Female'),
                              # sex = sex_list,
                              reg_type = reg_list)


  } else if (spec_group == 'placebo') {

    #------------------------------------------------------------
    # Sensitivity Analysis: Placebo regression.
    # (with monthly and weekday seasonality)
    #------------------------------------------------------------

    # Set the partial list of model specification combinations.
    model_list <- expand.grid(past_pts = c('all'),
                              window = c('Placebo'),
                              # window = c('4 yr.'),
                              seasonality = c('mnwk'),
                              age_int = age_int_list,
                              pts_target = c('all'),
                              # pts_target = pts_target_list,
                              sex = c('Male', 'Female'),
                              # sex = sex_list,
                              reg_type = reg_list)

  } else if (spec_group == 'events') {

    #------------------------------------------------------------
    # Specification: REAL event study with seasonality
    #------------------------------------------------------------

    # Set the full list of model specification combinations.
    model_list <- expand.grid(past_pts = c('all'),
                              window = c('Monthly 4 yr.'),
                              seasonality = c('mnwk'),
                              age_int = age_int_list,
                              # pts_target = pts_target_list,
                              pts_target = 'all',
                              sex = c('Male', 'Female'),
                              # sex = sex_list,
                              reg_type = reg_list)


  } else {
    stop('Regression specification not recognized. ')
  }

  # Append list of models to master list.
  model_list_full <- rbind(model_list_full, model_list)


}

# Overwrite model_list with master list from all models.
model_list <- model_list_full


#------------------------------------------------------------
# Run estimation in a loop on the model specifications.
#------------------------------------------------------------


# Initialize data frame to store estimation results.
estn_results <- NULL


# Initialize path.
# Sample block of code for inserting after data prep.
# estn_num <- 1
# estn_num <- 10
# for (estn_num in 51:nrow(model_list)) {
for (estn_num in 1:nrow(model_list)) {

  # Extract parameters for this estimated model.
  past_pts_sel <- model_list[estn_num, 'past_pts']
  window_sel <- model_list[estn_num, 'window']
  season_incl <- model_list[estn_num, 'seasonality']
  reg_type <- model_list[estn_num, 'reg_type']
  sex_sel <- model_list[estn_num, 'sex']
  pts_target <- model_list[estn_num, 'pts_target']
  age_int <- model_list[estn_num, 'age_int']



  # Create a message to describe this model.
  out_msg <- sprintf("Estimating model for %s drivers, %s point tickets.",
                     sex_sel, pts_target)

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
  # Select subset of observations by sex.
  #--------------------------------------------------
  if (sex_sel == 'All') {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_window']

  } else if (sex_sel %in% c('Male', 'Female')) {

    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == substr(sex_sel, 1, 1) &
      saaq_data[, 'sel_window']

  } else {
    stop(sprintf("Sex selection '%s' not recognized.", sex_sel))
  }

  #--------------------------------------------------
  # Select subset of observations by age.
  #--------------------------------------------------
  if (age_int %in% age_grp_list) {
    saaq_data[, 'sel_obsn'] <- saaq_data[, 'sel_obsn'] &
      saaq_data[, 'age_grp'] %in% age_int
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
  # Store the results for tables.
  #--------------------------------------------------

  # Add sample size to data frame for tables.
  estn_results_sub <- model_list[estn_num, ]
  estn_results_sub[, 'N'] <- sum(saaq_data[sel_obs, 'num'])


  # Bind it to the full data frame of results.
  estn_results <- rbind(estn_results, estn_results_sub)

}

# Save the data frame of estimates.
write.csv(estn_results, file = estn_file_path)


################################################################################
# End
################################################################################

