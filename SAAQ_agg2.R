################################################################################
# 
# Investigation of SAAQ Traffic Ticket Violations
# 
# Construction of a series of numbers of tickets awarded by the 
# number of points per ticket.
# Datasets hold observations for sets of sequential id codes.
# Aggregate data by age and sex categories. 
# Join with non-event data from total licensees on SAAQ webpage.
# Output an aggregate dataset suitable for logistic regression. 
# 
# 
# 
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
# 
# November 1, 2019
# 
################################################################################
# 
# Load data from traffic violations, license suspensions and licensee data.
# Aggregate by demerit point value for each date.
# 
# This version calculates cumulative point totals and statistics from past
# driving behaviour.
# Note that these totals affect aggregation in that nonzero past violations
# must be subtracted from the counts of drivers without tickets each day. 
# This is complicated by the sex and age dimensions. 
# 
################################################################################


################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace.
rm(list=ls(all=TRUE))

# Load package for importing datasets in proprietary formats.
library(foreign)

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
ptsVersion <- 2 # Modified version with both past and present ticket counts.


# Set the list of years for inclusion in dataset.
# yearList <- seq(1999,2000) # First two years.
# yearList <- seq(1999,2003) # First few years.
yearList <- seq(1998,2010) # Entire list.


################################################################################
# Contents of available datasets
################################################################################


# The 'csYYYY.dta' files contain traffic violations.
#   Observations cover years 1998-2010, with 550,000-1,050,000 obsns/yr.,
#   with 10,545,473 osns in total.
#   pddobt is the number of points.
#   dinf is the YYYY-MM-DD date of infraction.
#   dcon is the YYYY-MM-DD date of conviction.
#   seq is an id code for licensees, numbered 1 to 3,911,743.
# The 'saYYYY.dta' files contain licence revocations.
#   Observations cover years 1999-2010, with 10,000-30,000 obsns/yr.,
#   with 238,091 osns in total.
#   orig is a character array, either 'PIP' or 'PDI'.
#     PDI refers to a regular license revocation (15 pts).
#     PIP refers to a learner license revocation (4 pts).
#   dvig is the YYYY-MM-DD date of revocation.
#   seq is an id code for licensees, numbered 1 to 3,911,743.
# The file 'seq.dta' contains licensee data for all 3,911,743 individuals.
#   sxz is either 1.0 (male) 2.0 (female), an indicator for gender.
#   an is the YY year of birth.
#   mois is the MM month of birth.
#   day is the DD day of birth.
#   seq is an id code for licensees, numbered 1 to 3,911,743.
# The file 'seq3.dta' contains licensee data for all 3,911,743 individuals,
#   with the seq equal to the row number (and stripped from the dataset).
#   sxz is either 1.0 2.0, an indicator for male or female.
#   dob is an integer for dates of birth, from 1960-01-01.




################################################################################
# Assemble and Join Tickets with Licensee Data
################################################################################

# Load Licensee Data
fileName <- sprintf('%s%s.dta', dataInPath, 'seq')
drivers <- read.dta(fileName)

head(drivers)
tail(drivers)


# Verify that seq match rownumbers.
sum(drivers[, 'seq'] != seq(nrow(drivers)))
# Check. 


# Initialize dataset with the first year of violations.
yr <- yearList[1]
fileName <- sprintf('%s%s%d.dta', dataInPath, 'cs', yr)
tickets <- read.dta(fileName)

# Reorder by date (one year at a time). 
tickets <- tickets[order(tickets$dinf), ]

colnames(tickets)
head(tickets)

# Join driver data.
tickets <- cbind(tickets, drivers[tickets[, 'seq'], ])
# Replace sex with factor. 
tickets[, 'sex'] <- factor(levels = c('M', 'F'))
tickets[tickets[, 'sxz'] == 1, 'sex'] <- 'M'
tickets[tickets[, 'sxz'] == 2, 'sex'] <- 'F'

