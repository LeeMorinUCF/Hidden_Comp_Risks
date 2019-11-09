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



################################################################################
# Analyse Groups of Related Offences
################################################################################


# Set parameters for tables.
april_fools_2008 <- '2008-04-01'
# No joke: policy change on April Fool's Day!

# Generae an indicator for the policy change. 
saaq_agg[, 'policy'] <- saaq_agg[, 'dinf'] > april_fools_2008



##################################################
# PLots of numbers of offences over time.
##################################################







##################################################
# End
##################################################
