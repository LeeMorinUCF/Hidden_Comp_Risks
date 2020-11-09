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
# This version also creates a function for each table to enable
# quick replacement of tables for sensitivity analysis.
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



# Set directory for Tables.
tab_dir <- sprintf("%s/Tables", git_path)


################################################################################
# Load Estimates for Tables.
################################################################################

# Obtain files of estimation results.
# Base case: All drivers.
estn_version <- 1
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_1 <- read.csv(file = estn_file_path)
summary(estn_results_1)

# High-point drivers
estn_version <- 2
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_2 <- read.csv(file = estn_file_path)
summary(estn_results_2)


# Placebo regressions
estn_version <- 3
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_3 <- read.csv(file = estn_file_path)
summary(estn_results_3)


# Monthly seasonality
# estn_version <- 4

# Monthly and weekday seasonality
estn_version <- 5
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_5 <- read.csv(file = estn_file_path)
summary(estn_results_5)

# Sensitivity Analysis: REAL event study with seasonality
# estn_version <- 6

# Seasonal model with High-point drivers
estn_version <- 7
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_7 <- read.csv(file = estn_file_path)
summary(estn_results_7)


# Placebo regressions with seasonal model
estn_version <- 8
estn_file_name <- sprintf('estimates_v%d.csv', estn_version)
estn_file_path <- sprintf('%s/%s', md_dir, estn_file_name)
estn_results_8 <- read.csv(file = estn_file_path)
summary(estn_results_8)







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