colnames(tickets)
head(tickets)
tail(tickets)


# Create new variables and variable names. 
saaq <- tickets[, c('seq', 'sex', 'an', 'mois', 'jour', 'dinf', 'pddobt', 'dcon')]
colnames(saaq) <- c('seq', 'sex', 'dob_yr', 'dob_mo', 'dob_day', 'dinf', 'points', 'dcon')


# Check format.
colnames(saaq)
head(saaq)
tail(saaq)


# Join tickets and driver data for remaining years.
# yr <- yearList[2]
for (yr in yearList[2:length(yearList)]) {
  
  # Print progress report.
  print(sprintf('Now loading data for year %d', yr))
  
  # Load the next set of violations for this yr.
  fileName <- sprintf('%s%s%d.dta', dataInPath, 'cs', yr)
  tickets <- read.dta(fileName)
  
  
  # Reorder by date (one year at a time). 
  tickets <- tickets[order(tickets$dinf), ]
  
  
  # Join driver data.
  tickets <- cbind(tickets, drivers[tickets[, 'seq'], ])
  # Replace sex with factor. 
  tickets[, 'sex'] <- factor(levels = c('M', 'F'))
  tickets[tickets[, 'sxz'] == 1, 'sex'] <- 'M'
  tickets[tickets[, 'sxz'] == 2, 'sex'] <- 'F'
  
  
  # Create new variables and variable names. 
  saaq_yr <- tickets[, c('seq', 'sex', 'an', 'mois', 'jour', 'dinf', 'pddobt', 'dcon')]
  colnames(saaq_yr) <- c('seq', 'sex', 'dob_yr', 'dob_mo', 'dob_day', 'dinf', 'points', 'dcon')
  
  
  # Append to current dataset. 
  saaq <- rbind(saaq, saaq_yr)
  
  
}

# Check format.
colnames(saaq)
head(saaq)
tail(saaq)



################################################################################
# Generate data By age group
################################################################################

# Age in years by date of infraction. 
saaq[, 'age'] <- as.integer(substr(saaq[, 'dinf'], 1, 4)) - (1900 + saaq[, 'dob_yr'])

summary(saaq[, 'age'])
sum(saaq[, 'age'] < 10)
saaq[saaq[, 'age'] < 10, ]

# One person of age zero is actually 100 years old (born in 1899). 
saaq[saaq[, 'age'] < 10, 'age'] <- 100
saaq[saaq[, 'age'] == 100, ]

# Any others?
sum(saaq[, 'age'] > 90)
sum(saaq[, 'age'] < 12)
sum(saaq[, 'age'] < 13)
# 3 12-year-olds (or 112-year-olds?).

sum(saaq[, 'age'] < 16)

# Sort into age groups to match SAAQ categories.

# Moins de 16 ans
# 16-19 ans
# 20-24 ans
# 25-34 ans
# 35-44 ans
# 45-54 ans
# 55-64 ans
# 65-74 ans
# 75-84 ans
# 85-89 ans
# 90 ans ou plus

age_group_list <- c('0-15', '16-19', '20-24', '25-34', '35-44', '45-54', 
                    '55-64', '65-74', '75-84', '85-89', '90-199')
age_cut_points <- c(0, 15.5, 19.5, seq(24.5, 84.5, by = 10), 89.5, 199)
# saaq[, 'age_grp'] <- factor(levels = age_group_list)
saaq[, 'age_grp'] <- cut(saaq[, 'age'], breaks = age_cut_points, 
                         labels = age_group_list)

summary(saaq[saaq[, 'age_grp'] == '0-15', 'age'])

summary(saaq[saaq[, 'age_grp'] == '55-64', 'age'])

summary(saaq[saaq[, 'age_grp'] == '90-199', 'age'])


################################################################################
# Summary Stats for  Tickets with Licensee Data
################################################################################

