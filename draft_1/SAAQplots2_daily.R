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
# This version plots daily counts of tickets. 
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
# Agregate data by day.
#--------------------------------------------------------------------------------

agg_var_list <- c('dinf', 'sex', 'age_grp', 'points')

# Need to create date variable by month. 
# saaq_agg[, 'month'] <- sprintf('%d-%02d', 
#                                year(saaq_agg[, 'dinf']), 
#                                month(saaq_agg[, 'dinf']))
# 
# table(saaq_agg[, 'month'])



saaq_daily <- aggregate(num ~ dinf + sex + age_grp + points, 
                          data = saaq_agg[saaq_agg[, 'window'], c(agg_var_list, 'num')], 
                          FUN = sum)

saaq_daily <- saaq_daily[order(saaq_daily$dinf, 
                                   saaq_daily$sex, saaq_daily$age_grp, 
                                   saaq_daily$points), ]


colnames(saaq_daily)
sapply(saaq_daily, class)


summary(saaq_daily)

table(saaq_daily[, 'points'], useNA = 'ifany')


head(saaq_daily, 50)
tail(saaq_daily, 50)


#--------------------------------------------------------------------------------
# Agregate data by month.
# Aggregate across sex and age groups too. 
#--------------------------------------------------------------------------------

saaq_daily_all <- aggregate(num ~ dinf + points, 
                              data = saaq_daily[, c('dinf', 'points', 'num')], 
                              FUN = sum)

saaq_daily_all <- saaq_daily_all[order(saaq_daily_all$dinf, 
                                           saaq_daily_all$points), ]


#--------------------------------------------------------------------------------
# Agregate data by month.
# Aggregate across age groups for each sex.  
#--------------------------------------------------------------------------------

# Male dummies:
saaq_daily_M <- aggregate(num ~ dinf + points, 
                            data = saaq_daily[saaq_daily[, 'sex'] == 'M', 
                                                c('dinf', 'points', 'num')], 
                            FUN = sum)

saaq_daily_M <- saaq_daily_M[order(saaq_daily_M$dinf, 
                                       saaq_daily_M$points), ]


# Females:
saaq_daily_F <- aggregate(num ~ dinf + points, 
                            data = saaq_daily[saaq_daily[, 'sex'] == 'F', 
                                                c('dinf', 'points', 'num')], 
                            FUN = sum)

saaq_daily_F <- saaq_daily_F[order(saaq_daily_F$dinf, 
                                       saaq_daily_F$points), ]





# Form a data table with columns for point balances. 
table(saaq_daily_all[, 'points'], useNA = 'ifany')
table(saaq_daily_M[, 'points'], useNA = 'ifany')
table(saaq_daily_F[, 'points'], useNA = 'ifany')

date_list <- unique(saaq_daily_all[, 'dinf'])
date_list <- date_list[order(date_list)]
point_list <- unique(saaq_daily_all[, 'points'])
point_list <- point_list[order(point_list)]
col_names <- sprintf('pts_%d', point_list)

saaq_daily_all_tab <- data.frame(dinf = date_list)
saaq_daily_M_tab <- data.frame(dinf = date_list)
saaq_daily_F_tab <- data.frame(dinf = date_list)


saaq_daily_all_tab[, col_names] <- 0
saaq_daily_M_tab[, col_names] <- 0
saaq_daily_F_tab[, col_names] <- 0

