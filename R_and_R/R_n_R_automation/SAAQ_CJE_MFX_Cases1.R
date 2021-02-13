



############################################################
# Calculate examples of Marginal Effects
############################################################


# > model_list
#    past_pts window seasonality age_int pts_target  sex reg_type
# 65      all  4 yr.        mnwk      no        all Male    Logit
# 66      all  4 yr.        mnwk    with        all Male    Logit

summary(log_model_1)

colnames(saaq_data)



############################################################
# Consider Model with no age-policy interaction
############################################################


# Selecting base cases for marginal effects.
# row 65:
# log_model_1_65 <- log_model_1
log_model_1 <- log_model_1_65


# Month variable arbitrary.
table(saaq_data[sel_obs, 'month'], useNA = 'ifany')
#    01    02    03    04    05    06    07    08    09    10    11    12
# 80526 77328 85545 82878 87303 84387 86607 85239 86945 88922 85004 71439
# Choose July?
# month = '07'


# Weekday variable arbitrary.
table(saaq_data[sel_obs, 'weekday'], useNA = 'ifany')
# Sunday    Monday   Tuesday Wednesday  Thursday    Friday  Saturday
# 135408    143760    146517    147419    146111    144945    137963
# Choose Wednesday?


# Select age variable.
table(saaq_data[sel_obs, 'age_grp'], useNA = 'ifany')
#  0-15  16-19  20-24  25-34  35-44  45-54  55-64 65-199
# 44068  93140 133776 145551 132201 123924 105200 224263
# 25-34


# Select points variable.
table(saaq_data[sel_obs, 'curr_pts_grp'], useNA = 'ifany')
#      0    1-3    4-6    7-9 10-150
# 139208 252352 225013 182250 203300



#--------------------------------------------------
# Marginal effects for chosen categories
#--------------------------------------------------



# Create a data frame with the correct entries for marginal effects.

# First row is the benchmark.
# Remaining rows are for the policy or age effects.

pred_mfx <- data.frame(policy = c(FALSE, TRUE),
                       age_grp = rep('25-34', 2),
                       curr_pts_grp = rep('1-3', 2),
                       month = rep('07', 2),
                       weekday = rep('Wednesday', 2))

# Predict for all combinations.
pred_mfx[, 'pred_prob'] <- predict(log_model_1, newdata = pred_mfx,
                                   type="response")

# Take differences between with and without policy.
mfx <- pred_mfx[pred_mfx[, 'policy'] == TRUE, 'pred_prob'] -
  pred_mfx[pred_mfx[, 'policy'] == FALSE, 'pred_prob']


mfx*100000


#--------------------------------------------------
# Marginal effects across all categories
#--------------------------------------------------


# Now use a series of variables.
mfx_month_list <- unique(saaq_data[, 'month'])
mfx_weekday_list <- unique(saaq_data[, 'weekday'])
mfx_curr_pts_list <- unique(saaq_data[, 'curr_pts_grp'])
mfx_age_list <- unique(saaq_data[, 'age_grp'])


# Create a data frame with all combinations for marginal effects.
pred_mfx <- expand.grid(policy = c(FALSE, TRUE),
                        age_grp = mfx_age_list,
                        curr_pts_grp = mfx_curr_pts_list,
                        month = mfx_month_list,
                        weekday = mfx_weekday_list)


# Predict for all combinations.
pred_mfx[, 'pred_prob'] <- predict(log_model_1, newdata = pred_mfx,
                                   type="response")

# Take differences between with and without policy.
mfx <- mean(pred_mfx[pred_mfx[, 'policy'] == TRUE, 'pred_prob']) -
  mean(pred_mfx[pred_mfx[, 'policy'] == FALSE, 'pred_prob'])

mfx*100000

#--------------------------------------------------
# Marginal effects averaged across observations
#--------------------------------------------------

# Predict for all observations.
saaq_data[, 'pred_prob'] <- NA
saaq_data[sel_obs, 'pred_prob'] <- predict(log_model_1,
                                           # newdata = saaq_data[sel_obs, ],
                                           type="response")
