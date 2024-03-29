################################################################################
#
# Investigation of SAAQ Excessive Speeding Laws
#
# Comparison of alternate data sets
# 
# Construction of a series of numbers of tickets awarded by the
# number of points per ticket.
# Datasets hold observations for sets of sequential id codes.
# Aggregate data by age and sex categories.
# Join with non-event data from total licensees on SAAQ webpage.
# Output an aggregate dataset suitable for regression analysis.
#
#
#
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business
# University of Central Florida
#
# June 22, 2021
#
################################################################################
#
################################################################################

################################################################################
# Clearing Workspace and Declaring Packages
################################################################################

# Clear workspace, if running interactively.
rm(list=ls(all=TRUE))

# Load data table package for quick selection on seq.
library(data.table)

# Load rpart package for partitioning with regression trees.
# library(rpart)


################################################################################
# Set parameters for file IO
################################################################################

# Set working directory, if running interactively.
drive_path <- 'C:/Users/le279259/OneDrive - University of Central Florida/Documents'
git_path <- 'Research/SAAQ/SAAQspeeding/SAAQ_XS_de_Vitesse_2008'
wd_path <- sprintf('%s/%s',drive_path, git_path)
setwd(wd_path)

# The original data are stored in 'Data/'.
data_in_path <- 'Data'

# The data of counts of licensed drivers are also stored in 'Data/'.
data_out_path <- 'Data'

# Set name of output file for training, testing and estimation samples.
train_file_name <- 'saaq_train.csv'
test_file_name <- 'saaq_test.csv'


# Set name of output file for full dataset.
# out_file_name <- 'saaq_out.csv'


set.seed(42)


################################################################################
# Set Parameters for variables
################################################################################



# Age group categories for defining factors.
age_group_list <- c('0-15', '16-19', '20-24', '25-34', '35-44', '45-54',
                    '55-64', '65-74', '75-84', '85-89', '90-199')

# Current points group categories for defining factors.
curr_pts_grp_list <- c(seq(0,10), '11-20', '21-30', '31-150')

# Weekday indicators.
weekday_list <- c('Sunday',
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  'Friday',
                  'Saturday')

# Set date of policy change.
april_fools_date <- '2008-04-01'
# No joke: policy change on April Fool's Day!


################################################################################
# Load Datasets
################################################################################

#-------------------------------------------------------------------------------
# Load Training Dataset
#-------------------------------------------------------------------------------

# Dataset for in-sample model fitting. 
in_path_file_name <- sprintf('%s/%s', data_in_path, train_file_name)
saaq_train <- fread(in_path_file_name)

summary(saaq_train)

summary(saaq_train[, .N, by = date])
head(saaq_train, 618)


table(saaq_train[, sex], useNA = 'ifany')

table(saaq_train[, age_grp], useNA = 'ifany')

table(saaq_train[, past_active], useNA = 'ifany')

table(saaq_train[, past_active], saaq_train[, sex], useNA = 'ifany')

table(saaq_train[, curr_pts_grp], saaq_train[, past_active], useNA = 'ifany')



length(unique(saaq_train[, date]))
# [1] 1826 days of driving.

2*length(age_group_list)*2*length(curr_pts_grp_list)
# [1] 616 combinations of categories per day.

# Observations added with observed tickets.
nrow(saaq_train) - 2*length(age_group_list)*2*length(curr_pts_grp_list)*1826


#-------------------------------------------------------------------------------
# Load Testing Dataset
#-------------------------------------------------------------------------------

# Dataset for out-of-sample model testing. 
in_path_file_name <- sprintf('%s/%s', data_in_path, test_file_name)
saaq_test <- fread(in_path_file_name)

summary(saaq_test)

summary(saaq_test[, .N, by = date])
head(saaq_test, 618)


table(saaq_test[, sex], useNA = 'ifany')

table(saaq_test[, age_grp], useNA = 'ifany')

table(saaq_test[, past_active], useNA = 'ifany')

