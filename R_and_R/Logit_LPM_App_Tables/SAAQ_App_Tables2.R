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
# College of Business
# University of Central Florida
#
# January 30, 2021
#
################################################################################
#
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Estimate linear probability models for sets of offenses.
# Identify discontinuity from policy change on April 1, 2008.
# Excessive speeding offenses were assigned double demerit points.
#
# This version accompanies a number of modifications for a revise and resubmit decision.
# It complements the estimation results to appear in the manuscript.
#
# This version also creates a function for a series of tables for a
# supplementary appendix of tables of regression results with all
# coefficients, including those for control variables not shown
# in the published paper.
# This version creates tables with pairs of models: one for each of
# logistic and LPM with the same specification on each page.
#
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Load lobrary to print tables to tex files.
library(xtable)


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
# md_dir <- sprintf("%s/results", git_path)
tab_dir <- sprintf("%s/RegTest", git_path)

# Set version of input file.
# ptsVersion <- 2 # With current points but not past active.
pts_version <- 3 # With current points and past active.


# Set version of output file.
# estn_version <- 99
# estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
# estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)


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
# For each set of specifications, estimate logit and LPM
# for both males and females (except for first).

past_pts_list <- c(rep('all', 9*2 - 1), rep('high', 7*2), rep('all', 2*2))
window_list <- c(rep('4 yr.', 16*2 - 1), rep('Placebo', 2), rep('Monthly 4 yr.', 2))
seasonality_list <- c(rep('mnwk', 18*2 - 1))
age_int_list <- c(rep('with', 18*2 - 1)) # ..  age interactions
pts_target_list <- c(rep('all', 2*2 - 1),
                     rep(c('1', '2', '3', '4', '5', '7', '9+'),
                         each = 2, times = 2),
                     rep('all', 2*2))
pts_target_label_list <- c(rep('all', 2*2 - 1),
                           rep(c('1', '2', '3', '4', '5', '7', '9plus'),
                               each = 2, times = 2),
                           rep('all', 2*2))
pts_target_caption_list <- c(rep('all offences', 2*2 - 1),
                             rep(sprintf('%s points', c('1', '2', '3', '4', '5', '7', '9 or more')),
                                 each = 2, times = 2),
                             rep('all offences', 2*2))
pts_target_caption_list[pts_target_caption_list == '1 points'] <- '1 point'


sex_list <- c(rep('All', 2 - 1), rep(c('Male', 'Female'), 17))
# Trim one because first pooled regression would be a duplicate.

# Set the full list of model specification combinations.
model_list <- data.frame(past_pts = past_pts_list,
                         window = window_list,
                         seasonality = seasonality_list,
                         age_int = age_int_list,
                         pts_target = pts_target_list,
                         sex = sex_list)



# Specify section headings by table names.
sec_head_list <- c('Table 3: Pooled regressions for all offences',
                   'Table 4: Regressions for all offences',
                   rep('Table 5: Regressions by ticket-point value', 7),
                   rep('Table 6: Regressions for high-point drivers by ticket-point value', 7),
                   'Table 7: Placebo regressions for all offences',
                   'Table 8: Regressions with indicators for month since policy change')

# Except for pooled regression, tables split in two by sex.
tab_sec_head_list <- sec_head_list
tab_sec_head_list <- c(tab_sec_head_list[1],
                       rep(tab_sec_head_list[2:length(tab_sec_head_list)], each = 2))

tab_num_list <- substr(tab_sec_head_list, 7, 7)

# Create series of labels for references.
tab_label_list <- sprintf('tab_%s_%s_pts_%s',
                          tab_num_list,
                          pts_target_label_list,
                          substr(sex_list, 1, 1))

# Create captions for each table (depends on whether separated by point value).
tab_caption_list_all <- sprintf('Full model from %s (%s drivers)',
                            tab_sec_head_list,
                            tolower(sex_list))
tab_caption_list_pts <- sprintf('Full model from %s (%s, %s drivers)',
                            tab_sec_head_list,
                            pts_target_caption_list,
                            tolower(sex_list))
tab_caption_list <- tab_caption_list_pts
tab_caption_list[pts_target_caption_list == 'all offences'] <-
  tab_caption_list_all[pts_target_caption_list == 'all offences']


# Create indicator for new table.
new_tab <- c(TRUE, c('0', tab_num_list[-c(1, length(tab_num_list))]) != tab_num_list[-1])


# Specify headings for each point level.
pts_target_full_list <- c('all',
                          '1', '2', '3', '4', '5', '7',
                          '9+')
