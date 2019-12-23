
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

A new categorical variable ```curr_pts_grp``` was added to capture the number of demerit points that a driver has accumulated over the past two years.
This was simple to calculate for the violation events.
For the non-events, an aggregate calculation was performed to take an inventory of the population of drivers with different point histories for each sex and age category.
To reduce the computational burden, the violation history was aggregated into the number of points for point levels 0-10, and in categories 11-20, 21-30 and 30-150, 150 being the highest observed.
In roughly 35% of the driver-days, drivers have no point history.
A further 45% have up to 10 demerit points in the last two years.
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

The following are linear probability regression models estimated from data aggregated by age groups and categories of previous demerit points.
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the same sex and age groups and categories of previous demerit points.

### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.564e-05  1.069e-05   3.333 0.000859 ***
age_grp16-19                   2.678e-04  1.093e-05  24.495  < 2e-16 ***
age_grp20-24                   2.687e-04  1.077e-05  24.939  < 2e-16 ***
age_grp25-34                   2.146e-04  1.072e-05  20.007  < 2e-16 ***
age_grp35-44                   1.914e-04  1.072e-05  17.856  < 2e-16 ***
age_grp45-54                   1.409e-04  1.072e-05  13.150  < 2e-16 ***
age_grp55-64                   9.195e-05  1.073e-05   8.571  < 2e-16 ***
age_grp65-74                   4.926e-05  1.077e-05   4.576 4.74e-06 ***
age_grp75-84                   2.589e-05  1.089e-05   2.379 0.017382 *  
age_grp85-89                   1.304e-05  1.291e-05   1.011 0.312148    
age_grp90-199                  4.814e-06  2.367e-05   0.203 0.838874    
policyTRUE                    -6.319e-06  1.483e-05  -0.426 0.670099    
curr_pts_grp1                  3.587e-04  3.859e-06  92.950  < 2e-16 ***
curr_pts_grp2                  4.164e-04  1.763e-06 236.128  < 2e-16 ***
curr_pts_grp3                  4.768e-04  1.709e-06 278.961  < 2e-16 ***
curr_pts_grp4                  7.924e-04  4.875e-06 162.545  < 2e-16 ***
curr_pts_grp5                  8.960e-04  3.860e-06 232.104  < 2e-16 ***
curr_pts_grp6                  1.050e-03  4.814e-06 218.060  < 2e-16 ***
curr_pts_grp7                  1.294e-03  8.664e-06 149.399  < 2e-16 ***
curr_pts_grp8                  1.428e-03  8.398e-06 170.028  < 2e-16 ***
curr_pts_grp9                  1.082e-03  8.887e-06 121.757  < 2e-16 ***
curr_pts_grp10                 1.724e-03  1.602e-05 107.621  < 2e-16 ***
curr_pts_grp11-20              1.863e-03  9.998e-06 186.329  < 2e-16 ***
curr_pts_grp21-30              4.098e-03  6.496e-05  63.086  < 2e-16 ***
curr_pts_grp30-150             8.030e-03  1.725e-04  46.540  < 2e-16 ***
age_grp16-19:policyTRUE        9.777e-06  1.516e-05   0.645 0.518852    
age_grp20-24:policyTRUE        1.481e-06  1.495e-05   0.099 0.921104    
age_grp25-34:policyTRUE       -7.995e-06  1.488e-05  -0.537 0.591025    
age_grp35-44:policyTRUE        2.049e-06  1.487e-05   0.138 0.890424    
age_grp45-54:policyTRUE       -7.222e-07  1.487e-05  -0.049 0.961260    
age_grp55-64:policyTRUE        1.716e-06  1.488e-05   0.115 0.908187    
age_grp65-74:policyTRUE        9.857e-06  1.493e-05   0.660 0.509163    
age_grp75-84:policyTRUE        8.193e-06  1.509e-05   0.543 0.587301    
age_grp85-89:policyTRUE        1.744e-05  1.771e-05   0.985 0.324561    
age_grp90-199:policyTRUE       2.430e-05  3.162e-05   0.768 0.442233    
policyTRUE:curr_pts_grp1       1.063e-05  5.174e-06   2.055 0.039923 *  
policyTRUE:curr_pts_grp2      -8.157e-06  2.354e-06  -3.465 0.000530 ***
policyTRUE:curr_pts_grp3      -1.181e-05  2.379e-06  -4.963 6.95e-07 ***
policyTRUE:curr_pts_grp4       2.204e-06  6.301e-06   0.350 0.726540    
policyTRUE:curr_pts_grp5       2.851e-06  5.173e-06   0.551 0.581508    
policyTRUE:curr_pts_grp6      -3.731e-05  6.462e-06  -5.773 7.78e-09 ***
policyTRUE:curr_pts_grp7      -1.947e-05  1.120e-05  -1.738 0.082299 .  
policyTRUE:curr_pts_grp8      -3.175e-05  1.110e-05  -2.861 0.004219 **
policyTRUE:curr_pts_grp9       4.200e-05  1.187e-05   3.539 0.000402 ***
policyTRUE:curr_pts_grp10     -2.967e-04  1.975e-05 -15.022  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.472e-04  1.264e-05 -11.650  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.095e-03  7.609e-05 -14.394  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -4.389e-03  2.019e-04 -21.733  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0163 on 4340212225 degrees of freedom
Multiple R-squared:  0.0002121,	Adjusted R-squared:  0.0002121
F-statistic: 1.959e+04 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```



### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.286e-06  3.259e-06   0.395 0.693027    
age_grp16-19                   3.163e-05  3.332e-06   9.494  < 2e-16 ***
age_grp20-24                   2.531e-05  3.284e-06   7.708 1.28e-14 ***
age_grp25-34                   2.030e-05  3.269e-06   6.212 5.23e-10 ***
age_grp35-44                   1.720e-05  3.267e-06   5.265 1.40e-07 ***
age_grp45-54                   1.326e-05  3.266e-06   4.061 4.89e-05 ***
age_grp55-64                   9.173e-06  3.270e-06   2.806 0.005023 **
age_grp65-74                   5.432e-06  3.281e-06   1.655 0.097828 .  
age_grp75-84                   2.827e-06  3.318e-06   0.852 0.394233    
age_grp85-89                   3.267e-06  3.934e-06   0.830 0.406263    
age_grp90-199                 -2.207e-06  7.215e-06  -0.306 0.759691    
policyTRUE                    -1.601e-06  4.521e-06  -0.354 0.723222    
curr_pts_grp1                  7.445e-05  1.176e-06  63.304  < 2e-16 ***
curr_pts_grp2                  3.497e-05  5.374e-07  65.067  < 2e-16 ***
curr_pts_grp3                  2.571e-05  5.210e-07  49.358  < 2e-16 ***
curr_pts_grp4                  6.792e-05  1.486e-06  45.713  < 2e-16 ***
curr_pts_grp5                  5.394e-05  1.177e-06  45.848  < 2e-16 ***
curr_pts_grp6                  6.065e-05  1.467e-06  41.336  < 2e-16 ***
curr_pts_grp7                  9.446e-05  2.641e-06  35.774  < 2e-16 ***
curr_pts_grp8                  8.415e-05  2.560e-06  32.875  < 2e-16 ***
curr_pts_grp9                  7.338e-05  2.708e-06  27.091  < 2e-16 ***
curr_pts_grp10                 1.392e-04  4.883e-06  28.506  < 2e-16 ***
curr_pts_grp11-20              1.589e-04  3.047e-06  52.152  < 2e-16 ***
curr_pts_grp21-30              3.114e-04  1.980e-05  15.731  < 2e-16 ***
curr_pts_grp30-150             5.378e-04  5.259e-05  10.226  < 2e-16 ***
age_grp16-19:policyTRUE        7.353e-06  4.619e-06   1.592 0.111428    
age_grp20-24:policyTRUE        3.365e-06  4.557e-06   0.738 0.460221    
age_grp25-34:policyTRUE        5.126e-06  4.535e-06   1.130 0.258289    
age_grp35-44:policyTRUE        6.455e-06  4.533e-06   1.424 0.154458    
age_grp45-54:policyTRUE        5.684e-06  4.532e-06   1.254 0.209727    
age_grp55-64:policyTRUE        5.477e-06  4.536e-06   1.207 0.227245    
age_grp65-74:policyTRUE        5.502e-06  4.551e-06   1.209 0.226695    
age_grp75-84:policyTRUE        4.529e-06  4.601e-06   0.984 0.324922    
age_grp85-89:policyTRUE        2.219e-06  5.396e-06   0.411 0.680936    
age_grp90-199:policyTRUE       6.656e-06  9.636e-06   0.691 0.489731    
policyTRUE:curr_pts_grp1      -8.113e-07  1.577e-06  -0.514 0.606971    
policyTRUE:curr_pts_grp2       5.948e-06  7.175e-07   8.291  < 2e-16 ***
policyTRUE:curr_pts_grp3       1.112e-05  7.252e-07  15.329  < 2e-16 ***
policyTRUE:curr_pts_grp4       8.984e-06  1.920e-06   4.679 2.89e-06 ***
policyTRUE:curr_pts_grp5       1.774e-05  1.577e-06  11.253  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.680e-05  1.970e-06   8.531  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.186e-05  3.415e-06   3.474 0.000514 ***
policyTRUE:curr_pts_grp8       2.986e-05  3.382e-06   8.829  < 2e-16 ***
policyTRUE:curr_pts_grp9       1.415e-05  3.617e-06   3.913 9.10e-05 ***
policyTRUE:curr_pts_grp10      3.480e-06  6.020e-06   0.578 0.563168    
policyTRUE:curr_pts_grp11-20   1.996e-05  3.851e-06   5.183 2.19e-07 ***
policyTRUE:curr_pts_grp21-30  -1.780e-05  2.319e-05  -0.768 0.442724    
policyTRUE:curr_pts_grp30-150 -2.520e-05  6.155e-05  -0.409 0.682206    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004969 on 4340212225 degrees of freedom
Multiple R-squared:  1.737e-05,	Adjusted R-squared:  1.736e-05
F-statistic:  1604 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```


### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.106e-06  7.265e-06  -0.152 0.879052    
age_grp16-19                   1.168e-04  7.429e-06  15.717  < 2e-16 ***
age_grp20-24                   1.260e-04  7.321e-06  17.212  < 2e-16 ***
age_grp25-34                   1.149e-04  7.288e-06  15.763  < 2e-16 ***
age_grp35-44                   1.074e-04  7.284e-06  14.737  < 2e-16 ***
age_grp45-54                   8.611e-05  7.283e-06  11.823  < 2e-16 ***
age_grp55-64                   6.164e-05  7.290e-06   8.456  < 2e-16 ***
age_grp65-74                   3.872e-05  7.315e-06   5.293 1.20e-07 ***
age_grp75-84                   2.477e-05  7.397e-06   3.349 0.000812 ***
age_grp85-89                   1.645e-05  8.771e-06   1.876 0.060661 .  
age_grp90-199                  9.917e-06  1.609e-05   0.616 0.537583    
policyTRUE                    -3.572e-06  1.008e-05  -0.354 0.723044    
curr_pts_grp1                  1.552e-04  2.622e-06  59.191  < 2e-16 ***
curr_pts_grp2                  2.002e-04  1.198e-06 167.116  < 2e-16 ***
curr_pts_grp3                  1.946e-04  1.162e-06 167.557  < 2e-16 ***
curr_pts_grp4                  3.654e-04  3.313e-06 110.287  < 2e-16 ***
curr_pts_grp5                  3.806e-04  2.623e-06 145.068  < 2e-16 ***
curr_pts_grp6                  3.987e-04  3.271e-06 121.879  < 2e-16 ***
curr_pts_grp7                  5.451e-04  5.887e-06  92.591  < 2e-16 ***
curr_pts_grp8                  5.545e-04  5.707e-06  97.167  < 2e-16 ***
curr_pts_grp9                  3.807e-04  6.039e-06  63.043  < 2e-16 ***
curr_pts_grp10                 6.286e-04  1.089e-05  57.733  < 2e-16 ***
curr_pts_grp11-20              6.516e-04  6.794e-06  95.906  < 2e-16 ***
curr_pts_grp21-30              1.160e-03  4.414e-05  26.273  < 2e-16 ***
curr_pts_grp30-150             1.679e-03  1.172e-04  14.318  < 2e-16 ***
age_grp16-19:policyTRUE        1.186e-05  1.030e-05   1.152 0.249503    
age_grp20-24:policyTRUE        8.825e-06  1.016e-05   0.869 0.385050    
age_grp25-34:policyTRUE        3.903e-06  1.011e-05   0.386 0.699503    
age_grp35-44:policyTRUE        7.166e-06  1.011e-05   0.709 0.478344    
age_grp45-54:policyTRUE        5.952e-06  1.010e-05   0.589 0.555795    
age_grp55-64:policyTRUE        5.209e-06  1.011e-05   0.515 0.606506    
age_grp65-74:policyTRUE        7.175e-06  1.015e-05   0.707 0.479473    
age_grp75-84:policyTRUE        4.231e-06  1.026e-05   0.412 0.679987    
age_grp85-89:policyTRUE        6.051e-06  1.203e-05   0.503 0.615007    
age_grp90-199:policyTRUE       6.607e-06  2.148e-05   0.308 0.758447    
policyTRUE:curr_pts_grp1       1.511e-05  3.516e-06   4.297 1.73e-05 ***
policyTRUE:curr_pts_grp2       4.466e-06  1.600e-06   2.792 0.005238 **
policyTRUE:curr_pts_grp3       6.463e-06  1.617e-06   3.997 6.42e-05 ***
policyTRUE:curr_pts_grp4       1.671e-05  4.281e-06   3.903 9.52e-05 ***
policyTRUE:curr_pts_grp5       2.709e-05  3.515e-06   7.707 1.29e-14 ***
policyTRUE:curr_pts_grp6       1.811e-05  4.391e-06   4.123 3.74e-05 ***
policyTRUE:curr_pts_grp7       2.486e-05  7.614e-06   3.266 0.001091 **
policyTRUE:curr_pts_grp8       1.732e-05  7.540e-06   2.298 0.021588 *  
policyTRUE:curr_pts_grp9       6.483e-05  8.064e-06   8.040 9.01e-16 ***
policyTRUE:curr_pts_grp10     -5.739e-05  1.342e-05  -4.276 1.90e-05 ***
policyTRUE:curr_pts_grp11-20  -1.144e-05  8.587e-06  -1.333 0.182657    
policyTRUE:curr_pts_grp21-30  -2.517e-04  5.171e-05  -4.868 1.13e-06 ***
policyTRUE:curr_pts_grp30-150 -7.597e-04  1.372e-04  -5.536 3.09e-08 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01108 on 4340212225 degrees of freedom
Multiple R-squared:  8.398e-05,	Adjusted R-squared:  8.397e-05
F-statistic:  7756 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.330e-05  6.950e-06   4.792 1.65e-06 ***
age_grp16-19                   9.951e-05  7.106e-06  14.003  < 2e-16 ***
age_grp20-24                   1.056e-04  7.004e-06  15.071  < 2e-16 ***
age_grp25-34                   7.484e-05  6.971e-06  10.735  < 2e-16 ***
age_grp35-44                   6.522e-05  6.968e-06   9.360  < 2e-16 ***
age_grp45-54                   4.168e-05  6.967e-06   5.982 2.20e-09 ***
age_grp55-64                   2.207e-05  6.974e-06   3.165  0.00155 **
age_grp65-74                   6.040e-06  6.998e-06   0.863  0.38805    
age_grp75-84                  -1.468e-06  7.076e-06  -0.207  0.83569    
age_grp85-89                  -7.317e-06  8.390e-06  -0.872  0.38314    
age_grp90-199                 -2.008e-06  1.539e-05  -0.131  0.89617    
policyTRUE                    -1.751e-06  9.642e-06  -0.182  0.85591    
curr_pts_grp1                  1.228e-04  2.508e-06  48.967  < 2e-16 ***
curr_pts_grp2                  1.739e-04  1.146e-06 151.669  < 2e-16 ***
curr_pts_grp3                  2.424e-04  1.111e-06 218.159  < 2e-16 ***
curr_pts_grp4                  3.311e-04  3.169e-06 104.474  < 2e-16 ***
curr_pts_grp5                  4.340e-04  2.509e-06 172.942  < 2e-16 ***
curr_pts_grp6                  5.553e-04  3.129e-06 177.450  < 2e-16 ***
curr_pts_grp7                  6.038e-04  5.632e-06 107.220  < 2e-16 ***
curr_pts_grp8                  7.309e-04  5.459e-06 133.887  < 2e-16 ***
curr_pts_grp9                  5.821e-04  5.777e-06 100.773  < 2e-16 ***
curr_pts_grp10                 8.657e-04  1.042e-05  83.114  < 2e-16 ***
curr_pts_grp11-20              9.323e-04  6.499e-06 143.441  < 2e-16 ***
curr_pts_grp21-30              2.127e-03  4.222e-05  50.379  < 2e-16 ***
curr_pts_grp30-150             4.590e-03  1.122e-04  40.923  < 2e-16 ***
age_grp16-19:policyTRUE       -7.080e-06  9.852e-06  -0.719  0.47237    
age_grp20-24:policyTRUE       -8.117e-06  9.718e-06  -0.835  0.40360    
age_grp25-34:policyTRUE       -1.517e-05  9.672e-06  -1.568  0.11684    
age_grp35-44:policyTRUE       -1.055e-05  9.668e-06  -1.091  0.27523    
age_grp45-54:policyTRUE       -1.149e-05  9.666e-06  -1.188  0.23471    
age_grp55-64:policyTRUE       -8.345e-06  9.675e-06  -0.863  0.38834    
age_grp65-74:policyTRUE       -2.059e-06  9.707e-06  -0.212  0.83200    
age_grp75-84:policyTRUE       -3.801e-07  9.812e-06  -0.039  0.96910    
age_grp85-89:policyTRUE        9.594e-06  1.151e-05   0.834  0.40454    
age_grp90-199:policyTRUE       7.214e-06  2.055e-05   0.351  0.72558    
policyTRUE:curr_pts_grp1      -3.076e-06  3.364e-06  -0.914  0.36048    
policyTRUE:curr_pts_grp2      -1.766e-05  1.530e-06 -11.543  < 2e-16 ***
policyTRUE:curr_pts_grp3      -2.613e-05  1.547e-06 -16.890  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.887e-05  4.096e-06  -4.608 4.06e-06 ***
policyTRUE:curr_pts_grp5      -3.636e-05  3.363e-06 -10.813  < 2e-16 ***
policyTRUE:curr_pts_grp6      -6.320e-05  4.201e-06 -15.044  < 2e-16 ***
policyTRUE:curr_pts_grp7      -4.683e-05  7.283e-06  -6.430 1.27e-10 ***
policyTRUE:curr_pts_grp8      -6.418e-05  7.213e-06  -8.898  < 2e-16 ***
policyTRUE:curr_pts_grp9      -2.435e-05  7.714e-06  -3.157  0.00159 **
policyTRUE:curr_pts_grp10     -1.988e-04  1.284e-05 -15.485  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.232e-04  8.214e-06 -15.001  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -6.910e-04  4.946e-05 -13.970  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.745e-03  1.313e-04 -20.914  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0106 on 4340212225 degrees of freedom
Multiple R-squared:  0.0001072,	Adjusted R-squared:  0.0001072
F-statistic:  9901 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```


This will be revisited with the 6-point violations below.


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    7.986e-07  6.814e-07   1.172 0.241206    
age_grp16-19                   8.038e-06  6.968e-07  11.535  < 2e-16 ***
age_grp20-24                   1.934e-06  6.867e-07   2.816 0.004859 **
age_grp25-34                   2.433e-07  6.835e-07   0.356 0.721926    
age_grp35-44                  -3.122e-07  6.832e-07  -0.457 0.647689    
age_grp45-54                  -6.117e-07  6.831e-07  -0.895 0.370524    
age_grp55-64                  -7.159e-07  6.838e-07  -1.047 0.295098    
age_grp65-74                  -5.797e-07  6.861e-07  -0.845 0.398162    
age_grp75-84                  -5.956e-07  6.938e-07  -0.858 0.390620    
age_grp85-89                  -4.759e-07  8.226e-07  -0.578 0.562931    
age_grp90-199                 -8.542e-07  1.509e-06  -0.566 0.571318    
policyTRUE                     7.376e-07  9.454e-07   0.780 0.435256    
curr_pts_grp1                  5.459e-07  2.459e-07   2.220 0.026436 *  
curr_pts_grp2                  5.584e-07  1.124e-07   4.968 6.76e-07 ***
curr_pts_grp3                  2.003e-06  1.090e-07  18.385  < 2e-16 ***
curr_pts_grp4                  7.776e-06  3.107e-07  25.026  < 2e-16 ***
curr_pts_grp5                  1.912e-06  2.460e-07   7.770 7.86e-15 ***
curr_pts_grp6                  3.602e-06  3.068e-07  11.739  < 2e-16 ***
curr_pts_grp7                  8.391e-06  5.522e-07  15.195  < 2e-16 ***
curr_pts_grp8                  4.475e-06  5.353e-07   8.360  < 2e-16 ***
curr_pts_grp9                  5.106e-06  5.664e-07   9.015  < 2e-16 ***
curr_pts_grp10                 1.322e-05  1.021e-06  12.941  < 2e-16 ***
curr_pts_grp11-20              2.088e-05  6.373e-07  32.758  < 2e-16 ***
curr_pts_grp21-30              4.586e-05  4.140e-06  11.078  < 2e-16 ***
curr_pts_grp30-150             3.344e-04  1.100e-05  30.408  < 2e-16 ***
age_grp16-19:policyTRUE       -2.688e-07  9.660e-07  -0.278 0.780837    
age_grp20-24:policyTRUE       -8.235e-08  9.529e-07  -0.086 0.931131    
age_grp25-34:policyTRUE       -7.551e-07  9.483e-07  -0.796 0.425897    
age_grp35-44:policyTRUE       -6.763e-07  9.480e-07  -0.713 0.475557    
age_grp45-54:policyTRUE       -6.822e-07  9.477e-07  -0.720 0.471626    
age_grp55-64:policyTRUE       -7.364e-07  9.486e-07  -0.776 0.437552    
age_grp65-74:policyTRUE       -9.038e-07  9.517e-07  -0.950 0.342274    
age_grp75-84:policyTRUE       -7.490e-07  9.621e-07  -0.778 0.436303    
age_grp85-89:policyTRUE       -6.642e-07  1.128e-06  -0.589 0.556165    
age_grp90-199:policyTRUE      -7.556e-07  2.015e-06  -0.375 0.707701    
policyTRUE:curr_pts_grp1      -2.870e-07  3.298e-07  -0.870 0.384236    
policyTRUE:curr_pts_grp2      -1.829e-07  1.500e-07  -1.219 0.222896    
policyTRUE:curr_pts_grp3      -6.038e-07  1.517e-07  -3.982 6.85e-05 ***
policyTRUE:curr_pts_grp4      -1.646e-06  4.016e-07  -4.098 4.17e-05 ***
policyTRUE:curr_pts_grp5      -8.974e-07  3.297e-07  -2.722 0.006493 **
policyTRUE:curr_pts_grp6      -1.295e-06  4.119e-07  -3.145 0.001661 **
policyTRUE:curr_pts_grp7      -2.460e-06  7.141e-07  -3.444 0.000572 ***
policyTRUE:curr_pts_grp8       3.182e-06  7.072e-07   4.499 6.83e-06 ***
policyTRUE:curr_pts_grp9      -1.739e-06  7.564e-07  -2.299 0.021505 *  
policyTRUE:curr_pts_grp10     -6.644e-06  1.259e-06  -5.278 1.31e-07 ***
policyTRUE:curr_pts_grp11-20  -3.354e-06  8.054e-07  -4.164 3.13e-05 ***
policyTRUE:curr_pts_grp21-30   1.710e-05  4.850e-06   3.526 0.000421 ***
policyTRUE:curr_pts_grp30-150 -3.365e-04  1.287e-05 -26.144  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001039 on 4340212225 degrees of freedom
Multiple R-squared:  3.95e-06,	Adjusted R-squared:  3.939e-06
F-statistic: 364.7 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

Note that there are no changes to the penalties for these offences and the swapping out of the 3-point speeding 40-45 over in a 100km/hr zone, which was changed to 6 points, is not a possibility, since the driver can only be awarded points for a single speeding infraction.


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.922e-07  1.017e-06  -0.287 0.773965    
age_grp16-19                   8.203e-06  1.040e-06   7.886 3.12e-15 ***
age_grp20-24                   8.734e-06  1.025e-06   8.519  < 2e-16 ***
age_grp25-34                   4.525e-06  1.020e-06   4.435 9.22e-06 ***
age_grp35-44                   2.685e-06  1.020e-06   2.632 0.008484 **
age_grp45-54                   1.468e-06  1.020e-06   1.439 0.150011    
age_grp55-64                   8.266e-07  1.021e-06   0.810 0.418050    
age_grp65-74                   4.154e-07  1.024e-06   0.405 0.685114    
age_grp75-84                   8.696e-08  1.036e-06   0.084 0.933088    
age_grp85-89                   1.109e-07  1.228e-06   0.090 0.928041    
age_grp90-199                  5.113e-09  2.253e-06   0.002 0.998189    
policyTRUE                     1.937e-07  1.411e-06   0.137 0.890851    
curr_pts_grp1                  5.071e-06  3.672e-07  13.811  < 2e-16 ***
curr_pts_grp2                  5.347e-06  1.678e-07  31.870  < 2e-16 ***
curr_pts_grp3                  9.799e-06  1.626e-07  60.246  < 2e-16 ***
curr_pts_grp4                  1.364e-05  4.639e-07  29.406  < 2e-16 ***
curr_pts_grp5                  2.044e-05  3.673e-07  55.656  < 2e-16 ***
curr_pts_grp6                  2.404e-05  4.581e-07  52.478  < 2e-16 ***
curr_pts_grp7                  3.636e-05  8.244e-07  44.101  < 2e-16 ***
curr_pts_grp8                  4.543e-05  7.991e-07  56.855  < 2e-16 ***
curr_pts_grp9                  2.962e-05  8.456e-07  35.034  < 2e-16 ***
curr_pts_grp10                 5.889e-05  1.525e-06  38.630  < 2e-16 ***
curr_pts_grp11-20              7.339e-05  9.514e-07  77.141  < 2e-16 ***
curr_pts_grp21-30              3.602e-04  6.181e-06  58.280  < 2e-16 ***
curr_pts_grp30-150             7.790e-04  1.642e-05  47.447  < 2e-16 ***
age_grp16-19:policyTRUE       -5.507e-06  1.442e-06  -3.819 0.000134 ***
age_grp20-24:policyTRUE       -6.094e-06  1.423e-06  -4.284 1.84e-05 ***
age_grp25-34:policyTRUE       -3.361e-06  1.416e-06  -2.374 0.017596 *  
age_grp35-44:policyTRUE       -2.130e-06  1.415e-06  -1.505 0.132318    
age_grp45-54:policyTRUE       -1.288e-06  1.415e-06  -0.911 0.362475    
age_grp55-64:policyTRUE       -6.955e-07  1.416e-06  -0.491 0.623351    
age_grp65-74:policyTRUE       -3.794e-07  1.421e-06  -0.267 0.789468    
age_grp75-84:policyTRUE       -5.553e-08  1.436e-06  -0.039 0.969160    
age_grp85-89:policyTRUE       -1.526e-07  1.685e-06  -0.091 0.927821    
age_grp90-199:policyTRUE      -4.485e-08  3.008e-06  -0.015 0.988105    
policyTRUE:curr_pts_grp1      -3.422e-06  4.924e-07  -6.951 3.63e-12 ***
policyTRUE:curr_pts_grp2      -3.665e-06  2.240e-07 -16.361  < 2e-16 ***
policyTRUE:curr_pts_grp3      -7.304e-06  2.264e-07 -32.258  < 2e-16 ***
policyTRUE:curr_pts_grp4      -9.429e-06  5.995e-07 -15.728  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.432e-05  4.922e-07 -29.098  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.693e-05  6.149e-07 -27.533  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.455e-05  1.066e-06 -23.025  < 2e-16 ***
policyTRUE:curr_pts_grp8      -3.625e-05  1.056e-06 -34.334  < 2e-16 ***
policyTRUE:curr_pts_grp9      -2.211e-05  1.129e-06 -19.584  < 2e-16 ***
policyTRUE:curr_pts_grp10     -5.236e-05  1.879e-06 -27.860  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -5.607e-05  1.202e-06 -46.634  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.789e-04  7.240e-06 -38.520  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.804e-04  1.921e-05 -40.616  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001551 on 4340212225 degrees of freedom
Multiple R-squared:  1.001e-05,	Adjusted R-squared:  1e-05
F-statistic: 924.5 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

Notice the sharp drop as several of the offences are moved to 10 points.
Repeat the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.921e-07  1.117e-06  -0.262  0.79359    
age_grp16-19                   8.203e-06  1.142e-06   7.185 6.71e-13 ***
age_grp20-24                   8.741e-06  1.125e-06   7.768 7.96e-15 ***
age_grp25-34                   4.526e-06  1.120e-06   4.041 5.33e-05 ***
age_grp35-44                   2.685e-06  1.119e-06   2.398  0.01647 *  
age_grp45-54                   1.468e-06  1.119e-06   1.312  0.18965    
age_grp55-64                   8.267e-07  1.120e-06   0.738  0.46059    
age_grp65-74                   4.154e-07  1.124e-06   0.369  0.71177    
age_grp75-84                   8.698e-08  1.137e-06   0.077  0.93901    
age_grp85-89                   1.109e-07  1.348e-06   0.082  0.93442    
age_grp90-199                  5.114e-09  2.472e-06   0.002  0.99835    
policyTRUE                     1.124e-07  1.549e-06   0.073  0.94214    
curr_pts_grp1                  5.070e-06  4.030e-07  12.582  < 2e-16 ***
curr_pts_grp2                  5.347e-06  1.842e-07  29.034  < 2e-16 ***
curr_pts_grp3                  9.798e-06  1.785e-07  54.887  < 2e-16 ***
curr_pts_grp4                  1.364e-05  5.091e-07  26.790  < 2e-16 ***
curr_pts_grp5                  2.044e-05  4.032e-07  50.707  < 2e-16 ***
curr_pts_grp6                  2.404e-05  5.027e-07  47.812  < 2e-16 ***
curr_pts_grp7                  3.635e-05  9.048e-07  40.181  < 2e-16 ***
curr_pts_grp8                  4.543e-05  8.770e-07  51.801  < 2e-16 ***
curr_pts_grp9                  2.962e-05  9.281e-07  31.919  < 2e-16 ***
curr_pts_grp10                 5.889e-05  1.673e-06  35.196  < 2e-16 ***
curr_pts_grp11-20              7.339e-05  1.044e-06  70.284  < 2e-16 ***
curr_pts_grp21-30              3.602e-04  6.784e-06  53.099  < 2e-16 ***
curr_pts_grp30-150             7.789e-04  1.802e-05  43.230  < 2e-16 ***
age_grp16-19:policyTRUE       -2.642e-06  1.583e-06  -1.669  0.09511 .  
age_grp20-24:policyTRUE       -4.071e-06  1.561e-06  -2.608  0.00912 **
age_grp25-34:policyTRUE       -2.319e-06  1.554e-06  -1.492  0.13567    
age_grp35-44:policyTRUE       -1.576e-06  1.553e-06  -1.015  0.31032    
age_grp45-54:policyTRUE       -9.622e-07  1.553e-06  -0.620  0.53549    
age_grp55-64:policyTRUE       -5.164e-07  1.554e-06  -0.332  0.73969    
age_grp65-74:policyTRUE       -2.450e-07  1.559e-06  -0.157  0.87518    
age_grp75-84:policyTRUE        1.188e-08  1.576e-06   0.008  0.99399    
age_grp85-89:policyTRUE       -1.876e-07  1.849e-06  -0.101  0.91918    
age_grp90-199:policyTRUE      -7.807e-08  3.302e-06  -0.024  0.98114    
policyTRUE:curr_pts_grp1      -2.423e-06  5.404e-07  -4.483 7.34e-06 ***
policyTRUE:curr_pts_grp2      -2.210e-06  2.458e-07  -8.990  < 2e-16 ***
policyTRUE:curr_pts_grp3      -5.217e-06  2.485e-07 -20.992  < 2e-16 ***
policyTRUE:curr_pts_grp4      -5.479e-06  6.580e-07  -8.326  < 2e-16 ***
policyTRUE:curr_pts_grp5      -9.564e-06  5.402e-07 -17.704  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.192e-05  6.749e-07 -17.668  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.570e-05  1.170e-06 -13.419  < 2e-16 ***
policyTRUE:curr_pts_grp8      -2.620e-05  1.159e-06 -22.614  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.640e-05  1.239e-06 -13.233  < 2e-16 ***
policyTRUE:curr_pts_grp10     -3.772e-05  2.063e-06 -18.285  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.887e-05  1.320e-06 -29.454  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.151e-04  7.946e-06 -27.067  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -5.746e-04  2.109e-05 -27.244  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001703 on 4340212225 degrees of freedom
Multiple R-squared:  9.599e-06,	Adjusted R-squared:  9.588e-06
F-statistic: 886.4 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```



