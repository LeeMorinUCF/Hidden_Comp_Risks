################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Totals of number of observations for each combination of categories
# of the explanatory variables.
#
#
#
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# August 5, 2020
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



##################################################
# Define an event
##################################################

# All violations combined: 2-year window.
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0



##################################################
# Count the number of observations in each category
##################################################

# Use data.table to speed things up.
library(data.table)


saaq_data <- data.table(saaq_data)

colnames(saaq_data)


# Tabulate counts of every single combination of categorical variables.
# Count only the denominators, that is, the non-events.


# Before the policy change.
saaq_data[window == TRUE & events == FALSE & policy == FALSE, sum(num),
          by = c('sex', 'age_grp', 'curr_pts_grp', 'policy')]

# After the policy change.
saaq_data[window == TRUE & events == FALSE & policy == TRUE, sum(num),
          by = c('sex', 'age_grp', 'curr_pts_grp', 'policy')]


# Zoom in on licensed age:


# Before the policy change.
saaq_data[window == TRUE & events == FALSE & policy == FALSE &
            !(age_grp %in% c('0-15', '65-199')), sum(num),
          by = c('sex', 'age_grp', 'curr_pts_grp', 'policy')]

# After the policy change.
saaq_data[window == TRUE & events == FALSE & policy == TRUE &
            !(age_grp %in% c('0-15', '65-199')), sum(num),
          by = c('sex', 'age_grp', 'curr_pts_grp', 'policy')]




##################################################
# End
##################################################