pts_headings <- data.frame(pts_target = pts_target_full_list,
                           heading = NA)
pts_headings[1, 'heading'] <- 'All violations combined'
pts_headings[2, 'heading'] <- 'One-point violations (for speeding 11-20 over)'
pts_headings[3, 'heading'] <- 'Two-point violations (speeding 21-30 over or 7 other violations)'
pts_headings[4, 'heading'] <- 'Three-point violations (speeding 31-60 over or 9 other violations)'
pts_headings[5, 'heading'] <- 'Four-point violations (speeding 31-45 over or 9 other violations)'
pts_headings[6, 'heading'] <- 'Five-point violations (speeding 46-60 over or a handheld device violation)'
pts_headings[7, 'heading'] <- 'Seven-point violations (speeding 61-80 over or combinations)'
pts_headings[8, 'heading'] <- 'All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)'





# Cycle through sex and models within the loop.
# reg_list_all <- c('Logit', 'LPM')
# sex_list_all <- rep('All', 2)
#
# reg_list_MF <- c(rep('Logit', 2), rep('LPM', 2))
# sex_list_MF <- c('All', 'Male', 'Female')


# Cycle through regression models within the loop.
reg_list <- c('Logit', 'LPM')


#------------------------------------------------------------
# Run estimation in a loop on the model specifications.
#------------------------------------------------------------



# Create the path and file name for the markdown file.
tab_version <- 1
tab_path <- sprintf('%s/SAAQ_App_Tabs_%d.tex', tab_dir, tab_version)



# Initialize tex file for tables.
divider <- paste(rep('%', 50), collapse = '')
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = FALSE)
cat(sprintf('%% Appendix: Full Tables of Estimates\n\n'),
    file = tab_path, append = TRUE)
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = TRUE)
cat('\\documentclass[10pt]{article}\n\n',
    file = tab_path, append = TRUE)
cat('\\setlength{\\tabcolsep}{4pt}\n\n',
    file = tab_path, append = TRUE)
cat('\\usepackage[margin=0.5in]{geometry}\n\n',
    file = tab_path, append = TRUE)
cat('\\begin{document}\n\n',
    file = tab_path, append = TRUE)
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = TRUE)

# Insert a title page.
cat('\\input{SAAQ_App_Intro}\n\n',
    file = tab_path, append = TRUE)
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = TRUE)


