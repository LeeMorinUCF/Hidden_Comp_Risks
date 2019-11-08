################################################################################
# 
# Investigation of SAAQ Traffic Ticket Violations
# 
# Construction of a series of numbers of tickets awarded by the 
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
# November 7, 2019
# 
################################################################################
# 
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Perform logistic regressions for sets of offenses. 
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
ptsVersion <- 1



################################################################################
# Load Annual Driver Counts
################################################################################


in_file_name <- sprintf('saaq_agg_%d.csv', ptsVersion)
in_path_file_name <- sprintf('%s%s', dataInPath, in_file_name)
# Yes, keep it in dataInPath since it is yet to be joined. 
saaq_agg <- read.csv(file = in_path_file_name)



################################################################################
# Analyse Groups of Related Offences
################################################################################


# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!

# Generae an indicator for the policy change. 
saaq_agg[, 'policy'] <- saaq_agg[, 'dinf'] > april_fools_2008


# Generate a count of the number of events. 
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 1
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 2
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 3
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 4
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 5
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 6


# Compare the distributions of variables 
# for classes of the dependent variable. 
# summary(saaq_agg[saaq_agg[, 'events'] == 0, ])
# summary(saaq_agg[saaq_agg[, 'events'] == 1, ])



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# One point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 1

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Two point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 2

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Three point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 3

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Four point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 4

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Five point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 5

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


table(saaq_agg[, 'points'] == 10, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] == 5, 
      saaq_agg[, 'policy'], useNA = 'ifany')


# Five and ten point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(5, 10)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)

##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_agg[, 'points'] == 6, 
      saaq_agg[, 'policy'], useNA = 'ifany')

# Six point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 6

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)

# Combined event with 3 or 6 points. 

table(saaq_agg[, 'points'] %in% c(3, 6), 
      saaq_agg[, 'policy'], useNA = 'ifany')


# Six and three point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(3, 6)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_agg[, 'points'] == 7, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] == 14, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] %in% c(7, 14), 
      saaq_agg[, 'policy'], useNA = 'ifany')

# Seven and fourteen point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(7, 14)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_agg[, 'points'] == 9, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] == 18, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] %in% c(9, 18), 
      saaq_agg[, 'policy'], useNA = 'ifany')

# Nine and eighteen point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(9, 18)

# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)




##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################


table(saaq_agg[, 'points'] == 12, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] == 24, 
      saaq_agg[, 'policy'], useNA = 'ifany')
table(saaq_agg[, 'points'] %in% c(12, 24), 
      saaq_agg[, 'policy'], useNA = 'ifany')


# Twelve and twenty-four point violations. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(12, 24)

# Select observations
# sel_obs <- TRUE
sel_obs <- saaq_agg[, 'age_grp'] %in% age_group_list[2:7]
# sel_obs <- saaq_agg[, 'sex'] == 'F'

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp,
                     # formula = events ~ policy + sex + policy*sex,
                     # formula = events ~ policy + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c( 15, 18,
                                                     30, 36)

# Select observations
# sel_obs <- TRUE
sel_obs <- saaq_agg[, 'age_grp'] %in% age_group_list[2:7]

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c( 12, 15, 18,
                                                     24, 30, 36)

# Select observations
# sel_obs <- TRUE
sel_obs <- saaq_agg[, 'age_grp'] %in% age_group_list[2:7]

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)



##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c( 9, 12, 15, 18,
                                                     18, 24, 30, 36)



# Select observations
sel_obs <- TRUE

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)




##################################################
# Estimating a Logistic Regression Model
# Model 1: Logistic model for traffic violations
##################################################

# Generate a count of the number of events. 
saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 1
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 2
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 3
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 4
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 5
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 6
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] == 7
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(3, 6)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(5, 10)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(7, 14)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(9, 18)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(12, 24)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(15, 30)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(18, 36)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(7 ,  9, 12, 15, 18,
#                                                     14, 18, 24, 30, 36)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c( 9, 12, 15, 18,
#                                                      18, 24, 30, 36)
# saaq_agg[, 'events'] <- saaq_agg[, 'points'] %in% c(12, 15, 18,
#                                                     24, 30, 36)
# Fine if restricted to age groups but former 9s now confounded
# with 18s. 
# Create dependent variable 

# Age group selection for high point violations.
sel_obs <- TRUE
# sel_obs <- saaq_agg[, 'age_grp'] %in% age_group_list[1:7]

# Estimate a logistic regression model.
logit_model_1 <- glm(data = saaq_agg[sel_obs, ], 
                     formula = events ~ policy + sex + policy*sex + age_grp, 
                     # + policy*age_grp
                     weights = num, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


# Calculate the predictions of this model.
# saaq_agg[, 'pred_1'] <- predict(logit_model_1, type = 'response')

# summary(saaq_agg[, 'pred_1'])


##################################################
# Compare quality of prediction with AUROC
# The Area Under the ROC Curve
##################################################

# Calculate the AUROC for the logistic model.
# roc(response = saaq_agg[, 'events'], 
#     predictor = saaq_agg[, 'pred_1'])




################################################################################
# End
################################################################################