# Demographics
table(saaq[, 'age_grp'], useNA = 'ifany')
table(saaq[, 'sex'], saaq[, 'age_grp'], useNA = 'ifany')

table(saaq[, 'points'], saaq[, 'age_grp'], useNA = 'ifany')


# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!


# Tabulate point distribution for subgroups.

# Before policy change.
sel_obs <- saaq[, 'dinf'] <= april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')

# Males before policy change.
sel_obs <- saaq[, 'sex'] == 'M' & saaq[, 'dinf'] <= april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')

# Females before policy change.
sel_obs <- saaq[, 'sex'] == 'F' & saaq[, 'dinf'] <= april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')



# After policy change.
sel_obs <- saaq[, 'dinf'] > april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')

# Males after policy change.
sel_obs <- saaq[, 'sex'] == 'M' & saaq[, 'dinf'] > april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')

# Females after policy change.
sel_obs <- saaq[, 'sex'] == 'F' & saaq[, 'dinf'] > april_fools_2008
table(saaq[sel_obs, 'points'], saaq[sel_obs, 'age_grp'], useNA = 'ifany')


# Compare males and females by age group (better to compare with woman on top). 
# Select subset of offenses that apply to females.
sel_obs_num <- saaq[, 'sex'] == 'F' & 
  saaq[, 'dinf'] > april_fools_2008 & 
  saaq[, 'points'] %in% c(seq(1, 7), 9, 10, 12, 14, 18, 24)
table(saaq[sel_obs_num, 'points'], saaq[sel_obs_num, 'age_grp'], useNA = 'ifany')
sel_obs_denom <- saaq[, 'sex'] == 'M' & 
  saaq[, 'dinf'] > april_fools_2008 & 
  saaq[, 'points'] %in% c(seq(1, 7), 9, 10, 12, 14, 18, 24)
table(saaq[sel_obs_denom, 'points'], saaq[sel_obs_denom, 'age_grp'], useNA = 'ifany')

table(saaq[sel_obs_num, 'points'], saaq[sel_obs_num, 'age_grp'], useNA = 'ifany') / 
  table(saaq[sel_obs_denom, 'points'], saaq[sel_obs_denom, 'age_grp'], useNA = 'ifany')


# Repeat for violations before policy change.

# Compare males and females by age group (better to compare with woman on top). 
# Select subset of offenses that apply to females.
sel_obs_num <- saaq[, 'sex'] == 'F' & 
  saaq[, 'dinf'] <= april_fools_2008 & 
  saaq[, 'points'] %in% c(seq(1, 7), 9, 10, 12, 14, 15)
table(saaq[sel_obs_num, 'points'], saaq[sel_obs_num, 'age_grp'], useNA = 'ifany')
sel_obs_denom <- saaq[, 'sex'] == 'M' & 
  saaq[, 'dinf'] <= april_fools_2008 & 
  saaq[, 'points'] %in% c(seq(1, 7), 9, 10, 12, 14, 15)
table(saaq[sel_obs_denom, 'points'], saaq[sel_obs_denom, 'age_grp'], useNA = 'ifany')

table(saaq[sel_obs_num, 'points'], saaq[sel_obs_num, 'age_grp'], useNA = 'ifany') / 
  table(saaq[sel_obs_denom, 'points'], saaq[sel_obs_denom, 'age_grp'], useNA = 'ifany')



################################################################################
# Generate new variables for violation history.
################################################################################

# Create a new driver table to record points history. 
# colnames(drivers)
# driver_hist <- drivers[, 'seq']

# Add a new variable for the date. 
# length(unique(saaq[, 'dinf']))
# No. Would make too many permutations. 

# Instead, make a table with dates as rows and columns as categories. 


# Create rows for list of dates.
day_1 <- as.numeric(as.Date('1998-01-01'))
day_T <- as.numeric(as.Date('2010-12-31'))
date_list <- as.Date(seq(day_1, day_T), origin = as.Date('1970-01-01'))

