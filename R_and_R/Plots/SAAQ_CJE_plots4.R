################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Plots the time series of numbers of tickets awarded by the
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
# February 6, 2020
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

# Load lubridate library for handling dates.
# library(lubridate)

# Load data table package for quick selection on seq
# (and functions for dates).
library(data.table)

################################################################################
# Set parameters for file IO
################################################################################

# Set working directory.
# setwd('/home/ec2-user/saaq')
setwd('C:/Users/le279259/Documents/Research/SAAQ/')

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


# Check data.
colnames(saaq_agg)


summary(saaq_agg)


table(saaq_agg[, 'points'], useNA = 'ifany')


head(saaq_agg, 50)
tail(saaq_agg, 50)

sapply(saaq_agg, class)

# Change dinf into date format.
saaq_agg[, 'dinf'] <- as.Date(saaq_agg[, 'dinf'])


################################################################################
# Analyse Groups of Related Offences
################################################################################


# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!

# Generae an indicator for the policy change.
saaq_agg[, 'policy'] <- saaq_agg[, 'dinf'] > april_fools_2008


# Generate indicators for months.
saaq_agg[, 'month_num'] <- month(saaq_agg[, 'dinf'])
table(saaq_agg[, 'month_num'], useNA = 'ifany')



##################################################
# Sample Selection
##################################################

# Select symmetric window around the policy change.
saaq_agg[, 'window'] <- saaq_agg[, 'dinf'] >= '2006-04-01' &
  saaq_agg[, 'dinf'] <= '2010-03-31'
# Entire sample.
# saaq_agg[, 'window'] <- TRUE

summary(saaq_agg[saaq_agg[, 'window'], 'dinf'])


# Consider entire population.
# saaq_agg[, 'sel_obsn'] <- saaq_agg[, 'window']

# Run separate models by sex.
saaq_agg[, 'sel_obsn'] <- saaq_agg[, 'sex'] == 'M' &
  saaq_agg[, 'window']
# Because there are more than enough male dummies to model separately.
# saaq_agg[, 'sel_obsn'] <- saaq_agg[, 'sex'] == 'F' &
#   saaq_agg[, 'window']


summary(saaq_agg[saaq_agg[, 'sel_obsn'], 'dinf'])

table(saaq_agg[saaq_agg[, 'sel_obsn'], 'sex'])


##################################################
# Agregate data for various plots.
##################################################


#--------------------------------------------------------------------------------
# Agregate data by month.
#--------------------------------------------------------------------------------

agg_var_list <- c('month', 'sex', 'age_grp', 'points')

# Need to create date variable by month.
saaq_agg[, 'month'] <- sprintf('%d-%02d',
                               year(saaq_agg[, 'dinf']),
                               month(saaq_agg[, 'dinf']))

table(saaq_agg[, 'month'])



saaq_monthly <- aggregate(num ~ month + sex + age_grp + points,
                          data = saaq_agg[saaq_agg[, 'window'], c(agg_var_list, 'num')],
                          FUN = sum)

saaq_monthly <- saaq_monthly[order(saaq_monthly$month,
                                   saaq_monthly$sex, saaq_monthly$age_grp,
                                   saaq_monthly$points), ]


colnames(saaq_monthly)
sapply(saaq_monthly, class)


summary(saaq_monthly)

table(saaq_monthly[, 'points'], useNA = 'ifany')


head(saaq_monthly, 50)
tail(saaq_monthly, 50)


#--------------------------------------------------------------------------------
# Agregate data by month.
# Aggregate across sex and age groups too.
#--------------------------------------------------------------------------------

saaq_monthly_all <- aggregate(num ~ month + points,
                              data = saaq_monthly[, c('month', 'points', 'num')],
                              FUN = sum)

saaq_monthly_all <- saaq_monthly_all[order(saaq_monthly_all$month,
                                           saaq_monthly_all$points), ]


#--------------------------------------------------------------------------------
# Agregate data by month.
# Aggregate across age groups for each sex.
#--------------------------------------------------------------------------------

# Male dummies:
saaq_monthly_M <- aggregate(num ~ month + points,
                            data = saaq_monthly[saaq_monthly[, 'sex'] == 'M',
                                                c('month', 'points', 'num')],
                            FUN = sum)

saaq_monthly_M <- saaq_monthly_M[order(saaq_monthly_M$month,
                                       saaq_monthly_M$points), ]


# Females:
saaq_monthly_F <- aggregate(num ~ month + points,
                            data = saaq_monthly[saaq_monthly[, 'sex'] == 'F',
                                                c('month', 'points', 'num')],
                            FUN = sum)

