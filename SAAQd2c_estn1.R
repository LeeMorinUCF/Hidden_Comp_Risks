################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Datasets hold observations for sets of sequential id codes.
# Aggregate data by age and sex categories and accumulated points balances.
# Analysis of factors affecting time to conviction.
#
#
#
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# June 21, 2020
#
################################################################################
#
#
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Load package for importing datasets in proprietary formats.
# library(foreign)

# Load data table package for quick selection on seq.
library(data.table)


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
# ptsVersion <- 1 # Original version with only the present ticket counts.
# ptsVersion <- 2 # Modified version with both past and present ticket counts.
ptsVersion <- 3 # Modified to analyze days to conviction.

# Set directory for figures.
fig_path <- 'SAAQspeeding/Hidden_Comp_Risks/days2con'

# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!



################################################################################
# Load Data
################################################################################



# Save a subset of data to analyze time to conviction.
in_file_name <- sprintf('saaq_days2con_%d.csv', ptsVersion)
in_path_file_name <- sprintf('%s%s', dataInPath, in_file_name)
# Yes, keep it in dataInPath since it is yet to be joined.
# write.csv(x = saaq[saaq[, 'window'] == TRUE, sel_cols],
#           file = out_path_file_name, row.names = FALSE)
saaq <- read.csv(file = in_path_file_name)




################################################################################
# Inspection
################################################################################


colnames(saaq)
head(saaq)

# Dependent variable is the number of days to conviction.
summary(saaq[, 'days2con'])

# A large fraction are zeros 46144/3949799 = 0.01168262.
sum(saaq[, 'days2con'] == 0)
sum(saaq[, 'days2con'] == 0)/nrow(saaq)

# Many people pay it the first day.
table(saaq[saaq[, 'days2con'] == 0, 'points'])
table(saaq[saaq[, 'days2con'] == 0, 'sex'])
# Males pay tickets the same day 2:1 vs. females.
table(saaq[, 'sex'])
# But thats the ratio in the dataset.

# Compare time to conviction before and after policy change.
summary(saaq[saaq[, 'policy'] == TRUE, 'days2con'])
summary(saaq[saaq[, 'policy'] == FALSE, 'days2con'])
# Not much difference. A little longer *before* the policy.

# Compare by sex.
# Males:
summary(saaq[saaq[, 'policy'] == TRUE &
               saaq[, 'sex'] == 'M', 'days2con'])
summary(saaq[saaq[, 'policy'] == FALSE &
               saaq[, 'sex'] == 'M', 'days2con'])
# Females:
summary(saaq[saaq[, 'policy'] == TRUE &
               saaq[, 'sex'] == 'F', 'days2con'])
summary(saaq[saaq[, 'policy'] == FALSE &
               saaq[, 'sex'] == 'F', 'days2con'])
# Some men like to prolong the agony.

#--------------------------------------------------------------------------------
# Create new factors by consolidating some categories
#--------------------------------------------------------------------------------

# Age groups.
table(saaq[, 'age_grp'], useNA = 'ifany')


age_grp_list <- levels(saaq[, 'age_grp'])
saaq[, 'age_grp_orig'] <- saaq[, 'age_grp']
new_age_grp_list <- c(age_grp_list[seq(7)], '65-199')

saaq[, 'age_grp'] <- as.factor(NA)
levels(saaq[, 'age_grp']) <- new_age_grp_list
age_group_sel <- saaq[, 'age_grp_orig'] %in% age_grp_list[seq(7)]
saaq[age_group_sel, 'age_grp'] <- saaq[age_group_sel, 'age_grp_orig']
saaq[!age_group_sel, 'age_grp'] <- new_age_grp_list[8]


# Trust but verify.
table(saaq[, 'age_grp'],
      saaq[, 'age_grp_orig'], useNA = 'ifany')
# Check.



################################################################################
# Plots
################################################################################

# Initial histogram.
hist(saaq[, 'days2con'],
     main = sprintf('Time to Conviction for Traffic Tickets (%s)', 'All Drivers'),
     xlab = 'Number of Days between Infraction and Conviction',
     xlim = c(0, 200),
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(0, 0, 255, alpha = 125))
for (n_days in seq(7, 63, by = 7)) {
  abline(v = n_days, lwd = 2, lty = 'dashed', col = 'black')
}


#--------------------------------------------------
# Both sexes together.
#--------------------------------------------------


out_file_name <- 'hist_days2con_All_by_sex.png'
out_path_file_name <- sprintf('%s/%s', fig_path, out_file_name)

png(out_path_file_name)

# Plot both sexes together.
hist(saaq[saaq[, 'sex'] == 'F', 'days2con'],
     main = c('Time to Conviction for Traffic Tickets (All Drivers)'),
     xlab = 'Number of Days between Infraction and Conviction',
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(255, 0, 0, max = 255, alpha = 125))
legend("topright", c("Males", "Females"),
       col = c(rgb(0, 0, 255, max = 255, alpha = 125),
               rgb(255, 0, 0, max = 255, alpha = 125)), lwd = 10)
# for (n_days in seq(7, 63, by = 7)) {
#   abline(v = n_days, lwd = 2, lty = 'dashed', col = 'black')
# }
hist(saaq[saaq[, 'sex'] == 'M', 'days2con'],
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(0, 0, 255, max = 255, alpha = 125),
     add = TRUE)
dev.off()



#--------------------------------------------------
# Before and after Policy Change - All drivers.
#--------------------------------------------------


