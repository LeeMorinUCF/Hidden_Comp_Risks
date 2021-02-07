
# Probit vs logit pdf comparison.


# Compare to estimates.
# > summary(predict(probit_model_1, type = 'response'))
#      Min.   1st Qu.    Median      Mean   3rd Qu.      Max.
# 3.454e-05 6.149e-04 1.141e-03 1.312e-03 1.795e-03 4.992e-03
# > summary(qnorm(predict(probit_model_1, type = 'response')))
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
# -3.979  -3.232  -3.051  -3.084  -2.912  -2.576


# Set range of probabilities.
prob_min <- 4*10^(-5)
prob_max <- 5*10^(-3)
#
prob_min <- 0.45
prob_max <- 0.55


# Calculate the range for the single index.
# Use the probit as the benchmark.
x_beta_min <- qnorm(p = prob_min)
x_beta_max <- qnorm(p = prob_max)
x_beta_len <- 500
x_beta_grid <- seq(x_beta_min, x_beta_max, length.out = x_beta_len)


# Calculate the normal CDFs.
probit_cdf <- pnorm(q = x_beta_grid)

# Calculate the logit CDF.
logit_scale_factor <- 2.2
logit_cdf <- exp(logit_scale_factor*x_beta_grid)
logit_cdf <- logit_cdf/(1 + logit_cdf)


# Plot the CDFs together to compare.
plot(NA,
     xlim = c(min(x_beta_grid), max(x_beta_grid)),
     ylim = c(0, max(c(probit_cdf, logit_cdf))),
     xlab = 'Index',
     ylab = 'Cumulative Probability')
lines(x_beta_grid, probit_cdf,
      lwd = 3,
      col = 'black')
lines(x_beta_grid, logit_cdf,
      lwd = 3,
      col = 'grey')





# End.