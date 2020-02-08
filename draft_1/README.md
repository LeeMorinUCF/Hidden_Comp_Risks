
# Draft 1: Second version

Current point groups have been further consolidated in the regressions below.

# UNDER CONSTRUCTION!

Please see the old version in ```README_v1.md```.


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

A new categorical variable ```curr_pts_grp``` was added to capture the number of demerit points that a driver has accumulated over the past two years.
This was simple to calculate for the violation events.
For the non-events, an aggregate calculation was performed to take an inventory of the population of drivers with different point histories for each sex and age category.
To reduce the computational burden, the violation history was aggregated into the number of points for point levels 0-10, and in categories 11-20, 21-30 and 30-150, 150 being the highest observed.
In roughly 35% of the driver-days, drivers have no point history.
A further 45% have up to 10 demerit points in the last two years.
The 11-20 category accounts for the next decile.
The remaining decile  is split 7-3% between the next two categories, 21-30 and 30-150, respectively.
The last three categories were consolidated into a 10-150 point category.


### Policy Change: Excessive Speeding

On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revocation of licenses.
Under this policy change, some violations are associated with different demerit point levels.

### Sample selection

The sample was limited to an equal window of two years before and after the date of the policy change,
from April 1, 2006 to March 31, 2010.
The summer months account for a large fraction of the infractions, so it is important to either impose symmetry over the calendar year or explicitly model the seasonality.




## Time Series Plots



### Pairs of Point Values for Related Speeding violations

Plots of the number of instances of tickets with selected pairs of point values.
Coloring should be clear from the context: original point value occurs before the
date of the policy change, the double-point tickets occur afterward.

The 5- and 10-point ticket volumes highlight the strategic choice of pairs of offences.

<img src="num_pts_5_10_all.png" width="1000" />
<img src="num_pts_5_10_M.png" width="1000" />
<img src="num_pts_5_10_F.png" width="1000" />

The 7- and 14- point pair is much cleaner comparison,
since the combinations of other tickets worth 7 points are relatively rare.


<img src="num_pts_7_14_all.png" width="1000" />
<img src="num_pts_7_14_M.png" width="1000" />
<img src="num_pts_7_14_F.png" width="1000" />

### Accumulated Points Balances (Included later)

For each driver, an accumulated demerit point balance
is calculated as the sum of the points awarded to each driver for all violations committed over a two-year rolling window.
A rolling window is used, as opposed to cumulative demerit points, to avoid continually growing balances over the sample period.
The two-year horizon is chosen because that is the time period over which demerit points remain on a driver's record,
potentially counting toward a revocation.

## Tables - Summary Statistics (Included later)


## Linear Probability Models

The following are linear probability regression models estimated from data aggregated by age groups and categories of previous demerit points.
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the same sex and age groups and categories of previous demerit points.

### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 1.079e-04  8.256e-06  13.068  < 2e-16 ***
age_grp16-19                6.471e-04  8.707e-06  74.317  < 2e-16 ***
age_grp20-24                4.850e-04  8.426e-06  57.558  < 2e-16 ***
age_grp25-34                3.133e-04  8.323e-06  37.639  < 2e-16 ***
age_grp35-44                2.393e-04  8.313e-06  28.793  < 2e-16 ***
age_grp45-54                1.901e-04  8.308e-06  22.877  < 2e-16 ***
age_grp55-64                1.294e-04  8.325e-06  15.546  < 2e-16 ***
age_grp65-199               3.740e-05  8.339e-06   4.485 7.28e-06 ***
policyTRUE                 -1.106e-06  1.184e-05  -0.093  0.92558    
curr_pts_grp1-3             6.518e-04  1.262e-06 516.410  < 2e-16 ***
curr_pts_grp4-6             1.268e-03  2.122e-06 597.289  < 2e-16 ***
curr_pts_grp7-9             1.752e-03  3.356e-06 521.983  < 2e-16 ***
age_grp16-19:policyTRUE    -6.116e-05  1.244e-05  -4.918 8.73e-07 ***
age_grp20-24:policyTRUE    -7.486e-05  1.208e-05  -6.200 5.64e-10 ***
age_grp25-34:policyTRUE    -6.036e-05  1.193e-05  -5.060 4.20e-07 ***
age_grp35-44:policyTRUE    -3.327e-05  1.192e-05  -2.791  0.00525 **
age_grp45-54:policyTRUE    -2.424e-05  1.191e-05  -2.035  0.04181 *  
age_grp55-64:policyTRUE    -1.832e-05  1.193e-05  -1.536  0.12465    
age_grp65-199:policyTRUE   -2.018e-06  1.195e-05  -0.169  0.86586    
policyTRUE:curr_pts_grp1-3 -6.805e-05  1.742e-06 -39.059  < 2e-16 ***
policyTRUE:curr_pts_grp4-6 -1.291e-04  2.870e-06 -44.966  < 2e-16 ***
policyTRUE:curr_pts_grp7-9 -1.465e-04  4.527e-06 -32.357  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02223 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  0.0003593,	Adjusted R-squared:  0.0003593
F-statistic: 9.007e+04 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 3.617e-05  1.061e-05   3.410  0.00065 ***
age_grp16-19                2.689e-04  1.085e-05  24.784  < 2e-16 ***
age_grp20-24                2.669e-04  1.069e-05  24.969  < 2e-16 ***
age_grp25-34                2.138e-04  1.064e-05  20.092  < 2e-16 ***
age_grp35-44                1.909e-04  1.064e-05  17.949  < 2e-16 ***
age_grp45-54                1.405e-04  1.063e-05  13.216  < 2e-16 ***
age_grp55-64                9.144e-05  1.065e-05   8.590  < 2e-16 ***
age_grp65-199               4.178e-05  1.066e-05   3.919 8.90e-05 ***
policyTRUE                 -6.226e-06  1.472e-05  -0.423  0.67228    
curr_pts_grp1-3             4.399e-04  1.198e-06 367.150  < 2e-16 ***
curr_pts_grp4-6             9.111e-04  2.564e-06 355.403  < 2e-16 ***
curr_pts_grp7-9             1.275e-03  4.963e-06 256.851  < 2e-16 ***
age_grp16-19:policyTRUE     1.021e-05  1.504e-05   0.679  0.49698    
age_grp20-24:policyTRUE     2.821e-06  1.483e-05   0.190  0.84917    
age_grp25-34:policyTRUE    -8.363e-06  1.476e-05  -0.566  0.57109    
age_grp35-44:policyTRUE     1.790e-06  1.476e-05   0.121  0.90346    
age_grp45-54:policyTRUE    -1.042e-06  1.475e-05  -0.071  0.94370    
age_grp55-64:policyTRUE     1.655e-06  1.477e-05   0.112  0.91076    
age_grp65-199:policyTRUE    9.528e-06  1.479e-05   0.644  0.51936    
policyTRUE:curr_pts_grp1-3 -1.106e-05  1.633e-06  -6.777 1.23e-11 ***
policyTRUE:curr_pts_grp4-6 -1.429e-05  3.403e-06  -4.199 2.68e-05 ***
policyTRUE:curr_pts_grp7-9 -2.148e-06  6.530e-06  -0.329  0.74221    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01618 on 4329784692 degrees of freedom
  (79070 observations deleted due to missingness)