# Loop through model specifications.
# estn_num <- 1
for (estn_num in 1:nrow(model_list)) {

  # Extract parameters for this estimated model.
  past_pts_sel <- model_list[estn_num, 'past_pts']
  window_sel <- model_list[estn_num, 'window']
  season_incl <- model_list[estn_num, 'seasonality']
  pts_target <- model_list[estn_num, 'pts_target']
  age_int <- model_list[estn_num, 'age_int']
  sex_sel <- model_list[estn_num, 'sex']


  # Print section heading for each set.
  if (new_tab[estn_num] == TRUE) {
    cat(sprintf('\\section{%s}\n\n', tab_sec_head_list[estn_num]),
        file = tab_path, append = TRUE)
    cat(sprintf('\n\n%s\n\n', divider),
        file = tab_path, append = TRUE)
  }

  # Print subsection heading, for regressions by point level.
  if (pts_target != 'all' & sex_sel %in% c('All', 'Male')) {
    if (pts_target == '1') {
      cat(sprintf('\\subsection{Tickets for %s point}\n\n', pts_target),
          file = tab_path, append = TRUE)
    } else {
      cat(sprintf('\\subsection{Tickets for %s points}\n\n', pts_target),
          file = tab_path, append = TRUE)
    }
    cat(sprintf('\n\n%s\n\n', divider),
        file = tab_path, append = TRUE)
  }


  # Print progress report to screen.
  print(sprintf('Estimating model specification %d.', estn_num))
  print(model_list[estn_num, ])


  for (reg_num in 1:length(reg_list)) {

    reg_type <- reg_list[reg_num]

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

      est_coefs_lm <- summ_model$coef_hccme

      # # Checking for negative LPM predictions.
      # lpm_neg_check(lm(data = saaq_data[sel_obs, ], weights = num,
      #                  formula = chosen_model))

    } else if (reg_type == 'Logit') {

      # Estimate logistic regression model.
      log_model_1 <- glm(data = saaq_data[sel_obs, ], weights = num,
                         formula = fmla,
                         family = 'binomial')
      summ_model <- summary(log_model_1)

      est_coefs_log <- summ_model$coefficients

    } else {
      stop(sprintf("Model type '%s' not recognized.", reg_type))
    }





    #--------------------------------------------------
    # Print TeX file for regression table.
    #--------------------------------------------------

    if (reg_num == length(reg_list)) {


      #--------------------------------------------------
      # Collect the estimation results into a table.
      #--------------------------------------------------

      # Bind tables from logistic and LPM.
      reg_table_est <- data.frame(est_coefs_lm[, c('Estimate', 'Std. Error', 't value')],
                                  est_coefs_log[, c('Estimate', 'Std. Error', 'z value')])
      # Change column names.
      colnames(reg_table_est) <- c('Est-LPM', 'SE-LPM', 't-LPM',
                                   'Est-Log', 'SE-Log', 'z-Log')
      # Multiply LPM estimates by 100,000.
      reg_table_est[, c('Est-LPM', 'SE-LPM')] <- 100000*
        reg_table_est[, c('Est-LPM', 'SE-LPM')]

      # Replace labels of intercept.
      row_sel <- rownames(reg_table_est) == '(Intercept)'
      rownames(reg_table_est)[row_sel] <- 'intercept'

      # Replace labels of policy indicator variable.
      row_sel <- rownames(reg_table_est) == 'policyTRUE'
      rownames(reg_table_est)[row_sel] <- 'policy'

      # Replace labels of policy interaction variables.
      row_sel <- substr(rownames(reg_table_est), 1, 18) == 'policyTRUE:age_grp'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- sprintf('policy-age-%s',
                                                  substr(var_name_sel,
                                                         19, nchar(var_name_sel)))
      # Modify variable names for weekday categories.
      row_sel <- substr(rownames(reg_table_est), 1, 7) == 'weekday'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- substr(var_name_sel,
                                                 8, nchar(var_name_sel))

      # Modify variable names for age groups.
      row_sel <- substr(rownames(reg_table_est), 1, 7) == 'age_grp'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- sprintf('age-%s',
                                                  substr(var_name_sel,
                                                         8, nchar(var_name_sel)))

      # Modify variable names for current points groups.
      row_sel <- substr(rownames(reg_table_est), 1, 12) == 'curr_pts_grp'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- sprintf('points-%s',
                                                  substr(var_name_sel,
                                                         13, nchar(var_name_sel)))

      # Modify variable names for months.
      row_sel <- substr(rownames(reg_table_est), 1, 5) == 'month'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- sprintf('month-%s',
                                                  substr(var_name_sel,
                                                         6, nchar(var_name_sel)))

      # Replace labels of policy interaction variables.
      row_sel <- substr(rownames(reg_table_est), 1, 18) == 'policy_monthpolicy'
      var_name_sel <- rownames(reg_table_est)[row_sel]
      rownames(reg_table_est)[row_sel] <- sprintf('policy-month-%s',
                                                  substr(var_name_sel,
                                                         19, nchar(var_name_sel)))


      # Convert the table to a LaTex table.
      out_xtable <- xtable(reg_table_est[, ],
                           digits = 4,
                           align = 'lrrrrrr',
                           label = tab_label_list[estn_num],
                           caption = tab_caption_list[estn_num])

      # Output to TeX file.
      cat(print(out_xtable), file = tab_path, append = TRUE)

      # Previous version used texreg.
      # texreg(reg_model_list,
      #        digits = 4,
      #        file = tab_path,
      #        label = tab_label_list[estn_num],
      #        caption = tab_caption_list[estn_num])


      cat(sprintf('\n\n%s\n%s\n\n', '\\clearpage', '\\pagebreak'),
          file = tab_path, append = TRUE)
      cat(sprintf('\n\n%s\n\n', divider),
          file = tab_path, append = TRUE)

    }








  }






}


# Insert section comparing Probit and Logit.
tab_version <- 1
probit_tab_file <- sprintf('SAAQ_App_Probit_Tabs_%d.tex', tab_version)

cat('\\input{SAAQ_Probit_Desc}\n\n',
    file = tab_path, append = TRUE)
cat(sprintf('\\input{%s}\n\n', probit_tab_file),
    file = tab_path, append = TRUE)
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = TRUE)


# Closing arguments.
cat('\n\n\\end{document}\n\n',
    file = tab_path, append = TRUE)
cat(sprintf('\n\n%s\n\n', divider),
    file = tab_path, append = TRUE)



################################################################################
# End
################################################################################

