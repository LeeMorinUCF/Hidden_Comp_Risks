################################################################################
# 
# Investigation of SAAQ Traffic Ticket Violations
# 
# Logistic regressions of numbers of tickets awarded by the 
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
                          data = saaq_agg[, c(agg_var_list, 'num')], 
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


# Form a data table with columns for point balances. 
table(saaq_monthly_all[, 'points'], useNA = 'ifany')

month_list <- unique(saaq_monthly_all[, 'month'])
point_list <- unique(saaq_monthly_all[, 'points'])
col_names <- sprintf('pts_%d', point_list)

saaq_monthly_all_tab <- data.frame(month = month_list)


saaq_monthly_all_tab[, col_names] <- 0

for (month in month_list) {
  for (points in point_list) {
    
    col_name <- sprintf('pts_%d', points)
    
    num <- saaq_monthly_all[saaq_monthly_all[, 'month'] == month &
                              saaq_monthly_all[, 'points'] == points, 'num']
    
    if (length(num) > 0) {
      saaq_monthly_all_tab[saaq_monthly_all_tab[, 'month'] == month, 
                           col_name] <- num
    }
    
  }
}


# Note that units are in driver months. 
head(saaq_monthly_all_tab)
tail(saaq_monthly_all_tab)


##################################################
# PLots of numbers of offences over time.
##################################################

new_year_dates <- substr(saaq_monthly_all_tab[, 'month'], 6, 7) == '01'
new_year_dates <- (1:nrow(saaq_monthly_all_tab))[new_year_dates]
new_year_labels <- substr(saaq_monthly_all_tab[new_year_dates, 'month'], 1, 4)

#--------------------------------------------------------------------------------
# One point value at a time
#--------------------------------------------------------------------------------


# Select the number of points to display. 
pts_plot <- 1

plot(1:nrow(saaq_monthly_all_tab), 
     saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot)], 
     main = sprintf('Monthly Total Number of %d-point Tickets', pts_plot), 
     xlab = 'Month', 
     ylab = '# Tickets', 
     ylim = c(0, max(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot)])), 
     pch = 16, 
     xaxt='n')
abline(v = (1:nrow(saaq_monthly_all_tab))[saaq_monthly_all_tab[, 'month'] == '2008-04'], 
       lwd = 2)

axis(1, at = new_year_dates, 
     labels = new_year_labels)


#--------------------------------------------------------------------------------
# Two point values at a time
#--------------------------------------------------------------------------------


# Select the number of points to display. 
# pts_plot <- c(3, 6)
# pts_plot <- c(9, 18)
pts_plot <- c(12, 24)

plot(1:nrow(saaq_monthly_all_tab), 
     saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])], 
     main = sprintf('Monthly Total Number of %d- and %d-point Tickets', pts_plot[1], pts_plot[2]), 
     xlab = 'Month', 
     ylab = '# Tickets', 
     ylim = c(0, max(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot)])), 
     pch = 16, 
     xaxt='n')
points(1:nrow(saaq_monthly_all_tab), 
       saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[2])], 
       pch = 16, 
       col = 'red')
abline(v = (1:nrow(saaq_monthly_all_tab))[saaq_monthly_all_tab[, 'month'] == '2008-04'], 
       lwd = 2)

axis(1, at = new_year_dates, 
     labels = new_year_labels)


# Plot as a stacked bar plot.
counts <- cbind(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[1])], 
                saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot[2])])


barplot(t(counts), 
        main = sprintf('Monthly Total Number of %d- and %d-point Tickets', pts_plot[1], pts_plot[2]), 
        xlab = 'Month', 
        ylab = '# Tickets', 
        ylim = c(0, max(saaq_monthly_all_tab[, sprintf('pts_%d', pts_plot)])), 
        pch = 16, 
        xaxt='n', 
        col = c('blue', 'red'))
abline(v = (1:nrow(saaq_monthly_all_tab))[saaq_monthly_all_tab[, 'month'] == '2008-04'], 
       lwd = 2)

axis(1, at = new_year_dates, 
     labels = new_year_labels)




# Example with mtcars.
# data(mtcars)
# counts <- table(mtcars$vs, mtcars$gear)



##################################################
# End
##################################################
