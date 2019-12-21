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
# December 21, 2019
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
saaq_data[, 'window'] <- saaq_data[, 'dinf'] >= '2006-01-01' & 
  saaq_data[, 'dinf'] <= '2010-03-31'

summary(saaq_data[saaq_data[, 'window'], 'dinf'])

# Run separate models by sex. 
saaq_data[, 'sel_obsn'] <- saaq_data[, 'sex'] == 'M' & 
  saaq_data[, 'window']
# Because there would be too many male dummies to model separately. 


summary(saaq_data[saaq_data[, 'sel_obsn'], 'dinf'])

table(saaq_data[saaq_data[, 'sel_obsn'], 'sex'])


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# All violations combined. 
saaq_data[, 'events'] <- saaq_data[, 'points'] > 0

# Select observations
sel_obs <- saaq_data[, 'sel_obsn']

summary(saaq_data[sel_obs, ])

# Estimate a logistic regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + policy*age_grp +
                   curr_pts_grp + policy*curr_pts_grp)

# Refined model for this population and event definition.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                 weights = num,
                 formula = events ~ age_grp + 
                   policy + 
                   curr_pts_grp)

# summary(lm_model_1)

# Recalculate the RSS for sampling weights, not (inverse) GLS weights.
lm_model_1_fixed <- lm_model_1
lm_model_1_fixed$df.residual <- with(lm_model_1_fixed, sum(weights) - length(coefficients))

# Output the results to screen.
summary(lm_model_1_fixed)




##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# One point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 1

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- lm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Two point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 2

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Three point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 3

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Four point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 4

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Five point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 5

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


table(saaq_data[, 'points'] == 10, 
      saaq_data[, 'policy'], useNA = 'ifany')
table(saaq_data[, 'points'] == 5, 
      saaq_data[, 'policy'], useNA = 'ifany')


# Five and ten point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(5, 10)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_data[, 'points'] == 6, 
      saaq_data[, 'policy'], useNA = 'ifany')

# Six point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 6

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)

# Combined event with 3 or 6 points. 

table(saaq_data[, 'points'] %in% c(3, 6), 
      saaq_data[, 'policy'], useNA = 'ifany')


# Six and three point violations. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(3, 6)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)



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

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)



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
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)




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
# sel_obs <- TRUE
sel_obs <- saaq_data[, 'age_grp'] %in% age_group_list[2:7]
# sel_obs <- saaq_data[, 'sex'] == 'F'

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 15, 18,
                                                     30, 36)

# Select observations
# sel_obs <- TRUE
sel_obs <- saaq_data[, 'age_grp'] %in% age_group_list[2:7]

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 12, 15, 18,
                                                     24, 30, 36)

# Select observations
# sel_obs <- TRUE
sel_obs <- saaq_data[, 'age_grp'] %in% age_group_list[2:7]

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 9, 12, 15, 18,
                                                     18, 24, 30, 36)



# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)













##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_data[, 'events'] <- saaq_data[, 'points'] == 1
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 2
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 3
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 4
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 5
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 6
# saaq_data[, 'events'] <- saaq_data[, 'points'] == 7
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(3, 6)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(5, 10)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(7, 14)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(9, 18)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(12, 24)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(15, 30)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(18, 36)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(7 ,  9, 12, 15, 18,
#                                                     14, 18, 24, 30, 36)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c( 9, 12, 15, 18,
#                                                      18, 24, 30, 36)
# saaq_data[, 'events'] <- saaq_data[, 'points'] %in% c(12, 15, 18,
#                                                     24, 30, 36)
# Fine if restricted to age groups but former 9s now confounded
# with 18s. 
# Create dependent variable 

# Age group selection for high point violations.
sel_obs <- TRUE
# sel_obs <- saaq_data[, 'age_grp'] %in% age_group_list[1:7]

# Estimate a logistic regression model.
lm_model_1 <- glm(data = saaq_data[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp)

# Output the results to screen.
summary(lm_model_1)


# Calculate the predictions of this model.
# saaq_data[, 'pred_1'] <- predict(logit_model_1, type = 'response')

# summary(saaq_data[, 'pred_1'])





################################################################################
# End
################################################################################