table(saaq_test[, past_active], saaq_test[, sex], useNA = 'ifany')

table(saaq_test[, curr_pts_grp], saaq_test[, past_active], useNA = 'ifany')



length(unique(saaq_test[, date]))
# [1] 1826 days of driving.

2*length(age_group_list)*2*length(curr_pts_grp_list)
# [1] 616 combinations of categories per day.

# Observations added with observed tickets.
nrow(saaq_test) - 2*length(age_group_list)*2*length(curr_pts_grp_list)*1826



################################################################################
# Stack the datasets and label by sample
################################################################################

saaq_train[, sample := 'train']
saaq_test[, sample := 'test']
saaq_data <- rbind(saaq_train, saaq_test)

rm(saaq_train, saaq_test)


################################################################################
# Define additional variables
################################################################################

# Define categorical variables as factors.
saaq_data[, sex := factor(sex, levels = c('M', 'F'))]
saaq_data[, age_grp := factor(age_grp, levels = age_group_list)]
saaq_data[, curr_pts_grp := factor(curr_pts_grp, levels = curr_pts_grp_list)]

# Define new variables for seasonality.
# Numeric indicator for month. 
# saaq_data[, 'month'] <- substr(saaq_data[, 'date'], 6, 7)
saaq_data[, month := substr(date, 6, 7)]
table(saaq_data[, 'month'], useNA = "ifany")

# Weekday indicator.
saaq_data[, weekday := weekdays(date)]
table(saaq_data[, 'weekday'], useNA = "ifany")
class(saaq_data[, weekday])
saaq_data[, weekday := factor(weekday, levels = weekday_list)]
class(saaq_data[, weekday])

# Last, but not least, define the indicator for the policy change.
saaq_data[, policy := date >= april_fools_date]



summary(saaq_data[month == '06', date])
summary(saaq_data[policy == TRUE, date])
summary(saaq_data[policy == FALSE, date])




################################################################################
# Read the original dataset
################################################################################


# The original data are stored in 'SAAQdata/origData/'.
# dataInPath <- 'SAAQdata_full/'
# data_in_path <- '~/Research/SAAQ/SAAQdata_full/'
# data_in_path <- 'C:/Users/le279259/Documents/Research/SAAQ/SAAQdata_full/'

# Current path of original dataset.
# drive_path <- 'C:/Users/le279259/OneDrive - University of Central Florida/Documents'
orig_path <- 'Research/SAAQ/SAAQdata_full'
data_orig_path <- sprintf('%s/%s',drive_path, orig_path)

# Set version of input file.
# ptsVersion <- 2 # With current points but not past active.
pts_version <- 3 # With current points and past active.



in_file_name <- sprintf('saaq_agg_%d.csv', pts_version)
in_path_file_name <- sprintf('%s/%s', data_orig_path, in_file_name)
# Yes, keep it in dataInPath since it is yet to be joined.
# saaq_data_orig <- read.csv(file = in_path_file_name)
saaq_data_orig <- fread(file = in_path_file_name)



colnames(saaq_data_orig)

colnames(saaq_data_orig)[1] <- 'date'

sapply(saaq_data_orig, class)

# Rewrite dinf as date format.
# saaq_data_orig[, 'dinf'] <- as.Date(saaq_data_orig[, 'dinf'])


# Drop data out of sample period.
sample_beg <- '2006-04-01'
sample_end <- '2010-03-31'
saaq_data_orig <- saaq_data_orig[date >= sample_beg & date <= sample_end]



summary(saaq_data_orig)



# Define categorical variables as factors.
saaq_data_orig[, sex := factor(sex, levels = c('M', 'F'))]
saaq_data_orig[, age_grp := factor(age_grp, levels = age_group_list)]
table(saaq_data_orig[, curr_pts_grp])
saaq_data_orig[curr_pts_grp == '30-150', curr_pts_grp := '31-150']
saaq_data_orig[, curr_pts_grp := factor(curr_pts_grp, levels = curr_pts_grp_list)]

