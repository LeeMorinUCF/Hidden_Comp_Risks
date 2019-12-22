
# Linear Probability Models - Female Drivers

## Data

The example dataset contains traffic violations in the Province of Quebec in the years from 1998 to 2010.
The dataset is the complete record of demerit points for the Province of Quebec through those years.
However, the dataset contains only the total number of demerit points awarded at a single roadside stop, not the points for a single violation.
There are no labels for the particular infraction.
The dataset also contains the age and sex of each driver, along with an individual identifier.
The data are aggregated by sex, age_group, demerit point value and recorded daily.
Each aggregate observation for a given point value is weighted by the number of drivers in a particular sex:age_group:point category for a particular day.
These totals are obtained from the SAAQ website [here](http://www.bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERRUNYAW46-44034787356|@}zb&p_lang=2&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3370).
It is numerically the same as recording 1 or zero with one observation for each licensed driver every day (except that most would be zeros).

### Drivers' History

A new categorical variable was added to capture the number of demerit points that a driver has accumulated over the past two years.
This was simple to calculate for the violation events.
For the non-events, an aggregate calculation was performed to take an inventory of the population of drivers with different point histories for each sex and age category.
To reduce the computational burden, the violation history was aggregated into the number of points for point levels 0-10, and in categories 11-20, 21-30 and 30-150, 150 being the highest observed.
Roughly 30% of the driver-days, drivers have no point history.
A further 40% have up to 10 demerit points in the last two years.
The 11-20 category accounts for the next decile.
The remaining decile  is split 7-3% between the next two categories, 21-30 and 30-150, respectively.


### Policy Change: Excessive Speeding

On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revocation of licenses.
Under this policy change, some violations are associated with different demerit point levels.

### Sample selection

The sample was limited to an equal window of two years before and after the date of the policy change,
from April 1, 2006 to March 31, 2010.
The summer months account for a large fraction of the infractions, so it is important to either impose symmetry over the calendar year or explicitly model the seasonality.


## Linear Regression Results

The following are linear probability regression models estimated from data aggregated by sex and age groups and categories of previous demerit points.
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the same sex and age groups and categories of previous demerit points.

### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.206e-05  1.006e-05   3.186 0.001444 **
age_grp16-19                   2.518e-04  1.029e-05  24.471  < 2e-16 ***
age_grp20-24                   2.574e-04  1.014e-05  25.379  < 2e-16 ***
age_grp25-34                   2.082e-04  1.010e-05  20.622  < 2e-16 ***
age_grp35-44                   1.869e-04  1.009e-05  18.518  < 2e-16 ***
age_grp45-54                   1.381e-04  1.009e-05  13.692  < 2e-16 ***
age_grp55-64                   9.092e-05  1.010e-05   9.003  < 2e-16 ***
age_grp65-74                   4.963e-05  1.013e-05   4.898 9.70e-07 ***
age_grp75-84                   2.714e-05  1.025e-05   2.649 0.008072 **
age_grp85-89                   1.561e-05  1.215e-05   1.284 0.198967    
age_grp90-199                  8.473e-06  2.231e-05   0.380 0.704069    
policyTRUE                    -2.747e-06  1.431e-05  -0.192 0.847818    
curr_pts_grp1                  3.457e-04  3.618e-06  95.550  < 2e-16 ***
curr_pts_grp2                  4.021e-04  1.658e-06 242.583  < 2e-16 ***
curr_pts_grp3                  4.637e-04  1.604e-06 288.999  < 2e-16 ***
curr_pts_grp4                  7.721e-04  4.600e-06 167.838  < 2e-16 ***
curr_pts_grp5                  8.735e-04  3.641e-06 239.931  < 2e-16 ***
curr_pts_grp6                  1.027e-03  4.537e-06 226.458  < 2e-16 ***
curr_pts_grp7                  1.256e-03  8.188e-06 153.440  < 2e-16 ***
curr_pts_grp8                  1.392e-03  7.933e-06 175.421  < 2e-16 ***
curr_pts_grp9                  1.052e-03  8.376e-06 125.626  < 2e-16 ***
curr_pts_grp10                 1.679e-03  1.514e-05 110.915  < 2e-16 ***
curr_pts_grp11-20              1.813e-03  9.478e-06 191.280  < 2e-16 ***
curr_pts_grp21-30              3.880e-03  6.104e-05  63.565  < 2e-16 ***
curr_pts_grp30-150             7.394e-03  1.640e-04  45.089  < 2e-16 ***
age_grp16-19:policyTRUE        2.575e-05  1.462e-05   1.761 0.078283 .  
age_grp20-24:policyTRUE        1.278e-05  1.443e-05   0.886 0.375627    
age_grp25-34:policyTRUE       -1.624e-06  1.436e-05  -0.113 0.909940    
age_grp35-44:policyTRUE        6.585e-06  1.435e-05   0.459 0.646338    
age_grp45-54:policyTRUE        2.072e-06  1.435e-05   0.144 0.885197    
age_grp55-64:policyTRUE        2.746e-06  1.436e-05   0.191 0.848336    
age_grp65-74:policyTRUE        9.487e-06  1.441e-05   0.658 0.510269    
age_grp75-84:policyTRUE        6.941e-06  1.457e-05   0.477 0.633693    
age_grp85-89:policyTRUE        1.488e-05  1.708e-05   0.871 0.383638    
age_grp90-199:policyTRUE       2.064e-05  3.046e-05   0.677 0.498119    
policyTRUE:curr_pts_grp1       2.359e-05  4.973e-06   4.743 2.10e-06 ***
policyTRUE:curr_pts_grp2       6.101e-06  2.265e-06   2.693 0.007075 **
policyTRUE:curr_pts_grp3       1.367e-06  2.293e-06   0.596 0.551121    
policyTRUE:curr_pts_grp4       2.252e-05  6.064e-06   3.714 0.000204 ***
policyTRUE:curr_pts_grp5       2.531e-05  4.987e-06   5.076 3.86e-07 ***
policyTRUE:curr_pts_grp6      -1.500e-05  6.229e-06  -2.409 0.016016 *  
policyTRUE:curr_pts_grp7       1.853e-05  1.079e-05   1.716 0.086073 .  
policyTRUE:curr_pts_grp8       4.459e-06  1.070e-05   0.417 0.676845    
policyTRUE:curr_pts_grp9       7.172e-05  1.143e-05   6.272 3.57e-10 ***
policyTRUE:curr_pts_grp10     -2.517e-04  1.897e-05 -13.268  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -9.710e-05  1.218e-05  -7.973 1.55e-15 ***
policyTRUE:curr_pts_grp21-30  -8.772e-04  7.255e-05 -12.090  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -3.753e-03  1.941e-04 -19.334  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01614 on 4590638624 degrees of freedom
Multiple R-squared:  0.0002086,	Adjusted R-squared:  0.0002086
F-statistic: 2.038e+04 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```



### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.110e-06  3.064e-06   0.362   0.7171    
age_grp16-19                   2.999e-05  3.133e-06   9.573  < 2e-16 ***
age_grp20-24                   2.473e-05  3.088e-06   8.008 1.16e-15 ***
age_grp25-34                   1.978e-05  3.073e-06   6.435 1.24e-10 ***
age_grp35-44                   1.680e-05  3.072e-06   5.467 4.57e-08 ***
age_grp45-54                   1.294e-05  3.072e-06   4.213 2.52e-05 ***
age_grp55-64                   8.849e-06  3.074e-06   2.878   0.0040 **
age_grp65-74                   5.324e-06  3.085e-06   1.726   0.0844 .  
age_grp75-84                   2.871e-06  3.119e-06   0.920   0.3574    
age_grp85-89                   3.122e-06  3.700e-06   0.844   0.3988    
age_grp90-199                 -1.991e-06  6.791e-06  -0.293   0.7694    
policyTRUE                    -1.425e-06  4.357e-06  -0.327   0.7437    
curr_pts_grp1                  7.366e-05  1.101e-06  66.874  < 2e-16 ***
curr_pts_grp2                  3.406e-05  5.046e-07  67.491  < 2e-16 ***
curr_pts_grp3                  2.496e-05  4.884e-07  51.109  < 2e-16 ***
curr_pts_grp4                  6.646e-05  1.400e-06  47.453  < 2e-16 ***
curr_pts_grp5                  5.361e-05  1.108e-06  48.365  < 2e-16 ***
curr_pts_grp6                  5.874e-05  1.381e-06  42.530  < 2e-16 ***
curr_pts_grp7                  9.094e-05  2.493e-06  36.482  < 2e-16 ***
curr_pts_grp8                  8.302e-05  2.415e-06  34.375  < 2e-16 ***
curr_pts_grp9                  7.111e-05  2.550e-06  27.885  < 2e-16 ***
curr_pts_grp10                 1.302e-04  4.609e-06  28.240  < 2e-16 ***
curr_pts_grp11-20              1.527e-04  2.885e-06  52.916  < 2e-16 ***
curr_pts_grp21-30              3.079e-04  1.858e-05  16.569  < 2e-16 ***
curr_pts_grp30-150             4.946e-04  4.992e-05   9.907  < 2e-16 ***
age_grp16-19:policyTRUE        9.000e-06  4.452e-06   2.022   0.0432 *  
age_grp20-24:policyTRUE        3.949e-06  4.392e-06   0.899   0.3686    
age_grp25-34:policyTRUE        5.654e-06  4.371e-06   1.293   0.1959    
age_grp35-44:policyTRUE        6.861e-06  4.369e-06   1.570   0.1164    
age_grp45-54:policyTRUE        6.010e-06  4.368e-06   1.376   0.1688    
age_grp55-64:policyTRUE        5.801e-06  4.372e-06   1.327   0.1845    
age_grp65-74:policyTRUE        5.610e-06  4.386e-06   1.279   0.2009    
age_grp75-84:policyTRUE        4.484e-06  4.434e-06   1.011   0.3118    
age_grp85-89:policyTRUE        2.364e-06  5.199e-06   0.455   0.6493    
age_grp90-199:policyTRUE       6.440e-06  9.273e-06   0.694   0.4874    
policyTRUE:curr_pts_grp1      -2.037e-08  1.514e-06  -0.013   0.9893    
policyTRUE:curr_pts_grp2       6.859e-06  6.896e-07   9.947  < 2e-16 ***
policyTRUE:curr_pts_grp3       1.187e-05  6.981e-07  17.001  < 2e-16 ***
policyTRUE:curr_pts_grp4       1.045e-05  1.846e-06   5.661 1.50e-08 ***
policyTRUE:curr_pts_grp5       1.808e-05  1.518e-06  11.908  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.871e-05  1.896e-06   9.867  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.539e-05  3.286e-06   4.683 2.83e-06 ***
policyTRUE:curr_pts_grp8       3.098e-05  3.257e-06   9.512  < 2e-16 ***
policyTRUE:curr_pts_grp9       1.642e-05  3.481e-06   4.718 2.38e-06 ***
policyTRUE:curr_pts_grp10      1.251e-05  5.776e-06   2.167   0.0303 *  
policyTRUE:curr_pts_grp11-20   2.621e-05  3.708e-06   7.069 1.56e-12 ***
policyTRUE:curr_pts_grp21-30  -1.423e-05  2.209e-05  -0.644   0.5193    
policyTRUE:curr_pts_grp30-150  1.796e-05  5.909e-05   0.304   0.7613    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004912 on 4590638624 degrees of freedom
Multiple R-squared:  1.722e-05,	Adjusted R-squared:  1.721e-05
F-statistic:  1682 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```


### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.313e-06  6.816e-06  -0.193 0.847215    
age_grp16-19                   1.092e-04  6.969e-06  15.677  < 2e-16 ***
age_grp20-24                   1.191e-04  6.868e-06  17.335  < 2e-16 ***
age_grp25-34                   1.094e-04  6.837e-06  15.997  < 2e-16 ***
age_grp35-44                   1.024e-04  6.834e-06  14.980  < 2e-16 ***
age_grp45-54                   8.198e-05  6.833e-06  11.999  < 2e-16 ***
age_grp55-64                   5.873e-05  6.839e-06   8.588  < 2e-16 ***
age_grp65-74                   3.677e-05  6.863e-06   5.358 8.44e-08 ***
age_grp75-84                   2.350e-05  6.939e-06   3.387 0.000707 ***
age_grp85-89                   1.611e-05  8.230e-06   1.958 0.050257 .  
age_grp90-199                  1.059e-05  1.511e-05   0.701 0.483372    
policyTRUE                    -3.364e-06  9.693e-06  -0.347 0.728529    
curr_pts_grp1                  1.479e-04  2.450e-06  60.375  < 2e-16 ***
curr_pts_grp2                  1.919e-04  1.123e-06 170.923  < 2e-16 ***
curr_pts_grp3                  1.869e-04  1.087e-06 172.003  < 2e-16 ***
curr_pts_grp4                  3.537e-04  3.115e-06 113.529  < 2e-16 ***
curr_pts_grp5                  3.679e-04  2.466e-06 149.198  < 2e-16 ***
curr_pts_grp6                  3.895e-04  3.072e-06 126.773  < 2e-16 ***
curr_pts_grp7                  5.260e-04  5.545e-06  94.867  < 2e-16 ***
curr_pts_grp8                  5.345e-04  5.373e-06  99.482  < 2e-16 ***
curr_pts_grp9                  3.633e-04  5.673e-06  64.051  < 2e-16 ***
curr_pts_grp10                 6.113e-04  1.025e-05  59.619  < 2e-16 ***
curr_pts_grp11-20              6.244e-04  6.418e-06  97.276  < 2e-16 ***
curr_pts_grp21-30              1.097e-03  4.134e-05  26.549  < 2e-16 ***
curr_pts_grp30-150             1.545e-03  1.111e-04  13.911  < 2e-16 ***
age_grp16-19:policyTRUE        1.937e-05  9.903e-06   1.956 0.050488 .  
age_grp20-24:policyTRUE        1.578e-05  9.769e-06   1.615 0.106261    
age_grp25-34:policyTRUE        9.411e-06  9.723e-06   0.968 0.333127    
age_grp35-44:policyTRUE        1.215e-05  9.720e-06   1.250 0.211373    
age_grp45-54:policyTRUE        1.008e-05  9.717e-06   1.037 0.299682    
age_grp55-64:policyTRUE        8.116e-06  9.726e-06   0.835 0.403970    
age_grp65-74:policyTRUE        9.125e-06  9.758e-06   0.935 0.349685    
age_grp75-84:policyTRUE        5.497e-06  9.864e-06   0.557 0.577291    
age_grp85-89:policyTRUE        6.392e-06  1.156e-05   0.553 0.580460    
age_grp90-199:policyTRUE       5.936e-06  2.063e-05   0.288 0.773537    
policyTRUE:curr_pts_grp1       2.238e-05  3.368e-06   6.646 3.02e-11 ***
policyTRUE:curr_pts_grp2       1.284e-05  1.534e-06   8.368  < 2e-16 ***
policyTRUE:curr_pts_grp3       1.421e-05  1.553e-06   9.148  < 2e-16 ***
policyTRUE:curr_pts_grp4       2.838e-05  4.107e-06   6.911 4.81e-12 ***
policyTRUE:curr_pts_grp5       3.977e-05  3.377e-06  11.777  < 2e-16 ***
policyTRUE:curr_pts_grp6       2.729e-05  4.218e-06   6.471 9.74e-11 ***
policyTRUE:curr_pts_grp7       4.394e-05  7.309e-06   6.011 1.84e-09 ***
policyTRUE:curr_pts_grp8       3.735e-05  7.245e-06   5.155 2.54e-07 ***
policyTRUE:curr_pts_grp9       8.220e-05  7.744e-06  10.614  < 2e-16 ***
policyTRUE:curr_pts_grp10     -4.014e-05  1.285e-05  -3.124 0.001786 **
policyTRUE:curr_pts_grp11-20   1.581e-05  8.248e-06   1.916 0.055318 .  
policyTRUE:curr_pts_grp21-30  -1.895e-04  4.914e-05  -3.856 0.000115 ***
policyTRUE:curr_pts_grp30-150 -6.259e-04  1.315e-04  -4.761 1.92e-06 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01093 on 4590638624 degrees of freedom
Multiple R-squared:  8.269e-05,	Adjusted R-squared:  8.268e-05
F-statistic:  8077 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.034e-05  6.570e-06   4.618 3.87e-06 ***
age_grp16-19                   9.400e-05  6.717e-06  13.995  < 2e-16 ***
age_grp20-24                   1.024e-04  6.620e-06  15.470  < 2e-16 ***
age_grp25-34                   7.462e-05  6.590e-06  11.324  < 2e-16 ***
age_grp35-44                   6.601e-05  6.587e-06  10.022  < 2e-16 ***
age_grp45-54                   4.320e-05  6.585e-06   6.561 5.36e-11 ***
age_grp55-64                   2.406e-05  6.592e-06   3.650 0.000262 ***
age_grp65-74                   8.253e-06  6.615e-06   1.248 0.212160    
age_grp75-84                   8.167e-07  6.688e-06   0.122 0.902805    
age_grp85-89                  -4.384e-06  7.932e-06  -0.553 0.580452    
age_grp90-199                  6.670e-07  1.456e-05   0.046 0.963464    
policyTRUE                     1.212e-06  9.342e-06   0.130 0.896752    
curr_pts_grp1                  1.182e-04  2.362e-06  50.071  < 2e-16 ***
curr_pts_grp2                  1.692e-04  1.082e-06 156.341  < 2e-16 ***
curr_pts_grp3                  2.385e-04  1.047e-06 227.709  < 2e-16 ***
curr_pts_grp4                  3.255e-04  3.003e-06 108.394  < 2e-16 ***
curr_pts_grp5                  4.256e-04  2.376e-06 179.090  < 2e-16 ***
curr_pts_grp6                  5.458e-04  2.961e-06 184.300  < 2e-16 ***
curr_pts_grp7                  5.898e-04  5.344e-06 110.363  < 2e-16 ***
curr_pts_grp8                  7.194e-04  5.178e-06 138.915  < 2e-16 ***
curr_pts_grp9                  5.739e-04  5.467e-06 104.958  < 2e-16 ***
curr_pts_grp10                 8.517e-04  9.883e-06  86.182  < 2e-16 ***
curr_pts_grp11-20              9.206e-04  6.186e-06 148.822  < 2e-16 ***
curr_pts_grp21-30              2.010e-03  3.984e-05  50.461  < 2e-16 ***
curr_pts_grp30-150             4.227e-03  1.070e-04  39.489  < 2e-16 ***
age_grp16-19:policyTRUE       -1.570e-06  9.545e-06  -0.165 0.869331    
age_grp20-24:policyTRUE       -4.970e-06  9.416e-06  -0.528 0.597638    
age_grp25-34:policyTRUE       -1.495e-05  9.371e-06  -1.595 0.110645    
age_grp35-44:policyTRUE       -1.134e-05  9.368e-06  -1.211 0.225971    
age_grp45-54:policyTRUE       -1.301e-05  9.365e-06  -1.390 0.164626    
age_grp55-64:policyTRUE       -1.034e-05  9.374e-06  -1.103 0.270035    
age_grp65-74:policyTRUE       -4.272e-06  9.405e-06  -0.454 0.649685    
age_grp75-84:policyTRUE       -2.664e-06  9.507e-06  -0.280 0.779272    
age_grp85-89:policyTRUE        6.661e-06  1.115e-05   0.598 0.550114    
age_grp90-199:policyTRUE       4.539e-06  1.988e-05   0.228 0.819426    
policyTRUE:curr_pts_grp1       1.502e-06  3.246e-06   0.463 0.643553    
policyTRUE:curr_pts_grp2      -1.297e-05  1.478e-06  -8.773  < 2e-16 ***
policyTRUE:curr_pts_grp3      -2.218e-05  1.497e-06 -14.816  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.326e-05  3.958e-06  -3.351 0.000804 ***
policyTRUE:curr_pts_grp5      -2.797e-05  3.255e-06  -8.592  < 2e-16 ***
policyTRUE:curr_pts_grp6      -5.368e-05  4.066e-06 -13.203  < 2e-16 ***
policyTRUE:curr_pts_grp7      -3.282e-05  7.045e-06  -4.658 3.19e-06 ***
policyTRUE:curr_pts_grp8      -5.261e-05  6.983e-06  -7.535 4.90e-14 ***
policyTRUE:curr_pts_grp9      -1.607e-05  7.464e-06  -2.152 0.031373 *  
policyTRUE:curr_pts_grp10     -1.849e-04  1.238e-05 -14.929  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.116e-04  7.949e-06 -14.038  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -5.741e-04  4.736e-05 -12.123  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.382e-03  1.267e-04 -18.803  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01053 on 4590638624 degrees of freedom
Multiple R-squared:  0.0001054,	Adjusted R-squared:  0.0001054
F-statistic: 1.03e+04 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```


This will be revisited with the 6-point violations below.


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    7.182e-07  6.439e-07   1.115 0.264655    
age_grp16-19                   7.680e-06  6.583e-07  11.667  < 2e-16 ***
age_grp20-24                   1.936e-06  6.488e-07   2.983 0.002852 **
age_grp25-34                   3.175e-07  6.459e-07   0.492 0.623053    
age_grp35-44                  -2.287e-07  6.456e-07  -0.354 0.723119    
age_grp45-54                  -5.263e-07  6.454e-07  -0.815 0.414854    
age_grp55-64                  -6.261e-07  6.461e-07  -0.969 0.332516    
age_grp65-74                  -5.178e-07  6.483e-07  -0.799 0.424475    
age_grp75-84                  -5.127e-07  6.555e-07  -0.782 0.434163    
age_grp85-89                  -4.303e-07  7.775e-07  -0.554 0.579917    
age_grp90-199                 -7.712e-07  1.427e-06  -0.540 0.588935    
policyTRUE                     8.180e-07  9.156e-07   0.893 0.371685    
curr_pts_grp1                  5.526e-07  2.315e-07   2.387 0.016967 *  
curr_pts_grp2                  5.398e-07  1.060e-07   5.090 3.58e-07 ***
curr_pts_grp3                  1.949e-06  1.026e-07  18.990  < 2e-16 ***
curr_pts_grp4                  7.555e-06  2.943e-07  25.672  < 2e-16 ***
curr_pts_grp5                  1.911e-06  2.329e-07   8.204 2.33e-16 ***
curr_pts_grp6                  3.428e-06  2.902e-07  11.812  < 2e-16 ***
curr_pts_grp7                  9.112e-06  5.238e-07  17.395  < 2e-16 ***
curr_pts_grp8                  4.721e-06  5.075e-07   9.301  < 2e-16 ***
curr_pts_grp9                  5.090e-06  5.359e-07   9.499  < 2e-16 ***
curr_pts_grp10                 1.196e-05  9.686e-07  12.351  < 2e-16 ***
curr_pts_grp11-20              2.010e-05  6.063e-07  33.153  < 2e-16 ***
curr_pts_grp21-30              5.552e-05  3.905e-06  14.218  < 2e-16 ***
curr_pts_grp30-150             3.081e-04  1.049e-05  29.370  < 2e-16 ***
age_grp16-19:policyTRUE        8.827e-08  9.355e-07   0.094 0.924823    
age_grp20-24:policyTRUE       -8.406e-08  9.229e-07  -0.091 0.927427    
age_grp25-34:policyTRUE       -8.293e-07  9.185e-07  -0.903 0.366594    
age_grp35-44:policyTRUE       -7.598e-07  9.182e-07  -0.828 0.407916    
age_grp45-54:policyTRUE       -7.676e-07  9.179e-07  -0.836 0.403014    
age_grp55-64:policyTRUE       -8.262e-07  9.187e-07  -0.899 0.368502    
age_grp65-74:policyTRUE       -9.658e-07  9.218e-07  -1.048 0.294771    
age_grp75-84:policyTRUE       -8.319e-07  9.318e-07  -0.893 0.371964    
age_grp85-89:policyTRUE       -7.097e-07  1.092e-06  -0.650 0.515914    
age_grp90-199:policyTRUE      -8.386e-07  1.949e-06  -0.430 0.666962    
policyTRUE:curr_pts_grp1      -2.936e-07  3.182e-07  -0.923 0.356050    
policyTRUE:curr_pts_grp2      -1.643e-07  1.449e-07  -1.134 0.256922    
policyTRUE:curr_pts_grp3      -5.500e-07  1.467e-07  -3.749 0.000178 ***
policyTRUE:curr_pts_grp4      -1.425e-06  3.879e-07  -3.673 0.000240 ***
policyTRUE:curr_pts_grp5      -8.965e-07  3.190e-07  -2.810 0.004956 **
policyTRUE:curr_pts_grp6      -1.122e-06  3.985e-07  -2.816 0.004863 **
policyTRUE:curr_pts_grp7      -3.181e-06  6.905e-07  -4.607 4.09e-06 ***
policyTRUE:curr_pts_grp8       2.936e-06  6.844e-07   4.290 1.79e-05 ***
policyTRUE:curr_pts_grp9      -1.723e-06  7.316e-07  -2.355 0.018512 *  
policyTRUE:curr_pts_grp10     -5.393e-06  1.214e-06  -4.443 8.86e-06 ***
policyTRUE:curr_pts_grp11-20  -2.580e-06  7.791e-07  -3.311 0.000930 ***
policyTRUE:curr_pts_grp21-30   7.449e-06  4.642e-06   1.605 0.108531    
policyTRUE:curr_pts_grp30-150 -3.102e-04  1.242e-05 -24.982  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001032 on 4590638624 degrees of freedom
Multiple R-squared:  3.829e-06,	Adjusted R-squared:  3.819e-06
F-statistic:   374 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```

Note that there are no changes to the penalties for these offences and the swapping out of the 3-point speeding 40-45 over in a 100km/hr zone, which was changed to 6 points, is not a possibility, since the driver can only be awarded points for a single speeding infraction.


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.752e-07  9.559e-07  -0.288 0.773429    
age_grp16-19                   7.487e-06  9.773e-07   7.660 1.85e-14 ***
age_grp20-24                   8.067e-06  9.632e-07   8.375  < 2e-16 ***
age_grp25-34                   4.213e-06  9.588e-07   4.394 1.11e-05 ***
age_grp35-44                   2.516e-06  9.584e-07   2.625 0.008655 **
age_grp45-54                   1.369e-06  9.582e-07   1.428 0.153217    
age_grp55-64                   7.721e-07  9.592e-07   0.805 0.420815    
age_grp65-74                   3.946e-07  9.625e-07   0.410 0.681801    
age_grp75-84                   9.126e-08  9.732e-07   0.094 0.925286    
age_grp85-89                   9.976e-08  1.154e-06   0.086 0.931126    
age_grp90-199                  9.961e-09  2.119e-06   0.005 0.996248    
policyTRUE                     1.767e-07  1.359e-06   0.130 0.896564    
curr_pts_grp1                  4.649e-06  3.436e-07  13.530  < 2e-16 ***
curr_pts_grp2                  5.093e-06  1.574e-07  32.351  < 2e-16 ***
curr_pts_grp3                  9.185e-06  1.524e-07  60.280  < 2e-16 ***
curr_pts_grp4                  1.297e-05  4.369e-07  29.693  < 2e-16 ***
curr_pts_grp5                  1.949e-05  3.458e-07  56.377  < 2e-16 ***
curr_pts_grp6                  2.306e-05  4.309e-07  53.514  < 2e-16 ***
curr_pts_grp7                  3.462e-05  7.777e-07  44.521  < 2e-16 ***
curr_pts_grp8                  4.252e-05  7.535e-07  56.432  < 2e-16 ***
curr_pts_grp9                  2.814e-05  7.956e-07  35.377  < 2e-16 ***
curr_pts_grp10                 5.449e-05  1.438e-06  37.895  < 2e-16 ***
curr_pts_grp11-20              6.968e-05  9.001e-07  77.408  < 2e-16 ***
curr_pts_grp21-30              3.245e-04  5.797e-06  55.984  < 2e-16 ***
curr_pts_grp30-150             7.182e-04  1.558e-05  46.111  < 2e-16 ***
age_grp16-19:policyTRUE       -4.790e-06  1.389e-06  -3.449 0.000562 ***
age_grp20-24:policyTRUE       -5.427e-06  1.370e-06  -3.961 7.47e-05 ***
age_grp25-34:policyTRUE       -3.049e-06  1.364e-06  -2.236 0.025361 *  
age_grp35-44:policyTRUE       -1.961e-06  1.363e-06  -1.439 0.150170    
age_grp45-54:policyTRUE       -1.189e-06  1.363e-06  -0.873 0.382892    
age_grp55-64:policyTRUE       -6.410e-07  1.364e-06  -0.470 0.638397    
age_grp65-74:policyTRUE       -3.586e-07  1.368e-06  -0.262 0.793268    
age_grp75-84:policyTRUE       -5.983e-08  1.383e-06  -0.043 0.965501    
age_grp85-89:policyTRUE       -1.415e-07  1.622e-06  -0.087 0.930495    
age_grp90-199:policyTRUE      -4.970e-08  2.893e-06  -0.017 0.986293    
policyTRUE:curr_pts_grp1      -3.001e-06  4.723e-07  -6.352 2.12e-10 ***
policyTRUE:curr_pts_grp2      -3.411e-06  2.151e-07 -15.854  < 2e-16 ***
policyTRUE:curr_pts_grp3      -6.690e-06  2.178e-07 -30.718  < 2e-16 ***
policyTRUE:curr_pts_grp4      -8.762e-06  5.759e-07 -15.214  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.337e-05  4.737e-07 -28.235  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.595e-05  5.916e-07 -26.965  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.281e-05  1.025e-06 -22.255  < 2e-16 ***
policyTRUE:curr_pts_grp8      -3.334e-05  1.016e-06 -32.809  < 2e-16 ***
policyTRUE:curr_pts_grp9      -2.063e-05  1.086e-06 -18.999  < 2e-16 ***
policyTRUE:curr_pts_grp10     -4.796e-05  1.802e-06 -26.617  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -5.236e-05  1.157e-06 -45.267  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.432e-04  6.891e-06 -35.296  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.197e-04  1.844e-05 -39.036  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001533 on 4590638624 degrees of freedom
Multiple R-squared:  9.331e-06,	Adjusted R-squared:  9.321e-06
F-statistic: 911.4 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```

Notice the sharp drop as several of the offences are moved to 10 points.
Repeat the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.752e-07  1.046e-06  -0.263 0.792560    
age_grp16-19                   7.487e-06  1.070e-06   6.998 2.59e-12 ***
age_grp20-24                   8.073e-06  1.054e-06   7.657 1.91e-14 ***
age_grp25-34                   4.213e-06  1.050e-06   4.014 5.96e-05 ***
age_grp35-44                   2.516e-06  1.049e-06   2.399 0.016461 *  
age_grp45-54                   1.369e-06  1.049e-06   1.305 0.191943    
age_grp55-64                   7.722e-07  1.050e-06   0.735 0.462060    
age_grp65-74                   3.946e-07  1.054e-06   0.375 0.707971    
age_grp75-84                   9.127e-08  1.065e-06   0.086 0.931720    
age_grp85-89                   9.976e-08  1.263e-06   0.079 0.937063    
age_grp90-199                  9.962e-09  2.319e-06   0.004 0.996572    
policyTRUE                     9.548e-08  1.488e-06   0.064 0.948835    
curr_pts_grp1                  4.649e-06  3.761e-07  12.358  < 2e-16 ***
curr_pts_grp2                  5.093e-06  1.723e-07  29.551  < 2e-16 ***
curr_pts_grp3                  9.184e-06  1.668e-07  55.065  < 2e-16 ***
curr_pts_grp4                  1.297e-05  4.782e-07  27.124  < 2e-16 ***
curr_pts_grp5                  1.949e-05  3.785e-07  51.501  < 2e-16 ***
curr_pts_grp6                  2.306e-05  4.717e-07  48.886  < 2e-16 ***
curr_pts_grp7                  3.462e-05  8.512e-07  40.671  < 2e-16 ***
curr_pts_grp8                  4.252e-05  8.248e-07  51.553  < 2e-16 ***
curr_pts_grp9                  2.814e-05  8.708e-07  32.318  < 2e-16 ***
curr_pts_grp10                 5.449e-05  1.574e-06  34.618  < 2e-16 ***
curr_pts_grp11-20              6.968e-05  9.853e-07  70.715  < 2e-16 ***
curr_pts_grp21-30              3.245e-04  6.345e-06  51.145  < 2e-16 ***
curr_pts_grp30-150             7.182e-04  1.705e-05  42.125  < 2e-16 ***
age_grp16-19:policyTRUE       -1.925e-06  1.520e-06  -1.266 0.205393    
age_grp20-24:policyTRUE       -3.404e-06  1.500e-06  -2.270 0.023236 *  
age_grp25-34:policyTRUE       -2.006e-06  1.493e-06  -1.344 0.178898    
age_grp35-44:policyTRUE       -1.407e-06  1.492e-06  -0.943 0.345580    
age_grp45-54:policyTRUE       -8.628e-07  1.492e-06  -0.578 0.562958    
age_grp55-64:policyTRUE       -4.619e-07  1.493e-06  -0.309 0.757022    
age_grp65-74:policyTRUE       -2.242e-07  1.498e-06  -0.150 0.881013    
age_grp75-84:policyTRUE        7.587e-09  1.514e-06   0.005 0.996002    
age_grp85-89:policyTRUE       -1.765e-07  1.775e-06  -0.099 0.920821    
age_grp90-199:policyTRUE      -8.291e-08  3.167e-06  -0.026 0.979112    
policyTRUE:curr_pts_grp1      -2.001e-06  5.170e-07  -3.870 0.000109 ***
policyTRUE:curr_pts_grp2      -1.956e-06  2.355e-07  -8.306  < 2e-16 ***
policyTRUE:curr_pts_grp3      -4.603e-06  2.384e-07 -19.308  < 2e-16 ***
policyTRUE:curr_pts_grp4      -4.811e-06  6.304e-07  -7.632 2.31e-14 ***
policyTRUE:curr_pts_grp5      -8.615e-06  5.185e-07 -16.617  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.095e-05  6.475e-07 -16.903  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.397e-05  1.122e-06 -12.448  < 2e-16 ***
policyTRUE:curr_pts_grp8      -2.329e-05  1.112e-06 -20.942  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.492e-05  1.189e-06 -12.551  < 2e-16 ***
policyTRUE:curr_pts_grp10     -3.332e-05  1.972e-06 -16.892  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.516e-05  1.266e-06 -27.768  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.794e-04  7.543e-06 -23.787  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -5.138e-04  2.018e-05 -25.460  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001678 on 4590638624 degrees of freedom
Multiple R-squared:  9.066e-06,	Adjusted R-squared:  9.056e-06
F-statistic: 885.5 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```



### Six-point violations (combinations)

The only offence that merits precisely 6 demerit points is speeding 40-45 over in a 100+ zone, only after the policy change.
Other than that, a driver can only get 6 points for a combination of 1-5 point offences.
Among these, the above offence (40-45 over in a 100+ zone) can be one of two 3-point offences that add to 6 points.

Since the 6 point combination with multiple tickets is rare, the former 3 point violation (fairly common) dominates in the post-policy change period.


The regression with only 6 points as the event is as follows.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.819e-10  5.302e-07  -0.001  0.99958    
age_grp16-19                   1.692e-07  5.421e-07   0.312  0.75500    
age_grp20-24                   5.371e-08  5.343e-07   0.101  0.91992    
age_grp25-34                   1.936e-09  5.318e-07   0.004  0.99710    
age_grp35-44                  -1.902e-09  5.316e-07  -0.004  0.99715    
age_grp45-54                   1.429e-10  5.315e-07   0.000  0.99979    
age_grp55-64                  -2.093e-09  5.320e-07  -0.004  0.99686    
age_grp65-74                  -9.981e-10  5.338e-07  -0.002  0.99851    
age_grp75-84                  -8.697e-10  5.398e-07  -0.002  0.99871    
age_grp85-89                  -8.120e-10  6.402e-07  -0.001  0.99899    
age_grp90-199                  1.451e-10  1.175e-06   0.000  0.99990    
policyTRUE                    -1.272e-07  7.540e-07  -0.169  0.86607    
curr_pts_grp1                 -1.185e-08  1.906e-07  -0.062  0.95044    
curr_pts_grp2                  1.057e-08  8.732e-08   0.121  0.90367    
curr_pts_grp3                 -1.214e-09  8.452e-08  -0.014  0.98854    
curr_pts_grp4                  6.843e-08  2.423e-07   0.282  0.77765    
curr_pts_grp5                  1.403e-07  1.918e-07   0.731  0.46461    
curr_pts_grp6                 -9.959e-09  2.390e-07  -0.042  0.96676    
curr_pts_grp7                 -1.374e-08  4.313e-07  -0.032  0.97459    
curr_pts_grp8                  2.294e-07  4.179e-07   0.549  0.58314    
curr_pts_grp9                  2.561e-07  4.413e-07   0.580  0.56171    
curr_pts_grp10                -1.502e-08  7.976e-07  -0.019  0.98498    
curr_pts_grp11-20              2.050e-06  4.993e-07   4.107 4.01e-05 ***
curr_pts_grp21-30             -2.512e-08  3.215e-06  -0.008  0.99377    
curr_pts_grp30-150            -2.593e-08  8.639e-06  -0.003  0.99761    
age_grp16-19:policyTRUE        2.017e-06  7.703e-07   2.618  0.00884 **
age_grp20-24:policyTRUE        1.913e-06  7.599e-07   2.517  0.01183 *  
age_grp25-34:policyTRUE        1.320e-06  7.563e-07   1.745  0.08091 .  
age_grp35-44:policyTRUE        1.259e-06  7.560e-07   1.666  0.09578 .  
age_grp45-54:policyTRUE        8.251e-07  7.558e-07   1.092  0.27500    
age_grp55-64:policyTRUE        6.085e-07  7.565e-07   0.804  0.42117    
age_grp65-74:policyTRUE        3.437e-07  7.590e-07   0.453  0.65066    
age_grp75-84:policyTRUE        3.409e-07  7.673e-07   0.444  0.65682    
age_grp85-89:policyTRUE       -4.729e-08  8.996e-07  -0.053  0.95808    
age_grp90-199:policyTRUE      -4.281e-08  1.605e-06  -0.027  0.97872    
policyTRUE:curr_pts_grp1       1.788e-06  2.620e-07   6.823 8.89e-12 ***
policyTRUE:curr_pts_grp2       2.074e-06  1.193e-07  17.380  < 2e-16 ***
policyTRUE:curr_pts_grp3       3.441e-06  1.208e-07  28.483  < 2e-16 ***
policyTRUE:curr_pts_grp4       5.629e-06  3.194e-07  17.623  < 2e-16 ***
policyTRUE:curr_pts_grp5       6.662e-06  2.627e-07  25.357  < 2e-16 ***
policyTRUE:curr_pts_grp6       8.431e-06  3.281e-07  25.696  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.062e-05  5.686e-07  18.683  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.245e-05  5.636e-07  22.092  < 2e-16 ***
policyTRUE:curr_pts_grp9       6.550e-06  6.024e-07  10.873  < 2e-16 ***
policyTRUE:curr_pts_grp10      1.588e-05  9.994e-07  15.886  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   1.869e-05  6.416e-07  29.126  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   9.319e-05  3.822e-06  24.383  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  8.147e-05  1.023e-05   7.967 1.62e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00085 on 4590638624 degrees of freedom
Multiple R-squared:  3.837e-06,	Adjusted R-squared:  3.827e-06
F-statistic: 374.8 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```


Consider next the combined event with either 3 or 6 points at a single roadside stop.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.034e-05  6.591e-06   4.603 4.16e-06 ***
age_grp16-19                   9.417e-05  6.738e-06  13.975  < 2e-16 ***
age_grp20-24                   1.025e-04  6.641e-06  15.428  < 2e-16 ***
age_grp25-34                   7.462e-05  6.611e-06  11.287  < 2e-16 ***
age_grp35-44                   6.601e-05  6.608e-06   9.989  < 2e-16 ***
age_grp45-54                   4.320e-05  6.607e-06   6.539 6.18e-11 ***
age_grp55-64                   2.406e-05  6.613e-06   3.638 0.000275 ***
age_grp65-74                   8.252e-06  6.636e-06   1.243 0.213700    
age_grp75-84                   8.159e-07  6.710e-06   0.122 0.903221    
age_grp85-89                  -4.385e-06  7.958e-06  -0.551 0.581609    
age_grp90-199                  6.671e-07  1.461e-05   0.046 0.963574    
policyTRUE                     1.085e-06  9.373e-06   0.116 0.907829    
curr_pts_grp1                  1.182e-04  2.369e-06  49.904  < 2e-16 ***
curr_pts_grp2                  1.692e-04  1.086e-06 155.844  < 2e-16 ***
curr_pts_grp3                  2.385e-04  1.051e-06 226.970  < 2e-16 ***
curr_pts_grp4                  3.255e-04  3.012e-06 108.066  < 2e-16 ***
curr_pts_grp5                  4.257e-04  2.384e-06 178.569  < 2e-16 ***
curr_pts_grp6                  5.458e-04  2.971e-06 183.699  < 2e-16 ***
curr_pts_grp7                  5.898e-04  5.362e-06 110.003  < 2e-16 ***
curr_pts_grp8                  7.196e-04  5.195e-06 138.509  < 2e-16 ***
curr_pts_grp9                  5.741e-04  5.485e-06 104.665  < 2e-16 ***
curr_pts_grp10                 8.517e-04  9.915e-06  85.901  < 2e-16 ***
curr_pts_grp11-20              9.227e-04  6.206e-06 148.671  < 2e-16 ***
curr_pts_grp21-30              2.010e-03  3.997e-05  50.297  < 2e-16 ***
curr_pts_grp30-150             4.227e-03  1.074e-04  39.360  < 2e-16 ***
age_grp16-19:policyTRUE        4.466e-07  9.576e-06   0.047 0.962802    
age_grp20-24:policyTRUE       -3.057e-06  9.447e-06  -0.324 0.746251    
age_grp25-34:policyTRUE       -1.363e-05  9.402e-06  -1.450 0.147136    
age_grp35-44:policyTRUE       -1.008e-05  9.398e-06  -1.073 0.283323    
age_grp45-54:policyTRUE       -1.219e-05  9.396e-06  -1.297 0.194507    
age_grp55-64:policyTRUE       -9.730e-06  9.404e-06  -1.035 0.300809    
age_grp65-74:policyTRUE       -3.928e-06  9.435e-06  -0.416 0.677192    
age_grp75-84:policyTRUE       -2.323e-06  9.538e-06  -0.244 0.807528    
age_grp85-89:policyTRUE        6.614e-06  1.118e-05   0.591 0.554236    
age_grp90-199:policyTRUE       4.496e-06  1.995e-05   0.225 0.821669    
policyTRUE:curr_pts_grp1       3.290e-06  3.257e-06   1.010 0.312422    
policyTRUE:curr_pts_grp2      -1.090e-05  1.483e-06  -7.346 2.04e-13 ***
policyTRUE:curr_pts_grp3      -1.874e-05  1.502e-06 -12.477  < 2e-16 ***
policyTRUE:curr_pts_grp4      -7.635e-06  3.971e-06  -1.923 0.054492 .  
policyTRUE:curr_pts_grp5      -2.131e-05  3.266e-06  -6.525 6.81e-11 ***
policyTRUE:curr_pts_grp6      -4.525e-05  4.079e-06 -11.093  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.219e-05  7.068e-06  -3.140 0.001688 **
policyTRUE:curr_pts_grp8      -4.016e-05  7.006e-06  -5.733 9.87e-09 ***
policyTRUE:curr_pts_grp9      -9.515e-06  7.488e-06  -1.271 0.203840    
policyTRUE:curr_pts_grp10     -1.690e-04  1.242e-05 -13.603  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -9.290e-05  7.975e-06 -11.649  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -4.809e-04  4.751e-05 -10.122  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.301e-03  1.271e-04 -18.101  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01057 on 4590638624 degrees of freedom
Multiple R-squared:  0.0001066,	Adjusted R-squared:  0.0001066
F-statistic: 1.042e+04 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```



### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.

```R

```

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards.
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence.

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.245e-08  2.867e-07  -0.078 0.937604    
age_grp16-19                   1.589e-06  2.931e-07   5.421 5.94e-08 ***
age_grp20-24                   8.672e-07  2.889e-07   3.002 0.002686 **
age_grp25-34                   3.146e-07  2.876e-07   1.094 0.273949    
age_grp35-44                   9.996e-08  2.875e-07   0.348 0.728054    
age_grp45-54                   3.429e-08  2.874e-07   0.119 0.905026    
age_grp55-64                  -1.530e-08  2.877e-07  -0.053 0.957598    
age_grp65-74                  -6.076e-09  2.887e-07  -0.021 0.983207    
age_grp75-84                   1.646e-08  2.919e-07   0.056 0.955032    
age_grp85-89                  -7.741e-09  3.462e-07  -0.022 0.982160    
age_grp90-199                  2.434e-10  6.355e-07   0.000 0.999694    
policyTRUE                     1.015e-08  4.077e-07   0.025 0.980133    
curr_pts_grp1                  1.133e-07  1.031e-07   1.099 0.271793    
curr_pts_grp2                  3.126e-07  4.722e-08   6.619 3.62e-11 ***
curr_pts_grp3                  7.356e-07  4.570e-08  16.094  < 2e-16 ***
curr_pts_grp4                  1.117e-06  1.310e-07   8.527  < 2e-16 ***
curr_pts_grp5                  2.073e-06  1.037e-07  19.990  < 2e-16 ***
curr_pts_grp6                  3.142e-06  1.292e-07  24.313  < 2e-16 ***
curr_pts_grp7                  3.053e-06  2.333e-07  13.087  < 2e-16 ***
curr_pts_grp8                  2.386e-06  2.260e-07  10.559  < 2e-16 ***
curr_pts_grp9                  2.432e-06  2.386e-07  10.193  < 2e-16 ***
curr_pts_grp10                 6.729e-06  4.313e-07  15.602  < 2e-16 ***
curr_pts_grp11-20              9.667e-06  2.700e-07  35.804  < 2e-16 ***
curr_pts_grp21-30              5.678e-05  1.739e-06  32.656  < 2e-16 ***
curr_pts_grp30-150            -4.681e-07  4.672e-06  -0.100 0.920182    
age_grp16-19:policyTRUE       -8.877e-07  4.166e-07  -2.131 0.033100 *  
age_grp20-24:policyTRUE       -3.120e-07  4.109e-07  -0.759 0.447694    
age_grp25-34:policyTRUE       -1.961e-07  4.090e-07  -0.479 0.631665    
age_grp35-44:policyTRUE       -7.165e-08  4.088e-07  -0.175 0.860891    
age_grp45-54:policyTRUE       -2.114e-08  4.087e-07  -0.052 0.958753    
age_grp55-64:policyTRUE        1.720e-08  4.091e-07   0.042 0.966456    
age_grp65-74:policyTRUE        5.823e-10  4.105e-07   0.001 0.998868    
age_grp75-84:policyTRUE       -2.247e-08  4.149e-07  -0.054 0.956818    
age_grp85-89:policyTRUE       -1.040e-09  4.865e-07  -0.002 0.998295    
age_grp90-199:policyTRUE      -8.184e-09  8.678e-07  -0.009 0.992475    
policyTRUE:curr_pts_grp1       6.050e-09  1.417e-07   0.043 0.965936    
policyTRUE:curr_pts_grp2      -1.844e-07  6.453e-08  -2.858 0.004258 **
policyTRUE:curr_pts_grp3      -5.000e-07  6.533e-08  -7.654 1.95e-14 ***
policyTRUE:curr_pts_grp4      -6.380e-07  1.727e-07  -3.693 0.000221 ***
policyTRUE:curr_pts_grp5      -1.397e-06  1.421e-07  -9.830  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.012e-06  1.774e-07 -11.341  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.860e-06  3.075e-07  -6.048 1.46e-09 ***
policyTRUE:curr_pts_grp8      -1.531e-06  3.048e-07  -5.025 5.05e-07 ***
policyTRUE:curr_pts_grp9       2.221e-07  3.258e-07   0.682 0.495373    
policyTRUE:curr_pts_grp10     -3.879e-06  5.405e-07  -7.178 7.07e-13 ***
policyTRUE:curr_pts_grp11-20  -4.686e-06  3.469e-07 -13.507  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -9.767e-06  2.067e-06  -4.726 2.29e-06 ***
policyTRUE:curr_pts_grp30-150  2.046e-07  5.530e-06   0.037 0.970487    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0004597 on 4590638624 degrees of freedom
Multiple R-squared:  1.916e-06,	Adjusted R-squared:  1.906e-06
F-statistic: 187.1 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```


### Nine-point violations (speeding 81-100 over or combinations)

One offence that merits 9 demerit points is speeding 80-100 over, only before the policy change, after which it was changed to a 18-point offence.
Other than that, there 7 other violations that result in 9 demerit points, none of which were changed with the excessive speeding policy.

The combined 9- and 18-point event is analyzed in the following logistic regression:

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.506e-06  6.698e-07   2.248  0.02457 *  
age_grp16-19                   1.652e-06  6.848e-07   2.413  0.01583 *  
age_grp20-24                   2.572e-07  6.750e-07   0.381  0.70317    
age_grp25-34                  -4.251e-07  6.719e-07  -0.633  0.52695    
age_grp35-44                  -6.978e-07  6.716e-07  -1.039  0.29882    
age_grp45-54                  -8.636e-07  6.715e-07  -1.286  0.19838    
age_grp55-64                  -8.559e-07  6.721e-07  -1.274  0.20283    
age_grp65-74                  -5.817e-07  6.744e-07  -0.863  0.38840    
age_grp75-84                   3.584e-07  6.819e-07   0.526  0.59921    
age_grp85-89                   1.099e-06  8.088e-07   1.359  0.17406    
age_grp90-199                 -3.078e-08  1.485e-06  -0.021  0.98346    
policyTRUE                     3.367e-08  9.525e-07   0.035  0.97180    
curr_pts_grp1                  5.651e-07  2.408e-07   2.347  0.01892 *  
curr_pts_grp2                  1.067e-06  1.103e-07   9.668  < 2e-16 ***
curr_pts_grp3                  1.488e-06  1.068e-07  13.932  < 2e-16 ***
curr_pts_grp4                  4.767e-06  3.062e-07  15.571  < 2e-16 ***
curr_pts_grp5                  2.853e-06  2.423e-07  11.775  < 2e-16 ***
curr_pts_grp6                  3.777e-06  3.019e-07  12.509  < 2e-16 ***
curr_pts_grp7                  2.775e-06  5.449e-07   5.092 3.54e-07 ***
curr_pts_grp8                  4.739e-06  5.280e-07   8.976  < 2e-16 ***
curr_pts_grp9                  8.065e-06  5.575e-07  14.467  < 2e-16 ***
curr_pts_grp10                 1.297e-05  1.008e-06  12.871  < 2e-16 ***
curr_pts_grp11-20              1.368e-05  6.307e-07  21.695  < 2e-16 ***
curr_pts_grp21-30              2.732e-05  4.062e-06   6.725 1.76e-11 ***
curr_pts_grp30-150             1.020e-04  1.091e-05   9.344  < 2e-16 ***
age_grp16-19:policyTRUE       -3.422e-07  9.732e-07  -0.352  0.72511    
age_grp20-24:policyTRUE       -9.668e-08  9.601e-07  -0.101  0.91978    
age_grp25-34:policyTRUE       -2.513e-08  9.555e-07  -0.026  0.97902    
age_grp35-44:policyTRUE       -1.019e-07  9.551e-07  -0.107  0.91507    
age_grp45-54:policyTRUE       -1.720e-07  9.549e-07  -0.180  0.85708    
age_grp55-64:policyTRUE       -1.692e-07  9.557e-07  -0.177  0.85946    
age_grp65-74:policyTRUE       -1.362e-07  9.589e-07  -0.142  0.88704    
age_grp75-84:policyTRUE        1.294e-07  9.693e-07   0.133  0.89382    
age_grp85-89:policyTRUE        3.950e-07  1.136e-06   0.348  0.72816    
age_grp90-199:policyTRUE       4.694e-06  2.027e-06   2.315  0.02059 *  
policyTRUE:curr_pts_grp1       2.268e-07  3.310e-07   0.685  0.49325    
policyTRUE:curr_pts_grp2      -4.032e-07  1.507e-07  -2.675  0.00748 **
policyTRUE:curr_pts_grp3      -3.194e-07  1.526e-07  -2.093  0.03637 *  
policyTRUE:curr_pts_grp4      -1.800e-06  4.035e-07  -4.460 8.18e-06 ***
policyTRUE:curr_pts_grp5      -3.675e-07  3.319e-07  -1.107  0.26818    
policyTRUE:curr_pts_grp6      -1.681e-06  4.145e-07  -4.055 5.01e-05 ***
policyTRUE:curr_pts_grp7       4.050e-07  7.183e-07   0.564  0.57288    
policyTRUE:curr_pts_grp8      -1.773e-06  7.120e-07  -2.490  0.01277 *  
policyTRUE:curr_pts_grp9      -9.652e-07  7.610e-07  -1.268  0.20471    
policyTRUE:curr_pts_grp10     -1.251e-05  1.263e-06  -9.909  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.788e-06  8.105e-07  -4.673 2.96e-06 ***
policyTRUE:curr_pts_grp21-30  -1.085e-05  4.829e-06  -2.246  0.02470 *  
policyTRUE:curr_pts_grp30-150 -2.041e-05  1.292e-05  -1.580  0.11409    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001074 on 4590638624 degrees of freedom
Multiple R-squared:  9.209e-07,	Adjusted R-squared:  9.106e-07
F-statistic: 89.94 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```

### Twelve-point violations (speeding 100-119 over or 3 other offences)

The 12-point speeding offence was changed to a 24-point offence but the others were unchanged.



```R

```



### Twelve-points and up (speeding 100 or more and 3 other 12-point offences)

Combining with the more excessive speeding offences, the results are close to the case including only the 12-point offences.



```R

```


### More than Twelve points (only speeding 120 or more)

This category includes speeding 120-139 over (15, changed to 30 points after policy change),
speeding 140-159 over (18, changed to 36 points after policy change),


```R

```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.506e-06  6.702e-07   2.247   0.0246 *  
age_grp16-19                   1.652e-06  6.852e-07   2.411   0.0159 *  
age_grp20-24                   2.623e-07  6.753e-07   0.388   0.6978    
age_grp25-34                  -4.256e-07  6.723e-07  -0.633   0.5266    
age_grp35-44                  -6.982e-07  6.719e-07  -1.039   0.2988    
age_grp45-54                  -8.620e-07  6.718e-07  -1.283   0.1994    
age_grp55-64                  -8.561e-07  6.725e-07  -1.273   0.2030    
age_grp65-74                  -5.818e-07  6.748e-07  -0.862   0.3886    
age_grp75-84                   3.583e-07  6.823e-07   0.525   0.5995    
age_grp85-89                   1.099e-06  8.092e-07   1.358   0.1743    
age_grp90-199                 -3.078e-08  1.485e-06  -0.021   0.9835    
policyTRUE                     3.365e-08  9.531e-07   0.035   0.9718    
curr_pts_grp1                  5.645e-07  2.409e-07   2.343   0.0191 *  
curr_pts_grp2                  1.066e-06  1.104e-07   9.657  < 2e-16 ***
curr_pts_grp3                  1.487e-06  1.068e-07  13.919  < 2e-16 ***
curr_pts_grp4                  4.766e-06  3.063e-07  15.560  < 2e-16 ***
curr_pts_grp5                  2.852e-06  2.424e-07  11.765  < 2e-16 ***
curr_pts_grp6                  3.776e-06  3.021e-07  12.500  < 2e-16 ***
curr_pts_grp7                  2.774e-06  5.452e-07   5.088 3.63e-07 ***
curr_pts_grp8                  4.979e-06  5.283e-07   9.426  < 2e-16 ***
curr_pts_grp9                  8.064e-06  5.578e-07  14.457  < 2e-16 ***
curr_pts_grp10                 1.297e-05  1.008e-06  12.863  < 2e-16 ***
curr_pts_grp11-20              1.368e-05  6.311e-07  21.681  < 2e-16 ***
curr_pts_grp21-30              2.732e-05  4.064e-06   6.721 1.81e-11 ***
curr_pts_grp30-150             1.020e-04  1.092e-05   9.338  < 2e-16 ***
age_grp16-19:policyTRUE       -3.432e-07  9.737e-07  -0.352   0.7245    
age_grp20-24:policyTRUE       -9.112e-08  9.606e-07  -0.095   0.9244    
age_grp25-34:policyTRUE       -2.629e-08  9.561e-07  -0.028   0.9781    
age_grp35-44:policyTRUE       -1.007e-07  9.557e-07  -0.105   0.9161    
age_grp45-54:policyTRUE       -1.747e-07  9.554e-07  -0.183   0.8549    
age_grp55-64:policyTRUE       -1.698e-07  9.563e-07  -0.178   0.8591    
age_grp65-74:policyTRUE       -1.314e-07  9.594e-07  -0.137   0.8911    
age_grp75-84:policyTRUE        1.291e-07  9.699e-07   0.133   0.8941    
age_grp85-89:policyTRUE        3.948e-07  1.137e-06   0.347   0.7284    
age_grp90-199:policyTRUE       4.694e-06  2.028e-06   2.314   0.0207 *  
policyTRUE:curr_pts_grp1       2.268e-07  3.312e-07   0.685   0.4934    
policyTRUE:curr_pts_grp2      -3.946e-07  1.508e-07  -2.616   0.0089 **
policyTRUE:curr_pts_grp3      -3.195e-07  1.527e-07  -2.092   0.0364 *  
policyTRUE:curr_pts_grp4      -1.800e-06  4.038e-07  -4.458 8.27e-06 ***
policyTRUE:curr_pts_grp5      -3.237e-07  3.321e-07  -0.975   0.3297    
policyTRUE:curr_pts_grp6      -1.681e-06  4.147e-07  -4.053 5.05e-05 ***
policyTRUE:curr_pts_grp7       4.048e-07  7.187e-07   0.563   0.5733    
policyTRUE:curr_pts_grp8      -1.817e-06  7.124e-07  -2.551   0.0107 *  
policyTRUE:curr_pts_grp9      -9.656e-07  7.615e-07  -1.268   0.2048    
policyTRUE:curr_pts_grp10     -1.251e-05  1.263e-06  -9.904  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.788e-06  8.110e-07  -4.672 2.99e-06 ***
policyTRUE:curr_pts_grp21-30  -1.085e-05  4.831e-06  -2.245   0.0248 *  
policyTRUE:curr_pts_grp30-150 -2.041e-05  1.293e-05  -1.579   0.1143    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001074 on 4590638624 degrees of freedom
Multiple R-squared:  9.242e-07,	Adjusted R-squared:  9.139e-07
F-statistic: 90.27 on 47 and 4590638624 DF,  p-value: < 2.2e-16
```
