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





# Compare the distributions of variables 
# for classes of the dependent variable. 
summary(female_employment[female_employment[, 'D'] == 0, ])
summary(female_employment[female_employment[, 'D'] == 1, ])



##################################################
# Estimating a Logistic Regression Model
# Model 2: Logistic model for female employment
##################################################

# Estimate a logistic regression model.
logit_model_1 <- glm(data = female_employment, 
                     formula = D ~ M + S, 
                     family = 'binomial')

# Output the results to screen.
summary(logit_model_1)


# Calculate the predictions of this model.
female_employment[, 'D_hat_logit'] <- predict(logit_model_1, type = 'response')

summary(female_employment[, 'D_hat_logit'])


##################################################
# Compare quality of prediction with AUROC
# The Area Under the ROC Curve
##################################################

# Calculate the AUROC for the logistic model.
roc(response = female_employment[, 'D'], 
    predictor = female_employment[, 'D_hat_logit'])




################################################################################
# End
################################################################################