# Define new variables for seasonality.
# Numeric indicator for month. 
# saaq_data[, 'month'] <- substr(saaq_data[, 'date'], 6, 7)
saaq_data_orig[, month := substr(date, 6, 7)]
table(saaq_data_orig[, 'month'], useNA = "ifany")

# Weekday indicator.
saaq_data_orig[, weekday := weekdays(date)]
table(saaq_data_orig[, 'weekday'], useNA = "ifany")
class(saaq_data_orig[, weekday])
saaq_data_orig[, weekday := factor(weekday, levels = weekday_list)]
class(saaq_data_orig[, weekday])

# Last, but not least, define the indicator for the policy change.
saaq_data_orig[, policy := date >= april_fools_date]



summary(saaq_data_orig)

colnames(saaq_data_orig)


saaq_data_orig[date >= sample_beg & date <= sample_end,
               sum(as.numeric(num)), by = points][order(points)]



################################################################################
# Aggregate newer dataset for comparison.
################################################################################


summary(saaq_data)

colnames(saaq_data)

saaq_data[date >= sample_beg & date <= sample_end,
          sum(as.numeric(num)), by = points][order(points)]


saaq_data_comp <- saaq_data[, num := sum(num), 
                            by = c("date", "sex", "age_grp", 
                                   "curr_pts_grp", "past_active",  
                                   "points", "month", "weekday", "policy")]

saaq_data_comp <- unique(saaq_data_comp[, colnames(saaq_data_orig), with = FALSE])


summary(saaq_data_comp)

colnames(saaq_data_comp)

saaq_data_comp[date >= sample_beg & date <= sample_end,
               sum(as.numeric(num)), by = points][order(points)]


################################################################################
# Compare overall counts
################################################################################


colnames(saaq_data_comp)
colnames(saaq_data_orig)



summary(saaq_data_comp)
summary(saaq_data_orig)

# Many more counts in the newer dataset saaq_data_orig. 
saaq_data_comp[, sum(num), by = c('sex')]
saaq_data_orig[, sum(num), by = c('sex')]

# Calculate a ratio. 
comp_var_name <- 'sex'
comp_check <- saaq_data_comp[, sum(num), by = c(comp_var_name)]
comp_check[, num_comp := V1]
orig_check <- saaq_data_orig[, sum(num), by = c(comp_var_name)]
orig_check[, num_orig := V1]
check <- cbind(comp_check[, c(comp_var_name, 'num_comp'), with = FALSE], 
               orig_check[, c('num_orig'), with = FALSE])
check[, pct_comp := num_comp/num_orig]
print(check)

# Create a function to streamline comparisons. 
data_var_check <- function(comp_var_name) {
  
  comp_check <- saaq_data_comp[, sum(as.numeric(num)), by = c(comp_var_name)]
  comp_check[, num_comp := V1]
  orig_check <- saaq_data_orig[, sum(as.numeric(num)), by = c(comp_var_name)]
  orig_check[, num_orig := V1]
  check <- cbind(comp_check[, c(comp_var_name, 'num_comp'), with = FALSE], 
                 orig_check[, c('num_orig'), with = FALSE])
  check[, pct_comp := num_comp/num_orig]
  print(check)
}

# Test it on the last category.
comp_var_name <- 'sex'
data_var_check(comp_var_name)


# Now compare by age group.
comp_var_name <- 'age_grp'
data_var_check(comp_var_name)


# > colnames(saaq_data_comp)
# [1] "date"         "sex"          "age_grp"      "curr_pts_grp" "past_active"  "points"      
# [7] "num"          "month"        "weekday"      "policy"  


# Very different across different points categories. 
comp_var_name <- 'curr_pts_grp'
data_var_check(comp_var_name)


comp_var_name <- 'past_active'
data_var_check(comp_var_name)

# Zero points total 24B vs 9.6B: waaayyy too high!
# Much higher counts for 2, 3, and 5 points. 
# Almost the same numbers 18 and up.
comp_var_name <- 'points'
data_var_check(comp_var_name)