saaq_monthly_F <- saaq_monthly_F[order(saaq_monthly_F$month,
                                       saaq_monthly_F$points), ]





# Form a data table with columns for point balances.
table(saaq_monthly_all[, 'points'], useNA = 'ifany')
table(saaq_monthly_M[, 'points'], useNA = 'ifany')
table(saaq_monthly_F[, 'points'], useNA = 'ifany')

month_list <- unique(saaq_monthly_all[, 'month'])
month_list <- month_list[order(month_list)]
point_list <- unique(saaq_monthly_all[, 'points'])
point_list <- point_list[order(point_list)]
col_names <- sprintf('pts_%d', point_list)

saaq_monthly_all_tab <- data.frame(month = month_list)
saaq_monthly_M_tab <- data.frame(month = month_list)
saaq_monthly_F_tab <- data.frame(month = month_list)


saaq_monthly_all_tab[, col_names] <- 0
saaq_monthly_M_tab[, col_names] <- 0
saaq_monthly_F_tab[, col_names] <- 0

for (month in month_list) {
  for (points in point_list) {

    col_name <- sprintf('pts_%d', points)

    # Both sexes.
    num <- saaq_monthly_all[saaq_monthly_all[, 'month'] == month &
                              saaq_monthly_all[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_monthly_all_tab[saaq_monthly_all_tab[, 'month'] == month,
                           col_name] <- num
    }

    # Males only:
    num <- saaq_monthly_M[saaq_monthly_M[, 'month'] == month &
                              saaq_monthly_M[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_monthly_M_tab[saaq_monthly_M_tab[, 'month'] == month,
                           col_name] <- num
    }


    # Females:
    num <- saaq_monthly_F[saaq_monthly_F[, 'month'] == month &
                            saaq_monthly_F[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_monthly_F_tab[saaq_monthly_F_tab[, 'month'] == month,
                         col_name] <- num
    }




  }
}




# Add totals by calendar month.
saaq_monthly_all[, 'month_num'] <- as.numeric(substr(saaq_monthly_all[, 'month'], 6,7))
table(saaq_monthly_all[, 'month_num'], useNA = 'ifany')
saaq_monthly_all_tab[, 'month_num'] <- as.numeric(substr(saaq_monthly_all_tab[, 'month'], 6,7))
table(saaq_monthly_all_tab[, 'month_num'], useNA = 'ifany')


saaq_monthly_all_tab[, 'month_avg_num'] <- NA
saaq_monthly_all_tab[, 'month_avg_5_10'] <- NA
saaq_monthly_all_tab[, 'month_avg_7_14'] <- NA
for (month_num in 1:12) {

  #--------------------------------------------------
  # All violations
  #--------------------------------------------------

  # Calculate monthly seasonal totals from 4 years.
  num <- sum(saaq_monthly_all[
    saaq_monthly_all[, 'month_num'] == month_num &
      saaq_monthly_all[, 'points'] > 0, 'num'])/4

  saaq_monthly_all_tab[
    saaq_monthly_all_tab[, 'month_num'] == month_num, 'month_avg_num'] <- num


  #--------------------------------------------------
  # 5- and 10-point violations
  #--------------------------------------------------

  # Calculate monthly seasonal totals from 4 years.
  num <- sum(saaq_monthly_all[
    saaq_monthly_all[, 'month_num'] == month_num &
      saaq_monthly_all[, 'points'] %in% c(5, 10), 'num'])/4

  saaq_monthly_all_tab[
    saaq_monthly_all_tab[, 'month_num'] == month_num, 'month_avg_5_10'] <- num


  #--------------------------------------------------
  # 7- and 14-point violations
  #--------------------------------------------------

  # Calculate monthly seasonal totals from 4 years.
  num <- sum(saaq_monthly_all[
    saaq_monthly_all[, 'month_num'] == month_num &
      saaq_monthly_all[, 'points'] %in% c(7, 14), 'num'])/4

  saaq_monthly_all_tab[
    saaq_monthly_all_tab[, 'month_num'] == month_num, 'month_avg_7_14'] <- num

}

head(saaq_monthly_all_tab[, c('month', 'month_avg_num')])
head(saaq_monthly_all_tab)



# Note that units are in driver months.
head(saaq_monthly_all_tab)
tail(saaq_monthly_all_tab)


##################################################
# PLots of numbers of offences over time.
##################################################

#--------------------------------------------------
# Selected pairs of offences by sex
#--------------------------------------------------

new_year_dates <- substr(saaq_monthly_all_tab[, 'month'], 6, 7) == '01'
new_year_dates <- (1:nrow(saaq_monthly_all_tab))[new_year_dates]
new_year_labels <- substr(saaq_monthly_all_tab[new_year_dates, 'month'], 1, 4)
# Correct for off-by one in graph.
new_year_dates <- new_year_dates - 1




# Bar plot version.
# pts_plot <- c(3, 6) # Overwhelmed by other 3-point violations.
# pts_plot <- c(5, 10)
pts_plot <- c(7, 14)
# pts_plot <- c(9, 18)
# pts_plot <- c(12, 24)
# pts_plot <- c(15, 30) # Thin sample for these violations.
# pts_plot <- c(18, 36) # Thin sample contaminated by more frequent 9 -> 18 point violations.


# Select a particular sex or both.
sel_tab <- 'all'
# sel_tab <- 'M'
# sel_tab <- 'F'

# Set file location for this draft.
# file_ext <- 'eps'
file_ext <- 'png'
# file_ext <- 'pdf'
# file_ext <- 'screen'
# fig_path <- '~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/draft_1'
fig_path <- '~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R'
fig_file_name <- sprintf('%s/num_pts_%d_%d_%s.%s',
                         fig_path, pts_plot[1], pts_plot[2], sel_tab, file_ext)
if (file_ext == 'png') {
  png(file = fig_file_name)
} else if (file_ext == 'pdf') {
  pdf(file = fig_file_name)
} else if (file_ext == 'eps') {
  setEPS()
  postscript(fig_file_name)
}

# Plot as a stacked bar plot.


# Select data.
if (sel_tab == 'all') {
  subtitle <- '(Both Sexes)'
  counts <- cbind(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])],
                  saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[2])])
} else if (sel_tab == 'M') {
  subtitle <- '(Males Only)'
  # Male dummies:
  counts <- cbind(saaq_monthly_M_tab[, sprintf('pts_%d', pts_plot[1])],
                  saaq_monthly_M_tab[, sprintf('pts_%d', pts_plot[2])])
} else if (sel_tab == 'F') {
  subtitle <- '(Females Only)'
  # Females:
  counts <- cbind(saaq_monthly_F_tab[, sprintf('pts_%d', pts_plot[1])],
                  saaq_monthly_F_tab[, sprintf('pts_%d', pts_plot[2])])
}




