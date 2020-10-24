################################################################################
#
# Investigation of SAAQ Traffic Ticket Violations
#
# Logistic and linear probability models of numbers of tickets awarded by the
# number of points per ticket.
#
#
#
# Lee Morin, Ph.D.
# Assistant Professor
# Department of Economics
# College of Business Administration
# University of Central Florida
#
# October 24, 2020
#
################################################################################
#
# Load data from traffic violations, and licensee data.
# Aggregated data by demerit point value for each date, sex and age category.
# Estimate linear probability models for sets of offenses.
# Identify discontinuity from policy change on April 1, 2008.
# Excessive speeding offenses were assigned double demerit points.
#
# This version includes a number of modifications for a revise and resubmit decision.
# It contains the full estimation results to appear in the manuscript.
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


# Set directory for results in GitHub repo.
git_path <- "~/Research/SAAQ/SAAQspeeding/Hidden_Comp_Risks/R_and_R"
md_dir <- sprintf("%s/results", git_path)



# Identify file of estimation results.
estn_version <- 1
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)


# Set directory for Tables.
tab_dir <- sprintf("%s/Tables", git_path)


################################################################################
# Load Data
################################################################################

# Obtain file of estimation results.
estn_results <- read.csv(file = estn_file_path)

summary(estn_results)



################################################################################
# Define functions and tables required
################################################################################

p_val_stars <- function(p_value) {
  if (p_value < 0.00001) {
    star_str <- ' **'
  } else if (p_value < 0.001) {
    star_str <- '  *'
  } else {
    star_str <- '   '
  }
}

age_int_label_list <- data.frame(Variable = )


################################################################################
# Organize estimates into tables
################################################################################

# Table 3 in the paper:
# Regressions


# Collect estimates into table.

results_sel <- estn_results[, 'past_pts'] == 'all' &
  estn_results[, 'window'] == '4 yr.' &
  estn_results[, 'seasonality'] == 'excluded' &
  estn_results[, 'age_int'] %in% c('no', 'with') &
  estn_results[, 'pts_target'] == 'all' &
  estn_results[, 'reg_type'] == 'LPM' &
  (substr(estn_results[, 'Variable'], 1, 6) == 'policy')
estn_results_tab <- estn_results[results_sel, ]
                                 # c('Estimate', 'Std_Error')]


# Create TeX file for Table.
tab_file_name <- 'orig_regs.tex'
tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)

cat('% Linear Probability Models: Original Specification \n\n',
    file = tab_file_path, append = FALSE)
cat('\\begin{table}% [ht] \n', file = tab_file_path, append = TRUE)
cat('\\centering \n', file = tab_file_path, append = TRUE)
cat('\\begin{tabular}{l r r l r r l} \n', file = tab_file_path, append = TRUE)

cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

cat(" & Estimate & Std. Error & Sig. & Estimate & Std. Error & Sig. \\\\",
    file = tab_file_path, append = TRUE)
cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)


for (sex_sel in sex_list) {

  # Print sample title in first line.
  if (sex_sel == 'All') {
    row_str <- 'Full sample'
  } else {
    row_str <- sex_sel
  }
  cat(sprintf('%s \\\\ \n', row_str), file = tab_file_path, append = TRUE)

  # Print first row with policy indicator from both models.
  # Model without age interactions.
  cat('Policy            ', file = tab_file_path, append = TRUE)
  est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                 estn_results_tab[, 'age_int'] == 'no' &
                                 estn_results_tab[, 'Variable'] == 'policyTRUE',
                               c('Estimate', 'Std_Error', 'p_value')]
  cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
  cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
  # Model with age interactions.
  est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                 estn_results_tab[, 'age_int'] == 'with' &
                                 estn_results_tab[, 'Variable'] == 'policyTRUE',
                               c('Estimate', 'Std_Error', 'p_value')]
  cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
  cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)

  # Remaining rows show only age interaction.
  for (age_int_var in age_int_label_list) {
    age_int_label <- age_int_label_list[age_int_var, ]
    cat(sprintf('%s            ', age_int_label), file = tab_file_path, append = TRUE)
  }


}

cat(' \n', file = tab_file_path, append = TRUE)
cat(' \n', file = tab_file_path, append = TRUE)








cat('\n\\hline  \n\n', file = tab_file_path, append = TRUE)
cat('\\end{tabular} \n', file = tab_file_path, append = TRUE)
cat('\\caption{Regressions} \n', file = tab_file_path, append = TRUE)
cat('\\label{tab:orig_regs} \n', file = tab_file_path, append = TRUE)
cat('\\end{table} \n \n', file = tab_file_path, append = TRUE)




################################################################################
# End
################################################################################