Multiple R-squared:  0.0001862,	Adjusted R-squared:  0.0001862
F-statistic: 3.84e+04 on 21 and 4329784692 DF,  p-value: < 2.2e-16
```

### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.



#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 1.849e-06  2.334e-06   0.792 0.428161    
age_grp16-19                5.140e-05  2.461e-06  20.885  < 2e-16 ***
age_grp20-24                2.857e-05  2.382e-06  11.996  < 2e-16 ***
age_grp25-34                2.520e-05  2.352e-06  10.711  < 2e-16 ***
age_grp35-44                2.468e-05  2.349e-06  10.506  < 2e-16 ***
age_grp45-54                2.226e-05  2.348e-06   9.480  < 2e-16 ***
age_grp55-64                1.784e-05  2.353e-06   7.580 3.45e-14 ***
age_grp65-199               8.639e-06  2.357e-06   3.665 0.000247 ***
policyTRUE                  2.219e-06  3.345e-06   0.663 0.507221    
curr_pts_grp1-3             4.762e-05  3.567e-07 133.473  < 2e-16 ***
curr_pts_grp4-6             8.556e-05  5.999e-07 142.625  < 2e-16 ***
curr_pts_grp7-9             1.263e-04  9.484e-07 133.163  < 2e-16 ***
age_grp16-19:policyTRUE    -2.912e-07  3.515e-06  -0.083 0.933978    
age_grp20-24:policyTRUE    -3.838e-06  3.413e-06  -1.125 0.260762    
age_grp25-34:policyTRUE    -1.604e-06  3.372e-06  -0.476 0.634165    
age_grp35-44:policyTRUE     8.827e-07  3.368e-06   0.262 0.793253    
age_grp45-54:policyTRUE     1.814e-06  3.365e-06   0.539 0.589862    
age_grp55-64:policyTRUE     1.952e-06  3.372e-06   0.579 0.562664    
age_grp65-199:policyTRUE    2.189e-06  3.376e-06   0.648 0.516751    
policyTRUE:curr_pts_grp1-3  4.442e-06  4.924e-07   9.021  < 2e-16 ***
policyTRUE:curr_pts_grp4-6  8.665e-06  8.112e-07  10.682  < 2e-16 ***
policyTRUE:curr_pts_grp7-9  1.106e-05  1.279e-06   8.648  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006282 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  2.581e-05,	Adjusted R-squared:  2.58e-05
F-statistic:  6468 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 1.114e-06  3.232e-06   0.345  0.73034    
age_grp16-19                3.211e-05  3.305e-06   9.715  < 2e-16 ***
age_grp20-24                2.537e-05  3.258e-06   7.789 6.74e-15 ***
age_grp25-34                2.044e-05  3.242e-06   6.305 2.88e-10 ***
age_grp35-44                1.739e-05  3.241e-06   5.364 8.12e-08 ***
age_grp45-54                1.346e-05  3.240e-06   4.155 3.25e-05 ***
age_grp55-64                9.349e-06  3.243e-06   2.883  0.00394 **
age_grp65-199               4.810e-06  3.248e-06   1.481  0.13862    
policyTRUE                 -1.580e-06  4.484e-06  -0.352  0.72463    
curr_pts_grp1-3             3.411e-05  3.650e-07  93.448  < 2e-16 ***
curr_pts_grp4-6             5.971e-05  7.811e-07  76.440  < 2e-16 ***
curr_pts_grp7-9             8.418e-05  1.512e-06  55.671  < 2e-16 ***
age_grp16-19:policyTRUE     7.491e-06  4.582e-06   1.635  0.10212    
age_grp20-24:policyTRUE     3.399e-06  4.520e-06   0.752  0.45201    
age_grp25-34:policyTRUE     5.105e-06  4.498e-06   1.135  0.25644    
age_grp35-44:policyTRUE     6.376e-06  4.497e-06   1.418  0.15624    
age_grp45-54:policyTRUE     5.637e-06  4.495e-06   1.254  0.20988    
age_grp55-64:policyTRUE     5.457e-06  4.499e-06   1.213  0.22518    
age_grp65-199:policyTRUE    5.203e-06  4.506e-06   1.155  0.24818    
policyTRUE:curr_pts_grp1-3  8.153e-06  4.975e-07  16.389  < 2e-16 ***
policyTRUE:curr_pts_grp4-6  1.517e-05  1.037e-06  14.634  < 2e-16 ***
policyTRUE:curr_pts_grp7-9  1.929e-05  1.990e-06   9.694  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004929 on 4329784692 degrees of freedom
  (79070 observations deleted due to missingness)
Multiple R-squared:  1.425e-05,	Adjusted R-squared:  1.425e-05
F-statistic:  2939 on 21 and 4329784692 DF,  p-value: < 2.2e-16
```

### Two-point violations (speeding 21-30 over or 7 other violations)