sel_group <- 'All Drivers'

out_file_name <- sprintf('hist_days2con_%s_B4_after.png',
                         substr(sel_group, 1, 1))
out_path_file_name <- sprintf('%s/%s', fig_path, out_file_name)

png(out_path_file_name)

# Plot before and after policy change.
hist(saaq[saaq[, 'policy'] == FALSE, 'days2con'],
     main = sprintf('Time to Conviction for Traffic Tickets (%s)',
                    sel_group),
     xlab = 'Number of Days between Infraction and Conviction',
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(0, 255, 0, max = 255, alpha = 125))
legend("topright", c("Before", "After"),
       col = c(rgb(0, 255, 0, max = 255, alpha = 125),
               rgb(255, 0, 255, max = 255, alpha = 125)), lwd = 10)
# for (n_days in seq(7, 63, by = 7)) {
#   abline(v = n_days, lwd = 2, lty = 'dashed', col = 'black')
# }
hist(saaq[saaq[, 'policy'] == TRUE, 'days2con'],
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(255, 0, 255, max = 255, alpha = 125),
     add = TRUE)
dev.off()



#--------------------------------------------------
# Before and after Policy Change - By sex.
#--------------------------------------------------


sel_group <- 'Males'
sel_group <- 'Females'

out_file_name <- sprintf('hist_days2con_%s_B4_after.png',
                         substr(sel_group, 1, 1))
out_path_file_name <- sprintf('%s/%s', fig_path, out_file_name)

png(out_path_file_name)

# Plot both sexes together.
hist(saaq[saaq[, 'sex'] == substr(sel_group, 1, 1) &
            saaq[, 'policy'] == FALSE, 'days2con'],
     main = sprintf('Time to Conviction for Traffic Tickets (%s)',
                    sel_group),
     xlab = 'Number of Days between Infraction and Conviction',
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(0, 255, 0, max = 255, alpha = 125))
legend("topright", c("Before", "After"),
       col = c(rgb(0, 255, 0, max = 255, alpha = 125),
               rgb(255, 0, 255, max = 255, alpha = 125)), lwd = 10)
# for (n_days in seq(7, 63, by = 7)) {
#   abline(v = n_days, lwd = 2, lty = 'dashed', col = 'black')
# }
hist(saaq[saaq[, 'sex'] == substr(sel_group, 1, 1) &
            saaq[, 'policy'] == TRUE, 'days2con'],
     xlim = c(0, 200),
     probability = TRUE,
     # breaks = 500,
     breaks = max(saaq[, 'days2con'] + 1),
     col = rgb(255, 0, 255, max = 255, alpha = 125),
     add = TRUE)
dev.off()








# How many in each category?

# The mode is zero 46144/3949799 = 0.01168262.
sum(saaq[, 'days2con'] == 0)
sum(saaq[, 'days2con'] == 0)/nrow(saaq)

# A large fraction (45%) settle before the due date.
# 1789467/3949799 = 0.4530527.
sum(saaq[, 'days2con'] < 30)
sum(saaq[, 'days2con'] < 30)/nrow(saaq)


# Some are late but probably didn't challenge in court.
# 2362939/3949799 = 0.5982428,
# (2362939 - 1789467)/3949799 = 0.1451902.
sum(saaq[, 'days2con'] < 42)
sum(saaq[, 'days2con'] < 42)/nrow(saaq)



################################################################################
# Estimation: Linear regression
################################################################################



#--------------------------------------------------
# All drivers
#--------------------------------------------------

# Estimate a linear regression model.
lm_model_1 <- lm(data = saaq,
                 formula = days2con ~ sex + age_grp + policy*sex +
                   policy + # policy*age_grp +
                   points # + policy*points
)

summary(lm_model_1)


# Model the log of (1 + days2con).
saaq[, 'log_days2con'] <- log(1 + saaq[, 'days2con'])

lm_model_1 <- lm(data = saaq,
                 formula = log_days2con ~ sex + age_grp + policy*sex +
                   policy + # policy*age_grp +
                   points + policy*points
)

summary(lm_model_1)


#--------------------------------------------------
# Selected male or female drivers
#--------------------------------------------------




################################################################################
# Estimation: Logistic Regression
################################################################################

# Define event to study.
saaq[, 'event'] <- saaq[, 'days2con'] == 0
saaq[, 'event'] <- saaq[, 'days2con'] > 30
saaq[, 'event'] <- saaq[, 'days2con'] > 42


#--------------------------------------------------
# All drivers
#--------------------------------------------------


# Estimate a logistic regression model.
log_model_1 <- glm(data = saaq,
                  family = 'binomial',
                 formula = event ~ sex + age_grp + policy*sex +
                   policy + # policy*age_grp +
                   points # + policy*points
)

summary(log_model_1)


#--------------------------------------------------
# Selected male or female drivers
#--------------------------------------------------




################################################################################
# Estimation: Exponential Distribution
################################################################################

saaq[, 'event'] <- saaq[, 'days2con'] + 1


#--------------------------------------------------
# All drivers
#--------------------------------------------------


# Estimate a logistic regression model.
gamma_model_1 <- glm(data = saaq,
                   family = Gamma(link = "log"),
                   formula = event ~ sex + age_grp +
                     policy + # policy*age_grp +
                     points # + policy*points
)

summary(gamma_model_1)

# Similar story.


#--------------------------------------------------
# Selected male or female drivers
#--------------------------------------------------



################################################################################
# End
################################################################################