barplot(t(counts),
        main = c(sprintf('Monthly Total Number of %d- and %d-point Tickets', pts_plot[1], pts_plot[2]),
                 subtitle),
        xlab = 'Month',
        ylab = '# Tickets',
        ylim = c(0, max(counts)),
        pch = 16,
        xaxt='n',
        space = rep(0, length(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])])),
        col = c('blue', 'red'))
abline(v = (1:nrow(saaq_monthly_all_tab))[saaq_monthly_all_tab[, 'month'] == '2008-04'] - 1,
       lwd = 3)
axis(1, at = new_year_dates,
     labels = new_year_labels)
if (file_ext %in% c('png', 'pdf')) {
  dev.off()
}


#--------------------------------------------------
# Production-quality figures for manuscript.
#--------------------------------------------------

# Select set of point values.
# pts_plot <- c(5, 10)
pts_plot <- c(7, 14)

# Select a particular sex or both.
sel_tab <- 'all'
# sel_tab <- 'M'
# sel_tab <- 'F'

# Set file location for this draft.
file_ext <- 'eps'
fig_path <- 'SAAQspeeding/Hidden_Comp_Risks/R_and_R/Figures'
fig_file_name <- sprintf('%s/num_pts_%d_%d_%s.%s',
                         fig_path, pts_plot[1], pts_plot[2], sel_tab, file_ext)




# Select data.
# subtitle <- '(Both Sexes)'
counts <- cbind(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])],
                saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[2])])



# Normalize counts by (monthly) seasonal averages.
counts_avg <- saaq_monthly_all_tab[, sprintf('month_avg_%d_%d', pts_plot[1], pts_plot[2])]
counts_exs <- counts/counts_avg


setEPS()
postscript(fig_file_name)

# Plot as a stacked bar plot.

barplot(t(counts_exs),
        # t(counts),
        main = '',
        xlab = 'Month',
        ylab = 'Number of Tickets versus Monthly Average',
        # ylim = c(0, max(counts)),
        ylim = c(0, 2),
        pch = 16,
        xaxt='n',
        space = rep(0, length(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])])),
        col = grey.colors(n = 2, start = 0.3, end = 0.9))
abline(v = (1:nrow(saaq_monthly_all_tab))[saaq_monthly_all_tab[, 'month'] == '2008-04'] - 1,
       lwd = 3)
axis(1, at = new_year_dates,
     labels = new_year_labels)
abline(h = 1.0, lwd = 2, lty = 'dashed')


dev.off()



##################################################
# Event-Study Figure
##################################################