#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                -5.768e-06  5.228e-06  -1.103 0.269944    
age_grp16-19                1.965e-04  5.513e-06  35.636  < 2e-16 ***
age_grp20-24                1.788e-04  5.336e-06  33.503  < 2e-16 ***
age_grp25-34                1.584e-04  5.270e-06  30.063  < 2e-16 ***
age_grp35-44                1.488e-04  5.264e-06  28.261  < 2e-16 ***
age_grp45-54                1.379e-04  5.261e-06  26.214  < 2e-16 ***
age_grp55-64                1.145e-04  5.272e-06  21.725  < 2e-16 ***
age_grp65-199               6.827e-05  5.281e-06  12.928  < 2e-16 ***
policyTRUE                  2.603e-07  7.495e-06   0.035 0.972296    
curr_pts_grp1-3             2.512e-04  7.992e-07 314.246  < 2e-16 ***
curr_pts_grp4-6             4.592e-04  1.344e-06 341.679  < 2e-16 ***
curr_pts_grp7-9             6.021e-04  2.125e-06 283.361  < 2e-16 ***
age_grp16-19:policyTRUE     8.336e-06  7.875e-06   1.059 0.289808    
age_grp20-24:policyTRUE    -7.147e-07  7.646e-06  -0.093 0.925524    
age_grp25-34:policyTRUE    -7.562e-06  7.554e-06  -1.001 0.316816    
age_grp35-44:policyTRUE    -4.074e-06  7.546e-06  -0.540 0.589269    
age_grp45-54:policyTRUE    -1.878e-06  7.540e-06  -0.249 0.803298    
age_grp55-64:policyTRUE    -1.601e-06  7.554e-06  -0.212 0.832155    
age_grp65-199:policyTRUE    1.650e-06  7.564e-06   0.218 0.827313    
policyTRUE:curr_pts_grp1-3 -4.208e-06  1.103e-06  -3.814 0.000137 ***
policyTRUE:curr_pts_grp4-6 -3.243e-06  1.817e-06  -1.785 0.074306 .  
policyTRUE:curr_pts_grp7-9  5.433e-06  2.866e-06   1.895 0.058037 .  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01407 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  0.0001212,	Adjusted R-squared:  0.0001212
F-statistic: 3.037e+04 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                -1.222e-06  7.221e-06  -0.169    0.866    
age_grp16-19                1.176e-04  7.384e-06  15.927  < 2e-16 ***
age_grp20-24                1.261e-04  7.277e-06  17.323  < 2e-16 ***
age_grp25-34                1.149e-04  7.243e-06  15.868  < 2e-16 ***
age_grp35-44                1.075e-04  7.240e-06  14.844  < 2e-16 ***
age_grp45-54                8.618e-05  7.238e-06  11.906  < 2e-16 ***
age_grp55-64                6.175e-05  7.245e-06   8.523  < 2e-16 ***
age_grp65-199               3.459e-05  7.256e-06   4.767 1.87e-06 ***
policyTRUE                 -3.580e-06  1.002e-05  -0.357    0.721    
curr_pts_grp1-3             1.937e-04  8.155e-07 237.497  < 2e-16 ***
curr_pts_grp4-6             3.815e-04  1.745e-06 218.664  < 2e-16 ***
curr_pts_grp7-9             4.966e-04  3.378e-06 147.016  < 2e-16 ***
age_grp16-19:policyTRUE     1.200e-05  1.024e-05   1.172    0.241    
age_grp20-24:policyTRUE     9.214e-06  1.010e-05   0.913    0.361    
age_grp25-34:policyTRUE     3.707e-06  1.005e-05   0.369    0.712    
age_grp35-44:policyTRUE     7.174e-06  1.005e-05   0.714    0.475    
age_grp45-54:policyTRUE     5.970e-06  1.004e-05   0.594    0.552    
age_grp55-64:policyTRUE     5.241e-06  1.005e-05   0.521    0.602    
age_grp65-199:policyTRUE    6.284e-06  1.007e-05   0.624    0.532    
policyTRUE:curr_pts_grp1-3  6.341e-06  1.111e-06   5.706 1.16e-08 ***
policyTRUE:curr_pts_grp4-6  2.063e-05  2.316e-06   8.906  < 2e-16 ***
policyTRUE:curr_pts_grp7-9  3.744e-05  4.445e-06   8.423  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01101 on 4329784692 degrees of freedom
  (79070 observations deleted due to missingness)