length(date_list)
min(date_list)
max(date_list)


# Create columns for the sex and age combinations. 
# But wait! There are many point categories as well. 

table(saaq[, 'sex'], saaq[, 'age_grp'], useNA = 'ifany')


# Ok. For real. Add a new column to the event dataset. 
colnames(saaq)





# Sort by date and seq.
saaq <- saaq[order(saaq$seq, saaq$dinf), ]
head(saaq, 10)

# Calculate cumulative points total by driver. 
saaq_dt <- data.table(saaq)
saaq_dt[, cum_pts := cumsum(points)]
saaq_dt[, beg_pts := min(cum_pts), by = seq]
saaq_dt[, past_pts := cum_pts - beg_pts]

head(saaq_dt[, c('seq', 'dinf', 'points', 'cum_pts', 'beg_pts', 'past_pts')], 10)
summary(saaq_dt[, c('seq', 'dinf', 'points', 'cum_pts', 'beg_pts', 'past_pts')])

# hist(saaq_dt[, 'past_pts'])
# Fail. But anyway, this is the missing column. 
# plot(saaq_dt[, 'past_pts'])
# Too many to plot practically. 

# List the values instead. 
past_pts_list <- unique(saaq_dt[, past_pts])
past_pts_list <- past_pts_list[order(past_pts_list)]
# Every number up to 162 occurs, then 164, 165, 167 and 168.


# Instead, sort the past points into past points categories.
# List the quantiles to choose the categories. 
quantile(saaq_dt[, past_pts], probs = seq(0, 1, by = 0.1))
# 0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
# 0    0    0    0    2    3    5    8   11   18  168 
quantile(saaq_dt[, past_pts], probs = seq(0.3, 1, by = 0.05))
# 30%  35%  40%  45%  50%  55%  60%  65%  70%  75%  80%  85%  90%  95% 100% 
# 0    2    2    3    3    4    5    6    8    9   11   14   18   25  168 
quantile(saaq_dt[, past_pts], probs = seq(0.8, 1, by = 0.01))
# 80%  81%  82%  83%  84%  85%  86%  87%  88%  89%  90%  91%  92%  93%  94%  95%  96% 
# 11   12   12   13   13   14   15   15   16   17   18   19   20   22   23   25   27 
# 97%  98%  99% 100% 
#   30   35   43  168 

# Integers 0 to 10 get us to 80%.
# Next increments of 5 get us the next three vigintiles. 
# 

# Problem: counts will keep growing over time.
# Last half of dataset will have the highest point balances. 

# Repeat the calculation with two-year balances.
saaq_dt <- NULL

# Sort by date and seq.
saaq <- saaq[order(saaq$seq, saaq$dinf), ]
head(saaq, 10)





# Calculate cumulative points total by driver. 
saaq_past_pts <- data.table(saaq[, c('seq', 'sex', 'age', 'dinf', 'points')])
# Translate into the drops in points two years later. 
saaq_past_pts[, dinf := as.Date(dinf + 730)]
saaq_past_pts[, age := age + 2]
saaq_past_pts[, points := - points]
head(saaq_past_pts, 10)
# Append the original observations, then sort. 
saaq_past_pts <- rbind(saaq_past_pts, 
                       data.table(saaq[, c('seq', 'sex', 'age', 'dinf', 'points')]))
saaq_past_pts <- saaq_past_pts[order(saaq_past_pts$seq, 
                                     saaq_past_pts$dinf, 
                                     saaq_past_pts$points)]
head(saaq_past_pts, 10)



# Calculate point balances. 
saaq_past_pts[, curr_pts := cumsum(points)]
head(saaq_past_pts, 20)


# Not necessary, once points are removed later.
# saaq_past_pts[, beg_pts := min(cum_pts), by = seq]
# saaq_past_pts[, past_pts := cum_pts - beg_pts]

