##################################################
#
# QMB 6911: Capstone in Business Analytics
#
# OLS Regression Demo
# Regression with Data from Spreadsheet
#
# Lealand Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 17, 2020
#
##################################################
#
# House_Price_Reg gives an example of OLS regression
#   using data imported from a spreadsheet.
#   It automatically generates figures and tables for a
#   pdf document built with LaTeX.
#
# Dependencies:
#   The xtable library to create tex scripts for tables.
#   The texreg library to create tex scripts for tables from
#   regression models.
#
##################################################


##################################################
# Preparing the Workspace
##################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Set working directory.
# wd_path <- '/path/to/your/folder'
# wd_path <- 'C:/Users/le279259/Documents/Teaching/QMB6911_Summer_2021/LaTeX_Demo/QMB6911S21/LaTeX_from_R'
# setwd(wd_path)
setwd('C:/Users/le279259/Documents/Research/SAAQ/')

# It's not necessary to set the directory, since we are working in the
# main directory already: that's where the shell script is running.


# Set data directory.
data_dir <- 'C:/Users/le279259/Documents/Teaching/QMB6911_Summer_2021/LaTeX_Demo/QMB6911S21/LaTeX_from_R/Data'


# Set directory for storing tables.
tab_dir <- 'SAAQspeeding/Hidden_Comp_Risks/R_and_R/RegTest'


# Load libraries.

# The xtable library creates tex scripts for tables.
# install.packages("xtable")
library(xtable)
# The texreg library creates tex scripts for tables from
# regression models.
# install.packages("texreg")
library(texreg)


##################################################
# Load Data
##################################################

# Read the newly saved dataset.
data_file_path <- sprintf('%s/housing_data.csv', data_dir)
housing_data <- read.csv(file = data_file_path)

# Inspect the data.
summary(housing_data)


##################################################
# Create Tables
##################################################


#--------------------------------------------------
# Summarize categorical variables
#--------------------------------------------------

# Create a table of counts of variables by state and earthquake incidence.
out_tab <- table(housing_data[, 'in_cali'], housing_data[, 'earthquake'])


# Add some column names.
rownames(out_tab) <- c('Other', 'California')
colnames(out_tab) <- c('None', 'Earthquake')



# Convert the table to a LaTex table.
out_xtable <- xtable(out_tab[, ],
                     digits = 2, label = 'tab:earthquakes',
                     caption = 'Earthquake Incidence by State')

# Output to TeX file.
tab_file_name <- sprintf('%s/earthquakes.tex', tab_dir)
cat(print(out_xtable), file = tab_file_name, append = FALSE)



##################################################
# Estimating the Regression Model
# Model 1: All Variables Included
##################################################

# Note the formula object:
# Y ~ X_1 + X_2 + X_3


# Estimate a regression model.
lm_full_model <- lm(data = housing_data,
                    formula = house_price ~ income + in_cali + earthquake)

# Output the results to screen.
summary(lm_full_model)


##################################################
# Output table with regression estimates.
##################################################

# The texreg package makes a LaTeX table from the regression results.

# Print the output to a LaTeX file.
tab_file_name <- 'lm_model_1.tex'
out_file_name <- sprintf('%s/%s', tab_dir, tab_file_name)
texreg(lm_full_model,
       digits = 3,
       file = out_file_name,
       label = 'tab:lm_model_1',
       caption = "Regression Model 1")



##################################################
# Output table with logistic regression estimates.
##################################################

# Create a binary variable.
housing_data[, 'price_gt_500'] <- housing_data[, 'house_price'] > 0.50

# Estimate a logistic regression model.
logit_model <- glm(data = housing_data,
                    formula = price_gt_500 ~ income + in_cali + earthquake,
                   family = 'binomial')

# Output the results to screen.
summary(logit_model)

# Print the output to a LaTeX file.
tab_file_name <- 'logit_model_1.tex'
out_file_name <- sprintf('%s/%s', tab_dir, tab_file_name)
texreg(logit_model,
       digits = 3,
       file = out_file_name,
       label = 'tab:logit_model_1',
       caption = "Logistic Model 1")




##################################################
# Output table with logistic and regression estimates.
##################################################


# Print the output to a LaTeX file.
tab_file_name <- 'logit_lm_1.tex'
out_file_name <- sprintf('%s/%s', tab_dir, tab_file_name)
texreg(list(lm_full_model, logit_model),
       digits = 3,
       file = out_file_name,
       label = 'tab:logit_lm_1',
       caption = "Logistic and Regression Model 1")




##################################################
# End.
##################################################