Multiple R-squared:  7.7e-05,	Adjusted R-squared:  7.699e-05
F-statistic: 1.588e+04 on 21 and 4329784692 DF,  p-value: < 2.2e-16
```

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change. That is, the 6-point violations are not included in the sample before the window.

#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 9.230e-05  5.706e-06  16.175  < 2e-16 ***
age_grp16-19                2.827e-04  6.018e-06  46.979  < 2e-16 ***
age_grp20-24                2.286e-04  5.824e-06  39.245  < 2e-16 ***
age_grp25-34                1.231e-04  5.752e-06  21.400  < 2e-16 ***
age_grp35-44                7.634e-05  5.745e-06  13.288  < 2e-16 ***
age_grp45-54                4.551e-05  5.742e-06   7.926 2.27e-15 ***
age_grp55-64                1.572e-05  5.754e-06   2.732 0.006295 **
age_grp65-199              -2.037e-05  5.764e-06  -3.533 0.000410 ***
policyTRUE                  1.811e-06  8.181e-06   0.221 0.824821    
curr_pts_grp1-3             3.236e-04  8.724e-07 370.932  < 2e-16 ***
curr_pts_grp4-6             6.486e-04  1.467e-06 442.157  < 2e-16 ***
curr_pts_grp7-9             9.001e-04  2.319e-06 388.120  < 2e-16 ***
age_grp16-19:policyTRUE    -4.692e-05  8.595e-06  -5.459 4.80e-08 ***
age_grp20-24:policyTRUE    -5.371e-05  8.345e-06  -6.436 1.22e-10 ***
age_grp25-34:policyTRUE    -4.625e-05  8.245e-06  -5.610 2.03e-08 ***
age_grp35-44:policyTRUE    -3.199e-05  8.236e-06  -3.884 0.000103 ***
age_grp45-54:policyTRUE    -2.756e-05  8.230e-06  -3.349 0.000812 ***
age_grp55-64:policyTRUE    -2.356e-05  8.245e-06  -2.858 0.004265 **
age_grp65-199:policyTRUE   -1.125e-05  8.256e-06  -1.363 0.172881    
policyTRUE:curr_pts_grp1-3 -5.416e-05  1.204e-06 -44.979  < 2e-16 ***
policyTRUE:curr_pts_grp4-6 -9.974e-05  1.984e-06 -50.279  < 2e-16 ***
policyTRUE:curr_pts_grp7-9 -1.085e-04  3.129e-06 -34.668  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01536 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  0.0001896,	Adjusted R-squared:  0.0001896
F-statistic: 4.753e+04 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R

```


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 1.668e-05  8.383e-07  19.892  < 2e-16 ***
age_grp16-19                4.755e-05  8.841e-07  53.791  < 2e-16 ***
age_grp20-24                5.101e-07  8.555e-07   0.596 0.551054    
age_grp25-34               -1.269e-05  8.451e-07 -15.016  < 2e-16 ***
age_grp35-44               -1.568e-05  8.440e-07 -18.584  < 2e-16 ***
age_grp45-54               -1.650e-05  8.435e-07 -19.563  < 2e-16 ***
age_grp55-64               -1.661e-05  8.453e-07 -19.646  < 2e-16 ***
age_grp65-199              -1.650e-05  8.467e-07 -19.486  < 2e-16 ***
policyTRUE                 -4.654e-06  1.202e-06  -3.872 0.000108 ***
curr_pts_grp1-3             3.370e-06  1.282e-07  26.294  < 2e-16 ***
curr_pts_grp4-6             1.254e-05  2.155e-07  58.181  < 2e-16 ***
curr_pts_grp7-9             2.333e-05  3.407e-07  68.478  < 2e-16 ***
age_grp16-19:policyTRUE    -6.327e-07  1.263e-06  -0.501 0.616313    
age_grp20-24:policyTRUE     3.778e-06  1.226e-06   3.081 0.002061 **
age_grp25-34:policyTRUE     4.591e-06  1.211e-06   3.790 0.000151 ***
age_grp35-44:policyTRUE     4.695e-06  1.210e-06   3.881 0.000104 ***
age_grp45-54:policyTRUE     4.658e-06  1.209e-06   3.853 0.000117 ***
age_grp55-64:policyTRUE     4.527e-06  1.211e-06   3.737 0.000186 ***
age_grp65-199:policyTRUE    4.532e-06  1.213e-06   3.736 0.000187 ***
policyTRUE:curr_pts_grp1-3 -9.215e-07  1.769e-07  -5.209 1.90e-07 ***
policyTRUE:curr_pts_grp4-6 -2.322e-06  2.914e-07  -7.969 1.61e-15 ***
policyTRUE:curr_pts_grp7-9 -4.418e-06  4.596e-07  -9.612  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002257 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  2.517e-05,	Adjusted R-squared:  2.516e-05
F-statistic:  6307 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R

