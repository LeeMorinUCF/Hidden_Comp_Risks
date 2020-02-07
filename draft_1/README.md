
# Draft 1


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

```

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change.

#### Male drivers:
```R

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

```
### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.


#### Male drivers:
```R

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

The following regression is done including both 7- and 14-point violations in the sample after the policy change.

#### Male drivers:
```R

```
#### Female drivers:
```R

```

### X-points and up (speeding 100 or more and 3 other 12-point offences)

I'm not sure that 9 is the best number here. With 9 as the threshold,
it would include 10 but not 5, 14 but not 7, etc. after the policy change.
Let me think about this in the morning.

Combining with the more excessive speeding offences, the number of events is larger.


#### Male drivers:
```R

```
#### Female drivers:
```R

```