single_point_reg_table <- function(tab_file_path, estn_results_tab,
                                   header, caption, description, label,
                                   sex_list,
                                   age_int_label_list,
                                   obsn_str_list,
                                   num_fmt = 'science') {
  cat(sprintf('%% %s \n\n', header),
      file = tab_file_path, append = FALSE)
  cat('\\begin{table}% [ht] \n', file = tab_file_path, append = TRUE)
  cat('\\centering \n', file = tab_file_path, append = TRUE)
  cat('\\begin{tabular}{l r r l r r l} \n', file = tab_file_path, append = TRUE)

  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  cat(" & Estimate & Std. Error & Sig. & Estimate & Std. Error & Sig. \\\\ \n",
      file = tab_file_path, append = TRUE)
  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  for (sex_sel in sex_list) {

    # Print sample title in first line.
    if (sex_sel == 'All') {
      row_str <- 'Full sample'
    } else {
      row_str <- sex_sel
    }
    cat(sprintf('\\textbf{%s} \\\\ \n\n', row_str), file = tab_file_path, append = TRUE)

    # Print first row with policy indicator from both models.
    # Model without age interactions.
    cat('Policy            ', file = tab_file_path, append = TRUE)
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    # Model with age interactions.
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'with' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    cat(' \\\\ \n', file = tab_file_path, append = TRUE)
    # Remaining rows show only age interaction.
    for (age_int_num in 1:nrow(age_int_label_list)) {
      age_int_var <- age_int_label_list[age_int_num, 'Variable']
      age_int_label <- age_int_label_list[age_int_num, 'Label']
      cat(sprintf('%s           & & & ', age_int_label), file = tab_file_path, append = TRUE)
      est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                     estn_results_tab[, 'age_int'] == 'with' &
                                     estn_results_tab[, 'Variable'] == age_int_var,
                                   c('Estimate', 'Std_Error', 'p_value')]
      if (num_fmt == 'science') {
        cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else if (num_fmt %in% c('num', 'x100K')) {
        cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else {
        stop(sprintf('Number format %s not recognized.', num_fmt))
      }
      cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
      cat(' \\\\ \n', file = tab_file_path, append = TRUE)
    }

    # Print divider between subsamples.
    obsn_str <- obsn_str_list[sex_sel]
    cat(sprintf('Observations & %s \\\\ \n\n', obsn_str), file = tab_file_path, append = TRUE)
    cat('\n\\hline \n\n', file = tab_file_path, append = TRUE)

  }

  cat('\\end{tabular} \n', file = tab_file_path, append = TRUE)
  cat(sprintf('\\caption{%s} \n', caption), file = tab_file_path, append = TRUE)
  cat('All regressions contain age category and demerit point category controls. \n', file = tab_file_path, append = TRUE)
  cat('The symbol * denotes statistical significance at the 0.1\\% level \n', file = tab_file_path, append = TRUE)
  cat('and ** the 0.001\\% level. \n', file = tab_file_path, append = TRUE)
  cat('``Sig.\'\' is an abbreviation for statistical significance. \n', file = tab_file_path, append = TRUE)
  for (desc_row in 1:length(description)) {
    cat(sprintf('%s \n', description[desc_row]), file = tab_file_path, append = TRUE)
  }
  cat(sprintf('\\label{%s} \n', label), file = tab_file_path, append = TRUE)
  cat('\\end{table} \n \n', file = tab_file_path, append = TRUE)

}



single_point_LPM_logit_table <- function(tab_file_path, estn_results_tab,
                                         header, caption, description, label,
                                         sex_list,
                                         age_int_label_list,
                                         obsn_str_list,
                                         num_fmt = 'science') {
  cat(sprintf('%% %s \n\n', header),
      file = tab_file_path, append = FALSE)
  cat('\\begin{table}% [ht] \n', file = tab_file_path, append = TRUE)
  cat('\\centering \n', file = tab_file_path, append = TRUE)
  cat('\\begin{tabular}{l r r l r r l} \n', file = tab_file_path, append = TRUE)

  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  cat(" & \\multicolumn{3}{c}{Logistic Regression} ",
      file = tab_file_path, append = TRUE)
  cat(" & \\multicolumn{3}{c}{Linear Probability Model} \\\\ \n",
      file = tab_file_path, append = TRUE)

  cat('\n \\cmidrule(lr){2-4}\\cmidrule(lr){5-7} \n', file = tab_file_path, append = TRUE)


  cat(" & Estimate & Std. Error & Sig. & Estimate & Std. Error & Sig. \\\\ \n",
      file = tab_file_path, append = TRUE)
  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  # for (sex_sel in sex_list) {
  for (sex_sel in sex_list[2:length(sex_list)]) {

    # Print sample title in first line.
    if (sex_sel == 'All') {
      row_str <- 'Full sample'
    } else {
      row_str <- sex_sel
    }
    # Print number of observations in header.
    obsn_str <- obsn_str_list[sex_sel]

    cat(sprintf('\\multicolumn{7}{l}{\\textbf{%s Drivers} (%s observations)} \\\\ \n\n',
                row_str, obsn_str), file = tab_file_path, append = TRUE)

    #------------------------------------------------------------
    # Print first row with policy indicator from both regression types.
    # Logit model without age interactions.
    #------------------------------------------------------------
    row_str <- 'Model without age-policy interaction: '
    cat(sprintf('\\hline\n\\multicolumn{7}{l}{%s} \\\\ \n', row_str), file = tab_file_path, append = TRUE)
    cat('Policy                  ', file = tab_file_path, append = TRUE)
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'reg_type'] == 'Logit' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    # Print logit results directly.
    cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # if (num_fmt == 'science') {
    #   cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # } else if (num_fmt %in% c('num', 'x100K')) {
    #   cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # } else {
    #   stop(sprintf('Number format %s not recognized.', num_fmt))
    # }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    # LPM model without age interactions.
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   # estn_results_tab[, 'age_int'] == 'with' &
                                   estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'reg_type'] == 'LPM' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    cat(' \\\\ \n', file = tab_file_path, append = TRUE)

    #------------------------------------------------------------
    # Print first row with policy indicator from both regression types.
    # Logit model with age interactions.
    #------------------------------------------------------------
    row_str <- 'Model with age-policy interaction: '
    cat(sprintf('\\hline\n\\multicolumn{7}{l}{%s} \\\\ \n', row_str), file = tab_file_path, append = TRUE)
    cat('Policy                  ', file = tab_file_path, append = TRUE)
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'with' &
                                   # estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'reg_type'] == 'Logit' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    # Print logit results directly.
    cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # if (num_fmt == 'science') {
    #   cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # } else if (num_fmt %in% c('num', 'x100K')) {
    #   cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    # } else {
    #   stop(sprintf('Number format %s not recognized.', num_fmt))
    # }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    # LPM model with age interactions.
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'with' &
                                   # estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'reg_type'] == 'LPM' &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    cat(' \\\\ \n', file = tab_file_path, append = TRUE)


    # Remaining rows show only age interaction.
    for (age_int_num in 1:nrow(age_int_label_list)) {
      age_int_var <- age_int_label_list[age_int_num, 'Variable']
      age_int_label <- age_int_label_list[age_int_num, 'Label']
      # cat(sprintf('%s           & & & ', age_int_label), file = tab_file_path, append = TRUE)


      #------------------------------------------------------------
      # Logit model with age interactions.
      #------------------------------------------------------------
      cat(sprintf('%s  ', age_int_label), file = tab_file_path, append = TRUE)
      est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                     estn_results_tab[, 'age_int'] == 'with' &
                                     estn_results_tab[, 'reg_type'] == 'Logit' &
                                     estn_results_tab[, 'Variable'] == age_int_var,
                                   c('Estimate', 'Std_Error', 'p_value')]
      # Print logit results directly.
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # if (num_fmt == 'science') {
      #   cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # } else if (num_fmt %in% c('num', 'x100K')) {
      #   cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # } else {
      #   stop(sprintf('Number format %s not recognized.', num_fmt))
      # }
      cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
      #------------------------------------------------------------


      #------------------------------------------------------------
      # LPM model with age interactions.
      #------------------------------------------------------------
      # cat(sprintf('%s  ', age_int_label), file = tab_file_path, append = TRUE)
      est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                     estn_results_tab[, 'age_int'] == 'with' &
                                     estn_results_tab[, 'reg_type'] == 'LPM' &
                                     estn_results_tab[, 'Variable'] == age_int_var,
                                   c('Estimate', 'Std_Error', 'p_value')]
      if (num_fmt == 'science') {
        cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else if (num_fmt %in% c('num', 'x100K')) {
        cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else {
        stop(sprintf('Number format %s not recognized.', num_fmt))
      }
      cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
      #------------------------------------------------------------

      cat(' \\\\ \n', file = tab_file_path, append = TRUE)

    }

    # Print divider between subsamples.
    # obsn_str <- obsn_str_list[sex_sel]
    # cat(sprintf('Observations & \\multicolumn{2}{c}{%s} \\\\ \n\n', obsn_str),
    #     file = tab_file_path, append = TRUE)
    cat('\n\\hline \n\n', file = tab_file_path, append = TRUE)

  }

  cat('\\end{tabular} \n', file = tab_file_path, append = TRUE)
  cat(sprintf('\\caption{%s} \n', caption), file = tab_file_path, append = TRUE)
  cat('All regressions contain age category and demerit point category controls. \n', file = tab_file_path, append = TRUE)
  cat('The symbol * denotes statistical significance at the 0.1\\% level \n', file = tab_file_path, append = TRUE)
  cat('and ** the 0.001\\% level. \n', file = tab_file_path, append = TRUE)
  cat('``Sig.\'\' is an abbreviation for statistical significance. \n', file = tab_file_path, append = TRUE)
  for (desc_row in 1:length(description)) {
    cat(sprintf('%s \n', description[desc_row]), file = tab_file_path, append = TRUE)
  }
  cat(sprintf('\\label{%s} \n', label), file = tab_file_path, append = TRUE)
  cat('\\end{table} \n \n', file = tab_file_path, append = TRUE)

}


