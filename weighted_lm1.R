
# Fixing weighted OLS
# So that weights account for sample size 
# rather than (inverse) GLS weights.





# Testing weights to make sure.
# summary(lm(c(8000, 50000, 116000) ~ c(6, 7, 8)))
# summary(lm(c(8000, 50000, 116000) ~ c(6, 7, 8), weight = c(123, 123, 246)))
# summary(lm(c(8000, 50000, 116000, 116000) ~ c(6, 7, 8, 8)))
# Not the same standard errors.
# The weights argument is to implement GLS,
# not to account for sampling weights. 

correct_lm <- lm(c(8000, 50000, 116000, 116000) ~ c(6, 7, 8, 8))
incorrect_lm <- lm(c(8000, 50000, 116000) ~ c(6, 7, 8), weight = c(123, 123, 246))

summary(correct_lm)
summary(incorrect_lm)


# Apply the fix to the model.

fixed_lm <- incorrect_lm
fixed_lm$df.residual <- with(fixed_lm, sum(weights) - length(coefficients))

summary(fixed_lm)

# Recalculate standard errors.
# The old fashioned way. 
vcov(incorrect_lm)
vcov(correct_lm)
# Compare the ratios.
vcov(incorrect_lm) / vcov(correct_lm)
# vcov matrix is twice the size. 


# now compare with fix:
vcov(correct_lm)
vcov(fixed_lm)
# Not the same.
vcov(fixed_lm) / vcov(correct_lm)


(vcov(correct_lm) / vcov(fixed_lm))[1]
# = 245 = 246 weight, less 2 df for parameters.


# If variance is adjusted by a function of the weight,
# Then the se's should be adjusted by the quare root.


fixed_lm_2 <- incorrect_lm
fixed_lm_2$df.residual <- with(fixed_lm_2, sqrt(sum(weights) - length(coefficients)))

summary(fixed_lm_2)



# See what the adjustment does to the standard errors.
vcov(incorrect_lm) / vcov(fixed_lm)
vcov(incorrect_lm) / vcov(fixed_lm_2)

# Compare to the correct vcov()
vcov(correct_lm) / vcov(fixed_lm)
vcov(incorrect_lm) / vcov(correct_lm)
vcov(correct_lm) / vcov(fixed_lm_2)


# See how far off the original was. 
vcov(incorrect_lm) / vcov(correct_lm)


# Generate a nontrivial example.
ind_data <- data.frame(expand.grid(x1 = seq(1,3), 
                                   x2 = seq(5,10), 
                                   x3 = c(2, 2, 2, 4, 4, 6)))
summary(ind_data)

# Add an outcome according to a linear probability model.
prob_vec <- rowSums(ind_data[, c('x1', 'x2', 'x3')]) / 20
  

summary(prob_vec)

# Draw a binary dependent variable. 
for (i in 1:nrow(ind_data)) {
  ind_data[i, 'y'] <- sample(c(0,1), size = 1,
                            replace = TRUE, 
                            prob = c(1 - prob_vec[i], prob_vec[i]))
}
summary(ind_data)

# Aggregate the counts.
ind_data[, 'num'] <- 1

wtd_data <- aggregate(num ~ y + x1 + x2 + x3,
                      data = ind_data,
                      FUN = sum)

# Ok, now let's run some regressions.
ind_lm <- lm(y ~ x1 + x2 + x3, data = ind_data)


wtd_lm <- lm(y ~ x1 + x2 + x3, data = wtd_data, weights = num)


# Compare.
summary(ind_lm)
summary(wtd_lm)

# Compare the vcov() matrices.
vcov(wtd_lm)/vcov(ind_lm)




# Try the "fix" above.
fixed_wtd_lm <- wtd_lm
fixed_wtd_lm$df.residual <- with(fixed_wtd_lm, sqrt(sum(weights) - length(coefficients)))

summary(ind_lm)
summary(fixed_wtd_lm)
# Now they're too small. 

# It just applies a fixed factor, not the correct correction. 
vcov(wtd_lm)/vcov(fixed_wtd_lm)
vcov(fixed_wtd_lm)/vcov(wtd_lm)




# Try using White corrected SEs.
library(sandwich)
White_ind_se <- sqrt(diag(vcovHC(ind_lm)))

# Not much of a change.
summary(ind_lm)
White_ind_se

# Apply the change to the weighted model.
White_wtd_se <- sqrt(diag(vcovHC(wtd_lm)))

# Not much change.
summary(wtd_lm)
White_wtd_se
# They're still too big. 

# Try getting into the meat of the White sandwich.
meat_ind_se <- sqrt(diag(solve(meatHC(ind_lm, 
                                      type = 'const', omega = NULL))))


# Compare with X'X
# X <- matrix(ind_data[, c('x1', 'x2', 'x3')], 
#             nrow = nrow(ind_data), ncol = 3)
X <- as.matrix(cbind(1, ind_data[, c('x1', 'x2', 'x3')]), 
            nrow = nrow(ind_data), ncol = 3)
meat_ind_xtx_se <- sqrt(diag(solve(t(X) %*% X))) * 
  sqrt(sum(ind_lm$residuals^2)/(104))


meat_ind_xtx_se
# Bingo. From 1st principles. 


meat_ind_xtx_se/sqrt(diag(vcov(ind_lm)))
sqrt(diag(vcov(ind_lm)))/meat_ind_xtx_se


t(X) %*% X
meatHC(ind_lm, type = 'const')

meatHC(ind_lm, type = 'const')/(t(X) %*% X)
(t(X) %*% X)/meatHC(ind_lm, type = 'const')


sqrt(meatHC(ind_lm, type = 'const')/(t(X) %*% X))
sqrt((t(X) %*% X)/meatHC(ind_lm, type = 'const'))

(t(X) %*% X)/meatHC(ind_lm, type = 'const')/sqrt(104)
(t(X) %*% X)/meatHC(ind_lm, type = 'const')/104



meat_ind_se
sqrt(diag(vcov(ind_lm))) # Calculated SEs. 

# Off by a constant. 
meat_ind_se/sqrt(diag(vcov(ind_lm)))
sqrt(diag(vcov(ind_lm)))/meat_ind_se

sqrt(sum(ind_lm$residuals^2)/(104))
1/sqrt(sum(ind_lm$residuals^2)/(104))

sqrt(sum(ind_lm$residuals^2))/(104)
104/sqrt(sum(ind_lm$residuals^2))


# Apply to the weighted regression.
meat_wtd_se <- sqrt(diag(solve(meatHC(wtd_lm, 
                                      omega = wtd_data[, 'num']))))


# Off by a constant. 
meat_wtd_se/sqrt(diag(vcov(ind_lm)))
sqrt(diag(vcov(ind_lm)))/meat_wtd_se

sum(wtd_data[, 'num'])
nrow(wtd_data)

sum(wtd_data[, 'num'])/nrow(wtd_data)
nrow(wtd_data)/sum(wtd_data[, 'num'])




# Try a bunch of things.

(meat_wtd_se/sqrt(diag(vcov(ind_lm))))^2

(sqrt(diag(vcov(ind_lm)))/meat_wtd_se)^2


sqrt(meat_wtd_se/sqrt(diag(vcov(ind_lm))))
sqrt(sqrt(diag(vcov(ind_lm)))/meat_wtd_se)

s_hat <- sqrt(sum(ind_lm$residuals^2)/(104))


meat_wtd_se_adj <- meat_wtd_se*s_hat


meat_wtd_se_adj/sqrt(diag(vcov(ind_lm)))
sqrt(diag(vcov(ind_lm)))/meat_wtd_se_adj