# 2.5 x every month.
comp_var_name <- 'month'
data_var_check(comp_var_name)



# 2.5 x every weekday.
comp_var_name <- 'weekday'
data_var_check(comp_var_name)



# 2.5 x both before and after policy.
comp_var_name <- 'policy'
data_var_check(comp_var_name)

# The cidderences are concentrated on specific points and curr_pts_grp categories.
# The differences in past_active and age groups seems to be by correlation:
# bigger changes in the less active categories.




################################################################################
# Compare across two dimensions.
################################################################################

# Create a function to streamline comparisons.
data_2D_var_check <- function(comp_var_name, by_var_name) {

  comp_check <- saaq_data_comp[, sum(as.numeric(num)), 
                               by = c(comp_var_name, by_var_name)]
  comp_check[, num_comp := V1]
  orig_check <- saaq_data_orig[, sum(as.numeric(num)), 
                               by = c(comp_var_name,by_var_name)]
  orig_check[, num_orig := V1]
  check <- cbind(comp_check[, c(comp_var_name, by_var_name, 'num_comp'), with = FALSE],
                 orig_check[, c('num_orig'), with = FALSE])
  check[, pct_comp := num_comp/num_orig]
  
  # Print in a loop by by_var_name levels.
  check[, 'by_var_name'] <- check[, c(by_var_name), with = FALSE]
  by_var_levels <- unique((check[, c(by_var_name), with = FALSE]))
  for (by_var_level in unlist(by_var_levels)) {
    print(sprintf('Comparison for %s = %s:', by_var_name, by_var_level))
    print(check[by_var_name == by_var_level, 
                c(comp_var_name, by_var_name, 'num_comp', 'num_orig', 'pct_comp'), with = FALSE])
  }
}


comp_var_name <- 'points'
by_var_name <- 'curr_pts_grp'
data_2D_var_check(comp_var_name, by_var_name)



by_var_name <- 'points'
comp_var_name <- 'curr_pts_grp'
data_2D_var_check(comp_var_name, by_var_name)




################################################################################
# Investigate the original list of tickets
################################################################################


# Set working directory, if running interactively.
drive_path <- 'C:/Users/le279259/OneDrive - University of Central Florida/Documents'
git_path <- 'Research/SAAQ/SAAQspeeding/SAAQ_XS_de_Vitesse_2008'
wd_path <- sprintf('%s/%s',drive_path, git_path)
setwd(wd_path)

# The original data are stored in 'Data/'.
data_in_path <- 'Data'

# Set name of file with records of tickets. 
tickets_in_file_name <- 'saaq_tickets.csv'



# Start with the dataset of tickets. 
in_path_file_name <- sprintf('%s/%s', data_in_path, tickets_in_file_name)
saaq_point_hist <- fread(file = in_path_file_name)

colnames(saaq_point_hist)



summary(saaq_point_hist)


colnames(saaq_point_hist)[6] <- 'date'


saaq_point_hist <- saaq_point_hist[date >= sample_beg & date <= sample_end, ]


saaq_point_hist[, sex := factor(sex, levels = c('M', 'F'))]
saaq_point_hist[, age_grp := factor(age_grp, levels = age_group_list)]


saaq_point_hist <- saaq_point_hist[, colnames(saaq_point_hist)[c(6, 1, 2, 10, 7)], 
                                   with = FALSE]


summary(saaq_point_hist)


check_tickets_orig <- saaq_point_hist[, .N, by = points][order(points)]

check_tickets_comp <- saaq_data_comp[points > 0, sum(as.numeric(num)), by = points][order(points)]

check_tickets_points <- cbind(check_tickets_orig, check_tickets_comp[, V1])
check_tickets_points[, diff := V2 - N]
check_tickets_points[, pct_diff := V2/N]