# Read in the estimates.

# Set directory for results in GitHub repo.
# git_path <- "~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R"
git_path <- "C:/Users/le279259/Documents/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R"
md_dir <- sprintf("%s/results", git_path)


# Sensitivity Analysis: REAL event study with seasonality
estn_version <- 6
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_6 <- read.csv(file = estn_file_path)
summary(estn_results_6)

# Select the relevant estimates.
mfx_males <- estn_results_6[estn_results_6[, 'sex'] == 'Male' &
                              estn_results_6[, 'reg_type'] == 'LPM' &
                              estn_results_6[, 'age_int'] == 'no', ]
mfx_females <- estn_results_6[estn_results_6[, 'sex'] == 'Female' &
                              estn_results_6[, 'reg_type'] == 'LPM' &
                              estn_results_6[, 'age_int'] == 'no', ]

head(mfx_males, 14)
head(mfx_females, 14)

# Create the time series of policy effects.
perm_males <- mfx_males[mfx_males[, 'Variable'] == 'policyTRUE', 'Estimate']
first_yr_males <- mfx_males[
  substr(mfx_males[, 'Variable'], 1, 18) == 'policy_monthpolicy', 'Estimate']
first_yr_males <- c(first_yr_males, rep(0, 12)) + perm_males

# Repeat for standard errors.
perm_males_SE <- mfx_males[mfx_males[, 'Variable'] == 'policyTRUE', 'Std_Error']
first_yr_males_SE <- mfx_males[
  substr(mfx_males[, 'Variable'], 1, 18) == 'policy_monthpolicy', 'Std_Error']
first_yr_males_SE <- c(first_yr_males_SE, rep(0, 12)) + perm_males_SE



perm_females <- mfx_females[mfx_females[, 'Variable'] == 'policyTRUE', 'Estimate']
first_yr_females <- mfx_females[
  substr(mfx_females[, 'Variable'], 1, 18) == 'policy_monthpolicy', 'Estimate']
first_yr_females <- c(first_yr_females, rep(0, 12)) + perm_females

# Repeat for standard errors.
perm_females_SE <- mfx_females[mfx_females[, 'Variable'] == 'policyTRUE', 'Std_Error']
first_yr_females_SE <- mfx_females[
  substr(mfx_females[, 'Variable'], 1, 18) == 'policy_monthpolicy', 'Std_Error']
first_yr_females_SE <- c(first_yr_females_SE, rep(0, 12)) + perm_females_SE




# Plot the figures.


# Set file location for this draft.
file_ext <- 'eps'
fig_path <- 'SAAQspeeding/Hidden_Comp_Risks/R_and_R/Figures'
fig_file_name <- sprintf('%s/Event_Study.%s',
                         fig_path, file_ext)

# Set colors.
color_list <- grey.colors(n = 2, start = 0.3, end = 0.6)

setEPS()
postscript(fig_file_name)


# Set axes.
plot(NA,
     xlim = c(1, 24),
     ylim = c(-20, 10),
     xlab = "Months Since Policy Change",
     ylab = "Policy Effect x 100,000",
     # main = c("Salary Comparison for Business Analytics Students*"),
     # cex.main = 1.60, cex.lab = 1.5, cex.axis = 1.5
     xaxt = "n"
     )
axis(side = 1, at = seq(3, 24, by = 3)) #, labels = FALSE)
abline(h = 0, lwd = 1, col = 'black', lty = 'solid')



# Plot curves for males.
# lines(seq(13, 24), rep(perm_males*100000, 12), lwd = 3, col = color_list[1], lty = 'solid')
lines(seq(24), first_yr_males*100000, lwd = 3, col = color_list[1], lty = 'solid')
# Plot SE bands for males.
lines(seq(24), (first_yr_males + 1.96*first_yr_males_SE)*100000,
      lwd = 3, col = color_list[1], lty = 'dashed')
lines(seq(24), (first_yr_males - 1.96*first_yr_males_SE)*100000,
      lwd = 3, col = color_list[1], lty = 'dashed')



# Plot curves for females.
# lines(seq(13, 24), rep(perm_females*100000, 12), lwd = 3, col = color_list[2], lty = 'dashed')
lines(seq(24), first_yr_females*100000, lwd = 3, col = color_list[2], lty = 'solid')
# Plot SE bands for females.
lines(seq(24), (first_yr_females + 1.96*first_yr_females_SE)*100000,
      lwd = 3, col = color_list[2], lty = 'dashed')
lines(seq(24), (first_yr_females - 1.96*first_yr_females_SE)*100000,
      lwd = 3, col = color_list[2], lty = 'dashed')


dev.off()



##################################################
# End
##################################################

