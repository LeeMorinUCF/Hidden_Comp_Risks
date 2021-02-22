

# Examples with QMLE.

# data <- caret::twoClassSim()
# model <- glm(Class~TwoFactor1*TwoFactor2, data = data, family="binomial")

# here are the standard errors we want
# SE <- broom::tidy(model)$std.error

# X <- model.matrix(model)
# p <- fitted(model)
# W <- diag(p*(1-p))
# # this is the covariance matrix (inverse of Fisher information)
# V <- solve(t(X)%*%W%*%X)
# all.equal(vcov(model), V)
# #> [1] "Mean relative difference: 1.066523e-05"
# # close enough
#
# # these are the standard errors: take square root of diagonal
# all.equal(SE, sqrt(diag(V)))
# #> [1] "names for current but not for target"
# #> [2] "Mean relative difference: 4.359204e-06"


# Changed to fit SAAQ data:

summary(log_model_1)

# The full design matrix:
X <- model.matrix(log_model_1)

# The predicted probabilities.
p <- fitted(log_model_1)
# The weighting matrix.
W <- diag(p*(1-p))
# which is too big to calculate.

# Instead, weight the X matrix on one side.
# d <- p*(1-p)
# Also weight by number of observations.
num_weights <- saaq_data[sel_obs, 'num']
d <- p*(1-p) * num_weights
# nd <- length(d)
kX <- ncol(X)

XD <- X * matrix(rep(d, each = kX), ncol = kX, byrow = TRUE)


# this is the covariance matrix (inverse of Fisher information)
# V <- solve(t(X)%*%W%*%X)
V <- solve(t(XD) %*% X)

# The same?
all.equal(vcov(log_model_1), V)
# [1] "Mean relative difference: 1.52272e-07"
# Close enough for me.

# Some comparisons:
rbind(diag(vcov(log_model_1)),
      diag(V))

diag(V) / diag(vcov(log_model_1))
# diag(V) / sqrt(diag(vcov(log_model_1)))

summary(log_model_1)
sqrt(diag(vcov(log_model_1)))
# Bingo!


# Now calculate OPG.
summary(saaq_data[sel_obs, 'events'])
y <- as.integer(saaq_data[sel_obs, 'events'])

# Now calculate a different weighting matrix.
g <- (y-p) * sqrt(num_weights)
# Note that the outer product will get back the weights.

# This is the formula for the nxk matrix of
# contributions to the gradient (G(theta) in the good book).
Xg <- X * matrix(rep(g, each = kX), ncol = kX, byrow = TRUE)

# This is the meat of the sandwich.
# XppX <- t(Xg) %*% X
XppX <- t(Xg) %*% Xg


# Now make a sandwich.
VS <- V %*% XppX %*% V


# Compare these standard errors to the standard MLE.

rbind(diag(V),
      diag(VS))
# Same order of magnitude.

diag(V) / diag(VS)

diag(VS) / diag(V)

# With XppX <- t(Xg) %*% X:
# Sandwich estimates are 30-75% as large as in the standard MLE.

# With XppX <- t(Xg) %*% Xg:
# Sandwich estimates are 99-101% as large as in the standard MLE.
# Essentially exactly the same.


# Ready to work in to the estimates.



# End.