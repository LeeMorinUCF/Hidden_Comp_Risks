
# Draft 1: First version

Current point groups have been further consolidated in the new ```README.md```.


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
(Intercept)                    1.046e-04  8.495e-06  12.318  < 2e-16 ***
age_grp16-19                   6.376e-04  8.947e-06  71.270  < 2e-16 ***
age_grp20-24                   4.915e-04  8.664e-06  56.723  < 2e-16 ***
age_grp25-34                   3.183e-04  8.562e-06  37.178  < 2e-16 ***
age_grp35-44                   2.428e-04  8.552e-06  28.388  < 2e-16 ***
age_grp45-54                   1.930e-04  8.548e-06  22.582  < 2e-16 ***
age_grp55-64                   1.323e-04  8.565e-06  15.446  < 2e-16 ***
age_grp65-199                  3.985e-05  8.580e-06   4.645 3.40e-06 ***
policyTRUE                    -1.077e-06  1.218e-05  -0.088  0.92954    
curr_pts_grp1                  5.763e-04  4.279e-06 134.690  < 2e-16 ***
curr_pts_grp2                  6.163e-04  1.982e-06 310.879  < 2e-16 ***
curr_pts_grp3                  6.886e-04  1.711e-06 402.465  < 2e-16 ***
curr_pts_grp4                  1.117e-03  4.373e-06 255.557  < 2e-16 ***
curr_pts_grp5                  1.241e-03  3.274e-06 378.934  < 2e-16 ***
curr_pts_grp6                  1.409e-03  3.702e-06 380.661  < 2e-16 ***
curr_pts_grp7                  1.682e-03  6.003e-06 280.189  < 2e-16 ***
curr_pts_grp8                  1.853e-03  5.617e-06 329.871  < 2e-16 ***
curr_pts_grp9                  1.701e-03  6.198e-06 274.484  < 2e-16 ***
curr_pts_grp10-150             2.580e-03  4.297e-06 600.495  < 2e-16 ***
age_grp16-19:policyTRUE       -7.350e-05  1.278e-05  -5.753 8.75e-09 ***
age_grp20-24:policyTRUE       -7.503e-05  1.241e-05  -6.045 1.50e-09 ***
age_grp25-34:policyTRUE       -6.085e-05  1.227e-05  -4.959 7.08e-07 ***
age_grp35-44:policyTRUE       -3.281e-05  1.226e-05  -2.677  0.00743 **
age_grp45-54:policyTRUE       -2.358e-05  1.225e-05  -1.925  0.05420 .  
age_grp55-64:policyTRUE       -1.774e-05  1.227e-05  -1.445  0.14835    
age_grp65-199:policyTRUE      -1.696e-06  1.229e-05  -0.138  0.89022    
policyTRUE:curr_pts_grp1      -5.501e-05  5.843e-06  -9.414  < 2e-16 ***
policyTRUE:curr_pts_grp2      -6.344e-05  2.669e-06 -23.773  < 2e-16 ***
policyTRUE:curr_pts_grp3      -6.667e-05  2.404e-06 -27.738  < 2e-16 ***
policyTRUE:curr_pts_grp4      -9.246e-05  5.754e-06 -16.071  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.203e-04  4.445e-06 -27.071  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.487e-04  5.063e-06 -29.381  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.226e-04  8.019e-06 -15.287  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.946e-04  7.574e-06 -25.688  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.103e-04  8.440e-06 -13.066  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -5.111e-04  5.568e-06 -91.792  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033185 degrees of freedom
Multiple R-squared:  0.0004603,	Adjusted R-squared:  0.0004603
F-statistic: 7.02e+04 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.563e-05  1.069e-05   3.333 0.000859 ***
age_grp16-19                   2.678e-04  1.093e-05  24.498  < 2e-16 ***
age_grp20-24                   2.689e-04  1.077e-05  24.953  < 2e-16 ***
age_grp25-34                   2.146e-04  1.072e-05  20.008  < 2e-16 ***
age_grp35-44                   1.914e-04  1.072e-05  17.852  < 2e-16 ***
age_grp45-54                   1.409e-04  1.072e-05  13.147  < 2e-16 ***
age_grp55-64                   9.192e-05  1.073e-05   8.568  < 2e-16 ***
age_grp65-199                  4.212e-05  1.074e-05   3.921 8.84e-05 ***
policyTRUE                    -6.319e-06  1.483e-05  -0.426 0.670103    
curr_pts_grp1                  3.588e-04  3.859e-06  92.977  < 2e-16 ***
curr_pts_grp2                  4.165e-04  1.763e-06 236.191  < 2e-16 ***
curr_pts_grp3                  4.769e-04  1.709e-06 278.993  < 2e-16 ***
curr_pts_grp4                  7.925e-04  4.875e-06 162.560  < 2e-16 ***
curr_pts_grp5                  8.961e-04  3.860e-06 232.125  < 2e-16 ***
curr_pts_grp6                  1.050e-03  4.814e-06 218.074  < 2e-16 ***
curr_pts_grp7                  1.294e-03  8.664e-06 149.405  < 2e-16 ***
curr_pts_grp8                  1.428e-03  8.398e-06 170.034  < 2e-16 ***
curr_pts_grp9                  1.082e-03  8.887e-06 121.741  < 2e-16 ***
curr_pts_grp10-150             1.877e-03  8.406e-06 223.267  < 2e-16 ***
age_grp16-19:policyTRUE        9.754e-06  1.516e-05   0.644 0.519841    
age_grp20-24:policyTRUE        1.623e-06  1.495e-05   0.109 0.913534    
age_grp25-34:policyTRUE       -7.988e-06  1.488e-05  -0.537 0.591358    
age_grp35-44:policyTRUE        2.028e-06  1.487e-05   0.136 0.891543    
age_grp45-54:policyTRUE       -7.501e-07  1.487e-05  -0.050 0.959765    
age_grp55-64:policyTRUE        1.713e-06  1.488e-05   0.115 0.908344    
age_grp65-199:policyTRUE       9.547e-06  1.490e-05   0.641 0.521761    
policyTRUE:curr_pts_grp1       1.066e-05  5.174e-06   2.059 0.039455 *  
policyTRUE:curr_pts_grp2      -8.147e-06  2.354e-06  -3.461 0.000538 ***
policyTRUE:curr_pts_grp3      -1.182e-05  2.379e-06  -4.970 6.71e-07 ***
policyTRUE:curr_pts_grp4       2.220e-06  6.301e-06   0.352 0.724525    
policyTRUE:curr_pts_grp5       2.863e-06  5.173e-06   0.553 0.579958    
policyTRUE:curr_pts_grp6      -3.730e-05  6.462e-06  -5.773 7.81e-09 ***
policyTRUE:curr_pts_grp7      -1.946e-05  1.120e-05  -1.737 0.082472 .  
policyTRUE:curr_pts_grp8      -3.173e-05  1.110e-05  -2.860 0.004238 **
policyTRUE:curr_pts_grp9       4.194e-05  1.187e-05   3.534 0.000410 ***
policyTRUE:curr_pts_grp10-150 -2.077e-04  1.053e-05 -19.732  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0163 on 4340212237 degrees of freedom
Multiple R-squared:  0.000211,	Adjusted R-squared:  0.000211
F-statistic: 2.617e+04 on 35 and 4340212237 DF,  p-value: < 2.2e-16
```

### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.



#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.965e-06  2.407e-06   0.817 0.414200    
age_grp16-19                   4.832e-05  2.535e-06  19.063  < 2e-16 ***
age_grp20-24                   2.715e-05  2.455e-06  11.060  < 2e-16 ***
age_grp25-34                   2.520e-05  2.426e-06  10.389  < 2e-16 ***
age_grp35-44                   2.495e-05  2.423e-06  10.299  < 2e-16 ***
age_grp45-54                   2.229e-05  2.422e-06   9.203  < 2e-16 ***
age_grp55-64                   1.780e-05  2.427e-06   7.337 2.18e-13 ***
age_grp65-199                  8.477e-06  2.431e-06   3.487 0.000488 ***
policyTRUE                     1.976e-06  3.450e-06   0.573 0.566710    
curr_pts_grp1                  1.101e-04  1.212e-06  90.822  < 2e-16 ***
curr_pts_grp2                  4.907e-05  5.616e-07  87.364  < 2e-16 ***
curr_pts_grp3                  3.755e-05  4.847e-07  77.465  < 2e-16 ***
curr_pts_grp4                  1.047e-04  1.239e-06  84.525  < 2e-16 ***
curr_pts_grp5                  7.987e-05  9.275e-07  86.114  < 2e-16 ***
curr_pts_grp6                  7.973e-05  1.049e-06  76.019  < 2e-16 ***
curr_pts_grp7                  1.328e-04  1.701e-06  78.101  < 2e-16 ***
curr_pts_grp8                  1.292e-04  1.591e-06  81.154  < 2e-16 ***
curr_pts_grp9                  1.167e-04  1.756e-06  66.440  < 2e-16 ***
curr_pts_grp10-150             2.074e-04  1.217e-06 170.391  < 2e-16 ***
age_grp16-19:policyTRUE       -1.237e-06  3.619e-06  -0.342 0.732451    
age_grp20-24:policyTRUE       -4.865e-06  3.517e-06  -1.383 0.166578    
age_grp25-34:policyTRUE       -1.380e-06  3.476e-06  -0.397 0.691375    
age_grp35-44:policyTRUE        1.273e-06  3.473e-06   0.367 0.713960    
age_grp45-54:policyTRUE        2.376e-06  3.471e-06   0.685 0.493590    
age_grp55-64:policyTRUE        2.249e-06  3.477e-06   0.647 0.517799    
age_grp65-199:policyTRUE       2.438e-06  3.482e-06   0.700 0.483720    
policyTRUE:curr_pts_grp1      -1.205e-05  1.655e-06  -7.277 3.41e-13 ***
policyTRUE:curr_pts_grp2       2.671e-06  7.561e-07   3.532 0.000412 ***
policyTRUE:curr_pts_grp3       7.459e-06  6.810e-07  10.953  < 2e-16 ***
policyTRUE:curr_pts_grp4      -5.543e-08  1.630e-06  -0.034 0.972873    
policyTRUE:curr_pts_grp5       9.168e-06  1.259e-06   7.280 3.34e-13 ***
policyTRUE:curr_pts_grp6       1.332e-05  1.434e-06   9.285  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.197e-05  2.272e-06   5.269 1.37e-07 ***
policyTRUE:curr_pts_grp8       3.464e-06  2.146e-06   1.614 0.106488    
policyTRUE:curr_pts_grp9       1.936e-05  2.391e-06   8.097 5.61e-16 ***
policyTRUE:curr_pts_grp10-150 -1.266e-05  1.578e-06  -8.027 1.00e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006482 on 5335033185 degrees of freedom
Multiple R-squared:  3.624e-05,	Adjusted R-squared:  3.623e-05
F-statistic:  5524 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.286e-06  3.259e-06   0.395 0.693061    
age_grp16-19                   3.164e-05  3.332e-06   9.495  < 2e-16 ***
age_grp20-24                   2.532e-05  3.284e-06   7.711 1.25e-14 ***
age_grp25-34                   2.030e-05  3.269e-06   6.212 5.23e-10 ***
age_grp35-44                   1.720e-05  3.267e-06   5.264 1.41e-07 ***
age_grp45-54                   1.326e-05  3.266e-06   4.060 4.91e-05 ***
age_grp55-64                   9.171e-06  3.270e-06   2.805 0.005033 **
age_grp65-199                  4.669e-06  3.275e-06   1.426 0.153908    
policyTRUE                    -1.601e-06  4.521e-06  -0.354 0.723211    
curr_pts_grp1                  7.446e-05  1.176e-06  63.314  < 2e-16 ***
curr_pts_grp2                  3.498e-05  5.374e-07  65.089  < 2e-16 ***
curr_pts_grp3                  2.572e-05  5.210e-07  49.369  < 2e-16 ***
curr_pts_grp4                  6.793e-05  1.486e-06  45.719  < 2e-16 ***
curr_pts_grp5                  5.395e-05  1.177e-06  45.856  < 2e-16 ***
curr_pts_grp6                  6.066e-05  1.467e-06  41.341  < 2e-16 ***
curr_pts_grp7                  9.447e-05  2.641e-06  35.776  < 2e-16 ***
curr_pts_grp8                  8.415e-05  2.560e-06  32.877  < 2e-16 ***
curr_pts_grp9                  7.336e-05  2.708e-06  27.086  < 2e-16 ***
curr_pts_grp10-150             1.570e-04  2.562e-06  61.260  < 2e-16 ***
age_grp16-19:policyTRUE        7.352e-06  4.619e-06   1.592 0.111482    
age_grp20-24:policyTRUE        3.386e-06  4.557e-06   0.743 0.457397    
age_grp25-34:policyTRUE        5.128e-06  4.535e-06   1.131 0.258138    
age_grp35-44:policyTRUE        6.451e-06  4.533e-06   1.423 0.154716    
age_grp45-54:policyTRUE        5.680e-06  4.532e-06   1.253 0.210112    
age_grp55-64:policyTRUE        5.475e-06  4.536e-06   1.207 0.227410    
age_grp65-199:policyTRUE       5.161e-06  4.542e-06   1.136 0.255843    
policyTRUE:curr_pts_grp1      -8.030e-07  1.577e-06  -0.509 0.610632    
policyTRUE:curr_pts_grp2       5.955e-06  7.175e-07   8.300  < 2e-16 ***
policyTRUE:curr_pts_grp3       1.112e-05  7.252e-07  15.330  < 2e-16 ***
policyTRUE:curr_pts_grp4       8.990e-06  1.920e-06   4.682 2.85e-06 ***
policyTRUE:curr_pts_grp5       1.775e-05  1.577e-06  11.257  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.681e-05  1.970e-06   8.533  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.187e-05  3.415e-06   3.475 0.000511 ***
policyTRUE:curr_pts_grp8       2.986e-05  3.382e-06   8.830  < 2e-16 ***
policyTRUE:curr_pts_grp9       1.414e-05  3.617e-06   3.909 9.28e-05 ***
policyTRUE:curr_pts_grp10-150  1.521e-05  3.208e-06   4.742 2.12e-06 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004969 on 4340212237 degrees of freedom
Multiple R-squared:  1.726e-05,	Adjusted R-squared:  1.725e-05
F-statistic:  2140 on 35 and 4340212237 DF,  p-value: < 2.2e-16
```