```
### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.


#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                -2.295e-06  1.251e-06  -1.834   0.0667 .  
age_grp16-19                4.622e-05  1.320e-06  35.023  < 2e-16 ***
age_grp20-24                3.808e-05  1.277e-06  29.817  < 2e-16 ***
age_grp25-34                1.884e-05  1.261e-06  14.935  < 2e-16 ***
age_grp35-44                8.797e-06  1.260e-06   6.982 2.90e-12 ***
age_grp45-54                5.351e-06  1.259e-06   4.250 2.14e-05 ***
age_grp55-64                2.942e-06  1.262e-06   2.331   0.0197 *  
age_grp65-199               1.602e-06  1.264e-06   1.268   0.2049    
policyTRUE                  9.330e-07  1.794e-06   0.520   0.6030    
curr_pts_grp1-3             2.033e-05  1.913e-07 106.294  < 2e-16 ***
curr_pts_grp4-6             4.726e-05  3.217e-07 146.906  < 2e-16 ***
curr_pts_grp7-9             7.479e-05  5.086e-07 147.060  < 2e-16 ***
age_grp16-19:policyTRUE    -1.357e-05  1.885e-06  -7.197 6.14e-13 ***
age_grp20-24:policyTRUE    -1.606e-05  1.830e-06  -8.773  < 2e-16 ***
age_grp25-34:policyTRUE    -8.727e-06  1.808e-06  -4.827 1.39e-06 ***
age_grp35-44:policyTRUE    -4.114e-06  1.806e-06  -2.278   0.0227 *  
age_grp45-54:policyTRUE    -2.862e-06  1.805e-06  -1.586   0.1128    
age_grp55-64:policyTRUE    -1.531e-06  1.808e-06  -0.847   0.3970    
age_grp65-199:policyTRUE   -8.613e-07  1.811e-06  -0.476   0.6343    
policyTRUE:curr_pts_grp1-3 -1.047e-05  2.641e-07 -39.656  < 2e-16 ***
policyTRUE:curr_pts_grp4-6 -2.484e-05  4.350e-07 -57.102  < 2e-16 ***
policyTRUE:curr_pts_grp7-9 -3.849e-05  6.861e-07 -56.097  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003369 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  2.331e-05,	Adjusted R-squared:  2.33e-05
F-statistic:  5841 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R

```

### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards.
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence.

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.

The following regression is done including both 7- and 14-point violations in the sample after the policy change but only 7-point violations before.

#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                -3.134e-07  5.040e-07  -0.622  0.53403    
age_grp16-19                1.441e-05  5.315e-07  27.115  < 2e-16 ***
age_grp20-24                8.936e-06  5.144e-07  17.373  < 2e-16 ***
age_grp25-34                3.440e-06  5.081e-07   6.770 1.29e-11 ***
age_grp35-44                7.229e-07  5.074e-07   1.425  0.15425    
age_grp45-54                1.051e-07  5.072e-07   0.207  0.83585    
age_grp55-64               -1.359e-07  5.082e-07  -0.267  0.78919    
age_grp65-199              -4.142e-08  5.091e-07  -0.081  0.93516    
policyTRUE                  1.128e-07  7.225e-07   0.156  0.87594    
curr_pts_grp1-3             3.188e-06  7.705e-08  41.379  < 2e-16 ***
curr_pts_grp4-6             8.433e-06  1.296e-07  65.085  < 2e-16 ***
curr_pts_grp7-9             1.412e-05  2.048e-07  68.956  < 2e-16 ***
age_grp16-19:policyTRUE    -5.908e-06  7.591e-07  -7.783 7.08e-15 ***
age_grp20-24:policyTRUE    -3.970e-06  7.371e-07  -5.386 7.21e-08 ***
age_grp25-34:policyTRUE    -1.936e-06  7.282e-07  -2.658  0.00785 **
age_grp35-44:policyTRUE    -3.049e-07  7.274e-07  -0.419  0.67512    
age_grp45-54:policyTRUE    -2.547e-09  7.269e-07  -0.004  0.99720    
age_grp55-64:policyTRUE     1.521e-07  7.282e-07   0.209  0.83454    
age_grp65-199:policyTRUE    4.098e-08  7.292e-07   0.056  0.95519    
policyTRUE:curr_pts_grp1-3 -2.008e-06  1.063e-07 -18.884  < 2e-16 ***
policyTRUE:curr_pts_grp4-6 -5.359e-06  1.752e-07 -30.590  < 2e-16 ***
policyTRUE:curr_pts_grp7-9 -7.136e-06  2.763e-07 -25.824  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001357 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  6.742e-06,	Adjusted R-squared:  6.738e-06
F-statistic:  1690 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R