multi_point_reg_table <- function(tab_file_path, estn_results_tab,
                                  header, caption, description, label,
                                  points_label_list,
                                  obsn_str_list,
                                  num_fmt = 'science') {
  cat(sprintf('%% %s \n\n', header),
      file = tab_file_path, append = FALSE)
  cat('\\begin{table}% [ht] \n', file = tab_file_path, append = TRUE)
  cat('\\centering \n', file = tab_file_path, append = TRUE)
  cat('\\begin{tabular}{l r r l r r l} \n', file = tab_file_path, append = TRUE)

  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  cat(" & \\multicolumn{3}{c}{Males} & \\multicolumn{3}{c}{Females} \\\\ \n",
      file = tab_file_path, append = TRUE)

  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  cat(" & Estimate & Std. Error & Sig. & Estimate & Std. Error & Sig. \\\\ \n",
      file = tab_file_path, append = TRUE)
  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  for (pts_target_num in 1:nrow(points_label_list)) {

    pts_target <- points_label_list[pts_target_num, 'Variable']
    pts_target_label <- points_label_list[pts_target_num, 'Label']
    pts_target_str <- substr(sprintf('%s %s', pts_target_label,
                                     paste(rep(' ', 30), collapse = '')), 1, 30)

    # Print row with policy indicator from both models.
    # Model for male drivers.
    sex_sel <- 'Male'
    cat(sprintf('%s ', pts_target_str), file = tab_file_path, append = TRUE)
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'pts_target'] == pts_target &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    # Model for female drivers.
    sex_sel <- 'Female'
    est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                   estn_results_tab[, 'age_int'] == 'no' &
                                   estn_results_tab[, 'pts_target'] == pts_target &
                                   estn_results_tab[, 'Variable'] == 'policyTRUE',
                                 c('Estimate', 'Std_Error', 'p_value')]
    if (num_fmt == 'science') {
      cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else if (num_fmt %in% c('num', 'x100K')) {
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
    } else {
      stop(sprintf('Number format %s not recognized.', num_fmt))
    }
    cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
    cat(' \\\\ \n', file = tab_file_path, append = TRUE)

  }

  # Print sample sizes at bottom.
  sex_sel <- 'Male'
  obsn_str <- obsn_str_list[sex_sel]
  cat(sprintf('Observations            & %s    &          &         ', obsn_str),
      file = tab_file_path, append = TRUE)
  sex_sel <- 'Female'
  obsn_str <- obsn_str_list[sex_sel]
  cat(sprintf('     &  %s \\\\ \n\n', obsn_str), file = tab_file_path, append = TRUE)
  cat('\n\\hline \n\n', file = tab_file_path, append = TRUE)

  cat('\\end{tabular} \n', file = tab_file_path, append = TRUE)
  cat(sprintf('\\caption{%s} \n', caption), file = tab_file_path, append = TRUE)
  cat('All regressions contain age category and demerit point category controls. \n', file = tab_file_path, append = TRUE)
  cat('The symbol * denotes statistical significance at the 0.1\\% level \n', file = tab_file_path, append = TRUE)
  cat('and ** the 0.001\\% level. \n', file = tab_file_path, append = TRUE)
  cat('``Sig.\'\' is an abbreviation for statistical significance. \n', file = tab_file_path, append = TRUE)
  for (desc_row in 1:length(description)) {
    cat(sprintf('%s \n', description[desc_row]), file = tab_file_path, append = TRUE)
  }
  cat(sprintf('\\label{%s} \n', label), file = tab_file_path, append = TRUE)
  cat('\\end{table} \n \n', file = tab_file_path, append = TRUE)
}