for (date in date_list) {
  for (points in point_list) {
    
    col_name <- sprintf('pts_%d', points)
    
    # Both sexes. 
    num <- saaq_daily_all[saaq_daily_all[, 'dinf'] == date &
                              saaq_daily_all[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_daily_all_tab[saaq_daily_all_tab[, 'dinf'] == date, 
                           col_name] <- num
    }
    
    # Males only:
    num <- saaq_daily_M[saaq_daily_M[, 'dinf'] == date &
                            saaq_daily_M[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_daily_M_tab[saaq_daily_M_tab[, 'dinf'] == date, 
                         col_name] <- num
    }
    
    
    # Females:
    num <- saaq_daily_F[saaq_daily_F[, 'dinf'] == date &
                            saaq_daily_F[, 'points'] == points, 'num']
    if (length(num) > 0) {
      saaq_daily_F_tab[saaq_daily_F_tab[, 'dinf'] == date, 
                         col_name] <- num
    }
    
    
    
    
  }
}


# Note that units are in driver months. 
head(saaq_daily_all_tab)
tail(saaq_daily_all_tab)


##################################################
# PLots of numbers of offences over time.
##################################################

#--------------------------------------------------
# Selected pairs of offences by sex
#--------------------------------------------------

new_year_dates <- substr(saaq_daily_all_tab[, 'dinf'], 6, 7) == '01' & 
  substr(saaq_daily_all_tab[, 'dinf'], 9, 10) == '01'
new_year_dates <- (1:nrow(saaq_daily_all_tab))[new_year_dates]
new_year_labels <- substr(saaq_daily_all_tab[new_year_dates, 'dinf'], 1, 4)
# Correct for off-by one in graph.
new_year_dates <- new_year_dates - 1




# Bar plot version.
# pts_plot <- c(3, 6) # Overwhelmed by other 3-point violations.
pts_plot <- c(5, 10)
# pts_plot <- c(7, 14)
# pts_plot <- c(9, 18)
# pts_plot <- c(12, 24)
# pts_plot <- c(15, 30) # Thin sample for these violations. 
# pts_plot <- c(18, 36) # Thin sample contaminated by more frequent 9 -> 18 point violations. 


# Select a window of dates.
saaq_daily_all_tab[, 'plot_window'] <- saaq_daily_all_tab[, 'dinf'] >= '2008-02-01' & 
  saaq_daily_all_tab[, 'dinf'] <= '2008-07-01'
plot_sel <- saaq_daily_all_tab[, 'plot_window']

# Create labels for new months. 
new_month_dates <- substr(saaq_daily_all_tab[plot_sel, 'dinf'], 9, 10) == '01'
new_month_dates <- (1:sum(plot_sel))[new_month_dates]
new_month_labels <- substr(saaq_daily_all_tab[plot_sel, 'dinf'][new_month_dates], 1, 7)
# Correct for off-by one in graph.
new_month_dates <- new_month_dates - 1


# Select a particular sex or both. 
sel_tab <- 'all'
# sel_tab <- 'M'
# sel_tab <- 'F'

# Set file location for this draft. 
# file_ext <- 'png'
# file_ext <- 'pdf'
file_ext <- 'screen'
fig_path <- '~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/draft_1'
fig_file_name <- sprintf('%s/num_pts_daily_%d_%d_%s.%s', 
                         fig_path, pts_plot[1], pts_plot[2], sel_tab, file_ext)
if (file_ext == 'png') {
  png(file = fig_file_name)
} else if (file_ext == 'pdf') {
  pdf(file = fig_file_name)
}

# Plot as a stacked bar plot.


# Select data.
if (sel_tab == 'all') {
  subtitle <- '(Both Sexes)'
  counts <- cbind(saaq_daily_all_tab[plot_sel, sprintf('pts_%d', pts_plot[1])], 
                  saaq_daily_all_tab[plot_sel, sprintf('pts_%d', pts_plot[2])])
} else if (sel_tab == 'M') {
  subtitle <- '(Males Only)'
  # Male dummies:
  counts <- cbind(saaq_daily_M_tab[plot_sel, sprintf('pts_%d', pts_plot[1])], 
                  saaq_daily_M_tab[plot_sel, sprintf('pts_%d', pts_plot[2])])
} else if (sel_tab == 'F') {
  subtitle <- '(Females Only)'
  # Females:
  counts <- cbind(saaq_daily_F_tab[plot_sel, sprintf('pts_%d', pts_plot[1])], 
                  saaq_daily_F_tab[plot_sel, sprintf('pts_%d', pts_plot[2])])
}




barplot(t(counts), 
        main = c(sprintf('Daily Total Number of %d- and %d-point Tickets', pts_plot[1], pts_plot[2]), 
                 subtitle), 
        xlab = 'Month', 
        ylab = '# Tickets', 
        ylim = c(0, max(counts)), 
        pch = 16, 
        xaxt='n', 
        space = rep(0, length(saaq_daily_all_tab[plot_sel, sprintf('pts_%d', pts_plot[1])])),
        col = c('blue', 'red'))
abline(v = (1:nrow(saaq_daily_all_tab))[saaq_daily_all_tab[plot_sel, 'dinf'] == '2008-04-01'] - 1, 
       lwd = 3)
abline(v = (1:nrow(saaq_daily_all_tab))[saaq_daily_all_tab[plot_sel, 'dinf'] == '2008-04-28'] - 1, 
       lwd = 3, lty = 'dashed')
abline(v = (1:nrow(saaq_daily_all_tab))[saaq_daily_all_tab[plot_sel, 'dinf'] == '2008-05-25'] - 1, 
       lwd = 3, lty = 'dashed')
axis(1, at = new_month_dates, 
     labels = new_month_labels)
if (file_ext %in% c('png', 'pdf')) {
  dev.off()
}


#--------------------------------------------------
# All tickets combined 
#--------------------------------------------------





#--------------------------------------------------
# Selected pairs of offences by sex
#--------------------------------------------------



##################################################
# End
##################################################