```

### Nine-points and up (speeding 80 or more and 10 other 9- or 12-point offences)

This includes as events all infractions classified as 9 points and up before the policy change.
That is, all the 9-, 12-, 15-, 18- and  21-point violations before the policy change.
Then I include all of the point values that are double those values after the policy change.
That is, in addition to the above, I include all the 24-, 30-, and 36-point violations.
This excludes the 10- and 14-point violations that are the doubled 5- and 7-point violations in the previous regressions.
It does, however, include the 7 different non-speeding 9-point violations
and the 3 different non-speeding 12-point violations,
which are the same before and after the policy change.
Note that 12- and 15- point violations never happen after the policy change (```policy == TRUE```) and 24-points and up are technically possible but never happen before the change.
It appears that the non-speeding 12-point violations never happen after the change.

Points in rows vs. post-policy change TRUE for males:
```R
> table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'],
+       saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

     FALSE TRUE
  9   6140 5020
  12   125    0
  15    17    0
  18     4  549
  24     0   96
  30     0   17
  36     0    4
```
(Units are number of rows, that is date-age-sex-point observations, not necessarily individuals.)

Finally, the 4 crazies who got 18 points before the change are equally matched by 4 others (yes, only 4 individuals, 1 per row in each).


#### Male drivers:
```R
Coefficients:
                             Estimate Std. Error t value Pr(>|t|)    
(Intercept)                 5.340e-06  5.715e-07   9.343  < 2e-16 ***
age_grp16-19                6.719e-06  6.027e-07  11.148  < 2e-16 ***
age_grp20-24                7.359e-07  5.833e-07   1.262   0.2071    
age_grp25-34               -3.025e-06  5.761e-07  -5.251 1.51e-07 ***
age_grp35-44               -4.140e-06  5.754e-07  -7.195 6.22e-13 ***
age_grp45-54               -4.419e-06  5.751e-07  -7.684 1.54e-14 ***
age_grp55-64               -4.696e-06  5.763e-07  -8.149 3.66e-16 ***
age_grp65-199              -4.061e-06  5.773e-07  -7.035 1.99e-12 ***
policyTRUE                 -1.682e-06  8.194e-07  -2.053   0.0401 *  
curr_pts_grp1-3             2.355e-06  8.737e-08  26.952  < 2e-16 ***
curr_pts_grp4-6             5.373e-06  1.469e-07  36.571  < 2e-16 ***
curr_pts_grp7-9             9.588e-06  2.323e-07  41.276  < 2e-16 ***
age_grp16-19:policyTRUE    -5.982e-07  8.608e-07  -0.695   0.4871    
age_grp20-24:policyTRUE     4.990e-07  8.359e-07   0.597   0.5505    
age_grp25-34:policyTRUE     1.094e-06  8.258e-07   1.325   0.1853    
age_grp35-44:policyTRUE     1.503e-06  8.249e-07   1.822   0.0685 .  
age_grp45-54:policyTRUE     1.439e-06  8.243e-07   1.746   0.0808 .  
age_grp55-64:policyTRUE     1.589e-06  8.258e-07   1.924   0.0543 .  
age_grp65-199:policyTRUE    1.548e-06  8.269e-07   1.872   0.0612 .  
policyTRUE:curr_pts_grp1-3 -5.242e-07  1.206e-07  -4.346 1.38e-05 ***
policyTRUE:curr_pts_grp4-6 -1.490e-06  1.987e-07  -7.502 6.29e-14 ***
policyTRUE:curr_pts_grp7-9 -3.266e-06  3.134e-07 -10.423  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001539 on 5262730104 degrees of freedom
  (128615 observations deleted due to missingness)
Multiple R-squared:  2.908e-06,	Adjusted R-squared:  2.904e-06
F-statistic: 728.8 on 21 and 5262730104 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R

```

There is not much going on in the higher point categories for the ladies.

Points in rows vs. post-policy change TRUE for females:
```R
> table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'],
+       saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

     FALSE TRUE
  9   2263 2136
  12     1    0
  15     1    0
  18     0   23
  24     0    4
```

All of the incidents above 12 points in the above table are individuals (i.e. one driver per row).
That is, it only happened 6 times that a lady got a ticket for speeding more than 100 km/hr over the speed limit.
Compare this to 263 events for males.
So, for the female drivers, most of the action in this regression is from the 9- point to the 18-point speeding violation,
although most of the 9-point violations relate to the 7 offences other than speeding.