multi_point_LPM_logit_table <- function(tab_file_path, estn_results_tab,
                                  header, caption, description, label,
                                  points_label_list,
                                  obsn_str_list,
                                  num_fmt = 'science') {
  cat(sprintf('%% %s \n\n', header),
      file = tab_file_path, append = FALSE)
  cat('\\begin{table}% [ht] \n', file = tab_file_path, append = TRUE)
  cat('\\centering \n', file = tab_file_path, append = TRUE)
  cat('\\begin{tabular}{l r r l r r l} \n', file = tab_file_path, append = TRUE)

  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)

  cat(" & \\multicolumn{3}{c}{Logistic Regression} ",
      file = tab_file_path, append = TRUE)
  cat(" & \\multicolumn{3}{c}{Linear Probability Model} \\\\ \n",
      file = tab_file_path, append = TRUE)

  cat('\n \\cmidrule(lr){2-4}\\cmidrule(lr){5-7} \n', file = tab_file_path, append = TRUE)

  cat(" & Estimate & Std. Error & Sig. & Estimate & Std. Error & Sig. \\\\ \n",
      file = tab_file_path, append = TRUE)
  cat('\n\\hline \n \n', file = tab_file_path, append = TRUE)
  for (sex_sel in sex_list[2:length(sex_list)]) {


    # Print sample title in first line.
    if (sex_sel == 'All') {
      row_str <- 'Full sample'
    } else {
      row_str <- sex_sel
    }
    # cat(sprintf('\\textbf{%s Drivers} \\\\ \n\\hline\n', row_str), file = tab_file_path, append = TRUE)

    # Print number of observations in header.
    obsn_str <- obsn_str_list[sex_sel]

    cat(sprintf('\\multicolumn{7}{l}{\\textbf{%s Drivers} (%s observations)} \\\\ \n\n',
                row_str, obsn_str), file = tab_file_path, append = TRUE)


    for (pts_target_num in 1:nrow(points_label_list)) {

      pts_target <- points_label_list[pts_target_num, 'Variable']
      pts_target_label <- points_label_list[pts_target_num, 'Label']
      pts_target_str <- substr(sprintf('%s %s', pts_target_label,
                                       paste(rep(' ', 30), collapse = '')), 1, 30)



      #------------------------------------------------------------
      # Logit model with age interactions.
      #------------------------------------------------------------
      # Print row with policy indicator from both models.
      cat(sprintf('%s ', pts_target_str), file = tab_file_path, append = TRUE)
      est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                     estn_results_tab[, 'age_int'] == 'no' &
                                     estn_results_tab[, 'reg_type'] == 'Logit' &
                                     estn_results_tab[, 'pts_target'] == pts_target &
                                     estn_results_tab[, 'Variable'] == 'policyTRUE',
                                   c('Estimate', 'Std_Error', 'p_value')]
      # Print logit results directly.
      cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # if (num_fmt == 'science') {
      #   cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # } else if (num_fmt %in% c('num', 'x100K')) {
      #   cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      # } else {
      #   stop(sprintf('Number format %s not recognized.', num_fmt))
      # }
      cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])),
          file = tab_file_path, append = TRUE)
      #------------------------------------------------------------


      #------------------------------------------------------------
      # Linear probability model with age interactions.
      #------------------------------------------------------------
      est_se_p <- estn_results_tab[estn_results_tab[, 'sex'] == sex_sel &
                                     estn_results_tab[, 'age_int'] == 'no' &
                                     estn_results_tab[, 'reg_type'] == 'LPM' &
                                     estn_results_tab[, 'pts_target'] == pts_target &
                                     estn_results_tab[, 'Variable'] == 'policyTRUE',
                                   c('Estimate', 'Std_Error', 'p_value')]
      if (num_fmt == 'science') {
        cat(sprintf(' &  %5.2E      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else if (num_fmt %in% c('num', 'x100K')) {
        cat(sprintf(' &  %6.4f      ', est_se_p[1:2]), file = tab_file_path, append = TRUE)
      } else {
        stop(sprintf('Number format %s not recognized.', num_fmt))
      }
      cat(sprintf(' &  %s      ', p_val_stars(p_value = est_se_p[3])), file = tab_file_path, append = TRUE)
      cat(' \\\\ \n', file = tab_file_path, append = TRUE)
      #------------------------------------------------------------

    }

    # Print sample sizes at bottom.
    # obsn_str <- obsn_str_list[sex_sel]
    # cat(sprintf('Observations            & \\multicolumn{2}{c}{%s} \\\\\n         ', obsn_str),
    #     file = tab_file_path, append = TRUE)

    cat('\n\\hline \n\n', file = tab_file_path, append = TRUE)
  }

  cat('\\end{tabular} \n', file = tab_file_path, append = TRUE)
  cat(sprintf('\\caption{%s} \n', caption), file = tab_file_path, append = TRUE)
  cat('All regressions contain age category and demerit point category controls. \n', file = tab_file_path, append = TRUE)
  cat('The symbol * denotes statistical significance at the 0.1\\% level \n', file = tab_file_path, append = TRUE)
  cat('and ** the 0.001\\% level. \n', file = tab_file_path, append = TRUE)
  cat('``Sig.\'\' is an abbreviation for statistical significance. \n', file = tab_file_path, append = TRUE)
  for (desc_row in 1:length(description)) {
    cat(sprintf('%s \n', description[desc_row]), file = tab_file_path, append = TRUE)
  }
  cat(sprintf('\\label{%s} \n', label), file = tab_file_path, append = TRUE)
  cat('\\end{table} \n \n', file = tab_file_path, append = TRUE)
}