### Two-point violations (speeding 21-30 over or 7 other violations)

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -6.163e-06  5.343e-06  -1.154 0.248690    
age_grp16-19                   1.872e-04  5.627e-06  33.262  < 2e-16 ***
age_grp20-24                   1.760e-04  5.450e-06  32.288  < 2e-16 ***
age_grp25-34                   1.595e-04  5.386e-06  29.617  < 2e-16 ***
age_grp35-44                   1.499e-04  5.379e-06  27.874  < 2e-16 ***
age_grp45-54                   1.387e-04  5.376e-06  25.804  < 2e-16 ***
age_grp55-64                   1.151e-04  5.388e-06  21.369  < 2e-16 ***
age_grp65-199                  6.859e-05  5.397e-06  12.709  < 2e-16 ***
policyTRUE                     6.942e-08  7.659e-06   0.009 0.992768    
curr_pts_grp1                  2.356e-04  2.691e-06  87.539  < 2e-16 ***
curr_pts_grp2                  2.642e-04  1.247e-06 211.914  < 2e-16 ***
curr_pts_grp3                  2.444e-04  1.076e-06 227.163  < 2e-16 ***
curr_pts_grp4                  4.420e-04  2.750e-06 160.696  < 2e-16 ***
curr_pts_grp5                  4.637e-04  2.059e-06 225.178  < 2e-16 ***
curr_pts_grp6                  4.671e-04  2.329e-06 200.603  < 2e-16 ***
curr_pts_grp7                  6.160e-04  3.776e-06 163.157  < 2e-16 ***
curr_pts_grp8                  6.314e-04  3.533e-06 178.704  < 2e-16 ***
curr_pts_grp9                  5.537e-04  3.898e-06 142.029  < 2e-16 ***
curr_pts_grp10-150             7.823e-04  2.703e-06 289.471  < 2e-16 ***
age_grp16-19:policyTRUE        3.590e-06  8.035e-06   0.447 0.655061    
age_grp20-24:policyTRUE       -2.174e-07  7.808e-06  -0.028 0.977784    
age_grp25-34:policyTRUE       -7.566e-06  7.718e-06  -0.980 0.326929    
age_grp35-44:policyTRUE       -3.780e-06  7.711e-06  -0.490 0.623968    
age_grp45-54:policyTRUE       -1.352e-06  7.705e-06  -0.175 0.860760    
age_grp55-64:policyTRUE       -1.140e-06  7.719e-06  -0.148 0.882632    
age_grp65-199:policyTRUE       1.876e-06  7.730e-06   0.243 0.808221    
policyTRUE:curr_pts_grp1      -1.260e-05  3.675e-06  -3.429 0.000605 ***
policyTRUE:curr_pts_grp2      -6.886e-06  1.679e-06  -4.102 4.09e-05 ***
policyTRUE:curr_pts_grp3      -2.025e-06  1.512e-06  -1.339 0.180466    
policyTRUE:curr_pts_grp4      -2.281e-06  3.619e-06  -0.630 0.528587    
policyTRUE:curr_pts_grp5      -5.264e-06  2.796e-06  -1.883 0.059760 .  
policyTRUE:curr_pts_grp6       1.037e-06  3.184e-06   0.326 0.744653    
policyTRUE:curr_pts_grp7       4.827e-06  5.044e-06   0.957 0.338553    
policyTRUE:curr_pts_grp8      -5.847e-06  4.764e-06  -1.227 0.219734    
policyTRUE:curr_pts_grp9       1.770e-05  5.309e-06   3.334 0.000856 ***
policyTRUE:curr_pts_grp10-150 -1.069e-04  3.502e-06 -30.514  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01439 on 5335033185 degrees of freedom
Multiple R-squared:  0.0001433,	Adjusted R-squared:  0.0001433
F-statistic: 2.185e+04 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.106e-06  7.265e-06  -0.152  0.87895    
age_grp16-19                   1.168e-04  7.429e-06  15.717  < 2e-16 ***
age_grp20-24                   1.260e-04  7.321e-06  17.216  < 2e-16 ***
age_grp25-34                   1.149e-04  7.288e-06  15.763  < 2e-16 ***
age_grp35-44                   1.073e-04  7.284e-06  14.736  < 2e-16 ***
age_grp45-54                   8.610e-05  7.283e-06  11.822  < 2e-16 ***
age_grp55-64                   6.163e-05  7.290e-06   8.454  < 2e-16 ***
age_grp65-199                  3.443e-05  7.301e-06   4.717 2.40e-06 ***
policyTRUE                    -3.572e-06  1.008e-05  -0.354  0.72303    
curr_pts_grp1                  1.553e-04  2.622e-06  59.216  < 2e-16 ***
curr_pts_grp2                  2.003e-04  1.198e-06 167.172  < 2e-16 ***
curr_pts_grp3                  1.947e-04  1.162e-06 167.588  < 2e-16 ***
curr_pts_grp4                  3.654e-04  3.313e-06 110.302  < 2e-16 ***
curr_pts_grp5                  3.806e-04  2.623e-06 145.088  < 2e-16 ***
curr_pts_grp6                  3.987e-04  3.271e-06 121.893  < 2e-16 ***
curr_pts_grp7                  5.452e-04  5.887e-06  92.598  < 2e-16 ***
curr_pts_grp8                  5.546e-04  5.707e-06  97.173  < 2e-16 ***
curr_pts_grp9                  3.806e-04  6.039e-06  63.030  < 2e-16 ***
curr_pts_grp10-150             6.562e-04  5.712e-06 114.876  < 2e-16 ***
age_grp16-19:policyTRUE        1.185e-05  1.030e-05   1.151  0.24990    
age_grp20-24:policyTRUE        8.852e-06  1.016e-05   0.871  0.38359    
age_grp25-34:policyTRUE        3.901e-06  1.011e-05   0.386  0.69963    
age_grp35-44:policyTRUE        7.159e-06  1.011e-05   0.708  0.47874    
age_grp45-54:policyTRUE        5.944e-06  1.010e-05   0.588  0.55633    
age_grp55-64:policyTRUE        5.207e-06  1.011e-05   0.515  0.60665    
age_grp65-199:policyTRUE       6.312e-06  1.013e-05   0.623  0.53313    
policyTRUE:curr_pts_grp1       1.514e-05  3.516e-06   4.305 1.67e-05 ***
policyTRUE:curr_pts_grp2       4.486e-06  1.600e-06   2.804  0.00504 **
policyTRUE:curr_pts_grp3       6.460e-06  1.617e-06   3.995 6.47e-05 ***
policyTRUE:curr_pts_grp4       1.673e-05  4.281e-06   3.908 9.31e-05 ***
policyTRUE:curr_pts_grp5       2.711e-05  3.515e-06   7.713 1.23e-14 ***
policyTRUE:curr_pts_grp6       1.812e-05  4.391e-06   4.127 3.68e-05 ***
policyTRUE:curr_pts_grp7       2.488e-05  7.614e-06   3.268  0.00108 **
policyTRUE:curr_pts_grp8       1.735e-05  7.540e-06   2.301  0.02141 *  
policyTRUE:curr_pts_grp9       6.478e-05  8.064e-06   8.033 9.48e-16 ***
policyTRUE:curr_pts_grp10-150 -2.886e-05  7.153e-06  -4.035 5.46e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01108 on 4340212237 degrees of freedom
Multiple R-squared:  8.383e-05,	Adjusted R-squared:  8.382e-05
F-statistic: 1.04e+04 on 35 and 4340212237 DF,  p-value: < 2.2e-16
```

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change. That is, the 6-point violations are not included in the sample before the window.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    8.946e-05  5.884e-06  15.204  < 2e-16 ***
age_grp16-19                   2.786e-04  6.198e-06  44.954  < 2e-16 ***
age_grp20-24                   2.353e-04  6.002e-06  39.211  < 2e-16 ***
age_grp25-34                   1.267e-04  5.931e-06  21.359  < 2e-16 ***
age_grp35-44                   7.884e-05  5.924e-06  13.309  < 2e-16 ***
age_grp45-54                   4.816e-05  5.921e-06   8.134 4.16e-16 ***
age_grp55-64                   1.839e-05  5.933e-06   3.099 0.001941 **
age_grp65-199                 -1.794e-05  5.943e-06  -3.018 0.002541 **
policyTRUE                     2.521e-06  8.435e-06   0.299 0.765053    
curr_pts_grp1                  2.134e-04  2.964e-06  72.014  < 2e-16 ***
curr_pts_grp2                  2.812e-04  1.373e-06 204.761  < 2e-16 ***
curr_pts_grp3                  3.703e-04  1.185e-06 312.484  < 2e-16 ***
curr_pts_grp4                  4.976e-04  3.029e-06 164.267  < 2e-16 ***
curr_pts_grp5                  6.297e-04  2.268e-06 277.686  < 2e-16 ***
curr_pts_grp6                  7.798e-04  2.564e-06 304.097  < 2e-16 ***
curr_pts_grp7                  8.139e-04  4.158e-06 195.752  < 2e-16 ***
curr_pts_grp8                  9.654e-04  3.891e-06 248.110  < 2e-16 ***
curr_pts_grp9                  9.111e-04  4.293e-06 212.231  < 2e-16 ***
curr_pts_grp10-150             1.331e-03  2.976e-06 447.028  < 2e-16 ***
age_grp16-19:policyTRUE       -5.274e-05  8.849e-06  -5.959 2.53e-09 ***
age_grp20-24:policyTRUE       -5.392e-05  8.599e-06  -6.271 3.58e-10 ***
age_grp25-34:policyTRUE       -4.718e-05  8.500e-06  -5.550 2.85e-08 ***
age_grp35-44:policyTRUE       -3.241e-05  8.492e-06  -3.816 0.000135 ***
age_grp45-54:policyTRUE       -2.825e-05  8.485e-06  -3.329 0.000873 ***
age_grp55-64:policyTRUE       -2.403e-05  8.501e-06  -2.827 0.004701 **
age_grp65-199:policyTRUE      -1.172e-05  8.513e-06  -1.377 0.168630    
policyTRUE:curr_pts_grp1      -2.208e-05  4.048e-06  -5.455 4.91e-08 ***
policyTRUE:curr_pts_grp2      -4.869e-05  1.849e-06 -26.341  < 2e-16 ***
policyTRUE:curr_pts_grp3      -5.533e-05  1.665e-06 -33.231  < 2e-16 ***
policyTRUE:curr_pts_grp4      -6.055e-05  3.985e-06 -15.193  < 2e-16 ***
policyTRUE:curr_pts_grp5      -8.828e-05  3.079e-06 -28.670  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.263e-04  3.507e-06 -36.005  < 2e-16 ***
policyTRUE:curr_pts_grp7      -8.679e-05  5.555e-06 -15.623  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.343e-04  5.247e-06 -25.595  < 2e-16 ***
policyTRUE:curr_pts_grp9      -9.553e-05  5.846e-06 -16.340  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -2.815e-04  3.857e-06 -72.993  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01585 on 5335033185 degrees of freedom
Multiple R-squared:  0.0002486,	Adjusted R-squared:  0.0002486
F-statistic: 3.79e+04 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.330e-05  6.973e-06   4.776 1.79e-06 ***
age_grp16-19                   9.953e-05  7.130e-06  13.959  < 2e-16 ***
age_grp20-24                   1.056e-04  7.027e-06  15.033  < 2e-16 ***
age_grp25-34                   7.484e-05  6.995e-06  10.700  < 2e-16 ***
age_grp35-44                   6.520e-05  6.992e-06   9.326  < 2e-16 ***
age_grp45-54                   4.166e-05  6.990e-06   5.960 2.53e-09 ***
age_grp55-64                   2.205e-05  6.997e-06   3.152  0.00162 **
age_grp65-199                  3.725e-06  7.007e-06   0.532  0.59498    
policyTRUE                    -1.878e-06  9.674e-06  -0.194  0.84608    
curr_pts_grp1                  1.229e-04  2.517e-06  48.815  < 2e-16 ***
curr_pts_grp2                  1.739e-04  1.150e-06 151.192  < 2e-16 ***
curr_pts_grp3                  2.424e-04  1.115e-06 217.443  < 2e-16 ***
curr_pts_grp4                  3.311e-04  3.180e-06 104.130  < 2e-16 ***
curr_pts_grp5                  4.340e-04  2.518e-06 172.371  < 2e-16 ***
curr_pts_grp6                  5.553e-04  3.140e-06 176.860  < 2e-16 ***
curr_pts_grp7                  6.039e-04  5.651e-06 106.862  < 2e-16 ***
curr_pts_grp8                  7.309e-04  5.478e-06 133.441  < 2e-16 ***
curr_pts_grp9                  5.821e-04  5.796e-06 100.426  < 2e-16 ***
curr_pts_grp10-150             9.426e-04  5.483e-06 171.917  < 2e-16 ***
age_grp16-19:policyTRUE       -4.903e-06  9.885e-06  -0.496  0.61988    
age_grp20-24:policyTRUE       -6.072e-06  9.751e-06  -0.623  0.53347    
age_grp25-34:policyTRUE       -1.384e-05  9.705e-06  -1.426  0.15386    
age_grp35-44:policyTRUE       -9.301e-06  9.701e-06  -0.959  0.33767    
age_grp45-54:policyTRUE       -1.067e-05  9.698e-06  -1.101  0.27108    
age_grp55-64:policyTRUE       -7.739e-06  9.707e-06  -0.797  0.42531    
age_grp65-199:policyTRUE      -1.008e-06  9.720e-06  -0.104  0.91738    
policyTRUE:curr_pts_grp1      -1.308e-06  3.375e-06  -0.388  0.69830    
policyTRUE:curr_pts_grp2      -1.559e-05  1.535e-06 -10.156  < 2e-16 ***
policyTRUE:curr_pts_grp3      -2.270e-05  1.552e-06 -14.626  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.318e-05  4.109e-06  -3.208  0.00134 **
policyTRUE:curr_pts_grp5      -2.957e-05  3.374e-06  -8.764  < 2e-16 ***
policyTRUE:curr_pts_grp6      -5.479e-05  4.215e-06 -12.998  < 2e-16 ***
policyTRUE:curr_pts_grp7      -3.624e-05  7.308e-06  -4.958 7.11e-07 ***
policyTRUE:curr_pts_grp8      -5.151e-05  7.237e-06  -7.117 1.10e-12 ***
policyTRUE:curr_pts_grp9      -1.755e-05  7.740e-06  -2.267  0.02340 *  
policyTRUE:curr_pts_grp10-150 -1.351e-04  6.866e-06 -19.683  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01063 on 4340212237 degrees of freedom
Multiple R-squared:  0.0001077,	Adjusted R-squared:  0.0001077
F-statistic: 1.336e+04 on 35 and 4340212237 DF,  p-value: < 2.2e-16
```


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.699e-05  8.927e-07  19.030  < 2e-16 ***
age_grp16-19                   5.128e-05  9.402e-07  54.541  < 2e-16 ***
age_grp20-24                   1.163e-06  9.105e-07   1.277 0.201499    
age_grp25-34                  -1.313e-05  8.998e-07 -14.596  < 2e-16 ***
age_grp35-44                  -1.621e-05  8.987e-07 -18.042  < 2e-16 ***
age_grp45-54                  -1.701e-05  8.983e-07 -18.938  < 2e-16 ***
age_grp55-64                  -1.705e-05  9.001e-07 -18.937  < 2e-16 ***
age_grp65-199                 -1.687e-05  9.016e-07 -18.713  < 2e-16 ***
policyTRUE                    -5.030e-06  1.280e-06  -3.930 8.48e-05 ***
curr_pts_grp1                  1.206e-06  4.496e-07   2.682 0.007320 **
curr_pts_grp2                  1.493e-06  2.083e-07   7.167 7.65e-13 ***
curr_pts_grp3                  4.844e-06  1.798e-07  26.944  < 2e-16 ***
curr_pts_grp4                  2.566e-05  4.595e-07  55.847  < 2e-16 ***
curr_pts_grp5                  5.828e-06  3.440e-07  16.941  < 2e-16 ***
curr_pts_grp6                  1.128e-05  3.890e-07  28.984  < 2e-16 ***
curr_pts_grp7                  2.709e-05  6.308e-07  42.944  < 2e-16 ***
curr_pts_grp8                  2.192e-05  5.903e-07  37.129  < 2e-16 ***
curr_pts_grp9                  2.017e-05  6.513e-07  30.971  < 2e-16 ***
curr_pts_grp10-150             5.599e-05  4.515e-07 123.993  < 2e-16 ***
age_grp16-19:policyTRUE       -4.447e-07  1.343e-06  -0.331 0.740468    
age_grp20-24:policyTRUE        4.380e-06  1.304e-06   3.357 0.000787 ***
age_grp25-34:policyTRUE        5.015e-06  1.290e-06   3.889 0.000101 ***
age_grp35-44:policyTRUE        5.005e-06  1.288e-06   3.885 0.000102 ***
age_grp45-54:policyTRUE        4.999e-06  1.287e-06   3.883 0.000103 ***
age_grp55-64:policyTRUE        4.895e-06  1.290e-06   3.795 0.000147 ***
age_grp65-199:policyTRUE       4.904e-06  1.292e-06   3.797 0.000146 ***
policyTRUE:curr_pts_grp1      -5.898e-07  6.141e-07  -0.960 0.336816    
policyTRUE:curr_pts_grp2      -4.394e-07  2.804e-07  -1.567 0.117181    
policyTRUE:curr_pts_grp3      -1.077e-06  2.526e-07  -4.265 2.00e-05 ***
policyTRUE:curr_pts_grp4      -6.312e-06  6.046e-07 -10.440  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.484e-06  4.671e-07  -3.178 0.001485 **
policyTRUE:curr_pts_grp6      -1.545e-06  5.320e-07  -2.904 0.003681 **
policyTRUE:curr_pts_grp7      -6.360e-06  8.427e-07  -7.547 4.45e-14 ***
policyTRUE:curr_pts_grp8      -2.415e-06  7.960e-07  -3.034 0.002415 **
policyTRUE:curr_pts_grp9      -4.923e-06  8.869e-07  -5.551 2.84e-08 ***
policyTRUE:curr_pts_grp10-150 -1.668e-05  5.852e-07 -28.504  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002404 on 5335033185 degrees of freedom
Multiple R-squared:  3.179e-05,	Adjusted R-squared:  3.179e-05
F-statistic:  4846 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    7.986e-07  6.814e-07   1.172 0.241203    
age_grp16-19                   8.037e-06  6.968e-07  11.535  < 2e-16 ***
age_grp20-24                   1.939e-06  6.867e-07   2.823 0.004751 **
age_grp25-34                   2.435e-07  6.835e-07   0.356 0.721699    
age_grp35-44                  -3.127e-07  6.832e-07  -0.458 0.647223    
age_grp45-54                  -6.124e-07  6.831e-07  -0.897 0.369934    
age_grp55-64                  -7.165e-07  6.838e-07  -1.048 0.294700    
age_grp65-199                 -5.825e-07  6.848e-07  -0.851 0.394960    
policyTRUE                     7.376e-07  9.454e-07   0.780 0.435244    
curr_pts_grp1                  5.458e-07  2.459e-07   2.219 0.026477 *  
curr_pts_grp2                  5.582e-07  1.124e-07   4.967 6.80e-07 ***
curr_pts_grp3                  2.003e-06  1.089e-07  18.383  < 2e-16 ***
curr_pts_grp4                  7.776e-06  3.107e-07  25.025  < 2e-16 ***
curr_pts_grp5                  1.911e-06  2.460e-07   7.769 7.94e-15 ***
curr_pts_grp6                  3.601e-06  3.068e-07  11.738  < 2e-16 ***
curr_pts_grp7                  8.390e-06  5.522e-07  15.194  < 2e-16 ***
curr_pts_grp8                  4.475e-06  5.353e-07   8.360  < 2e-16 ***
curr_pts_grp9                  5.106e-06  5.664e-07   9.015  < 2e-16 ***
curr_pts_grp10-150             1.993e-05  5.358e-07  37.199  < 2e-16 ***
age_grp16-19:policyTRUE       -2.678e-07  9.660e-07  -0.277 0.781583    
age_grp20-24:policyTRUE       -7.790e-08  9.529e-07  -0.082 0.934844    
age_grp25-34:policyTRUE       -7.546e-07  9.483e-07  -0.796 0.426216    
age_grp35-44:policyTRUE       -6.771e-07  9.480e-07  -0.714 0.475052    
age_grp45-54:policyTRUE       -6.828e-07  9.477e-07  -0.720 0.471238    
age_grp55-64:policyTRUE       -7.365e-07  9.486e-07  -0.776 0.437461    
age_grp65-199:policyTRUE      -8.564e-07  9.499e-07  -0.902 0.367254    
policyTRUE:curr_pts_grp1      -2.879e-07  3.298e-07  -0.873 0.382637    
policyTRUE:curr_pts_grp2      -1.837e-07  1.500e-07  -1.225 0.220709    
policyTRUE:curr_pts_grp3      -6.043e-07  1.517e-07  -3.985 6.75e-05 ***
policyTRUE:curr_pts_grp4      -1.647e-06  4.016e-07  -4.100 4.13e-05 ***
policyTRUE:curr_pts_grp5      -8.983e-07  3.297e-07  -2.725 0.006436 **
policyTRUE:curr_pts_grp6      -1.296e-06  4.119e-07  -3.147 0.001648 **
policyTRUE:curr_pts_grp7      -2.461e-06  7.141e-07  -3.446 0.000569 ***
policyTRUE:curr_pts_grp8       3.181e-06  7.072e-07   4.497 6.88e-06 ***
policyTRUE:curr_pts_grp9      -1.738e-06  7.564e-07  -2.298 0.021544 *  
policyTRUE:curr_pts_grp10-150 -4.609e-06  6.709e-07  -6.869 6.45e-12 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001039 on 4340212237 degrees of freedom
Multiple R-squared:  3.621e-06,	Adjusted R-squared:  3.612e-06
F-statistic:   449 on 35 and 4340212237 DF,  p-value: < 2.2e-16
```
### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.


#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.582e-06  1.326e-06  -1.946   0.0516 .  
age_grp16-19                   4.769e-05  1.397e-06  34.136  < 2e-16 ***
age_grp20-24                   3.990e-05  1.353e-06  29.491  < 2e-16 ***
age_grp25-34                   1.946e-05  1.337e-06  14.556  < 2e-16 ***
age_grp35-44                   8.869e-06  1.335e-06   6.641 3.11e-11 ***
age_grp45-54                   5.382e-06  1.335e-06   4.032 5.53e-05 ***
age_grp55-64                   2.977e-06  1.337e-06   2.226   0.0260 *  
age_grp65-199                  1.739e-06  1.340e-06   1.298   0.1943    
policyTRUE                     1.009e-06  1.901e-06   0.531   0.5956    
curr_pts_grp1                  1.300e-05  6.681e-07  19.454  < 2e-16 ***
curr_pts_grp2                  1.645e-05  3.096e-07  53.137  < 2e-16 ***
curr_pts_grp3                  2.403e-05  2.671e-07  89.962  < 2e-16 ***
curr_pts_grp4                  3.518e-05  6.828e-07  51.527  < 2e-16 ***
curr_pts_grp5                  4.788e-05  5.112e-07  93.658  < 2e-16 ***
curr_pts_grp6                  5.445e-05  5.781e-07  94.185  < 2e-16 ***
curr_pts_grp7                  6.558e-05  9.373e-07  69.962  < 2e-16 ***
curr_pts_grp8                  8.212e-05  8.771e-07  93.618  < 2e-16 ***
curr_pts_grp9                  7.468e-05  9.678e-07  77.166  < 2e-16 ***
curr_pts_grp10-150             1.401e-04  6.709e-07 208.796  < 2e-16 ***
age_grp16-19:policyTRUE       -1.375e-05  1.995e-06  -6.894 5.42e-12 ***
age_grp20-24:policyTRUE       -1.595e-05  1.938e-06  -8.227  < 2e-16 ***
age_grp25-34:policyTRUE       -8.921e-06  1.916e-06  -4.656 3.22e-06 ***
age_grp35-44:policyTRUE       -4.217e-06  1.914e-06  -2.203   0.0276 *  
age_grp45-54:policyTRUE       -2.946e-06  1.913e-06  -1.540   0.1235    
age_grp55-64:policyTRUE       -1.553e-06  1.916e-06  -0.810   0.4178    
age_grp65-199:policyTRUE      -8.736e-07  1.919e-06  -0.455   0.6489    
policyTRUE:curr_pts_grp1      -6.630e-06  9.124e-07  -7.267 3.69e-13 ***
policyTRUE:curr_pts_grp2      -8.455e-06  4.167e-07 -20.289  < 2e-16 ***
policyTRUE:curr_pts_grp3      -1.211e-05  3.753e-07 -32.271  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.769e-05  8.984e-07 -19.692  < 2e-16 ***
policyTRUE:curr_pts_grp5      -2.660e-05  6.941e-07 -38.327  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.685e-05  7.905e-07 -33.963  < 2e-16 ***
policyTRUE:curr_pts_grp7      -3.196e-05  1.252e-06 -25.524  < 2e-16 ***
policyTRUE:curr_pts_grp8      -4.481e-05  1.183e-06 -37.888  < 2e-16 ***
policyTRUE:curr_pts_grp9      -3.738e-05  1.318e-06 -28.366  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -6.389e-05  8.695e-07 -73.481  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003573 on 5335033185 degrees of freedom
Multiple R-squared:  3.437e-05,	Adjusted R-squared:  3.437e-05
F-statistic:  5240 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.922e-07  1.117e-06  -0.262   0.7936    
age_grp16-19                   8.209e-06  1.142e-06   7.191 6.44e-13 ***
age_grp20-24                   8.755e-06  1.125e-06   7.781 7.20e-15 ***
age_grp25-34                   4.528e-06  1.120e-06   4.043 5.28e-05 ***
age_grp35-44                   2.681e-06  1.119e-06   2.395   0.0166 *  
age_grp45-54                   1.465e-06  1.119e-06   1.309   0.1907    
age_grp55-64                   8.233e-07  1.120e-06   0.735   0.4624    
age_grp65-199                  3.204e-07  1.122e-06   0.286   0.7752    
policyTRUE                     1.125e-07  1.549e-06   0.073   0.9421    
curr_pts_grp1                  5.071e-06  4.030e-07  12.585  < 2e-16 ***
curr_pts_grp2                  5.348e-06  1.841e-07  29.043  < 2e-16 ***
curr_pts_grp3                  9.798e-06  1.785e-07  54.893  < 2e-16 ***
curr_pts_grp4                  1.364e-05  5.091e-07  26.793  < 2e-16 ***
curr_pts_grp5                  2.044e-05  4.031e-07  50.711  < 2e-16 ***
curr_pts_grp6                  2.404e-05  5.027e-07  47.815  < 2e-16 ***
curr_pts_grp7                  3.635e-05  9.047e-07  40.182  < 2e-16 ***
curr_pts_grp8                  4.543e-05  8.770e-07  51.803  < 2e-16 ***
curr_pts_grp9                  2.962e-05  9.280e-07  31.918  < 2e-16 ***
curr_pts_grp10-150             7.586e-05  8.779e-07  86.420  < 2e-16 ***
age_grp16-19:policyTRUE       -2.645e-06  1.583e-06  -1.671   0.0947 .  
age_grp20-24:policyTRUE       -4.061e-06  1.561e-06  -2.601   0.0093 **
age_grp25-34:policyTRUE       -2.319e-06  1.554e-06  -1.492   0.1356    
age_grp35-44:policyTRUE       -1.576e-06  1.553e-06  -1.014   0.3104    
age_grp45-54:policyTRUE       -9.627e-07  1.553e-06  -0.620   0.5353    
age_grp55-64:policyTRUE       -5.152e-07  1.554e-06  -0.331   0.7403    
age_grp65-199:policyTRUE      -1.763e-07  1.556e-06  -0.113   0.9098    
policyTRUE:curr_pts_grp1      -2.424e-06  5.404e-07  -4.486 7.25e-06 ***
policyTRUE:curr_pts_grp2      -2.212e-06  2.458e-07  -8.997  < 2e-16 ***
policyTRUE:curr_pts_grp3      -5.218e-06  2.485e-07 -20.999  < 2e-16 ***
policyTRUE:curr_pts_grp4      -5.480e-06  6.580e-07  -8.329  < 2e-16 ***
policyTRUE:curr_pts_grp5      -9.566e-06  5.402e-07 -17.708  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.193e-05  6.749e-07 -17.672  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.570e-05  1.170e-06 -13.421  < 2e-16 ***
policyTRUE:curr_pts_grp8      -2.621e-05  1.159e-06 -22.617  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.640e-05  1.239e-06 -13.234  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -4.192e-05  1.099e-06 -38.136  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001702 on 4340212237 degrees of freedom
Multiple R-squared:  8.57e-06,	Adjusted R-squared:  8.562e-06
F-statistic:  1063 on 35 and 4340212237 DF,  p-value: < 2.2e-16
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
(Intercept)                   -3.957e-07  5.532e-07  -0.715  0.47435    
age_grp16-19                   1.521e-05  5.826e-07  26.112  < 2e-16 ***
age_grp20-24                   9.834e-06  5.642e-07  17.430  < 2e-16 ***
age_grp25-34                   3.591e-06  5.576e-07   6.441 1.19e-10 ***
age_grp35-44                   7.007e-07  5.569e-07   1.258  0.20835    
age_grp45-54                   5.290e-08  5.566e-07   0.095  0.92429    
age_grp55-64                  -1.491e-07  5.578e-07  -0.267  0.78927    
age_grp65-199                  3.229e-09  5.587e-07   0.006  0.99539    
policyTRUE                     1.591e-07  7.930e-07   0.201  0.84099    
curr_pts_grp1                  2.005e-06  2.786e-07   7.197 6.17e-13 ***
curr_pts_grp2                  2.000e-06  1.291e-07  15.496  < 2e-16 ***
curr_pts_grp3                  4.132e-06  1.114e-07  37.091  < 2e-16 ***
curr_pts_grp4                  5.798e-06  2.847e-07  20.361  < 2e-16 ***
curr_pts_grp5                  7.981e-06  2.132e-07  37.437  < 2e-16 ***
curr_pts_grp6                  1.060e-05  2.411e-07  43.964  < 2e-16 ***
curr_pts_grp7                  1.540e-05  3.909e-07  39.400  < 2e-16 ***
curr_pts_grp8                  1.369e-05  3.658e-07  37.424  < 2e-16 ***
curr_pts_grp9                  1.281e-05  4.036e-07  31.729  < 2e-16 ***
curr_pts_grp10-150             3.821e-05  2.798e-07 136.566  < 2e-16 ***
age_grp16-19:policyTRUE       -6.195e-06  8.319e-07  -7.447 9.57e-14 ***
age_grp20-24:policyTRUE       -4.116e-06  8.084e-07  -5.091 3.56e-07 ***
age_grp25-34:policyTRUE       -1.981e-06  7.991e-07  -2.479  0.01317 *  
age_grp35-44:policyTRUE       -3.319e-07  7.983e-07  -0.416  0.67754    
age_grp45-54:policyTRUE       -2.142e-08  7.977e-07  -0.027  0.97858    
age_grp55-64:policyTRUE        1.199e-07  7.992e-07   0.150  0.88071    
age_grp65-199:policyTRUE      -1.277e-08  8.003e-07  -0.016  0.98727    
policyTRUE:curr_pts_grp1      -1.018e-06  3.805e-07  -2.675  0.00746 **
policyTRUE:curr_pts_grp2      -1.013e-06  1.738e-07  -5.827 5.64e-09 ***
policyTRUE:curr_pts_grp3      -2.822e-06  1.565e-07 -18.031  < 2e-16 ***
policyTRUE:curr_pts_grp4      -3.355e-06  3.747e-07  -8.956  < 2e-16 ***
policyTRUE:curr_pts_grp5      -5.324e-06  2.895e-07 -18.391  < 2e-16 ***
policyTRUE:curr_pts_grp6      -6.660e-06  3.297e-07 -20.201  < 2e-16 ***
policyTRUE:curr_pts_grp7      -9.176e-06  5.222e-07 -17.570  < 2e-16 ***
policyTRUE:curr_pts_grp8      -6.947e-06  4.932e-07 -14.083  < 2e-16 ***
policyTRUE:curr_pts_grp9      -4.977e-06  5.496e-07  -9.056  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -1.917e-05  3.626e-07 -52.864  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00149 on 5335033185 degrees of freedom
Multiple R-squared:  1.158e-05,	Adjusted R-squared:  1.157e-05
F-statistic:  1765 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.378e-08  3.076e-07  -0.077  0.93839    
age_grp16-19                   1.774e-06  3.146e-07   5.639 1.71e-08 ***
age_grp20-24                   9.475e-07  3.100e-07   3.056  0.00224 **
age_grp25-34                   3.433e-07  3.086e-07   1.113  0.26592    
age_grp35-44                   1.080e-07  3.084e-07   0.350  0.72624    
age_grp45-54                   3.684e-08  3.084e-07   0.119  0.90491    
age_grp55-64                  -1.992e-08  3.087e-07  -0.065  0.94855    
age_grp65-199                 -1.407e-10  3.091e-07   0.000  0.99964    
policyTRUE                     1.150e-08  4.268e-07   0.027  0.97851    
curr_pts_grp1                  1.308e-07  1.110e-07   1.178  0.23891    
curr_pts_grp2                  3.383e-07  5.074e-08   6.669 2.58e-11 ***
curr_pts_grp3                  8.001e-07  4.918e-08  16.268  < 2e-16 ***
curr_pts_grp4                  1.231e-06  1.403e-07   8.777  < 2e-16 ***
curr_pts_grp5                  2.175e-06  1.111e-07  19.579  < 2e-16 ***
curr_pts_grp6                  3.467e-06  1.385e-07  25.032  < 2e-16 ***
curr_pts_grp7                  3.349e-06  2.493e-07  13.434  < 2e-16 ***
curr_pts_grp8                  2.622e-06  2.416e-07  10.850  < 2e-16 ***
curr_pts_grp9                  2.090e-06  2.557e-07   8.175 2.96e-16 ***
curr_pts_grp10-150             1.026e-05  2.419e-07  42.405  < 2e-16 ***
age_grp16-19:policyTRUE       -1.071e-06  4.361e-07  -2.457  0.01401 *  
age_grp20-24:policyTRUE       -3.853e-07  4.302e-07  -0.896  0.37043    
age_grp25-34:policyTRUE       -2.245e-07  4.281e-07  -0.524  0.60004    
age_grp35-44:policyTRUE       -8.067e-08  4.280e-07  -0.189  0.85048    
age_grp45-54:policyTRUE       -2.463e-08  4.278e-07  -0.058  0.95410    
age_grp55-64:policyTRUE        2.126e-08  4.282e-07   0.050  0.96040    
age_grp65-199:policyTRUE      -5.741e-09  4.288e-07  -0.013  0.98932    
policyTRUE:curr_pts_grp1      -1.163e-08  1.489e-07  -0.078  0.93773    
policyTRUE:curr_pts_grp2      -2.104e-07  6.773e-08  -3.106  0.00190 **
policyTRUE:curr_pts_grp3      -5.648e-07  6.847e-08  -8.249  < 2e-16 ***
policyTRUE:curr_pts_grp4      -7.520e-07  1.813e-07  -4.148 3.35e-05 ***
policyTRUE:curr_pts_grp5      -1.498e-06  1.488e-07 -10.067  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.338e-06  1.859e-07 -12.572  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.157e-06  3.224e-07  -6.690 2.24e-11 ***
policyTRUE:curr_pts_grp8      -1.767e-06  3.192e-07  -5.536 3.10e-08 ***
policyTRUE:curr_pts_grp9       5.634e-07  3.415e-07   1.650  0.09895 .  
policyTRUE:curr_pts_grp10-150 -4.866e-06  3.029e-07 -16.065  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0004691 on 4340212237 degrees of freedom
Multiple R-squared:  1.516e-06,	Adjusted R-squared:  1.508e-06
F-statistic: 187.9 on 35 and 4340212237 DF,  p-value: < 2.2e-16
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
(Intercept)                    5.263e-06  6.014e-07   8.751  < 2e-16 ***
age_grp16-19                   7.499e-06  6.334e-07  11.839  < 2e-16 ***
age_grp20-24                   1.221e-06  6.134e-07   1.990 0.046541 *  
age_grp25-34                  -2.947e-06  6.062e-07  -4.862 1.16e-06 ***
age_grp35-44                  -4.159e-06  6.055e-07  -6.869 6.48e-12 ***
age_grp45-54                  -4.405e-06  6.052e-07  -7.279 3.36e-13 ***
age_grp55-64                  -4.634e-06  6.064e-07  -7.642 2.14e-14 ***
age_grp65-199                 -4.001e-06  6.074e-07  -6.587 4.48e-11 ***
policyTRUE                    -1.678e-06  8.621e-07  -1.946 0.051613 .  
curr_pts_grp1                  7.820e-07  3.029e-07   2.582 0.009836 **
curr_pts_grp2                  1.647e-06  1.403e-07  11.737  < 2e-16 ***
curr_pts_grp3                  3.048e-06  1.211e-07  25.163  < 2e-16 ***
curr_pts_grp4                  5.927e-06  3.096e-07  19.147  < 2e-16 ***
curr_pts_grp5                  4.908e-06  2.318e-07  21.177  < 2e-16 ***
curr_pts_grp6                  5.422e-06  2.621e-07  20.689  < 2e-16 ***
curr_pts_grp7                  9.282e-06  4.250e-07  21.841  < 2e-16 ***
curr_pts_grp8                  8.118e-06  3.977e-07  20.412  < 2e-16 ***
curr_pts_grp9                  1.145e-05  4.388e-07  26.094  < 2e-16 ***
curr_pts_grp10-150             2.258e-05  3.042e-07  74.218  < 2e-16 ***
age_grp16-19:policyTRUE       -8.635e-07  9.044e-07  -0.955 0.339715    
age_grp20-24:policyTRUE        5.556e-07  8.788e-07   0.632 0.527229    
age_grp25-34:policyTRUE        1.128e-06  8.687e-07   1.298 0.194245    
age_grp35-44:policyTRUE        1.491e-06  8.679e-07   1.718 0.085865 .  
age_grp45-54:policyTRUE        1.438e-06  8.673e-07   1.658 0.097324 .  
age_grp55-64:policyTRUE        1.556e-06  8.688e-07   1.791 0.073367 .  
age_grp65-199:policyTRUE       1.551e-06  8.701e-07   1.783 0.074626 .  
policyTRUE:curr_pts_grp1       1.390e-07  4.137e-07   0.336 0.736827    
policyTRUE:curr_pts_grp2      -4.103e-07  1.889e-07  -2.172 0.029865 *  
policyTRUE:curr_pts_grp3      -5.892e-07  1.702e-07  -3.462 0.000535 ***
policyTRUE:curr_pts_grp4      -1.558e-06  4.073e-07  -3.826 0.000130 ***
policyTRUE:curr_pts_grp5      -1.868e-06  3.147e-07  -5.936 2.92e-09 ***
policyTRUE:curr_pts_grp6      -9.729e-07  3.584e-07  -2.715 0.006637 **
policyTRUE:curr_pts_grp7      -3.358e-06  5.677e-07  -5.915 3.33e-09 ***
policyTRUE:curr_pts_grp8      -2.555e-06  5.362e-07  -4.764 1.90e-06 ***
policyTRUE:curr_pts_grp9      -3.927e-06  5.975e-07  -6.572 4.96e-11 ***
policyTRUE:curr_pts_grp10-150 -7.255e-06  3.942e-07 -18.404  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00162 on 5335033185 degrees of freedom
Multiple R-squared:  4.818e-06,	Adjusted R-squared:  4.811e-06
F-statistic: 734.4 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.669e-06  7.072e-07   2.360  0.01828 *  
age_grp16-19                   1.681e-06  7.231e-07   2.325  0.02007 *  
age_grp20-24                   1.285e-07  7.127e-07   0.180  0.85688    
age_grp25-34                  -5.727e-07  7.094e-07  -0.807  0.41948    
age_grp35-44                  -8.495e-07  7.090e-07  -1.198  0.23089    
age_grp45-54                  -1.009e-06  7.089e-07  -1.423  0.15462    
age_grp55-64                  -1.024e-06  7.096e-07  -1.443  0.14894    
age_grp65-199                 -4.455e-07  7.106e-07  -0.627  0.53074    
policyTRUE                    -1.293e-07  9.811e-07  -0.132  0.89518    
curr_pts_grp1                  4.454e-07  2.552e-07   1.745  0.08100 .  
curr_pts_grp2                  1.044e-06  1.166e-07   8.951  < 2e-16 ***
curr_pts_grp3                  1.484e-06  1.131e-07  13.126  < 2e-16 ***
curr_pts_grp4                  5.326e-06  3.225e-07  16.515  < 2e-16 ***
curr_pts_grp5                  2.836e-06  2.553e-07  11.105  < 2e-16 ***
curr_pts_grp6                  3.988e-06  3.184e-07  12.525  < 2e-16 ***
curr_pts_grp7                  2.842e-06  5.731e-07   4.959 7.07e-07 ***
curr_pts_grp8                  5.549e-06  5.555e-07   9.988  < 2e-16 ***
curr_pts_grp9                  8.691e-06  5.878e-07  14.786  < 2e-16 ***
curr_pts_grp10-150             1.344e-05  5.560e-07  24.168  < 2e-16 ***
age_grp16-19:policyTRUE       -3.715e-07  1.002e-06  -0.371  0.71097    
age_grp20-24:policyTRUE        4.851e-08  9.889e-07   0.049  0.96088    
age_grp25-34:policyTRUE        1.224e-07  9.842e-07   0.124  0.90100    
age_grp35-44:policyTRUE        5.053e-08  9.838e-07   0.051  0.95904    
age_grp45-54:policyTRUE       -2.808e-08  9.835e-07  -0.029  0.97722    
age_grp55-64:policyTRUE       -1.809e-09  9.844e-07  -0.002  0.99853    
age_grp65-199:policyTRUE       1.204e-07  9.858e-07   0.122  0.90277    
policyTRUE:curr_pts_grp1       3.382e-07  3.423e-07   0.988  0.32308    
policyTRUE:curr_pts_grp2      -3.796e-07  1.557e-07  -2.438  0.01478 *  
policyTRUE:curr_pts_grp3      -3.195e-07  1.574e-07  -2.030  0.04239 *  
policyTRUE:curr_pts_grp4      -2.365e-06  4.168e-07  -5.675 1.38e-08 ***
policyTRUE:curr_pts_grp5      -3.137e-07  3.422e-07  -0.917  0.35924    
policyTRUE:curr_pts_grp6      -1.898e-06  4.275e-07  -4.441 8.96e-06 ***
policyTRUE:curr_pts_grp7       3.312e-07  7.411e-07   0.447  0.65492    
policyTRUE:curr_pts_grp8      -2.392e-06  7.339e-07  -3.259  0.00112 **
policyTRUE:curr_pts_grp9      -1.583e-06  7.850e-07  -2.017  0.04373 *  
policyTRUE:curr_pts_grp10-150 -5.951e-06  6.963e-07  -8.546  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001078 on 4340212237 degrees of freedom
Multiple R-squared:  8.44e-07,	Adjusted R-squared:  8.359e-07
F-statistic: 104.7 on 35 and 4340212237 DF,  p-value: < 2.2e-16
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
