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
# November 1, 2019
# 
################################################################################
# 
# Load data from traffic violations, license suspensions and licensee data.
# Aggregate by demerit point value for each date.
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
# library(data.table)


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

# Totals are based on the number of driver's licenses outstanding
# for each category as of June 1 of each year. 

annual_file_name <- 'SAAQdrivers_annual.csv'
annual_path_file_name <- sprintf('%s/%s', dataInPath, annual_file_name)
annual <- read.csv(file = annual_path_file_name)

colnames(annual)
sapply(annual, class)


################################################################################
# Construct Daily Driver Counts
################################################################################

# COnstruct a date series from dates in main dataset. 

# > min(saaq[, 'dinf'])
# [1] "1998-01-01"
# > max(saaq[, 'dinf'])
# [1] "2010-12-31"
# > 

day_1 <- as.numeric(as.Date('1998-01-01'))
day_T <- as.numeric(as.Date('2010-12-31'))

date_list <- as.Date(seq(day_1, day_T), origin = as.Date('1970-01-01'))

length(date_list)
min(date_list)
max(date_list)


# Get dimensions from product of sex and age groups. 
age_group_list <- c('0-15', '16-19', '20-24', '25-34', '35-44', '45-54', 
                    '55-64', '65-74', '75-84', '85-89', '90-199')

num_rows <- length(date_list)*length(age_group_list)*2


# Define columns as in saaq dataset. 
# > colnames(saaq)
# [1] "seq"     "sex"     "dob_yr"  "dob_mo"  "dob_day" "dinf"    "points" 
# [8] "dcon"    "age"     "age_grp"
# > 

# Initialize a data frame for all the drivers without tickets each day. 
no_tickets_df <- data.frame(dinf = rep(date_list, 
                                       each = length(age_group_list)*2),
                            seq = rep(0, num_rows),
                            age_grp = rep(age_group_list, 
                                          length(date_list)*2),
                            sex = rep(rep(c('F', 'M'), 
                                          each = length(age_group_list)), 
                                      length(date_list)),
                            points = rep(0, num_rows),
                            num = rep(NA, num_rows))

summary(no_tickets_df)
head(no_tickets_df, 25)
tail(no_tickets_df, 25)


# Populate the number of licensed drivers by category. 


# Initialize counts with year 2000 totals for previous years. 
this_year <- 2000
next_june_counts <- annual[annual[, 'age_group'] != 'Total' & 
                              annual[, 'sex'] != 'T', 
                            sprintf('yr_%d', this_year)]
last_june_counts <- next_june_counts


for (date_num in 1:length(date_list)) {
  
  this_date <- date_list[date_num]
  this_year <- year(this_date)
  this_month <- month(this_date)
  this_day <- mday(this_date)
  
  # Print a progress report.
  if (this_day == 1 & this_month == 1) {
    print(sprintf('Now counting drivers in year %d.', this_year))
  }
  
  # Select rows to be modified. 
  row_nums <- seq((date_num - 1)*length(age_group_list)*2 + 1, 
                  date_num*length(age_group_list)*2)
  
  # Constant totals at earliest recorded date. 
  if (this_date <= date_list[year(date_list) == 2000 &
                             month(date_list) == 6 &
                             mday(date_list) == 1]) { # Before "2000-06-01"
    
    no_tickets_df[row_nums, 'num'] <- next_june_counts
    
  } else {
    
    # Calculate weighted average of day. 
    next_june_wt <- as.numeric(this_date - last_june_date) / 
      as.numeric(next_june_date - last_june_date)
    
    # Calculate the weighted average of counts.
    this_date_counts <- next_june_wt*next_june_counts + 
      (1 - next_june_wt)*last_june_counts
    
    no_tickets_df[row_nums, 'num'] <- this_date_counts
    
  }
  
  
  # Evey June 1, refresh the totals. 
  if (this_month == 6 & this_day == 1 & this_year >= 2000) {
    
    last_june_counts <- next_june_counts
    
    next_june_counts <- annual[annual[, 'age_group'] != 'Total' & 
                                  annual[, 'sex'] != 'T', 
                                sprintf('yr_%d', this_year)]
    
    last_june_date <- this_date
    if (this_year == 2010) {
      # Next june not in date_list.
      next_june_date <- as.Date('2011-06-01')
      
    } else {
      next_june_date <- date_list[year(date_list) == (this_year + 1) &
                                    month(date_list) == 6 &
                                    mday(date_list) == 1]
    }
    
  }
  
  
  
}


# Now do some tests to check. 



# Plot the age group counts over time. 

# Note the kinks on June 1, every year. 


################################################################################
# Output Daily Driver Counts
################################################################################


################################################################################
# End
################################################################################