SAAQ_reg_table_gen <- function(tab_tag, header_spec, reg_type, season_incl, num_fmt,
                               estn_results_full, estn_results_high, estn_results_placebo,
                               age_int_label_list, points_label_list, sex_list,
                               orig_description, orig_pts_description) {

  # Original settings
  if (reg_type == 'LPM') {
    header_model <- 'Linear Probability Models'
    orig_description[2] <- "Heteroskedasticity-robust errors are employed."
    orig_pts_description[2] <- "Heteroskedasticity-robust errors are employed."
  } else if (reg_type == 'Logit') {
    header_model <- 'Logistic Regression Models'
    orig_description[2] <- "Logistic regression model."
    orig_pts_description[2] <- "Logistic regression model."
  }

  if (num_fmt == 'x100K') {
    estn_results_full[, c('Estimate', 'Std_Error')] <-
      estn_results_full[, c('Estimate', 'Std_Error')]*100000
    estn_results_high[, c('Estimate', 'Std_Error')] <-
      estn_results_high[, c('Estimate', 'Std_Error')]*100000
    estn_results_placebo[, c('Estimate', 'Std_Error')] <-
      estn_results_placebo[, c('Estimate', 'Std_Error')]*100000

    num_fmt_tag <- 'multiplied by 100,000'
  } else if (num_fmt == 'science') {
    num_fmt_tag <- 'in scientific notation'
  } else if (num_fmt == 'num') {
    num_fmt_tag <- 'in general number format'
  }


  orig_description[1] <- sprintf('Estimates and standard errors are %s.', num_fmt_tag)
  orig_pts_description[1] <- sprintf('Estimates and standard errors are %s.', num_fmt_tag)



  #--------------------------------------------------
  # Table 3 in the paper:
  # Regressions
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_full <- c('9,675,245,494', '5,335,033,221', '4,340,212,273')
  names(obsn_str_list_full) <- sex_list

  # Collect estimates into table.
  results_sel <- estn_results_full[, 'past_pts'] == 'all' &
    estn_results_full[, 'window'] == '4 yr.' &
    estn_results_full[, 'seasonality'] == season_incl &
    estn_results_full[, 'age_int'] %in% c('no', 'with') &
    estn_results_full[, 'pts_target'] == 'all' &
    estn_results_full[, 'reg_type'] == reg_type &
    (substr(estn_results_full[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_full[results_sel, ]



  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)



  single_point_reg_table(tab_file_path, estn_results_tab,
                         header = sprintf('%s: %s Specification',
                                          header_model, header_spec),
                         caption = sprintf('Regressions (%s)', header_spec),
                         description = orig_description,
                         label = sprintf('tab:%s_regs', tab_tag),
                         sex_list,
                         age_int_label_list,
                         obsn_str_list_full,
                         num_fmt)



  #--------------------------------------------------
  # Table 5 in the paper:
  # Regressions for high point drivers
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_high <- c('1,170,426,426', '921,131,812', '249,294,614')
  names(obsn_str_list_high) <- sex_list


  # Collect estimates into table.
  # unique(estn_results_high[, 2:8])

  results_sel <- estn_results_high[, 'past_pts'] == 'high' &
    estn_results_high[, 'window'] == '4 yr.' &
    estn_results_high[, 'seasonality'] == season_incl &
    estn_results_high[, 'age_int'] %in% c('no', 'with') &
    estn_results_high[, 'pts_target'] == 'all' &
    estn_results_high[, 'reg_type'] == reg_type &
    (substr(estn_results_high[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_high[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_high_pt_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)



  single_point_reg_table(tab_file_path, estn_results_tab,
                         header = sprintf('%s: %s High-Point Subsample',
                                          header_model, header_spec),
                         caption = sprintf('Regressions for high-point drivers (%s)',
                                           header_spec),
                         description = orig_description,
                         label = sprintf('tab:%s_high_pt_regs', tab_tag),
                         sex_list,
                         age_int_label_list,
                         obsn_str_list_high,
                         num_fmt)



  #--------------------------------------------------
  # Table 6 in the paper:
  # Placebo regressions
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_placebo <- c('4,728,750,336', '2,618,869,394', '2,109,880,942 ')
  names(obsn_str_list_placebo) <- sex_list

  # Collect estimates into table.
  # unique(estn_results_placebo[, 2:8])

  results_sel <- estn_results_placebo[, 'past_pts'] == 'all' &
    estn_results_placebo[, 'window'] == 'Placebo' &
    estn_results_placebo[, 'seasonality'] == season_incl &
    estn_results_placebo[, 'age_int'] %in% c('no', 'with') &
    estn_results_placebo[, 'pts_target'] == 'all' &
    estn_results_placebo[, 'reg_type'] == reg_type &
    (substr(estn_results_placebo[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_placebo[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_placebo_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)



  single_point_reg_table(tab_file_path, estn_results_tab,
                         header = sprintf('%s: %s Placebo Specification',
                                          header_model, header_spec),
                         caption = sprintf('Placebo regressions (%s)', header_spec),
                         description = orig_description,
                         label = sprintf('tab:%s_placebo_regs', tab_tag),
                         sex_list,
                         age_int_label_list,
                         obsn_str_list_placebo,
                         num_fmt)



  #--------------------------------------------------
  # Table 4 in the paper:
  # Regressions by ticket point value
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_full <- c('9,675,245,494', '5,335,033,221', '4,340,212,273')
  names(obsn_str_list_full) <- sex_list

  # Collect estimates into table.
  results_sel <- estn_results_full[, 'past_pts'] == 'all' &
    estn_results_full[, 'window'] == '4 yr.' &
    estn_results_full[, 'seasonality'] == season_incl &
    estn_results_full[, 'age_int'] %in% c('no') &
    # estn_results_full[, 'pts_target'] != 'all' &
    estn_results_full[, 'reg_type'] == reg_type &
    estn_results_full[, 'Variable'] == 'policyTRUE'
  estn_results_tab <- estn_results_full[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_regs_by_points.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)




  multi_point_reg_table(tab_file_path, estn_results_tab,
                        header = sprintf('%s: %s Specification by Point Value',
                                         header_model, header_spec),
                        caption = sprintf('Regressions by ticket-point value (%s)',
                                          header_spec),
                        description = orig_pts_description,
                        label = sprintf('tab:%s_regs_by_points', tab_tag),
                        points_label_list,
                        obsn_str_list_full,
                        num_fmt)


  #--------------------------------------------------
  # New table not yet in the paper:
  # Regressions by ticket point value for high-point drivers
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_high <- c('1,170,426,426', '921,131,812', '249,294,614')
  names(obsn_str_list_high) <- sex_list


  results_sel <- estn_results_high[, 'past_pts'] == 'high' &
    estn_results_high[, 'window'] == '4 yr.' &
    estn_results_high[, 'seasonality'] == season_incl &
    estn_results_high[, 'age_int'] %in% c('no') &
    # estn_results_full[, 'pts_target'] != 'all' &
    estn_results_high[, 'reg_type'] == reg_type &
    estn_results_high[, 'Variable'] == 'policyTRUE'
  estn_results_tab <- estn_results_high[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_high_pt_regs_by_points.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  multi_point_reg_table(tab_file_path, estn_results_tab,
                        header = sprintf('%s: %s Specification for High-Point Drivers by Point Value',
                                         header_model, header_spec),
                        caption = sprintf('Regressions for high-point drivers by ticket-point value (%s)',
                                          header_spec),
                        description = orig_pts_description,
                        label = sprintf('tab:%s_regs_by_points', tab_tag),
                        points_label_list,
                        obsn_str_list_high,
                        num_fmt)

}





################################################################################
# Define lists required for tables
################################################################################


# Create list of labels for policy*age interactions.
age_int_var_list <- unique(estn_results_1[substr(estn_results_1[, 'Variable'], 1, 18) ==
                                          'policyTRUE:age_grp', 'Variable'])
age_int_label_list <- data.frame(Variable = age_int_var_list,
                                 Label = c('Age 16-19 * policy',
                                           'Age 20-24 * policy',
                                           'Age 25-34 * policy',
                                           'Age 35-44 * policy',
                                           'Age 45-54 * policy',
                                           'Age 55-64 * policy',
                                           'Age 65+ * policy'))


orig_description <- c(
  "Estimates and standard errors are in scientific notation.",
  "Heteroskedasticity-robust errors are employed.",
  "The baseline age category comprises drivers under the age of 16."
)

# Create list of labels for policy*age interactions.
points_var_list <- unique(estn_results_1[, 'pts_target'])
points_label_list <- data.frame(Variable = points_var_list,
                                Label = c('All point values',
                                          '1 points',
                                          '2 points',
                                          '3 points',
                                          '4 points',
                                          '5 points',
                                          '7 points',
                                          '9 or more points'))


orig_pts_description <- c(
  "Estimates and standard errors are in scientific notation.",
  "Heteroskedasticity-robust errors are employed.",
  "The baseline age category comprises drivers under the age of 16.",
  "The 5 point category of tickets includes 10 point tickets after the policy change, ",
  "the 7 point category includes 14 point tickets after the policy change, ",
  "and 9 or more point tickets include all possible doubled values for those tickets ",
  "worth more than 9 points after the policy change."
)




################################################################################
# Organize estimates into tables
################################################################################


# Settings for original version of tables:
tab_tag <- 'orig'
header_spec <- 'Original LPM'
reg_type <- 'LPM'
season_incl <- 'excluded'
num_fmt <- 'science'
estn_results_full <- estn_results_1
estn_results_high <- estn_results_2
estn_results_placebo <- estn_results_3

SAAQ_reg_table_gen(tab_tag, header_spec, reg_type, season_incl, num_fmt,
                   estn_results_full, estn_results_high, estn_results_placebo,
                   age_int_label_list, points_label_list, sex_list,
                   orig_description, orig_pts_description)

# Settings for tables with seasonal model:
tab_tag <- 'seas'
header_spec <- 'Seasonal LPM'
reg_type <- 'LPM'
season_incl <- 'mnwk'
num_fmt <- 'science'
estn_results_full <- estn_results_5
estn_results_high <- estn_results_7
estn_results_placebo <- estn_results_8

SAAQ_reg_table_gen(tab_tag, header_spec, reg_type, season_incl, num_fmt,
                   estn_results_full, estn_results_high, estn_results_placebo,
                   age_int_label_list, points_label_list, sex_list,
                   orig_description, orig_pts_description)


# Settings for tables with seasonal model (Logit):
tab_tag <- 'seas_logit'
header_spec <- 'Seasonal Logit'
reg_type <- 'Logit'
season_incl <- 'mnwk'
num_fmt <- 'num'

SAAQ_reg_table_gen(tab_tag, header_spec, reg_type, season_incl, num_fmt,
                   estn_results_full, estn_results_high, estn_results_placebo,
                   age_int_label_list, points_label_list, sex_list,
                   orig_description, orig_pts_description)


# Settings for tables with seasonal model (x100K):
tab_tag <- 'seas_LPMx100K'
header_spec <- 'Seasonal LPM x 100K'
reg_type <- 'LPM'
season_incl <- 'mnwk'
num_fmt <- 'x100K'

SAAQ_reg_table_gen(tab_tag, header_spec, reg_type, season_incl, num_fmt,
                   estn_results_full, estn_results_high, estn_results_placebo,
                   age_int_label_list, points_label_list, sex_list,
                   orig_description, orig_pts_description)





#------------------------------------------------------------
# Testing prototype of Logit vs LPM tables
#------------------------------------------------------------



#
# # Create TeX file for Table.
# tab_tag <- 'seas_Logit_vs_LPMx100K'
# # tab_file_name <- sprintf('%s_regs.tex', tab_tag)
# # tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)
#
#
# header_spec <- 'Seasonal Logit and LPM x 100K'
# season_incl <- 'mnwk'
# num_fmt <- 'x100K'
#
# sex_list <- c('All', 'Male', 'Female')
#
#
# # Pass estimates.
# estn_results_full <- estn_results_5

#
# # Collect estimates into table.
# results_sel <- estn_results_full[, 'past_pts'] == 'all' &
#   estn_results_full[, 'window'] == '4 yr.' &
#   estn_results_full[, 'seasonality'] == season_incl &
#   estn_results_full[, 'age_int'] %in% c('no', 'with') &
#   estn_results_full[, 'pts_target'] == 'all' &
#   # estn_results_full[, 'reg_type'] == reg_type &
#   (substr(estn_results_full[, 'Variable'], 1, 6) == 'policy')
# estn_results_tab <- estn_results_full[results_sel, ]

#
# Logit_LPM_description <- c(
#   "In the linear probability model, estimates and standard errors are in scientific notation ",
#   "and heteroskedasticity-robust errors are employed.",
#   "The baseline age category comprises drivers under the age of 16."
# )



#
# # Temporary list of fixed numbers of observations.
# obsn_str_list_full <- c('9,675,245,494', '5,335,033,221', '4,340,212,273')
# names(obsn_str_list_full) <- sex_list
#
#
#
# if (num_fmt == 'x100K') {
#   estn_results_tab[estn_results_tab[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')] <-
#     estn_results_tab[estn_results_tab[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')]*100000
#
#   num_fmt_tag <- 'multiplied by 100,000'
# } else if (num_fmt == 'science') {
#   num_fmt_tag <- 'in scientific notation'
# } else if (num_fmt == 'num') {
#   num_fmt_tag <- 'in general number format'
# }
#
#
# Logit_LPM_description[1] <- sprintf('In the linear probability model, estimates and standard errors are %s ', num_fmt_tag)
#
#
#
# header_model <- 'Logistic Regression and Linear Probability Models'


# single_point_LPM_logit_table(tab_file_path, estn_results_tab,
#                              header = sprintf('%s: %s Specification for All Drivers by Point Value',
#                                               header_model, header_spec),
#                              caption = sprintf('Regressions for all drivers (%s)',
#                                                header_spec),
#                              description = Logit_LPM_description,
#                              label = sprintf('tab:%s_regs', tab_tag),
#                              sex_list,
#                              age_int_label_list,
#                              obsn_str_list = obsn_str_list_full,
#                              num_fmt)





#------------------------------------------------------------
# Testing multi-point table
#------------------------------------------------------------


# # Create TeX file for Table.
# tab_tag <- 'seas_Logit_vs_LPMx100K'
# # tab_file_name <- sprintf('%s_regs_by_points.tex', tab_tag)
# # tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)
#
#
# header_spec <- 'Seasonal Logit and LPM x 100K'
# season_incl <- 'mnwk'
# num_fmt <- 'x100K'




# # Collect estimates into table.
# results_sel <- estn_results_full[, 'past_pts'] == 'all' &
#   estn_results_full[, 'window'] == '4 yr.' &
#   estn_results_full[, 'seasonality'] == season_incl &
#   estn_results_full[, 'age_int'] %in% c('no') &
#   # estn_results_full[, 'pts_target'] != 'all' &
#   # estn_results_full[, 'reg_type'] == reg_type &
#   estn_results_full[, 'Variable'] == 'policyTRUE'
# estn_results_tab <- estn_results_full[results_sel, ]

#
# if (num_fmt == 'x100K') {
#   estn_results_tab[estn_results_tab[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')] <-
#     estn_results_tab[estn_results_tab[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')]*100000
#
#   num_fmt_tag <- 'multiplied by 100,000'
# } else if (num_fmt == 'science') {
#   num_fmt_tag <- 'in scientific notation'
# } else if (num_fmt == 'num') {
#   num_fmt_tag <- 'in general number format'
# }


# multi_point_LPM_logit_table(tab_file_path, estn_results_tab,
#                             header = sprintf('%s: %s Specification by Point Value',
#                                              header_model, header_spec),
#                             caption = sprintf('Regressions by ticket-point value (%s)',
#                                               header_spec),
#                             description = orig_pts_description,
#                             label = sprintf('tab:%s_regs_by_points', tab_tag),
#                             points_label_list,
#                             obsn_str_list = obsn_str_list_full,
#                             num_fmt)





SAAQ_Logit_vs_LPM_table_gen <- function(tab_tag, header_spec, season_incl, num_fmt,
                                        estn_results_full, estn_results_high, estn_results_placebo,
                                        age_int_label_list, points_label_list, sex_list,
                                        orig_description, orig_pts_description) {


  header_model <- 'Logistic Regression and Linear Probability Models'


  if (num_fmt == 'x100K') {
    estn_results_full[estn_results_full[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')] <-
      estn_results_full[estn_results_full[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')]*100000
    estn_results_high[estn_results_high[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')] <-
      estn_results_high[estn_results_high[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')]*100000
    estn_results_placebo[estn_results_placebo[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')] <-
      estn_results_placebo[estn_results_placebo[, 'reg_type'] == 'LPM', c('Estimate', 'Std_Error')]*100000

    num_fmt_tag <- 'multiplied by 100,000'
  } else if (num_fmt == 'science') {
    num_fmt_tag <- 'in scientific notation'
  } else if (num_fmt == 'num') {
    num_fmt_tag <- 'in general number format'
  }

  orig_description[1] <- sprintf('In the linear probability model, estimates and standard errors are %s ', num_fmt_tag)
  orig_pts_description[1] <- sprintf('In the linear probability model, estimates and standard errors are %s.', num_fmt_tag)



  #--------------------------------------------------
  # Table 3 in the paper:
  # Regressions
  #--------------------------------------------------


  # Temporary list of fixed numbers of observations.
  obsn_str_list_full <- c('9,675,245,494', '5,335,033,221', '4,340,212,273')
  names(obsn_str_list_full) <- sex_list


  # Collect estimates into table.
  results_sel <- estn_results_full[, 'past_pts'] == 'all' &
    estn_results_full[, 'window'] == '4 yr.' &
    estn_results_full[, 'seasonality'] == season_incl &
    estn_results_full[, 'age_int'] %in% c('no', 'with') &
    estn_results_full[, 'pts_target'] == 'all' &
    # estn_results_full[, 'reg_type'] == reg_type &
    (substr(estn_results_full[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_full[results_sel, ]



  tab_file_name <- sprintf('%s_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  single_point_LPM_logit_table(tab_file_path, estn_results_tab,
                               header = sprintf('%s: %s Specification for All Drivers by Point Value',
                                                header_model, header_spec),
                               caption = sprintf('Regressions for all drivers (%s)',
                                                 header_spec),
                               description = orig_description,
                               label = sprintf('tab:%s_regs', tab_tag),
                               sex_list,
                               age_int_label_list,
                               obsn_str_list = obsn_str_list_full,
                               num_fmt)


  #--------------------------------------------------
  # Table 5 in the paper:
  # Regressions for high point drivers
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_high <- c('1,170,426,426', '921,131,812', '249,294,614')
  names(obsn_str_list_high) <- sex_list


  results_sel <- estn_results_high[, 'past_pts'] == 'high' &
    estn_results_high[, 'window'] == '4 yr.' &
    estn_results_high[, 'seasonality'] == season_incl &
    estn_results_high[, 'age_int'] %in% c('no', 'with') &
    estn_results_high[, 'pts_target'] == 'all' &
    # estn_results_high[, 'reg_type'] == reg_type &
    (substr(estn_results_high[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_high[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_high_pt_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  single_point_LPM_logit_table(tab_file_path, estn_results_tab,
                               header = sprintf('%s: %s High-Point Subsample',
                                                header_model, header_spec),
                               caption = sprintf('Regressions for high-point drivers (%s)',
                                                 header_spec),
                               description = orig_description,
                               label = sprintf('tab:%s_high_pt_regs', tab_tag),
                               sex_list,
                               age_int_label_list,
                               obsn_str_list_high,
                               num_fmt)





  #--------------------------------------------------
  # Table 6 in the paper:
  # Placebo regressions
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_placebo <- c('4,728,750,336', '2,618,869,394', '2,109,880,942 ')
  names(obsn_str_list_placebo) <- sex_list


  results_sel <- estn_results_placebo[, 'past_pts'] == 'all' &
    estn_results_placebo[, 'window'] == 'Placebo' &
    estn_results_placebo[, 'seasonality'] == season_incl &
    estn_results_placebo[, 'age_int'] %in% c('no', 'with') &
    estn_results_placebo[, 'pts_target'] == 'all' &
    # estn_results_placebo[, 'reg_type'] == reg_type &
    (substr(estn_results_placebo[, 'Variable'], 1, 6) == 'policy')
  estn_results_tab <- estn_results_placebo[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_placebo_regs.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  single_point_LPM_logit_table(tab_file_path, estn_results_tab,
                               header = sprintf('%s: %s Placebo Specification',
                                                header_model, header_spec),
                               caption = sprintf('Placebo regressions (%s)', header_spec),
                               description = orig_description,
                               label = sprintf('tab:%s_placebo_regs', tab_tag),
                               sex_list,
                               age_int_label_list,
                               obsn_str_list_placebo,
                               num_fmt)



  #--------------------------------------------------
  # Table 4 in the paper:
  # Regressions by ticket point value
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_full <- c('9,675,245,494', '5,335,033,221', '4,340,212,273')
  names(obsn_str_list_full) <- sex_list

  # Collect estimates into table.
  results_sel <- estn_results_full[, 'past_pts'] == 'all' &
    estn_results_full[, 'window'] == '4 yr.' &
    estn_results_full[, 'seasonality'] == season_incl &
    estn_results_full[, 'age_int'] %in% c('no') &
    # estn_results_full[, 'pts_target'] != 'all' &
    # estn_results_full[, 'reg_type'] == reg_type &
    estn_results_full[, 'Variable'] == 'policyTRUE'
  estn_results_tab <- estn_results_full[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_regs_by_points.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  multi_point_LPM_logit_table(tab_file_path, estn_results_tab,
                              header = sprintf('%s: %s Specification by Point Value',
                                               header_model, header_spec),
                              caption = sprintf('Regressions by ticket-point value (%s)',
                                                header_spec),
                              description = orig_pts_description,
                              label = sprintf('tab:%s_regs_by_points', tab_tag),
                              points_label_list,
                              obsn_str_list_full,
                              num_fmt)



  #--------------------------------------------------
  # New table not yet in the paper:
  # Regressions by ticket point value for high-point drivers
  #--------------------------------------------------

  # Temporary list of fixed numbers of observations.
  obsn_str_list_high <- c('1,170,426,426', '921,131,812', '249,294,614')
  names(obsn_str_list_high) <- sex_list


  results_sel <- estn_results_high[, 'past_pts'] == 'high' &
    estn_results_high[, 'window'] == '4 yr.' &
    estn_results_high[, 'seasonality'] == season_incl &
    estn_results_high[, 'age_int'] %in% c('no') &
    # estn_results_full[, 'pts_target'] != 'all' &
    # estn_results_high[, 'reg_type'] == reg_type &
    estn_results_high[, 'Variable'] == 'policyTRUE'
  estn_results_tab <- estn_results_high[results_sel, ]


  # Create TeX file for Table.
  tab_file_name <- sprintf('%s_high_pt_regs_by_points.tex', tab_tag)
  tab_file_path <- sprintf('%s/%s', tab_dir, tab_file_name)


  multi_point_LPM_logit_table(tab_file_path, estn_results_tab,
                              header = sprintf('%s: %s Specification for High-Point Drivers by Point Value',
                                               header_model, header_spec),
                              caption = sprintf('Regressions for high-point drivers by ticket-point value (%s)',
                                                header_spec),
                              description = orig_pts_description,
                              label = sprintf('tab:%s_regs_by_points', tab_tag),
                              points_label_list,
                              obsn_str_list_high,
                              num_fmt)


}


# Create TeX file for Table.
tab_tag <- 'seas_Logit_vs_LPMx100K'
header_spec <- 'Seasonal Logit and LPM x 100K'
season_incl <- 'mnwk'
num_fmt <- 'x100K'


Logit_LPM_description <- c(
  "In the linear probability model, estimates and standard errors are in scientific notation ",
  "and heteroskedasticity-robust errors are employed.",
  "The baseline age category comprises drivers under the age of 16."
)


Logit_LPM_pts_description <- c(
  "In the linear probability model, estimates and standard errors are in scientific notation ",
  "and heteroskedasticity-robust errors are employed.",
  "The baseline age category comprises drivers under the age of 16.",
  "The 3-point category of tickets includes 6-point tickets after the policy change, ",
  "The 5-point category of tickets includes 10-point tickets after the policy change, ",
  "the 7-point category includes 14-point tickets after the policy change, ",
  "and 9 or more point tickets include all possible doubled values for those tickets ",
  "worth more than 9 points after the policy change."
)


sex_list <- c('All', 'Male', 'Female')


# Pass estimates from seasonal model.
estn_results_full <- estn_results_5
estn_results_high <- estn_results_7
estn_results_placebo <- estn_results_8


# Generate tables.
SAAQ_Logit_vs_LPM_table_gen(tab_tag, header_spec, season_incl, num_fmt,
                            estn_results_full, estn_results_high, estn_results_placebo,
                            age_int_label_list, points_label_list, sex_list,
                            orig_description, orig_pts_description)




################################################################################
# End
################################################################################