summary(saaq_past_pts)



# List the possible values.  
past_pts_list <- unique(saaq_past_pts[, curr_pts])
past_pts_list <- past_pts_list[order(past_pts_list)]
# Every number up to 110, then more sparse up to 150.

# Inspect the distribution to choose categories. 
quantile(saaq_past_pts[, curr_pts], probs = seq(0, 1, by = 0.1))
# 0%  10%  20%  30%  40%  50%  60%  70%  80%  90% 100% 
# 0    0    0    1    2    3    3    4    6    8  150 

quantile(saaq_past_pts[, curr_pts], probs = seq(0.9, 1, by = 0.01))
# 90%  91%  92%  93%  94%  95%  96%  97%  98%  99% 100% 
# 8    9    9   10   10   11   12   13   15   18  150 

quantile(saaq_past_pts[, curr_pts], probs = seq(0.99, 1, by = 0.001))
# 99% 99.1% 99.2% 99.3% 99.4% 99.5% 99.6% 99.7% 99.8% 99.9%  100% 
# 18    18    19    20    21    22    23    25    27    32   150


# 0-10 gets up to the 95 percentile. 
# 15 gets to 98th percentile. 
# 20 gets inside 99th percentile.
# 30 gets to 99.9%.

# Categories:
# 0-10 separately, for granularity.
# 11-20 for next category.
# 21-30 for next category.
# 31+ for last category. 

# saaq_past_pts[, curr_pts_grp := as.factor(NA, levels = c(seq(0,10), '11-20', '21-30', '31-150'))]
saaq_past_pts[, curr_pts_grp := '-99']
head(saaq_past_pts, 20)
saaq_past_pts[curr_pts <= 10, curr_pts_grp := as.character(curr_pts)]
saaq_past_pts[curr_pts > 10 & curr_pts <= 20, 
              curr_pts_grp := '11-20']
saaq_past_pts[curr_pts > 20 & curr_pts <= 30, 
              curr_pts_grp := '21-30']
saaq_past_pts[curr_pts > 30, 
              curr_pts_grp := '30-150']


table(saaq_past_pts[, curr_pts_grp], useNA = 'ifany')

curr_pts_grp_list <- c(as.character(seq(0, 10), '11-20', '21-30', '30-150'))


# Now calculate age groups as before. 

age_group_list <- c('0-15', '16-19', '20-24', '25-34', '35-44', '45-54', 
                    '55-64', '65-74', '75-84', '85-89', '90-199')
age_cut_points <- c(0, 15.5, 19.5, seq(24.5, 84.5, by = 10), 89.5, 199)
# saaq[, 'age_grp'] <- factor(levels = age_group_list)
saaq_past_pts[, age_grp := cut(age, breaks = age_cut_points, 
                         labels = age_group_list)]

summary(saaq_past_pts[age_grp == '0-15', age])
summary(saaq_past_pts[age_grp == '55-64', age])
summary(saaq_past_pts[age_grp == '90-199', age])

head(saaq_past_pts, 20)

# Now this dataset can be used to calculate counts by category. 

# Start with a dataset of the categories.
saaq_past_counts <- data.table(expand.grid(date = date_list, 
                                           sex = c('M', 'F'), 
                                           age_grp = age_group_list, 
                                           curr_pts_grp = curr_pts_grp_list))
# Only a million rows or so. 
# Initialize with zeros for the combinations that didn't happen. 
saaq_past_counts[, num := 0]