# summary(saaq_data[sel_obs, 'pred_prob'])

mfx <- mean(saaq_data[saaq_data[, 'policy'] == TRUE &
                        sel_obs, 'pred_prob']) -
  mean(saaq_data[saaq_data[, 'policy'] == FALSE &
                   sel_obs, 'pred_prob'])

mfx*100000


############################################################
# Consider Model with age-policy interaction
############################################################


# Selecting base cases for marginal effects.
# row 66:
# log_model_1_66 <- log_model_1
log_model_1 <- log_model_1_66

summary(log_model_1)

#--------------------------------------------------
# Marginal effects for chosen categories
#--------------------------------------------------


pred_mfx <- data.frame(policy = c(FALSE, TRUE),
                       age_grp = rep(mfx_age_list, 2),
                       curr_pts_grp = rep('1-3', 2),
                       month = rep('07', 2),
                       weekday = rep('Wednesday', 2))

# Predict for all combinations.
pred_mfx[, 'pred_prob'] <- predict(log_model_1, newdata = pred_mfx,
                                   type="response")

# Take differences between with and without policy.
mfx <- pred_mfx[pred_mfx[, 'policy'] == TRUE, 'pred_prob'] -
  pred_mfx[pred_mfx[, 'policy'] == FALSE, 'pred_prob']

mfx_mat <- data.frame(age_grp = levels(mfx_age_list),
                      pred_prob = mfx*100000)


#--------------------------------------------------
# Marginal effects across all categories
#--------------------------------------------------

# Create a data frame with all combinations for marginal effects.
pred_mfx <- expand.grid(policy = c(FALSE, TRUE),
                        age_grp = mfx_age_list,
                        curr_pts_grp = mfx_curr_pts_list,
                        month = mfx_month_list,
                        weekday = mfx_weekday_list)


# Predict for all combinations.
pred_mfx[, 'pred_prob'] <- predict(log_model_1, newdata = pred_mfx,
                                   type="response")


# Initialize marginal effects matrix first.
mfx_mat <- data.frame(age_grp = levels(mfx_age_list),
                      pred_prob = NA)

for (mfx_row in 1:nrow(mfx_mat)) {
  age_grp_sel <- mfx_mat[mfx_row, 'age_grp']

  # Take differences between with and without policy.
  mfx <- mean(pred_mfx[pred_mfx[, 'policy'] == TRUE &
                         pred_mfx[, 'age_grp'] == age_grp_sel, 'pred_prob']) -
    mean(pred_mfx[pred_mfx[, 'policy'] == FALSE &
                    pred_mfx[, 'age_grp'] == age_grp_sel, 'pred_prob'])

  mfx_mat[mfx_row, 'pred_prob'] <- mfx*100000
}

mfx_mat



#--------------------------------------------------
# Marginal effects averaged across observations
#--------------------------------------------------

# Predict for all observations.
saaq_data[, 'pred_prob'] <- NA
saaq_data[sel_obs, 'pred_prob'] <- predict(log_model_1,
                                           # newdata = saaq_data[sel_obs, ],
                                   type="response")
# summary(saaq_data[sel_obs, 'pred_prob'])

mfx_mat <- data.frame(age_grp = levels(mfx_age_list),
                      pred_prob = NA)

for (mfx_row in 1:nrow(mfx_mat)) {
  age_grp_sel <- mfx_mat[mfx_row, 'age_grp']

  # Take differences between with and without policy.
  mfx <- mean(saaq_data[saaq_data[, 'policy'] == TRUE &
                          sel_obs &
                          saaq_data[, 'age_grp'] == age_grp_sel, 'pred_prob']) -
    mean(saaq_data[saaq_data[, 'policy'] == FALSE &
                     sel_obs &
                     saaq_data[, 'age_grp'] == age_grp_sel, 'pred_prob'])

  mfx_mat[mfx_row, 'pred_prob'] <- mfx*100000
}

mfx_mat