check_tickets_points
#    points       N       V2     diff  pct_diff
# 1:      1  331357  2003629  1672272  6.046738
# 2:      2 1638138 42308350 40670212 25.827098
# 3:      3 1816405 43508859 41692454 23.953281
# 4:      4   35531    65565    30034  1.845290
# 5:      5   65818   151680    85862  2.304537
# 6:      6   15813    21214     5401  1.341554
# 7:      7    8360    11380     3020  1.361244
# 8:      9   18191    22471     4280  1.235281
# 9:     10   14884    20680     5796  1.389411
# 10:     12     128      132        4  1.031250
# 11:     14    4447     5256      809  1.181920
# 12:     15      18       18        0  1.000000
# 13:     18     586      594        8  1.013652
# 14:     24     102      104        2  1.019608
# 15:     30      17       17        0  1.000000
# 16:     36       4        4        0  1.000000

saaq_point_hist[dinf >= sample_beg & dinf <= sample_end, 
                .N, by = points][order(points)]

saaq_point_hist[date >= sample_beg & date <= sample_end, 
                .N, by = points][order(points)]

colnames(saaq_data_orig)
saaq_data_orig[date >= sample_beg & date <= sample_end, 
               .N, by = points][order(points)]
saaq_data_orig[date >= sample_beg & date <= sample_end, 
               sum(as.numeric(num)), by = points][order(points)]
# Sum of tickets matches the tickets on the way in. 

# Total matches regression results. 
saaq_data_orig[date >= sample_beg & date <= sample_end, 
               sum(as.numeric(num))]


# Need to find out how many observations got into the dataset.
saaq_data[date >= sample_beg & date <= sample_end, 
          sum(as.numeric(num)), by = points][order(points)]


# Tickets data set read in from the joining script.
saaq_tickets[date >= sample_beg & date <= sample_end, 
             sum(as.numeric(num)), by = points][order(points)]
# Same as above. Good up until the dataset loaded to the join script.



# After sample selection, join train and test and compare counts by points.
saaq_train_test <- rbind(saaq_train, saaq_test)

saaq_train_test[date >= sample_beg & date <= sample_end, 
             sum(as.numeric(num)), by = points][order(points)]



################################################################################
# Analysis of counts in demographic categories
################################################################################

# From SAAQ_point_balances.R:
# add_counts <- unique(saaq_point_hist[event_id == first_id, 
#                                      c('seq', 'sex', 'age_grp', 'past_active')])
# add_counts <- unique(add_counts[, .N, by = c('sex', 'age_grp', 'past_active')])
# add_counts[, curr_pts_grp := 0]
# # Change column order to match.
# add_counts <- add_counts[, c('sex', 'age_grp', 'past_active', 
#                              'curr_pts_grp', 'N')]
# # Skip adding the zeros for now.
# add_counts[, curr_pts_grp := factor(curr_pts_grp, levels = curr_pts_grp_list)]
# add_counts <- add_counts[order(sex, age_grp, past_active, curr_pts_grp)]


# Simplify and calculate without past_active (none are past_active in driver counts):
add_counts <- unique(saaq_point_hist[event_id == first_id, 
                                     c('seq', 'sex', 'age_grp')])
add_counts <- unique(add_counts[, .N, by = c('sex', 'age_grp')])
add_counts[, curr_pts_grp := 0]
# Change column order to match.
add_counts <- add_counts[, c('sex', 'age_grp', 
                             'curr_pts_grp', 'N')]
# Skip adding the zeros for now.
add_counts[, curr_pts_grp := factor(curr_pts_grp, levels = curr_pts_grp_list)]
add_counts <- add_counts[order(sex, age_grp, curr_pts_grp)]


# Coarser grouping to merge less-populated age groups:
age_group_list <- c('0-19', 
                    '20-24', '25-34', '35-44', '45-54',
                    '55-64', '65-199')


# Take numbers directly from tickets dataset. 
non_zero_counts <- unique(saaq_tickets[, c('seq', 'sex', 'age_grp')])
non_zero_counts <- unique(non_zero_counts[, .N, by = c('sex', 'age_grp')])
non_zero_counts <- non_zero_counts[order(sex, age_grp)]