# Loop on dates and calculate the totals. 
date_num <- 2
# for (date_num in 2:length(date_list)) {
for (date_num in 2:100) {
  
  date_sel <- date_list[date_num]
  
  # Print progress report.
  if (TRUE | (mday(date_sel) == 1)) {
    print(sprintf('Now tabulating for date %s.', as.character(date_sel)))
  }
  
  # Obtain most recent point blance for each driver. 
  # Start with all previous balances.
  past_counts <- saaq_past_pts[dinf < date_sel, c('dinf', 'seq', 'sex', 'age_grp', 'curr_pts_grp')]
  # Obtain the last date for each driver. 
  past_counts[, most_recent_date := max(dinf), by = seq]
  # Obtain data from only the last date for each driver. 
  past_counts <- past_counts[dinf == most_recent_date, ]
  
  
  # Tabulate counts in each category. 
  past_counts_tab <- past_counts[, .N, by = c('sex', 'age_grp', 'curr_pts_grp')]
  
  # Now insert these counts in the total for each date. 
  for (row_num in 1:nrow(past_counts_tab)) {
    
    saaq_past_counts[date == date_sel & 
                     sex == past_counts_tab[row_num, sex] & 
                     age_grp == past_counts_tab[row_num, age_grp] & 
                     curr_pts_grp == past_counts_tab[row_num, curr_pts_grp], 
                     num := past_counts_tab[row_num, N]]
    
  }
  
  
}






################################################################################
# Aggregate by sex and age and point categories.
################################################################################

colnames(saaq)

agg_var_list <- c('dinf', 'sex', 'age_grp', 'points')
saaq[, 'num'] <- 1

# Wrong syntax:
# saaq_agg <- aggregate(x = saaq[, c(agg_var_list, 'one')], 
#                       by = list(saaq[, agg_var_list]), FUN = sum)

# Reverse order of rows:
# saaq_agg <- aggregate(one ~ dinf + sex + age_grp + points, 
#                       data = saaq[, c(agg_var_list, 'num')], 
#                       FUN = sum)
# saaq_agg <- saaq_agg[order(saaq_agg$dinf, saaq_agg$sex, saaq_agg$age_grp, saaq_agg$points), ]


# Reverse order of columns (easier to reorder). 
saaq_agg <- aggregate(num ~ points + age_grp + sex + dinf, 
                      data = saaq[, c(agg_var_list, 'num')], 
                      FUN = sum)

colnames(saaq_agg)

head(saaq_agg, 50)
tail(saaq_agg, 50)

summary(saaq_agg)



################################################################################
# Join Daily Driver Counts
################################################################################

ptsVersion <- 1
in_file_name <- sprintf('saaq_no_tickets_%d.csv', ptsVersion)
in_path_file_name <- sprintf('%s/%s', dataInPath, in_file_name)
# Yes, keep it in dataInPath since it is yet to be joined. 
# write.csv(x = no_tickets_df, file = out_path_file_name, row.names = FALSE)
no_tickets_df <- read.csv(file = in_path_file_name)



colnames(saaq_agg)
colnames(no_tickets_df)

# Select columns from no_tickets_df in same order as saaq_agg.
summary(no_tickets_df[, c(agg_var_list, 'num')])


# Stack the two data frames and reorder. 
saaq_agg <- rbind(saaq_agg[, c(agg_var_list, 'num')], 
                  no_tickets_df[, c(agg_var_list, 'num')])

colnames(saaq_agg)


summary(saaq_agg)


saaq_agg <- saaq_agg[order(saaq_agg$dinf, saaq_agg$sex, saaq_agg$age_grp, saaq_agg$points), ]


head(saaq_agg, 50)
tail(saaq_agg, 50)




################################################################################
# Output Daily Driver Counts
################################################################################

out_file_name <- sprintf('saaq_agg_%d.csv', ptsVersion)
out_path_file_name <- sprintf('%s%s', dataInPath, out_file_name)
# Yes, keep it in dataInPath since it is yet to be joined. 
# write.csv(x = saaq_agg, file = out_path_file_name, row.names = FALSE)




################################################################################
# Next want to analyze for patterns of incidence for choice of functional form
################################################################################

# Plot frequency distribution across point by age group and sex. 





################################################################################
# End
################################################################################