### Six-point violations (combinations)

The only offence that merits precisely 6 demerit points is speeding 40-45 over in a 100+ zone, only after the policy change.
Other than that, a driver can only get 6 points for a combination of 1-5 point offences.
Among these, the above offence (40-45 over in a 100+ zone) can be one of two 3-point offences that add to 6 points.

Since the 6 point combination with multiple tickets is rare, the former 3 point violation (fairly common) dominates in the post-policy change period.


The regression with only 6 points as the event is as follows.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -3.096e-10  5.733e-07  -0.001   0.9996    
age_grp16-19                   1.884e-07  5.862e-07   0.321   0.7479    
age_grp20-24                   6.032e-08  5.778e-07   0.104   0.9168    
age_grp25-34                   2.180e-09  5.751e-07   0.004   0.9970    
age_grp35-44                  -2.124e-09  5.748e-07  -0.004   0.9971    
age_grp45-54                   1.478e-10  5.747e-07   0.000   0.9998    
age_grp55-64                  -2.351e-09  5.753e-07  -0.004   0.9967    
age_grp65-74                  -1.126e-09  5.773e-07  -0.002   0.9984    
age_grp75-84                  -9.681e-10  5.837e-07  -0.002   0.9987    
age_grp85-89                  -8.967e-10  6.921e-07  -0.001   0.9990    
age_grp90-199                  1.561e-10  1.269e-06   0.000   0.9999    
policyTRUE                    -1.271e-07  7.954e-07  -0.160   0.8730    
curr_pts_grp1                 -1.321e-08  2.069e-07  -0.064   0.9491    
curr_pts_grp2                  1.164e-08  9.456e-08   0.123   0.9021    
curr_pts_grp3                 -1.444e-09  9.166e-08  -0.016   0.9874    
curr_pts_grp4                  7.510e-08  2.614e-07   0.287   0.7739    
curr_pts_grp5                  1.543e-07  2.070e-07   0.745   0.4560    
curr_pts_grp6                 -1.118e-08  2.581e-07  -0.043   0.9655    
curr_pts_grp7                 -1.538e-08  4.646e-07  -0.033   0.9736    
curr_pts_grp8                  2.516e-07  4.503e-07   0.559   0.5764    
curr_pts_grp9                  2.821e-07  4.765e-07   0.592   0.5538    
curr_pts_grp10                -1.684e-08  8.592e-07  -0.020   0.9844    
curr_pts_grp11-20              2.235e-06  5.362e-07   4.169 3.07e-05 ***
curr_pts_grp21-30             -2.820e-08  3.483e-06  -0.008   0.9935    
curr_pts_grp30-150            -2.589e-08  9.252e-06  -0.003   0.9978    
age_grp16-19:policyTRUE        1.998e-06  8.127e-07   2.458   0.0140 *  
age_grp20-24:policyTRUE        1.906e-06  8.017e-07   2.378   0.0174 *  
age_grp25-34:policyTRUE        1.320e-06  7.979e-07   1.654   0.0981 .  
age_grp35-44:policyTRUE        1.260e-06  7.976e-07   1.579   0.1143    
age_grp45-54:policyTRUE        8.251e-07  7.973e-07   1.035   0.3008    
age_grp55-64:policyTRUE        6.088e-07  7.981e-07   0.763   0.4456    
age_grp65-74:policyTRUE        3.439e-07  8.007e-07   0.429   0.6676    
age_grp75-84:policyTRUE        3.410e-07  8.095e-07   0.421   0.6736    
age_grp85-89:policyTRUE       -4.720e-08  9.494e-07  -0.050   0.9603    
age_grp90-199:policyTRUE      -4.282e-08  1.695e-06  -0.025   0.9799    
policyTRUE:curr_pts_grp1       1.789e-06  2.775e-07   6.448 1.14e-10 ***
policyTRUE:curr_pts_grp2       2.073e-06  1.262e-07  16.420  < 2e-16 ***
policyTRUE:curr_pts_grp3       3.441e-06  1.276e-07  26.968  < 2e-16 ***
policyTRUE:curr_pts_grp4       5.623e-06  3.379e-07  16.642  < 2e-16 ***
policyTRUE:curr_pts_grp5       6.648e-06  2.774e-07  23.965  < 2e-16 ***
policyTRUE:curr_pts_grp6       8.432e-06  3.465e-07  24.333  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.062e-05  6.008e-07  17.683  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.243e-05  5.950e-07  20.889  < 2e-16 ***
policyTRUE:curr_pts_grp9       6.524e-06  6.364e-07  10.251  < 2e-16 ***
policyTRUE:curr_pts_grp10      1.588e-05  1.059e-06  14.992  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   1.850e-05  6.776e-07  27.304  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   9.320e-05  4.080e-06  22.841  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  8.147e-05  1.083e-05   7.524 5.33e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0008742 on 4340212225 degrees of freedom
Multiple R-squared:  3.796e-06,	Adjusted R-squared:  3.785e-06
F-statistic: 350.5 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```


Consider next the combined event with either 3 or 6 points at a single roadside stop.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.330e-05  6.974e-06   4.776 1.79e-06 ***
age_grp16-19                   9.970e-05  7.131e-06  13.982  < 2e-16 ***
age_grp20-24                   1.056e-04  7.028e-06  15.029  < 2e-16 ***
age_grp25-34                   7.484e-05  6.995e-06  10.699  < 2e-16 ***
age_grp35-44                   6.522e-05  6.992e-06   9.328  < 2e-16 ***
age_grp45-54                   4.168e-05  6.990e-06   5.962 2.49e-09 ***
age_grp55-64                   2.207e-05  6.997e-06   3.154  0.00161 **
age_grp65-74                   6.039e-06  7.022e-06   0.860  0.38974    
age_grp75-84                  -1.469e-06  7.100e-06  -0.207  0.83614    
age_grp85-89                  -7.318e-06  8.418e-06  -0.869  0.38469    
age_grp90-199                 -2.008e-06  1.544e-05  -0.130  0.89653    
policyTRUE                    -1.878e-06  9.675e-06  -0.194  0.84609    
curr_pts_grp1                  1.228e-04  2.517e-06  48.796  < 2e-16 ***
curr_pts_grp2                  1.739e-04  1.150e-06 151.166  < 2e-16 ***
curr_pts_grp3                  2.424e-04  1.115e-06 217.420  < 2e-16 ***
curr_pts_grp4                  3.312e-04  3.180e-06 104.144  < 2e-16 ***
curr_pts_grp5                  4.341e-04  2.518e-06 172.418  < 2e-16 ***
curr_pts_grp6                  5.553e-04  3.140e-06 176.846  < 2e-16 ***
curr_pts_grp7                  6.038e-04  5.651e-06 106.854  < 2e-16 ***
curr_pts_grp8                  7.312e-04  5.478e-06 133.480  < 2e-16 ***
curr_pts_grp9                  5.824e-04  5.796e-06 100.481  < 2e-16 ***
curr_pts_grp10                 8.656e-04  1.045e-05  82.831  < 2e-16 ***
curr_pts_grp11-20              9.345e-04  6.521e-06 143.298  < 2e-16 ***
curr_pts_grp21-30              2.127e-03  4.237e-05  50.208  < 2e-16 ***
curr_pts_grp30-150             4.590e-03  1.125e-04  40.785  < 2e-16 ***
age_grp16-19:policyTRUE       -5.082e-06  9.886e-06  -0.514  0.60716    
age_grp20-24:policyTRUE       -6.210e-06  9.751e-06  -0.637  0.52420    
age_grp25-34:policyTRUE       -1.385e-05  9.705e-06  -1.427  0.15361    
age_grp35-44:policyTRUE       -9.290e-06  9.701e-06  -0.958  0.33828    
age_grp45-54:policyTRUE       -1.066e-05  9.698e-06  -1.099  0.27167    
age_grp55-64:policyTRUE       -7.737e-06  9.707e-06  -0.797  0.42545    
age_grp65-74:policyTRUE       -1.715e-06  9.740e-06  -0.176  0.86020    
age_grp75-84:policyTRUE       -3.909e-08  9.846e-06  -0.004  0.99683    
age_grp85-89:policyTRUE        9.546e-06  1.155e-05   0.827  0.40844    
age_grp90-199:policyTRUE       7.171e-06  2.062e-05   0.348  0.72803    
policyTRUE:curr_pts_grp1      -1.287e-06  3.375e-06  -0.381  0.70300    
policyTRUE:curr_pts_grp2      -1.559e-05  1.535e-06 -10.154  < 2e-16 ***
policyTRUE:curr_pts_grp3      -2.269e-05  1.552e-06 -14.616  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.325e-05  4.110e-06  -3.224  0.00126 **
policyTRUE:curr_pts_grp5      -2.971e-05  3.374e-06  -8.806  < 2e-16 ***
policyTRUE:curr_pts_grp6      -5.476e-05  4.215e-06 -12.992  < 2e-16 ***
policyTRUE:curr_pts_grp7      -3.621e-05  7.308e-06  -4.955 7.24e-07 ***
policyTRUE:curr_pts_grp8      -5.175e-05  7.237e-06  -7.150 8.65e-13 ***
policyTRUE:curr_pts_grp9      -1.783e-05  7.741e-06  -2.303  0.02125 *  
policyTRUE:curr_pts_grp10     -1.829e-04  1.288e-05 -14.200  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.047e-04  8.242e-06 -12.706  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -5.978e-04  4.963e-05 -12.045  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.664e-03  1.317e-04 -20.224  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01063 on 4340212225 degrees of freedom
Multiple R-squared:  0.0001085,	Adjusted R-squared:  0.0001085
F-statistic: 1.002e+04 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```



### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards.
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence.

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.377e-08  3.078e-07  -0.077  0.93845    
age_grp16-19                   1.772e-06  3.147e-07   5.632 1.78e-08 ***
age_grp20-24                   9.451e-07  3.102e-07   3.047  0.00231 **
age_grp25-34                   3.429e-07  3.087e-07   1.111  0.26674    
age_grp35-44                   1.087e-07  3.086e-07   0.352  0.72460    
age_grp45-54                   3.935e-08  3.085e-07   0.128  0.89852    
age_grp55-64                  -1.950e-08  3.088e-07  -0.063  0.94965    
age_grp65-74                  -7.058e-09  3.099e-07  -0.023  0.98183    
age_grp75-84                   1.822e-08  3.134e-07   0.058  0.95364    
age_grp85-89                  -8.297e-09  3.716e-07  -0.022  0.98218    
age_grp90-199                 -6.663e-10  6.815e-07  -0.001  0.99922    
policyTRUE                     1.148e-08  4.270e-07   0.027  0.97856    
curr_pts_grp1                  1.305e-07  1.111e-07   1.175  0.24019    
curr_pts_grp2                  3.380e-07  5.076e-08   6.658 2.78e-11 ***
curr_pts_grp3                  7.997e-07  4.921e-08  16.252  < 2e-16 ***
curr_pts_grp4                  1.231e-06  1.403e-07   8.771  < 2e-16 ***
curr_pts_grp5                  2.174e-06  1.111e-07  19.567  < 2e-16 ***
curr_pts_grp6                  3.467e-06  1.386e-07  25.017  < 2e-16 ***
curr_pts_grp7                  3.349e-06  2.494e-07  13.427  < 2e-16 ***
curr_pts_grp8                  2.622e-06  2.418e-07  10.844  < 2e-16 ***
curr_pts_grp9                  2.090e-06  2.558e-07   8.169 3.10e-16 ***
curr_pts_grp10                 7.383e-06  4.613e-07  16.007  < 2e-16 ***
curr_pts_grp11-20              1.016e-05  2.878e-07  35.308  < 2e-16 ***
curr_pts_grp21-30              6.301e-05  1.870e-06  33.693  < 2e-16 ***
curr_pts_grp30-150            -4.843e-07  4.967e-06  -0.098  0.92232    
age_grp16-19:policyTRUE       -1.071e-06  4.363e-07  -2.455  0.01410 *  
age_grp20-24:policyTRUE       -3.899e-07  4.304e-07  -0.906  0.36500    
age_grp25-34:policyTRUE       -2.243e-07  4.283e-07  -0.524  0.60050    
age_grp35-44:policyTRUE       -8.041e-08  4.282e-07  -0.188  0.85103    
age_grp45-54:policyTRUE       -2.619e-08  4.281e-07  -0.061  0.95120    
age_grp55-64:policyTRUE        2.141e-08  4.284e-07   0.050  0.96015    
age_grp65-74:policyTRUE        1.564e-09  4.299e-07   0.004  0.99710    
age_grp75-84:policyTRUE       -2.422e-08  4.346e-07  -0.056  0.95554    
age_grp85-89:policyTRUE       -4.838e-10  5.097e-07  -0.001  0.99924    
age_grp90-199:policyTRUE      -7.275e-09  9.102e-07  -0.008  0.99362    
policyTRUE:curr_pts_grp1      -1.115e-08  1.490e-07  -0.075  0.94031    
policyTRUE:curr_pts_grp2      -2.099e-07  6.777e-08  -3.097  0.00196 **
policyTRUE:curr_pts_grp3      -5.642e-07  6.850e-08  -8.236  < 2e-16 ***
policyTRUE:curr_pts_grp4      -7.514e-07  1.814e-07  -4.143 3.43e-05 ***
policyTRUE:curr_pts_grp5      -1.498e-06  1.489e-07 -10.058  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.337e-06  1.860e-07 -12.562  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.156e-06  3.225e-07  -6.684 2.33e-11 ***
policyTRUE:curr_pts_grp8      -1.767e-06  3.194e-07  -5.530 3.19e-08 ***
policyTRUE:curr_pts_grp9       5.644e-07  3.416e-07   1.652  0.09856 .  
policyTRUE:curr_pts_grp10     -4.533e-06  5.686e-07  -7.972 1.56e-15 ***
policyTRUE:curr_pts_grp11-20  -5.182e-06  3.638e-07 -14.245  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.599e-05  2.191e-06  -7.300 2.87e-13 ***
policyTRUE:curr_pts_grp30-150  2.208e-07  5.813e-06   0.038  0.96970    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0004693 on 4340212225 degrees of freedom
Multiple R-squared:  2.029e-06,	Adjusted R-squared:  2.018e-06
F-statistic: 187.3 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```


### Nine-point violations (speeding 81-100 over or combinations)

One offence that merits 9 demerit points is speeding 80-100 over, only before the policy change, after which it was changed to a 18-point offence.
Other than that, there 7 other violations that result in 9 demerit points, none of which were changed with the excessive speeding policy.

The combined 9- and 18-point event is analyzed in the following logistic regression:

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.669e-06  7.068e-07   2.361  0.01822 *  
age_grp16-19                   1.681e-06  7.227e-07   2.326  0.02003 *  
age_grp20-24                   1.204e-07  7.122e-07   0.169  0.86578    
age_grp25-34                  -5.727e-07  7.089e-07  -0.808  0.41919    
age_grp35-44                  -8.492e-07  7.086e-07  -1.198  0.23079    
age_grp45-54                  -1.011e-06  7.085e-07  -1.427  0.15365    
age_grp55-64                  -1.024e-06  7.092e-07  -1.444  0.14878    
age_grp65-74                  -7.556e-07  7.116e-07  -1.062  0.28834    
age_grp75-84                   2.543e-07  7.196e-07   0.353  0.72375    
age_grp85-89                   1.016e-06  8.532e-07   1.191  0.23363    
age_grp90-199                 -3.865e-08  1.565e-06  -0.025  0.98030    
policyTRUE                    -1.293e-07  9.805e-07  -0.132  0.89511    
curr_pts_grp1                  4.508e-07  2.551e-07   1.767  0.07721 .  
curr_pts_grp2                  1.049e-06  1.166e-07   9.003  < 2e-16 ***
curr_pts_grp3                  1.487e-06  1.130e-07  13.164  < 2e-16 ***
curr_pts_grp4                  5.330e-06  3.223e-07  16.539  < 2e-16 ***
curr_pts_grp5                  2.841e-06  2.552e-07  11.131  < 2e-16 ***
curr_pts_grp6                  3.992e-06  3.182e-07  12.545  < 2e-16 ***
curr_pts_grp7                  2.846e-06  5.727e-07   4.970 6.71e-07 ***
curr_pts_grp8                  5.288e-06  5.552e-07   9.525  < 2e-16 ***
curr_pts_grp9                  8.686e-06  5.875e-07  14.786  < 2e-16 ***
curr_pts_grp10                 1.142e-05  1.059e-06  10.781  < 2e-16 ***
curr_pts_grp11-20              1.350e-05  6.610e-07  20.424  < 2e-16 ***
curr_pts_grp21-30              3.042e-05  4.294e-06   7.085 1.39e-12 ***
curr_pts_grp30-150             1.107e-04  1.141e-05   9.707  < 2e-16 ***
age_grp16-19:policyTRUE       -3.707e-07  1.002e-06  -0.370  0.71137    
age_grp20-24:policyTRUE        4.012e-08  9.883e-07   0.041  0.96762    
age_grp25-34:policyTRUE        1.225e-07  9.836e-07   0.125  0.90090    
age_grp35-44:policyTRUE        4.957e-08  9.832e-07   0.050  0.95980    
age_grp45-54:policyTRUE       -2.473e-08  9.829e-07  -0.025  0.97993    
age_grp55-64:policyTRUE       -1.225e-09  9.838e-07  -0.001  0.99901    
age_grp65-74:policyTRUE        3.768e-08  9.871e-07   0.038  0.96955    
age_grp75-84:policyTRUE        2.334e-07  9.979e-07   0.234  0.81506    
age_grp85-89:policyTRUE        4.781e-07  1.170e-06   0.408  0.68291    
age_grp90-199:policyTRUE       4.702e-06  2.090e-06   2.250  0.02448 *  
policyTRUE:curr_pts_grp1       3.411e-07  3.421e-07   0.997  0.31862    
policyTRUE:curr_pts_grp2      -3.861e-07  1.556e-07  -2.481  0.01309 *  
policyTRUE:curr_pts_grp3      -3.193e-07  1.573e-07  -2.030  0.04237 *  
policyTRUE:curr_pts_grp4      -2.363e-06  4.165e-07  -5.673 1.40e-08 ***
policyTRUE:curr_pts_grp5      -3.551e-07  3.420e-07  -1.038  0.29913    
policyTRUE:curr_pts_grp6      -1.896e-06  4.272e-07  -4.439 9.05e-06 ***
policyTRUE:curr_pts_grp7       3.334e-07  7.407e-07   0.450  0.65261    
policyTRUE:curr_pts_grp8      -2.322e-06  7.335e-07  -3.165  0.00155 **
policyTRUE:curr_pts_grp9      -1.587e-06  7.845e-07  -2.023  0.04311 *  
policyTRUE:curr_pts_grp10     -1.096e-05  1.306e-06  -8.395  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.603e-06  8.353e-07  -4.313 1.61e-05 ***
policyTRUE:curr_pts_grp21-30  -1.395e-05  5.030e-06  -2.774  0.00554 **
policyTRUE:curr_pts_grp30-150 -2.915e-05  1.335e-05  -2.184  0.02898 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001078 on 4340212225 degrees of freedom
Multiple R-squared:  9.501e-07,	Adjusted R-squared:  9.392e-07
F-statistic: 87.73 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

The statistical significance and strength of the effect are not as consistent as for the males but the sample sizes are smaller.

### Twelve-point violations (speeding 100-119 over or 3 other offences)

The 12-point speeding offence was changed to a 24-point offence but the others were unchanged.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    4.166e-12  2.226e-08   0.000  0.99985    
age_grp16-19                  -4.354e-10  2.276e-08  -0.019  0.98474    
age_grp20-24                   5.619e-09  2.243e-08   0.250  0.80222    
age_grp25-34                  -6.777e-10  2.233e-08  -0.030  0.97579    
age_grp35-44                  -5.931e-10  2.232e-08  -0.027  0.97880    
age_grp45-54                  -3.605e-10  2.231e-08  -0.016  0.98711    
age_grp55-64                  -2.058e-10  2.233e-08  -0.009  0.99265    
age_grp65-74                  -9.589e-11  2.241e-08  -0.004  0.99659    
age_grp75-84                  -5.043e-11  2.266e-08  -0.002  0.99822    
age_grp85-89                  -5.648e-11  2.687e-08  -0.002  0.99832    
age_grp90-199                 -2.296e-14  4.929e-08   0.000  1.00000    
policyTRUE                    -6.422e-12  3.088e-08   0.000  0.99983    
curr_pts_grp1                 -1.497e-10  8.034e-09  -0.019  0.98514    
curr_pts_grp2                 -9.661e-11  3.671e-09  -0.026  0.97901    
curr_pts_grp3                 -1.395e-10  3.559e-09  -0.039  0.96873    
curr_pts_grp4                 -2.454e-10  1.015e-08  -0.024  0.98071    
curr_pts_grp5                 -2.646e-10  8.037e-09  -0.033  0.97374    
curr_pts_grp6                 -2.610e-10  1.002e-08  -0.026  0.97922    
curr_pts_grp7                 -4.434e-10  1.804e-08  -0.025  0.98039    
curr_pts_grp8                  2.643e-07  1.748e-08  15.114  < 2e-16 ***
curr_pts_grp9                 -3.213e-10  1.850e-08  -0.017  0.98614    
curr_pts_grp10                -5.350e-10  3.336e-08  -0.016  0.98720    
curr_pts_grp11-20             -6.495e-10  2.082e-08  -0.031  0.97511    
curr_pts_grp21-30             -1.247e-09  1.352e-07  -0.009  0.99265    
curr_pts_grp30-150            -1.606e-09  3.592e-07  -0.004  0.99643    
age_grp16-19:policyTRUE       -9.047e-10  3.155e-08  -0.029  0.97713    
age_grp20-24:policyTRUE        5.014e-09  3.113e-08   0.161  0.87203    
age_grp25-34:policyTRUE       -1.035e-09  3.098e-08  -0.033  0.97335    
age_grp35-44:policyTRUE        1.248e-09  3.097e-08   0.040  0.96785    
age_grp45-54:policyTRUE       -7.845e-10  3.096e-08  -0.025  0.97978    
age_grp55-64:policyTRUE       -5.319e-10  3.099e-08  -0.017  0.98630    
age_grp65-74:policyTRUE        4.840e-09  3.109e-08   0.156  0.87629    
age_grp75-84:policyTRUE       -2.224e-10  3.143e-08  -0.007  0.99435    
age_grp85-89:policyTRUE       -1.661e-10  3.686e-08  -0.005  0.99640    
age_grp90-199:policyTRUE      -1.399e-10  6.583e-08  -0.002  0.99830    
policyTRUE:curr_pts_grp1      -3.938e-10  1.077e-08  -0.037  0.97084    
policyTRUE:curr_pts_grp2       8.170e-09  4.901e-09   1.667  0.09552 .  
policyTRUE:curr_pts_grp3      -5.277e-10  4.954e-09  -0.107  0.91516    
policyTRUE:curr_pts_grp4      -4.583e-10  1.312e-08  -0.035  0.97213    
policyTRUE:curr_pts_grp5       4.344e-08  1.077e-08   4.033  5.5e-05 ***
policyTRUE:curr_pts_grp6      -6.216e-10  1.345e-08  -0.046  0.96315    
policyTRUE:curr_pts_grp7      -5.703e-10  2.333e-08  -0.024  0.98049    
policyTRUE:curr_pts_grp8      -6.821e-08  2.310e-08  -2.953  0.00315 **
policyTRUE:curr_pts_grp9      -7.948e-10  2.471e-08  -0.032  0.97434    
policyTRUE:curr_pts_grp10     -8.108e-10  4.112e-08  -0.020  0.98427    
policyTRUE:curr_pts_grp11-20  -9.013e-10  2.631e-08  -0.034  0.97267    
policyTRUE:curr_pts_grp21-30  -1.824e-09  1.584e-07  -0.012  0.99082    
policyTRUE:curr_pts_grp30-150 -1.466e-09  4.204e-07  -0.003  0.99722    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.394e-05 on 4340212225 degrees of freedom
Multiple R-squared:  1.076e-07,	Adjusted R-squared:  9.679e-08
F-statistic: 9.938 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

Not much here but there are not many ladies committing these offences (only 5, to be specific).
Compare this to 225 males in this category.

### Twelve-points and up (speeding 100 or more and 3 other 12-point offences)

Combining with the more excessive speeding offences, the results are close to the case including only the 12-point offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.836e-11  5.361e-08   0.000  0.99973    
age_grp16-19                  -3.667e-10  5.481e-08  -0.007  0.99466    
age_grp20-24                   5.694e-09  5.402e-08   0.105  0.91606    
age_grp25-34                  -6.135e-10  5.377e-08  -0.011  0.99090    
age_grp35-44                  -5.331e-10  5.375e-08  -0.010  0.99209    
age_grp45-54                   1.741e-09  5.374e-08   0.032  0.97415    
age_grp55-64                  -1.766e-10  5.379e-08  -0.003  0.99738    
age_grp65-74                  -8.070e-11  5.398e-08  -0.001  0.99881    
age_grp75-84                  -4.242e-11  5.458e-08  -0.001  0.99938    
age_grp85-89                  -5.308e-11  6.471e-08  -0.001  0.99935    
age_grp90-199                  1.202e-12  1.187e-07   0.000  0.99999    
policyTRUE                    -9.714e-10  7.437e-08  -0.013  0.98958    
curr_pts_grp1                 -6.582e-10  1.935e-08  -0.034  0.97286    
curr_pts_grp2                 -6.234e-10  8.841e-09  -0.071  0.94379    
curr_pts_grp3                 -6.480e-10  8.571e-09  -0.076  0.93973    
curr_pts_grp4                 -7.291e-10  2.444e-08  -0.030  0.97620    
curr_pts_grp5                 -7.406e-10  1.936e-08  -0.038  0.96948    
curr_pts_grp6                 -7.511e-10  2.414e-08  -0.031  0.97517    
curr_pts_grp7                 -8.832e-10  4.344e-08  -0.020  0.98378    
curr_pts_grp8                  2.638e-07  4.211e-08   6.265 3.73e-10 ***
curr_pts_grp9                 -7.483e-10  4.456e-08  -0.017  0.98660    
curr_pts_grp10                -9.498e-10  8.034e-08  -0.012  0.99057    
curr_pts_grp11-20             -1.037e-09  5.013e-08  -0.021  0.98350    
curr_pts_grp21-30             -1.531e-09  3.257e-07  -0.005  0.99625    
curr_pts_grp30-150            -1.855e-09  8.651e-07  -0.002  0.99829    
age_grp16-19:policyTRUE        5.940e-08  7.599e-08   0.782  0.43439    
age_grp20-24:policyTRUE        5.709e-08  7.496e-08   0.762  0.44633    
age_grp25-34:policyTRUE        3.992e-09  7.460e-08   0.054  0.95733    
age_grp35-44:policyTRUE        1.901e-09  7.458e-08   0.025  0.97966    
age_grp45-54:policyTRUE       -4.515e-09  7.455e-08  -0.061  0.95171    
age_grp55-64:policyTRUE       -2.412e-09  7.462e-08  -0.032  0.97422    
age_grp65-74:policyTRUE        4.020e-09  7.487e-08   0.054  0.95718    
age_grp75-84:policyTRUE       -6.190e-10  7.569e-08  -0.008  0.99347    
age_grp85-89:policyTRUE       -8.761e-10  8.878e-08  -0.010  0.99213    
age_grp90-199:policyTRUE      -9.247e-10  1.585e-07  -0.006  0.99535    
policyTRUE:curr_pts_grp1      -6.696e-09  2.594e-08  -0.258  0.79635    
policyTRUE:curr_pts_grp2       1.106e-08  1.180e-08   0.937  0.34877    
policyTRUE:curr_pts_grp3       1.223e-08  1.193e-08   1.025  0.30524    
policyTRUE:curr_pts_grp4       1.701e-07  3.159e-08   5.385 7.24e-08 ***
policyTRUE:curr_pts_grp5       7.986e-08  2.594e-08   3.079  0.00208 **
policyTRUE:curr_pts_grp6       6.086e-08  3.240e-08   1.878  0.06034 .  
policyTRUE:curr_pts_grp7       3.688e-07  5.618e-08   6.565 5.22e-11 ***
policyTRUE:curr_pts_grp8      -7.725e-08  5.563e-08  -1.389  0.16496    
policyTRUE:curr_pts_grp9       2.221e-07  5.950e-08   3.732  0.00019 ***
policyTRUE:curr_pts_grp10     -1.232e-08  9.903e-08  -0.124  0.90102    
policyTRUE:curr_pts_grp11-20   6.581e-07  6.336e-08  10.387  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   5.885e-06  3.815e-07  15.426  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.318e-08  1.013e-06  -0.023  0.98174    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 8.174e-05 on 4340212225 degrees of freedom
Multiple R-squared:  3.736e-07,	Adjusted R-squared:  3.628e-07
F-statistic:  34.5 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

Similarly confusing results to that case for males but there are only 29 females committing these offences (compared to 826 males).

### More than Twelve points (only speeding 120 or more)

This category includes speeding 120-139 over (15, changed to 30 points after policy change),
speeding 140-159 over (18, changed to 36 points after policy change),


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.419e-11  4.877e-08   0.000    1.000    
age_grp16-19                   6.874e-11  4.987e-08   0.001    0.999    
age_grp20-24                   7.521e-11  4.914e-08   0.002    0.999    
age_grp25-34                   6.413e-11  4.892e-08   0.001    0.999    
age_grp35-44                   6.009e-11  4.889e-08   0.001    0.999    
age_grp45-54                   2.102e-09  4.889e-08   0.043    0.966    
age_grp55-64                   2.914e-11  4.893e-08   0.001    1.000    
age_grp65-74                   1.519e-11  4.910e-08   0.000    1.000    
age_grp75-84                   8.017e-12  4.965e-08   0.000    1.000    
age_grp85-89                   3.404e-12  5.887e-08   0.000    1.000    
age_grp90-199                  1.225e-12  1.080e-07   0.000    1.000    
policyTRUE                    -9.650e-10  6.766e-08  -0.014    0.989    
curr_pts_grp1                 -5.086e-10  1.760e-08  -0.029    0.977    
curr_pts_grp2                 -5.268e-10  8.043e-09  -0.065    0.948    
curr_pts_grp3                 -5.085e-10  7.797e-09  -0.065    0.948    
curr_pts_grp4                 -4.837e-10  2.224e-08  -0.022    0.983    
curr_pts_grp5                 -4.761e-10  1.761e-08  -0.027    0.978    
curr_pts_grp6                 -4.901e-10  2.196e-08  -0.022    0.982    
curr_pts_grp7                 -4.398e-10  3.952e-08  -0.011    0.991    
curr_pts_grp8                 -4.457e-10  3.831e-08  -0.012    0.991    
curr_pts_grp9                 -4.270e-10  4.054e-08  -0.011    0.992    
curr_pts_grp10                -4.148e-10  7.308e-08  -0.006    0.995    
curr_pts_grp11-20             -3.870e-10  4.561e-08  -0.008    0.993    
curr_pts_grp21-30             -2.845e-10  2.963e-07  -0.001    0.999    
curr_pts_grp30-150            -2.493e-10  7.870e-07   0.000    1.000    
age_grp16-19:policyTRUE        6.031e-08  6.913e-08   0.872    0.383    
age_grp20-24:policyTRUE        5.207e-08  6.819e-08   0.764    0.445    
age_grp25-34:policyTRUE        5.027e-09  6.787e-08   0.074    0.941    
age_grp35-44:policyTRUE        6.532e-10  6.784e-08   0.010    0.992    
age_grp45-54:policyTRUE       -3.731e-09  6.782e-08  -0.055    0.956    
age_grp55-64:policyTRUE       -1.880e-09  6.788e-08  -0.028    0.978    
age_grp65-74:policyTRUE       -8.198e-10  6.811e-08  -0.012    0.990    
age_grp75-84:policyTRUE       -3.967e-10  6.885e-08  -0.006    0.995    
age_grp85-89:policyTRUE       -7.100e-10  8.076e-08  -0.009    0.993    
age_grp90-199:policyTRUE      -7.848e-10  1.442e-07  -0.005    0.996    
policyTRUE:curr_pts_grp1      -6.302e-09  2.360e-08  -0.267    0.789    
policyTRUE:curr_pts_grp2       2.889e-09  1.074e-08   0.269    0.788    
policyTRUE:curr_pts_grp3       1.276e-08  1.085e-08   1.176    0.240    
policyTRUE:curr_pts_grp4       1.706e-07  2.874e-08   5.935 2.93e-09 ***
policyTRUE:curr_pts_grp5       3.642e-08  2.360e-08   1.544    0.123    
policyTRUE:curr_pts_grp6       6.148e-08  2.948e-08   2.086    0.037 *  
policyTRUE:curr_pts_grp7       3.694e-07  5.111e-08   7.227 4.93e-13 ***
policyTRUE:curr_pts_grp8      -9.045e-09  5.061e-08  -0.179    0.858    
policyTRUE:curr_pts_grp9       2.229e-07  5.413e-08   4.118 3.83e-05 ***
policyTRUE:curr_pts_grp10     -1.151e-08  9.009e-08  -0.128    0.898    
policyTRUE:curr_pts_grp11-20   6.590e-07  5.764e-08  11.434  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   5.887e-06  3.471e-07  16.963  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.171e-08  9.211e-07  -0.024    0.981    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 7.436e-05 on 4340212225 degrees of freedom
Multiple R-squared:  4.206e-07,	Adjusted R-squared:  4.097e-07
F-statistic: 38.84 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

Similarly: included only for comparison with males and the above for these 24 young ladies (vs 601 males).


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.669e-06  7.072e-07   2.360  0.01828 *  
age_grp16-19                   1.680e-06  7.231e-07   2.324  0.02013 *  
age_grp20-24                   1.261e-07  7.127e-07   0.177  0.85958    
age_grp25-34                  -5.733e-07  7.094e-07  -0.808  0.41897    
age_grp35-44                  -8.497e-07  7.090e-07  -1.198  0.23077    
age_grp45-54                  -1.009e-06  7.089e-07  -1.423  0.15460    
age_grp55-64                  -1.024e-06  7.096e-07  -1.443  0.14895    
age_grp65-74                  -7.557e-07  7.121e-07  -1.061  0.28858    
age_grp75-84                   2.543e-07  7.200e-07   0.353  0.72395    
age_grp85-89                   1.016e-06  8.537e-07   1.190  0.23394    
age_grp90-199                 -3.865e-08  1.566e-06  -0.025  0.98031    
policyTRUE                    -1.293e-07  9.811e-07  -0.132  0.89515    
curr_pts_grp1                  4.501e-07  2.552e-07   1.763  0.07782 .  
curr_pts_grp2                  1.049e-06  1.166e-07   8.992  < 2e-16 ***
curr_pts_grp3                  1.487e-06  1.131e-07  13.150  < 2e-16 ***
curr_pts_grp4                  5.329e-06  3.225e-07  16.527  < 2e-16 ***
curr_pts_grp5                  2.840e-06  2.553e-07  11.122  < 2e-16 ***
curr_pts_grp6                  3.992e-06  3.184e-07  12.535  < 2e-16 ***
curr_pts_grp7                  2.845e-06  5.731e-07   4.965 6.87e-07 ***
curr_pts_grp8                  5.552e-06  5.555e-07   9.994  < 2e-16 ***
curr_pts_grp9                  8.686e-06  5.878e-07  14.776  < 2e-16 ***
curr_pts_grp10                 1.142e-05  1.060e-06  10.774  < 2e-16 ***
curr_pts_grp11-20              1.350e-05  6.614e-07  20.410  < 2e-16 ***
curr_pts_grp21-30              3.042e-05  4.297e-06   7.081 1.43e-12 ***
curr_pts_grp30-150             1.107e-04  1.141e-05   9.701  < 2e-16 ***
age_grp16-19:policyTRUE       -3.717e-07  1.002e-06  -0.371  0.71081    
age_grp20-24:policyTRUE        4.506e-08  9.889e-07   0.046  0.96366    
age_grp25-34:policyTRUE        1.214e-07  9.842e-07   0.123  0.90184    
age_grp35-44:policyTRUE        5.075e-08  9.838e-07   0.052  0.95886    
age_grp45-54:policyTRUE       -2.761e-08  9.835e-07  -0.028  0.97760    
age_grp55-64:policyTRUE       -1.786e-09  9.844e-07  -0.002  0.99855    
age_grp65-74:policyTRUE        4.250e-08  9.877e-07   0.043  0.96568    
age_grp75-84:policyTRUE        2.332e-07  9.985e-07   0.234  0.81535    
age_grp85-89:policyTRUE        4.779e-07  1.171e-06   0.408  0.68320    
age_grp90-199:policyTRUE       4.702e-06  2.091e-06   2.248  0.02457 *  
policyTRUE:curr_pts_grp1       3.413e-07  3.423e-07   0.997  0.31874    
policyTRUE:curr_pts_grp2      -3.774e-07  1.557e-07  -2.424  0.01536 *  
policyTRUE:curr_pts_grp3      -3.193e-07  1.574e-07  -2.029  0.04248 *  
policyTRUE:curr_pts_grp4      -2.363e-06  4.168e-07  -5.670 1.43e-08 ***
policyTRUE:curr_pts_grp5      -3.111e-07  3.422e-07  -0.909  0.36317    
policyTRUE:curr_pts_grp6      -1.896e-06  4.275e-07  -4.436 9.15e-06 ***
policyTRUE:curr_pts_grp7       3.333e-07  7.411e-07   0.450  0.65293    
policyTRUE:curr_pts_grp8      -2.390e-06  7.339e-07  -3.256  0.00113 **
policyTRUE:curr_pts_grp9      -1.587e-06  7.850e-07  -2.022  0.04318 *  
policyTRUE:curr_pts_grp10     -1.096e-05  1.306e-06  -8.391  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -3.603e-06  8.358e-07  -4.311 1.62e-05 ***
policyTRUE:curr_pts_grp21-30  -1.395e-05  5.033e-06  -2.772  0.00556 **
policyTRUE:curr_pts_grp30-150 -2.915e-05  1.336e-05  -2.183  0.02907 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001078 on 4340212225 degrees of freedom
Multiple R-squared:  9.537e-07,	Adjusted R-squared:  9.429e-07
F-statistic: 88.07 on 47 and 4340212225 DF,  p-value: < 2.2e-16
```

There are just over 5000 events in this sample with this definition of the dependent variable (vs 14000 males).