#--------------------------------------------------------------------------------
# Now load the driver counts (number of licensed drivers).
#--------------------------------------------------------------------------------

driver_counts_file_name <- 'SAAQ_drivers_daily.csv'
in_path_file_name <- sprintf('%s/%s', data_in_path, driver_counts_file_name)
driver_counts <- fread(in_path_file_name)


# Need to add empty column of curr_pts_grp to
# default population with no tickets.
# driver_counts[, curr_pts_grp := 0]

# Also need to add empty column of past_active to
# default population with no tickets.
# driver_counts[, past_active := FALSE]

# Standardize date variable.
# driver_counts[, date := dinf]


# Define categorical variables as factors.
driver_counts[, sex := factor(sex, levels = c('M', 'F'))]
driver_counts[age_grp %in% c('0-15', '16-19'), age_grp := '0-19']
driver_counts[age_grp %in% c('65-74', '75-84', '85-89', '90-199'), age_grp := '65-199']
driver_counts[, age_grp := factor(age_grp, levels = age_group_list)]
driver_counts <- unique(driver_counts[, num := sum(num), by = c('date', 'age_grp', 'sex')])
# driver_counts[, curr_pts_grp := factor(curr_pts_grp, levels = curr_pts_grp_list)]


# summary(driver_counts)
colnames(driver_counts)
lapply(driver_counts, class)

# summary(driver_counts[, c(join_var_list), with = FALSE])
summary(driver_counts)


# Trim some fat off of the driver counts.

# Focus on sample period.
driver_counts <- driver_counts[date >= sample_beg & date <= sample_end, ]
# driver_counts <- driver_counts[,c('date', 'sex', 'age_grp', 'curr_pts_grp', 'num'), 
#                                with = FALSE]
# driver_counts[, avg := mean(num), by = c('sex', 'age_grp', 'curr_pts_grp')]
# driver_counts[, min := min(num), by = c('sex', 'age_grp', 'curr_pts_grp')]
# driver_counts[, max := max(num), by = c('sex', 'age_grp', 'curr_pts_grp')]
driver_counts <- driver_counts[,c('date', 'sex', 'age_grp', 'num'), 
                               with = FALSE]
driver_counts[, avg := mean(num), by = c('sex', 'age_grp')]
driver_counts[, min := min(num), by = c('sex', 'age_grp')]
driver_counts[, max := max(num), by = c('sex', 'age_grp')]

# Drop unique variables after stats are calculated.
driver_counts[, num := NULL]
driver_counts[, date := NULL]

driver_counts <- unique(driver_counts)
# driver_counts <- driver_counts[order(sex, age_grp, curr_pts_grp)]
driver_counts <- driver_counts[order(sex, age_grp)]



#--------------------------------------------------------------------------------
# Now compare this to the driver counts (number of licenced drivers).
#--------------------------------------------------------------------------------

# add_counts
non_zero_counts
driver_counts

# count_comp <- cbind(driver_counts, add_counts[, N])
# colnames(count_comp)[7] <- 'num'
count_comp <- cbind(driver_counts, non_zero_counts[, N])
colnames(count_comp)[6] <- 'num'

count_comp[, diff_avg := avg - num]
count_comp[, diff_min := min - num]
count_comp[, diff_max := max - num]

# Some small negative counts in the subcategories age 65+.
# Other than that, only males age 16-19 have at most 3385 drivers with
# tickets above the driver counts. 
# This amounts to 3-5% above the number of licensed drivers. 
# These are teenagers who are stealing mom's car when the parents are out of town. 
# Many teenage boys drive a car and get a ticket without a license. 

# After adjustments, only a few minor excesses exist for seniors.
# These are canceled out by the "younger" groups of seniors. 
# In light of the low infraction rates in this group, 
# it is not worth adjusting further. 
# Some people get a ticket for a seat belt and, even if their license 
# is no longer valid, the ticket get recorded under their expired license number. 

count_comp[, sum(num)]
count_comp[, sum(num), by = c('sex')]




################################################################################
# End
################################################################################
