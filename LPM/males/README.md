
# Linear Probability Models - Male Drivers

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
(Intercept)                    1.044e-04  8.495e-06  12.287  < 2e-16 ***
age_grp16-19                   6.356e-04  8.947e-06  71.044  < 2e-16 ***
age_grp20-24                   4.891e-04  8.664e-06  56.453  < 2e-16 ***
age_grp25-34                   3.185e-04  8.562e-06  37.198  < 2e-16 ***
age_grp35-44                   2.435e-04  8.552e-06  28.470  < 2e-16 ***
age_grp45-54                   1.938e-04  8.548e-06  22.672  < 2e-16 ***
age_grp55-64                   1.330e-04  8.565e-06  15.525  < 2e-16 ***
age_grp65-74                   6.002e-05  8.624e-06   6.960 3.40e-12 ***
age_grp75-84                   5.118e-06  8.777e-06   0.583  0.55985    
age_grp85-89                  -2.107e-05  1.081e-05  -1.949  0.05132 .  
age_grp90-199                 -4.089e-05  1.827e-05  -2.238  0.02521 *  
policyTRUE                    -1.033e-06  1.218e-05  -0.085  0.93239    
curr_pts_grp1                  5.758e-04  4.279e-06 134.585  < 2e-16 ***
curr_pts_grp2                  6.159e-04  1.983e-06 310.655  < 2e-16 ***
curr_pts_grp3                  6.885e-04  1.711e-06 402.398  < 2e-16 ***
curr_pts_grp4                  1.117e-03  4.373e-06 255.528  < 2e-16 ***
curr_pts_grp5                  1.240e-03  3.274e-06 378.891  < 2e-16 ***
curr_pts_grp6                  1.409e-03  3.702e-06 380.652  < 2e-16 ***
curr_pts_grp7                  1.682e-03  6.003e-06 280.212  < 2e-16 ***
curr_pts_grp8                  1.853e-03  5.617e-06 329.889  < 2e-16 ***
curr_pts_grp9                  1.702e-03  6.198e-06 274.554  < 2e-16 ***
curr_pts_grp10                 2.182e-03  9.028e-06 241.658  < 2e-16 ***
curr_pts_grp11-20              2.538e-03  5.049e-06 502.659  < 2e-16 ***
curr_pts_grp21-30              4.296e-03  1.917e-05 224.091  < 2e-16 ***
curr_pts_grp30-150             6.174e-03  4.290e-05 143.924  < 2e-16 ***
age_grp16-19:policyTRUE       -7.356e-05  1.277e-05  -5.758 8.51e-09 ***
age_grp20-24:policyTRUE       -7.601e-05  1.241e-05  -6.124 9.15e-10 ***
age_grp25-34:policyTRUE       -6.110e-05  1.227e-05  -4.979 6.38e-07 ***
age_grp35-44:policyTRUE       -3.269e-05  1.226e-05  -2.667  0.00766 **
age_grp45-54:policyTRUE       -2.344e-05  1.225e-05  -1.914  0.05565 .  
age_grp55-64:policyTRUE       -1.765e-05  1.227e-05  -1.438  0.15036    
age_grp65-74:policyTRUE       -1.911e-06  1.235e-05  -0.155  0.87698    
age_grp75-84:policyTRUE       -5.083e-08  1.255e-05  -0.004  0.99677    
age_grp85-89:policyTRUE       -2.689e-06  1.515e-05  -0.178  0.85911    
age_grp90-199:policyTRUE       1.672e-06  2.498e-05   0.067  0.94664    
policyTRUE:curr_pts_grp1      -5.505e-05  5.843e-06  -9.421  < 2e-16 ***
policyTRUE:curr_pts_grp2      -6.352e-05  2.669e-06 -23.800  < 2e-16 ***
policyTRUE:curr_pts_grp3      -6.663e-05  2.404e-06 -27.717  < 2e-16 ***
policyTRUE:curr_pts_grp4      -9.256e-05  5.754e-06 -16.088  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.204e-04  4.445e-06 -27.086  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.487e-04  5.063e-06 -29.375  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.227e-04  8.019e-06 -15.304  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.946e-04  7.574e-06 -25.691  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.103e-04  8.440e-06 -13.070  < 2e-16 ***
policyTRUE:curr_pts_grp10     -4.741e-04  1.160e-05 -40.881  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -4.841e-04  6.592e-06 -73.434  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.210e-03  2.369e-05 -51.076  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -2.213e-03  5.093e-05 -43.444  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033173 degrees of freedom
Multiple R-squared:  0.0004661,	Adjusted R-squared:  0.0004661
F-statistic: 5.293e+04 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

As before, the benchmark group is 0-16, with the younger drivers earning more points and the incidence declining with age.
Past behaviour predicts future behaviour in that drivers with a higher current point balance are more likely to get the next ticket than other drivers.
The reaction to the policy change alone is not significant but differs by age group, with younger drivers reacting more strongly to the policy.
In addition, drivers with higher point balances have a stronger reaction to the policy, especially those with more than 20 demerit points on their record.

The R-squared numbers are all small for these LPM regressions, because most drivers do not get a ticket most days - even the high-point drivers - and the predicted probabilities are low, leading to large residuals when an event occurs.

### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.961e-06  2.407e-06   0.815 0.415280    
age_grp16-19                   4.827e-05  2.535e-06  19.043  < 2e-16 ***
age_grp20-24                   2.707e-05  2.455e-06  11.030  < 2e-16 ***
age_grp25-34                   2.521e-05  2.426e-06  10.392  < 2e-16 ***
age_grp35-44                   2.498e-05  2.423e-06  10.310  < 2e-16 ***
age_grp45-54                   2.231e-05  2.422e-06   9.214  < 2e-16 ***
age_grp55-64                   1.783e-05  2.427e-06   7.346 2.04e-13 ***
age_grp65-74                   1.054e-05  2.443e-06   4.315 1.60e-05 ***
age_grp75-84                   5.033e-06  2.487e-06   2.024 0.042962 *  
age_grp85-89                   6.293e-07  3.063e-06   0.205 0.837231    
age_grp90-199                 -2.097e-06  5.176e-06  -0.405 0.685371    
policyTRUE                     1.981e-06  3.450e-06   0.574 0.565885    
curr_pts_grp1                  1.100e-04  1.212e-06  90.775  < 2e-16 ***
curr_pts_grp2                  4.902e-05  5.617e-07  87.267  < 2e-16 ***
curr_pts_grp3                  3.752e-05  4.847e-07  77.409  < 2e-16 ***
curr_pts_grp4                  1.047e-04  1.239e-06  84.493  < 2e-16 ***
curr_pts_grp5                  7.983e-05  9.275e-07  86.075  < 2e-16 ***
curr_pts_grp6                  7.970e-05  1.049e-06  75.991  < 2e-16 ***
curr_pts_grp7                  1.328e-04  1.701e-06  78.087  < 2e-16 ***
curr_pts_grp8                  1.291e-04  1.591e-06  81.139  < 2e-16 ***
curr_pts_grp9                  1.167e-04  1.756e-06  66.445  < 2e-16 ***
curr_pts_grp10                 1.874e-04  2.558e-06  73.272  < 2e-16 ***
curr_pts_grp11-20              2.087e-04  1.430e-06 145.907  < 2e-16 ***
curr_pts_grp21-30              2.662e-04  5.431e-06  49.004  < 2e-16 ***
curr_pts_grp30-150             2.716e-04  1.215e-05  22.350  < 2e-16 ***
age_grp16-19:policyTRUE       -1.182e-06  3.619e-06  -0.327 0.743976    
age_grp20-24:policyTRUE       -4.847e-06  3.517e-06  -1.378 0.168175    
age_grp25-34:policyTRUE       -1.383e-06  3.476e-06  -0.398 0.690735    
age_grp35-44:policyTRUE        1.270e-06  3.473e-06   0.366 0.714544    
age_grp45-54:policyTRUE        2.372e-06  3.471e-06   0.684 0.494286    
age_grp55-64:policyTRUE        2.245e-06  3.477e-06   0.646 0.518499    
age_grp65-74:policyTRUE        2.557e-06  3.498e-06   0.731 0.464893    
age_grp75-84:policyTRUE        2.325e-06  3.556e-06   0.654 0.513146    
age_grp85-89:policyTRUE        1.955e-06  4.291e-06   0.456 0.648714    
age_grp90-199:policyTRUE       3.755e-06  7.077e-06   0.531 0.595708    
policyTRUE:curr_pts_grp1      -1.206e-05  1.656e-06  -7.282 3.29e-13 ***
policyTRUE:curr_pts_grp2       2.656e-06  7.561e-07   3.512 0.000444 ***
policyTRUE:curr_pts_grp3       7.455e-06  6.810e-07  10.946  < 2e-16 ***
policyTRUE:curr_pts_grp4      -7.497e-08  1.630e-06  -0.046 0.963316    
policyTRUE:curr_pts_grp5       9.150e-06  1.259e-06   7.265 3.73e-13 ***
policyTRUE:curr_pts_grp6       1.330e-05  1.434e-06   9.276  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.194e-05  2.272e-06   5.257 1.46e-07 ***
policyTRUE:curr_pts_grp8       3.446e-06  2.146e-06   1.606 0.108345    
policyTRUE:curr_pts_grp9       1.934e-05  2.391e-06   8.088 6.05e-16 ***
policyTRUE:curr_pts_grp10     -1.775e-05  3.286e-06  -5.403 6.56e-08 ***
policyTRUE:curr_pts_grp11-20  -6.093e-06  1.868e-06  -3.262 0.001105 **
policyTRUE:curr_pts_grp21-30  -6.606e-05  6.711e-06  -9.843  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.752e-05  1.443e-05  -5.372 7.77e-08 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006482 on 5335033173 degrees of freedom
Multiple R-squared:  3.634e-05,	Adjusted R-squared:  3.634e-05
F-statistic:  4126 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

A similar relationship with age and current points but a lack of significance for the policy effect by age.
There are mixed results for the policy change interacted with demerit point history, with the high-achievers reacting to the policy.
Some of the positive coefficients could reflect a substitution toward lesser offences.

I include all of the first- and second-order interactions in what follows, to err on the side of overspecification.


### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -6.174e-06  5.343e-06  -1.156 0.247845    
age_grp16-19                   1.870e-04  5.628e-06  33.230  < 2e-16 ***
age_grp20-24                   1.757e-04  5.450e-06  32.247  < 2e-16 ***
age_grp25-34                   1.596e-04  5.386e-06  29.626  < 2e-16 ***
age_grp35-44                   1.500e-04  5.379e-06  27.893  < 2e-16 ***
age_grp45-54                   1.388e-04  5.376e-06  25.823  < 2e-16 ***
age_grp55-64                   1.152e-04  5.388e-06  21.385  < 2e-16 ***
age_grp65-74                   7.965e-05  5.424e-06  14.685  < 2e-16 ***
age_grp75-84                   4.938e-05  5.521e-06   8.944  < 2e-16 ***
age_grp85-89                   3.252e-05  6.801e-06   4.781 1.74e-06 ***
age_grp90-199                  1.288e-05  1.149e-05   1.121 0.262315    
policyTRUE                     8.149e-08  7.659e-06   0.011 0.991511    
curr_pts_grp1                  2.353e-04  2.691e-06  87.427  < 2e-16 ***
curr_pts_grp2                  2.640e-04  1.247e-06 211.680  < 2e-16 ***
curr_pts_grp3                  2.443e-04  1.076e-06 227.018  < 2e-16 ***
curr_pts_grp4                  4.417e-04  2.750e-06 160.613  < 2e-16 ***
curr_pts_grp5                  4.635e-04  2.059e-06 225.075  < 2e-16 ***
curr_pts_grp6                  4.669e-04  2.329e-06 200.528  < 2e-16 ***
curr_pts_grp7                  6.158e-04  3.776e-06 163.116  < 2e-16 ***
curr_pts_grp8                  6.312e-04  3.533e-06 178.660  < 2e-16 ***
curr_pts_grp9                  5.537e-04  3.898e-06 142.033  < 2e-16 ***
curr_pts_grp10                 7.412e-04  5.679e-06 130.520  < 2e-16 ***
curr_pts_grp11-20              7.760e-04  3.176e-06 244.355  < 2e-16 ***
curr_pts_grp21-30              9.899e-04  1.206e-05  82.094  < 2e-16 ***
curr_pts_grp30-150             1.133e-03  2.698e-05  41.995  < 2e-16 ***
age_grp16-19:policyTRUE        3.586e-06  8.035e-06   0.446 0.655391    
age_grp20-24:policyTRUE       -3.237e-07  7.808e-06  -0.041 0.966926    
age_grp25-34:policyTRUE       -7.581e-06  7.718e-06  -0.982 0.325958    
age_grp35-44:policyTRUE       -3.748e-06  7.711e-06  -0.486 0.626895    
age_grp45-54:policyTRUE       -1.318e-06  7.705e-06  -0.171 0.864174    
age_grp55-64:policyTRUE       -1.116e-06  7.719e-06  -0.145 0.885001    
age_grp65-74:policyTRUE        3.402e-06  7.767e-06   0.438 0.661383    
age_grp75-84:policyTRUE       -4.604e-07  7.895e-06  -0.058 0.953498    
age_grp85-89:policyTRUE       -2.399e-06  9.527e-06  -0.252 0.801193    
age_grp90-199:policyTRUE       8.635e-06  1.571e-05   0.550 0.582578    
policyTRUE:curr_pts_grp1      -1.266e-05  3.675e-06  -3.445 0.000571 ***
policyTRUE:curr_pts_grp2      -6.980e-06  1.679e-06  -4.158 3.21e-05 ***
policyTRUE:curr_pts_grp3      -2.040e-06  1.512e-06  -1.349 0.177177    
policyTRUE:curr_pts_grp4      -2.378e-06  3.619e-06  -0.657 0.511111    
policyTRUE:curr_pts_grp5      -5.359e-06  2.796e-06  -1.917 0.055296 .  
policyTRUE:curr_pts_grp6       9.867e-07  3.184e-06   0.310 0.756655    
policyTRUE:curr_pts_grp7       4.713e-06  5.044e-06   0.934 0.350143    
policyTRUE:curr_pts_grp8      -5.923e-06  4.764e-06  -1.243 0.213825    
policyTRUE:curr_pts_grp9       1.762e-05  5.309e-06   3.319 0.000902 ***
policyTRUE:curr_pts_grp10     -1.094e-04  7.295e-06 -14.991  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.032e-04  4.146e-06 -24.882  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.509e-04  1.490e-05 -10.126  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -3.661e-04  3.203e-05 -11.429  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01439 on 5335033173 degrees of freedom
Multiple R-squared:  0.0001437,	Adjusted R-squared:  0.0001437
F-statistic: 1.632e+04 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

Relationships similar to the above, except that there is a U-shaped pattern in the policy reaction with respect to points groups.
The policy reaction is stronger for drivers with fewer points and for those with many points but insignificant for the middle groups.

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    8.928e-05  5.858e-06  15.242  < 2e-16 ***
age_grp16-19                   2.773e-04  6.170e-06  44.950  < 2e-16 ***
age_grp20-24                   2.339e-04  5.975e-06  39.145  < 2e-16 ***
age_grp25-34                   1.268e-04  5.905e-06  21.470  < 2e-16 ***
age_grp35-44                   7.926e-05  5.898e-06  13.439  < 2e-16 ***
age_grp45-54                   4.862e-05  5.895e-06   8.248  < 2e-16 ***
age_grp55-64                   1.880e-05  5.907e-06   3.183 0.001459 **
age_grp65-74                  -1.064e-05  5.947e-06  -1.788 0.073715 .  
age_grp75-84                  -3.060e-05  6.053e-06  -5.055 4.30e-07 ***
age_grp85-89                  -3.783e-05  7.457e-06  -5.074 3.90e-07 ***
age_grp90-199                 -3.534e-05  1.260e-05  -2.805 0.005024 **
policyTRUE                     2.651e-06  8.397e-06   0.316 0.752198    
curr_pts_grp1                  2.133e-04  2.951e-06  72.294  < 2e-16 ***
curr_pts_grp2                  2.811e-04  1.367e-06 205.583  < 2e-16 ***
curr_pts_grp3                  3.703e-04  1.180e-06 313.897  < 2e-16 ***
curr_pts_grp4                  4.976e-04  3.015e-06 165.020  < 2e-16 ***
curr_pts_grp5                  6.298e-04  2.258e-06 278.944  < 2e-16 ***
curr_pts_grp6                  7.799e-04  2.553e-06 305.493  < 2e-16 ***
curr_pts_grp7                  8.141e-04  4.139e-06 196.675  < 2e-16 ***
curr_pts_grp8                  9.656e-04  3.874e-06 249.265  < 2e-16 ***
curr_pts_grp9                  9.114e-04  4.274e-06 213.251  < 2e-16 ***
curr_pts_grp10                 1.089e-03  6.226e-06 174.908  < 2e-16 ***
curr_pts_grp11-20              1.304e-03  3.482e-06 374.605  < 2e-16 ***
curr_pts_grp21-30              2.361e-03  1.322e-05 178.608  < 2e-16 ***
curr_pts_grp30-150             3.608e-03  2.958e-05 121.966  < 2e-16 ***
age_grp16-19:policyTRUE       -6.550e-05  8.810e-06  -7.435 1.05e-13 ***
age_grp20-24:policyTRUE       -6.229e-05  8.560e-06  -7.276 3.43e-13 ***
age_grp25-34:policyTRUE       -5.070e-05  8.462e-06  -5.992 2.07e-09 ***
age_grp35-44:policyTRUE       -3.424e-05  8.454e-06  -4.051 5.11e-05 ***
age_grp45-54:policyTRUE       -2.969e-05  8.448e-06  -3.514 0.000441 ***
age_grp55-64:policyTRUE       -2.483e-05  8.463e-06  -2.934 0.003342 **
age_grp65-74:policyTRUE       -1.374e-05  8.515e-06  -1.613 0.106713    
age_grp75-84:policyTRUE       -8.210e-06  8.655e-06  -0.949 0.342823    
age_grp85-89:policyTRUE       -6.466e-06  1.045e-05  -0.619 0.535875    
age_grp90-199:policyTRUE      -1.485e-05  1.722e-05  -0.862 0.388760    
policyTRUE:curr_pts_grp1      -2.573e-05  4.030e-06  -6.386 1.71e-10 ***
policyTRUE:curr_pts_grp2      -5.278e-05  1.840e-06 -28.681  < 2e-16 ***
policyTRUE:curr_pts_grp3      -6.114e-05  1.658e-06 -36.883  < 2e-16 ***
policyTRUE:curr_pts_grp4      -6.904e-05  3.968e-06 -17.401  < 2e-16 ***
policyTRUE:curr_pts_grp5      -9.956e-05  3.066e-06 -32.479  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.396e-04  3.491e-06 -39.983  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.020e-04  5.530e-06 -18.440  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.532e-04  5.223e-06 -29.320  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.135e-04  5.820e-06 -19.497  < 2e-16 ***
policyTRUE:curr_pts_grp10     -2.835e-04  7.998e-06 -35.449  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -2.981e-04  4.546e-06 -65.573  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -7.363e-04  1.633e-05 -45.075  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.340e-03  3.512e-05 -38.153  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01578 on 5335033173 degrees of freedom
Multiple R-squared:  0.00025,	Adjusted R-squared:  0.00025
F-statistic: 2.838e+04 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

Similar reaction for the age and points groups, with the policy change having more pronounced effects for younger age groups and worse offenders.
Keep in mind that some of the decline might be attributed to the change of some 3-point offenses to 6-point offenses.

This will be revisited with the 6-point violations below.


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.697e-05  8.927e-07  19.008  < 2e-16 ***
age_grp16-19                   5.115e-05  9.402e-07  54.398  < 2e-16 ***
age_grp20-24                   1.013e-06  9.105e-07   1.113 0.265668    
age_grp25-34                  -1.313e-05  8.998e-07 -14.588  < 2e-16 ***
age_grp35-44                  -1.617e-05  8.987e-07 -17.997  < 2e-16 ***
age_grp45-54                  -1.697e-05  8.983e-07 -18.887  < 2e-16 ***
age_grp55-64                  -1.700e-05  9.001e-07 -18.891  < 2e-16 ***
age_grp65-74                  -1.692e-05  9.063e-07 -18.666  < 2e-16 ***
age_grp75-84                  -1.669e-05  9.224e-07 -18.098  < 2e-16 ***
age_grp85-89                  -1.677e-05  1.136e-06 -14.762  < 2e-16 ***
age_grp90-199                 -1.682e-05  1.920e-06  -8.761  < 2e-16 ***
policyTRUE                    -5.028e-06  1.280e-06  -3.929 8.52e-05 ***
curr_pts_grp1                  1.214e-06  4.496e-07   2.701 0.006919 **
curr_pts_grp2                  1.501e-06  2.083e-07   7.205 5.82e-13 ***
curr_pts_grp3                  4.858e-06  1.798e-07  27.022  < 2e-16 ***
curr_pts_grp4                  2.568e-05  4.595e-07  55.896  < 2e-16 ***
curr_pts_grp5                  5.848e-06  3.440e-07  16.999  < 2e-16 ***
curr_pts_grp6                  1.130e-05  3.890e-07  29.043  < 2e-16 ***
curr_pts_grp7                  2.712e-05  6.308e-07  42.997  < 2e-16 ***
curr_pts_grp8                  2.195e-05  5.903e-07  37.180  < 2e-16 ***
curr_pts_grp9                  2.020e-05  6.513e-07  31.019  < 2e-16 ***
curr_pts_grp10                 3.206e-05  9.488e-07  33.795  < 2e-16 ***
curr_pts_grp11-20              5.311e-05  5.306e-07 100.107  < 2e-16 ***
curr_pts_grp21-30              1.581e-04  2.015e-06  78.462  < 2e-16 ***
curr_pts_grp30-150             3.029e-04  4.508e-06  67.196  < 2e-16 ***
age_grp16-19:policyTRUE       -4.671e-07  1.343e-06  -0.348 0.727913    
age_grp20-24:policyTRUE        4.298e-06  1.304e-06   3.295 0.000984 ***
age_grp25-34:policyTRUE        4.997e-06  1.290e-06   3.875 0.000107 ***
age_grp35-44:policyTRUE        5.014e-06  1.288e-06   3.892 9.92e-05 ***
age_grp45-54:policyTRUE        5.010e-06  1.287e-06   3.892 9.96e-05 ***
age_grp55-64:policyTRUE        4.902e-06  1.290e-06   3.801 0.000144 ***
age_grp65-74:policyTRUE        4.881e-06  1.298e-06   3.761 0.000169 ***
age_grp75-84:policyTRUE        4.927e-06  1.319e-06   3.735 0.000187 ***
age_grp85-89:policyTRUE        5.294e-06  1.592e-06   3.326 0.000881 ***
age_grp90-199:policyTRUE       4.519e-06  2.625e-06   1.721 0.085180 .  
policyTRUE:curr_pts_grp1      -5.894e-07  6.141e-07  -0.960 0.337174    
policyTRUE:curr_pts_grp2      -4.368e-07  2.805e-07  -1.557 0.119362    
policyTRUE:curr_pts_grp3      -1.073e-06  2.526e-07  -4.247 2.17e-05 ***
policyTRUE:curr_pts_grp4      -6.309e-06  6.046e-07 -10.435  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.479e-06  4.672e-07  -3.166 0.001547 **
policyTRUE:curr_pts_grp6      -1.537e-06  5.320e-07  -2.889 0.003860 **
policyTRUE:curr_pts_grp7      -6.356e-06  8.427e-07  -7.542 4.63e-14 ***
policyTRUE:curr_pts_grp8      -2.407e-06  7.960e-07  -3.024 0.002492 **
policyTRUE:curr_pts_grp9      -4.913e-06  8.869e-07  -5.540 3.03e-08 ***
policyTRUE:curr_pts_grp10     -1.247e-05  1.219e-06 -10.230  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.677e-05  6.927e-07 -24.205  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -5.083e-05  2.489e-06 -20.420  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.156e-04  5.352e-06 -21.594  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002404 on 5335033173 degrees of freedom
Multiple R-squared:  3.4e-05,	Adjusted R-squared:  3.399e-05
F-statistic:  3859 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

Note that there are no changes to the penalties for these offences and the swapping out of the 3-point speeding 40-45 over in a 100km/hr zone, which was changed to 6 points, is not a possibility, since the driver can only be awarded points for a single speeding infraction.


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.


```R
Estimate Std. Error  t value Pr(>|t|)    
(Intercept)                   -2.611e-06  1.196e-06   -2.183 0.029034 *  
age_grp16-19                   4.747e-05  1.260e-06   37.679  < 2e-16 ***
age_grp20-24                   3.963e-05  1.220e-06   32.486  < 2e-16 ***
age_grp25-34                   1.947e-05  1.206e-06   16.147  < 2e-16 ***
age_grp35-44                   8.936e-06  1.204e-06    7.421 1.16e-13 ***
age_grp45-54                   5.457e-06  1.203e-06    4.534 5.79e-06 ***
age_grp55-64                   3.044e-06  1.206e-06    2.524 0.011604 *  
age_grp65-74                   1.899e-06  1.214e-06    1.564 0.117742    
age_grp75-84                   1.494e-06  1.236e-06    1.209 0.226652    
age_grp85-89                   1.982e-06  1.523e-06    1.302 0.193013    
age_grp90-199                  2.447e-06  2.572e-06    0.951 0.341416    
policyTRUE                     1.731e-06  1.715e-06    1.009 0.312743    
curr_pts_grp1                  1.301e-05  6.024e-07   21.589  < 2e-16 ***
curr_pts_grp2                  1.646e-05  2.791e-07   58.956  < 2e-16 ***
curr_pts_grp3                  2.405e-05  2.409e-07   99.854  < 2e-16 ***
curr_pts_grp4                  3.522e-05  6.157e-07   57.199  < 2e-16 ***
curr_pts_grp5                  4.791e-05  4.610e-07  103.930  < 2e-16 ***
curr_pts_grp6                  5.448e-05  5.213e-07  104.520  < 2e-16 ***
curr_pts_grp7                  6.563e-05  8.452e-07   77.652  < 2e-16 ***
curr_pts_grp8                  8.217e-05  7.909e-07  103.885  < 2e-16 ***
curr_pts_grp9                  7.473e-05  8.727e-07   85.639  < 2e-16 ***
curr_pts_grp10                 9.734e-05  1.271e-06   76.570  < 2e-16 ***
curr_pts_grp11-20              1.351e-04  7.109e-07  190.065  < 2e-16 ***
curr_pts_grp21-30              3.444e-04  2.699e-06  127.595  < 2e-16 ***
curr_pts_grp30-150             4.592e-04  6.040e-06   76.021  < 2e-16 ***
age_grp16-19:policyTRUE       -3.376e-05  1.799e-06  -18.771  < 2e-16 ***
age_grp20-24:policyTRUE       -2.812e-05  1.748e-06  -16.087  < 2e-16 ***
age_grp25-34:policyTRUE       -1.401e-05  1.728e-06   -8.107 5.17e-16 ***
age_grp35-44:policyTRUE       -6.461e-06  1.726e-06   -3.743 0.000182 ***
age_grp45-54:policyTRUE       -3.996e-06  1.725e-06   -2.317 0.020519 *  
age_grp55-64:policyTRUE       -2.270e-06  1.728e-06   -1.314 0.188921    
age_grp65-74:policyTRUE       -1.343e-06  1.739e-06   -0.773 0.439812    
age_grp75-84:policyTRUE       -1.052e-06  1.767e-06   -0.595 0.551857    
age_grp85-89:policyTRUE       -1.545e-06  2.133e-06   -0.725 0.468698    
age_grp90-199:policyTRUE      -2.120e-06  3.517e-06   -0.603 0.546735    
policyTRUE:curr_pts_grp1      -9.790e-06  8.228e-07  -11.899  < 2e-16 ***
policyTRUE:curr_pts_grp2      -1.222e-05  3.758e-07  -32.514  < 2e-16 ***
policyTRUE:curr_pts_grp3      -1.796e-05  3.385e-07  -53.063  < 2e-16 ***
policyTRUE:curr_pts_grp4      -2.666e-05  8.101e-07  -32.905  < 2e-16 ***
policyTRUE:curr_pts_grp5      -3.600e-05  6.259e-07  -57.509  < 2e-16 ***
policyTRUE:curr_pts_grp6      -4.004e-05  7.128e-07  -56.176  < 2e-16 ***
policyTRUE:curr_pts_grp7      -4.766e-05  1.129e-06  -42.208  < 2e-16 ***
policyTRUE:curr_pts_grp8      -6.199e-05  1.067e-06  -58.124  < 2e-16 ***
policyTRUE:curr_pts_grp9      -5.637e-05  1.188e-06  -47.434  < 2e-16 ***
policyTRUE:curr_pts_grp10     -7.587e-05  1.633e-06  -46.458  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.021e-04  9.282e-07 -110.026  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.788e-04  3.335e-06  -83.598  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -3.471e-04  7.171e-06  -48.409  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003222 on 5335033173 degrees of freedom
Multiple R-squared:  3.773e-05,	Adjusted R-squared:  3.773e-05
F-statistic:  4283 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

Notice the sharp drop as several of the offences are moved to 10 points.
Repeat the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.612e-06  1.327e-06  -1.969   0.0490 *  
age_grp16-19                   4.750e-05  1.397e-06  33.998  < 2e-16 ***
age_grp20-24                   3.964e-05  1.353e-06  29.298  < 2e-16 ***
age_grp25-34                   1.947e-05  1.337e-06  14.562  < 2e-16 ***
age_grp35-44                   8.937e-06  1.336e-06   6.691 2.21e-11 ***
age_grp45-54                   5.462e-06  1.335e-06   4.092 4.28e-05 ***
age_grp55-64                   3.043e-06  1.338e-06   2.275   0.0229 *  
age_grp65-74                   1.899e-06  1.347e-06   1.410   0.1584    
age_grp75-84                   1.494e-06  1.371e-06   1.090   0.2756    
age_grp85-89                   1.982e-06  1.689e-06   1.174   0.2405    
age_grp90-199                  2.448e-06  2.853e-06   0.858   0.3909    
policyTRUE                     1.014e-06  1.902e-06   0.533   0.5939    
curr_pts_grp1                  1.300e-05  6.682e-07  19.459  < 2e-16 ***
curr_pts_grp2                  1.645e-05  3.096e-07  53.144  < 2e-16 ***
curr_pts_grp3                  2.406e-05  2.672e-07  90.051  < 2e-16 ***
curr_pts_grp4                  3.521e-05  6.829e-07  51.563  < 2e-16 ***
curr_pts_grp5                  4.796e-05  5.113e-07  93.812  < 2e-16 ***
curr_pts_grp6                  5.450e-05  5.781e-07  94.272  < 2e-16 ***
curr_pts_grp7                  6.569e-05  9.374e-07  70.078  < 2e-16 ***
curr_pts_grp8                  8.216e-05  8.773e-07  93.657  < 2e-16 ***
curr_pts_grp9                  7.480e-05  9.679e-07  77.282  < 2e-16 ***
curr_pts_grp10                 9.733e-05  1.410e-06  69.031  < 2e-16 ***
curr_pts_grp11-20              1.353e-04  7.885e-07 171.535  < 2e-16 ***
curr_pts_grp21-30              3.451e-04  2.994e-06 115.270  < 2e-16 ***
curr_pts_grp30-150             4.592e-04  6.700e-06  68.539  < 2e-16 ***
age_grp16-19:policyTRUE       -1.377e-05  1.995e-06  -6.904 5.06e-12 ***
age_grp20-24:policyTRUE       -1.601e-05  1.939e-06  -8.257  < 2e-16 ***
age_grp25-34:policyTRUE       -8.945e-06  1.916e-06  -4.668 3.04e-06 ***
age_grp35-44:policyTRUE       -4.215e-06  1.914e-06  -2.202   0.0277 *  
age_grp45-54:policyTRUE       -2.948e-06  1.913e-06  -1.541   0.1233    
age_grp55-64:policyTRUE       -1.551e-06  1.917e-06  -0.809   0.4183    
age_grp65-74:policyTRUE       -9.713e-07  1.928e-06  -0.504   0.6145    
age_grp75-84:policyTRUE       -6.130e-07  1.960e-06  -0.313   0.7545    
age_grp85-89:policyTRUE       -1.171e-06  2.366e-06  -0.495   0.6206    
age_grp90-199:policyTRUE      -1.522e-06  3.901e-06  -0.390   0.6965    
policyTRUE:curr_pts_grp1      -6.628e-06  9.126e-07  -7.263 3.78e-13 ***
policyTRUE:curr_pts_grp2      -8.450e-06  4.168e-07 -20.274  < 2e-16 ***
policyTRUE:curr_pts_grp3      -1.212e-05  3.754e-07 -32.277  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.769e-05  8.985e-07 -19.688  < 2e-16 ***
policyTRUE:curr_pts_grp5      -2.666e-05  6.942e-07 -38.401  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.687e-05  7.906e-07 -33.981  < 2e-16 ***
policyTRUE:curr_pts_grp7      -3.203e-05  1.252e-06 -25.575  < 2e-16 ***
policyTRUE:curr_pts_grp8      -4.481e-05  1.183e-06 -37.880  < 2e-16 ***
policyTRUE:curr_pts_grp9      -3.745e-05  1.318e-06 -28.413  < 2e-16 ***
policyTRUE:curr_pts_grp10     -5.113e-05  1.811e-06 -28.227  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -6.167e-05  1.030e-06 -59.905  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.823e-04  3.699e-06 -49.285  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.742e-04  7.954e-06 -21.905  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003573 on 5335033173 degrees of freedom
Multiple R-squared:  3.676e-05,	Adjusted R-squared:  3.675e-05
F-statistic:  4173 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

The policy appears to be having its intended effects for young drivers and repeat offenders.


### Six-point violations (combinations)

The only offence that merits precisely 6 demerit points is speeding 40-45 over in a 100+ zone, only after the policy change.
Other than that, a driver can only get 6 points for a combination of 1-5 point offences.
Among these, the above offence (40-45 over in a 100+ zone) can be one of two 3-point offences that add to 6 points.

Since the 6 point combination with multiple tickets is rare, the former 3 point violation (fairly common) dominates in the post-policy change period.


The regression with only 6 points as the event is as follows.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.047e-07  5.682e-07   0.184  0.85387    
age_grp16-19                   1.805e-06  5.984e-07   3.016  0.00256 **
age_grp20-24                   8.733e-07  5.795e-07   1.507  0.13186    
age_grp25-34                  -3.596e-08  5.727e-07  -0.063  0.94994    
age_grp35-44                  -1.534e-07  5.720e-07  -0.268  0.78860    
age_grp45-54                  -1.706e-07  5.717e-07  -0.298  0.76539    
age_grp55-64                  -1.623e-07  5.729e-07  -0.283  0.77690    
age_grp65-74                  -1.414e-07  5.768e-07  -0.245  0.80642    
age_grp75-84                  -1.318e-07  5.871e-07  -0.224  0.82238    
age_grp85-89                  -1.253e-07  7.233e-07  -0.173  0.86250    
age_grp90-199                 -1.217e-07  1.222e-06  -0.100  0.92064    
policyTRUE                    -2.220e-07  8.145e-07  -0.273  0.78515    
curr_pts_grp1                  1.874e-07  2.862e-07   0.655  0.51258    
curr_pts_grp2                  2.193e-07  1.326e-07   1.654  0.09811 .  
curr_pts_grp3                  1.650e-07  1.144e-07   1.442  0.14942    
curr_pts_grp4                  6.659e-07  2.925e-07   2.277  0.02281 *  
curr_pts_grp5                  5.879e-07  2.190e-07   2.685  0.00726 **
curr_pts_grp6                  7.905e-07  2.476e-07   3.193  0.00141 **
curr_pts_grp7                  1.621e-06  4.015e-07   4.037 5.41e-05 ***
curr_pts_grp8                  1.178e-06  3.757e-07   3.136  0.00171 **
curr_pts_grp9                  5.305e-07  4.146e-07   1.280  0.20070    
curr_pts_grp10                 1.228e-06  6.039e-07   2.033  0.04201 *  
curr_pts_grp11-20              2.874e-06  3.377e-07   8.510  < 2e-16 ***
curr_pts_grp21-30              7.861e-06  1.282e-06   6.130 8.79e-10 ***
curr_pts_grp30-150             1.343e-05  2.869e-06   4.680 2.86e-06 ***
age_grp16-19:policyTRUE        1.083e-05  8.545e-07  12.671  < 2e-16 ***
age_grp20-24:policyTRUE        6.758e-06  8.303e-07   8.139 3.99e-16 ***
age_grp25-34:policyTRUE        3.393e-06  8.208e-07   4.134 3.57e-05 ***
age_grp35-44:policyTRUE        2.076e-06  8.200e-07   2.532  0.01133 *  
age_grp45-54:policyTRUE        1.715e-06  8.194e-07   2.094  0.03629 *  
age_grp55-64:policyTRUE        1.033e-06  8.209e-07   1.259  0.20802    
age_grp65-74:policyTRUE        4.024e-07  8.259e-07   0.487  0.62611    
age_grp75-84:policyTRUE        3.113e-07  8.395e-07   0.371  0.71082    
age_grp85-89:policyTRUE        3.082e-07  1.013e-06   0.304  0.76099    
age_grp90-199:policyTRUE       1.174e-07  1.671e-06   0.070  0.94396    
policyTRUE:curr_pts_grp1       3.498e-06  3.909e-07   8.950  < 2e-16 ***
policyTRUE:curr_pts_grp2       3.902e-06  1.785e-07  21.859  < 2e-16 ***
policyTRUE:curr_pts_grp3       5.704e-06  1.608e-07  35.474  < 2e-16 ***
policyTRUE:curr_pts_grp4       7.848e-06  3.849e-07  20.391  < 2e-16 ***
policyTRUE:curr_pts_grp5       1.074e-05  2.973e-07  36.110  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.261e-05  3.386e-07  37.250  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.358e-05  5.364e-07  25.321  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.775e-05  5.066e-07  35.026  < 2e-16 ***
policyTRUE:curr_pts_grp9       1.747e-05  5.645e-07  30.940  < 2e-16 ***
policyTRUE:curr_pts_grp10      1.783e-05  7.758e-07  22.987  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   2.728e-05  4.409e-07  61.872  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   4.992e-05  1.584e-06  31.508  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  7.864e-05  3.407e-06  23.086  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00153 on 5335033173 degrees of freedom
Multiple R-squared:  1.055e-05,	Adjusted R-squared:  1.054e-05
F-statistic:  1197 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

I'm showing this to compare with the result below, since much of the drop recorded here reflects the change of some of these offences from 3 to 6 points.

Consider next the combined event with either 3 or 6 points at a single roadside stop.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    8.939e-05  5.885e-06  15.188  < 2e-16 ***
age_grp16-19                   2.791e-04  6.199e-06  45.031  < 2e-16 ***
age_grp20-24                   2.348e-04  6.003e-06  39.108  < 2e-16 ***
age_grp25-34                   1.267e-04  5.932e-06  21.364  < 2e-16 ***
age_grp35-44                   7.910e-05  5.925e-06  13.351  < 2e-16 ***
age_grp45-54                   4.845e-05  5.922e-06   8.181 2.81e-16 ***
age_grp55-64                   1.864e-05  5.934e-06   3.140 0.001687 **
age_grp65-74                  -1.078e-05  5.975e-06  -1.804 0.071280 .  
age_grp75-84                  -3.073e-05  6.081e-06  -5.053 4.34e-07 ***
age_grp85-89                  -3.796e-05  7.492e-06  -5.067 4.05e-07 ***
age_grp90-199                 -3.547e-05  1.266e-05  -2.802 0.005078 **
policyTRUE                     2.429e-06  8.437e-06   0.288 0.773384    
curr_pts_grp1                  2.135e-04  2.964e-06  72.020  < 2e-16 ***
curr_pts_grp2                  2.813e-04  1.374e-06 204.784  < 2e-16 ***
curr_pts_grp3                  3.705e-04  1.185e-06 312.572  < 2e-16 ***
curr_pts_grp4                  4.983e-04  3.030e-06 164.470  < 2e-16 ***
curr_pts_grp5                  6.303e-04  2.268e-06 277.902  < 2e-16 ***
curr_pts_grp6                  7.807e-04  2.565e-06 304.376  < 2e-16 ***
curr_pts_grp7                  8.157e-04  4.159e-06 196.148  < 2e-16 ***
curr_pts_grp8                  9.668e-04  3.892e-06 248.405  < 2e-16 ***
curr_pts_grp9                  9.120e-04  4.294e-06 212.379  < 2e-16 ***
curr_pts_grp10                 1.090e-03  6.255e-06 174.289  < 2e-16 ***
curr_pts_grp11-20              1.307e-03  3.498e-06 373.679  < 2e-16 ***
curr_pts_grp21-30              2.369e-03  1.328e-05 178.367  < 2e-16 ***
curr_pts_grp30-150             3.622e-03  2.972e-05 121.848  < 2e-16 ***
age_grp16-19:policyTRUE       -5.467e-05  8.851e-06  -6.177 6.54e-10 ***
age_grp20-24:policyTRUE       -5.553e-05  8.600e-06  -6.457 1.07e-10 ***
age_grp25-34:policyTRUE       -4.731e-05  8.502e-06  -5.565 2.62e-08 ***
age_grp35-44:policyTRUE       -3.217e-05  8.493e-06  -3.787 0.000152 ***
age_grp45-54:policyTRUE       -2.797e-05  8.487e-06  -3.296 0.000981 ***
age_grp55-64:policyTRUE       -2.380e-05  8.503e-06  -2.799 0.005123 **
age_grp65-74:policyTRUE       -1.333e-05  8.555e-06  -1.559 0.119095    
age_grp75-84:policyTRUE       -7.899e-06  8.696e-06  -0.908 0.363677    
age_grp85-89:policyTRUE       -6.158e-06  1.049e-05  -0.587 0.557333    
age_grp90-199:policyTRUE      -1.473e-05  1.731e-05  -0.851 0.394736    
policyTRUE:curr_pts_grp1      -2.223e-05  4.049e-06  -5.492 3.98e-08 ***
policyTRUE:curr_pts_grp2      -4.888e-05  1.849e-06 -26.437  < 2e-16 ***
policyTRUE:curr_pts_grp3      -5.544e-05  1.665e-06 -33.286  < 2e-16 ***
policyTRUE:curr_pts_grp4      -6.120e-05  3.986e-06 -15.352  < 2e-16 ***
policyTRUE:curr_pts_grp5      -8.883e-05  3.080e-06 -28.841  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.270e-04  3.508e-06 -36.200  < 2e-16 ***
policyTRUE:curr_pts_grp7      -8.839e-05  5.556e-06 -15.909  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.354e-04  5.248e-06 -25.802  < 2e-16 ***
policyTRUE:curr_pts_grp9      -9.601e-05  5.847e-06 -16.419  < 2e-16 ***
policyTRUE:curr_pts_grp10     -2.657e-04  8.035e-06 -33.064  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -2.708e-04  4.567e-06 -59.294  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -6.864e-04  1.641e-05 -41.823  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.261e-03  3.529e-05 -35.746  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01585 on 5335033173 degrees of freedom
Multiple R-squared:  0.0002536,	Adjusted R-squared:  0.0002536
F-statistic: 2.879e+04 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

A similar pattern emerges, with a stronger policy reaction from the younger drivers and repeat offenders.

### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards.
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence.

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -4.113e-07  5.533e-07  -0.743  0.45727    
age_grp16-19                   1.513e-05  5.828e-07  25.962  < 2e-16 ***
age_grp20-24                   9.742e-06  5.644e-07  17.261  < 2e-16 ***
age_grp25-34                   3.600e-06  5.577e-07   6.455 1.08e-10 ***
age_grp35-44                   7.298e-07  5.571e-07   1.310  0.19016    
age_grp45-54                   8.619e-08  5.568e-07   0.155  0.87698    
age_grp55-64                  -1.199e-07  5.579e-07  -0.215  0.82982    
age_grp65-74                   5.878e-09  5.617e-07   0.010  0.99165    
age_grp75-84                   4.685e-08  5.717e-07   0.082  0.93470    
age_grp85-89                   1.679e-07  7.043e-07   0.238  0.81158    
age_grp90-199                  1.228e-07  1.190e-06   0.103  0.91781    
policyTRUE                     1.647e-07  7.932e-07   0.208  0.83546    
curr_pts_grp1                  2.009e-06  2.787e-07   7.210 5.60e-13 ***
curr_pts_grp2                  2.004e-06  1.291e-07  15.521  < 2e-16 ***
curr_pts_grp3                  4.146e-06  1.114e-07  37.198  < 2e-16 ***
curr_pts_grp4                  5.811e-06  2.848e-07  20.402  < 2e-16 ***
curr_pts_grp5                  8.032e-06  2.133e-07  37.666  < 2e-16 ***
curr_pts_grp6                  1.061e-05  2.411e-07  44.007  < 2e-16 ***
curr_pts_grp7                  1.549e-05  3.910e-07  39.615  < 2e-16 ***
curr_pts_grp8                  1.371e-05  3.659e-07  37.463  < 2e-16 ***
curr_pts_grp9                  1.283e-05  4.037e-07  31.768  < 2e-16 ***
curr_pts_grp10                 2.254e-05  5.881e-07  38.326  < 2e-16 ***
curr_pts_grp11-20              3.623e-05  3.289e-07 110.168  < 2e-16 ***
curr_pts_grp21-30              9.999e-05  1.249e-06  80.066  < 2e-16 ***
curr_pts_grp30-150             2.396e-04  2.794e-06  85.741  < 2e-16 ***
age_grp16-19:policyTRUE       -6.196e-06  8.321e-07  -7.445 9.66e-14 ***
age_grp20-24:policyTRUE       -4.146e-06  8.086e-07  -5.128 2.93e-07 ***
age_grp25-34:policyTRUE       -1.996e-06  7.993e-07  -2.497  0.01254 *  
age_grp35-44:policyTRUE       -3.340e-07  7.985e-07  -0.418  0.67572    
age_grp45-54:policyTRUE       -2.416e-08  7.979e-07  -0.030  0.97585    
age_grp55-64:policyTRUE        1.170e-07  7.994e-07   0.146  0.88368    
age_grp65-74:policyTRUE       -2.281e-08  8.043e-07  -0.028  0.97738    
age_grp75-84:policyTRUE        2.789e-09  8.176e-07   0.003  0.99728    
age_grp85-89:policyTRUE       -7.556e-08  9.867e-07  -0.077  0.93896    
age_grp90-199:policyTRUE      -2.498e-08  1.627e-06  -0.015  0.98775    
policyTRUE:curr_pts_grp1      -1.018e-06  3.806e-07  -2.675  0.00746 **
policyTRUE:curr_pts_grp2      -1.012e-06  1.738e-07  -5.820 5.88e-09 ***
policyTRUE:curr_pts_grp3      -2.826e-06  1.566e-07 -18.048  < 2e-16 ***
policyTRUE:curr_pts_grp4      -3.356e-06  3.748e-07  -8.954  < 2e-16 ***
policyTRUE:curr_pts_grp5      -5.362e-06  2.896e-07 -18.518  < 2e-16 ***
policyTRUE:curr_pts_grp6      -6.657e-06  3.298e-07 -20.188  < 2e-16 ***
policyTRUE:curr_pts_grp7      -9.245e-06  5.224e-07 -17.697  < 2e-16 ***
policyTRUE:curr_pts_grp8      -6.945e-06  4.934e-07 -14.076  < 2e-16 ***
policyTRUE:curr_pts_grp9      -4.975e-06  5.498e-07  -9.049  < 2e-16 ***
policyTRUE:curr_pts_grp10     -1.429e-05  7.555e-07 -18.913  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.867e-05  4.294e-07 -43.484  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -4.490e-05  1.543e-06 -29.099  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.410e-04  3.317e-06 -42.516  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00149 on 5335033173 degrees of freedom
Multiple R-squared:  1.394e-05,	Adjusted R-squared:  1.393e-05
F-statistic:  1582 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```


### Nine-point violations (speeding 81-100 over or combinations)

One offence that merits 9 demerit points is speeding 80-100 over, only before the policy change, after which it was changed to a 18-point offence.
Other than that, there 7 other violations that result in 9 demerit points, none of which were changed with the excessive speeding policy.

The combined 9- and 18-point event is analyzed in the following logistic regression:

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    5.264e-06  5.957e-07   8.837  < 2e-16 ***
age_grp16-19                   7.207e-06  6.274e-07  11.487  < 2e-16 ***
age_grp20-24                   9.086e-07  6.076e-07   1.495 0.134824    
age_grp25-34                  -3.014e-06  6.005e-07  -5.019 5.19e-07 ***
age_grp35-44                  -4.145e-06  5.998e-07  -6.910 4.83e-12 ***
age_grp45-54                  -4.375e-06  5.994e-07  -7.299 2.91e-13 ***
age_grp55-64                  -4.614e-06  6.007e-07  -7.681 1.57e-14 ***
age_grp65-74                  -4.383e-06  6.048e-07  -7.247 4.25e-13 ***
age_grp75-84                  -3.412e-06  6.155e-07  -5.543 2.98e-08 ***
age_grp85-89                  -1.642e-06  7.583e-07  -2.166 0.030349 *  
age_grp90-199                 -1.964e-06  1.281e-06  -1.533 0.125341    
policyTRUE                    -1.678e-06  8.540e-07  -1.966 0.049344 *  
curr_pts_grp1                  7.906e-07  3.001e-07   2.635 0.008419 **
curr_pts_grp2                  1.583e-06  1.390e-07  11.389  < 2e-16 ***
curr_pts_grp3                  2.986e-06  1.200e-07  24.883  < 2e-16 ***
curr_pts_grp4                  5.780e-06  3.066e-07  18.848  < 2e-16 ***
curr_pts_grp5                  4.692e-06  2.296e-07  20.436  < 2e-16 ***
curr_pts_grp6                  5.259e-06  2.596e-07  20.257  < 2e-16 ***
curr_pts_grp7                  8.822e-06  4.209e-07  20.958  < 2e-16 ***
curr_pts_grp8                  7.960e-06  3.939e-07  20.207  < 2e-16 ***
curr_pts_grp9                  1.109e-05  4.346e-07  25.515  < 2e-16 ***
curr_pts_grp10                 1.064e-05  6.332e-07  16.806  < 2e-16 ***
curr_pts_grp11-20              2.084e-05  3.541e-07  58.849  < 2e-16 ***
curr_pts_grp21-30              6.430e-05  1.344e-06  47.824  < 2e-16 ***
curr_pts_grp30-150             1.393e-04  3.009e-06  46.288  < 2e-16 ***
age_grp16-19:policyTRUE       -8.570e-07  8.959e-07  -0.957 0.338762    
age_grp20-24:policyTRUE        5.980e-07  8.705e-07   0.687 0.492112    
age_grp25-34:policyTRUE        1.157e-06  8.605e-07   1.344 0.178854    
age_grp35-44:policyTRUE        1.497e-06  8.597e-07   1.742 0.081564 .  
age_grp45-54:policyTRUE        1.438e-06  8.591e-07   1.674 0.094059 .  
age_grp55-64:policyTRUE        1.558e-06  8.606e-07   1.810 0.070327 .  
age_grp65-74:policyTRUE        1.578e-06  8.660e-07   1.822 0.068458 .  
age_grp75-84:policyTRUE        1.667e-06  8.802e-07   1.894 0.058163 .  
age_grp85-89:policyTRUE       -1.330e-07  1.062e-06  -0.125 0.900349    
age_grp90-199:policyTRUE       1.040e-06  1.752e-06   0.594 0.552588    
policyTRUE:curr_pts_grp1       1.273e-07  4.098e-07   0.311 0.756044    
policyTRUE:curr_pts_grp2      -3.572e-07  1.872e-07  -1.908 0.056335 .  
policyTRUE:curr_pts_grp3      -5.516e-07  1.686e-07  -3.272 0.001068 **
policyTRUE:curr_pts_grp4      -1.469e-06  4.035e-07  -3.641 0.000272 ***
policyTRUE:curr_pts_grp5      -1.809e-06  3.117e-07  -5.802 6.57e-09 ***
policyTRUE:curr_pts_grp6      -8.944e-07  3.550e-07  -2.519 0.011762 *  
policyTRUE:curr_pts_grp7      -3.001e-06  5.624e-07  -5.336 9.49e-08 ***
policyTRUE:curr_pts_grp8      -2.438e-06  5.312e-07  -4.590 4.43e-06 ***
policyTRUE:curr_pts_grp9      -3.758e-06  5.919e-07  -6.349 2.16e-10 ***
policyTRUE:curr_pts_grp10     -3.321e-06  8.134e-07  -4.084 4.43e-05 ***
policyTRUE:curr_pts_grp11-20  -7.367e-06  4.623e-07 -15.935  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.762e-05  1.661e-06 -16.629  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -8.127e-05  3.572e-06 -22.756  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001605 on 5335033173 degrees of freedom
Multiple R-squared:  5.333e-06,	Adjusted R-squared:  5.324e-06
F-statistic: 605.3 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

This time, the policy effect is not statistically related to age groups but the overall negative effect is now significant.
The effect is still increasing in point balances.

### Twelve-point violations (speeding 100-119 over or 3 other offences)

The 12-point speeding offence was changed to a 24-point offence but the others were unchanged.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.073e-08  7.624e-08  -0.141 0.888091    
age_grp16-19                   1.746e-07  8.030e-08   2.175 0.029662 *  
age_grp20-24                   2.237e-07  7.777e-08   2.876 0.004025 **
age_grp25-34                   5.823e-08  7.685e-08   0.758 0.448618    
age_grp35-44                   4.415e-09  7.676e-08   0.058 0.954138    
age_grp45-54                  -7.694e-09  7.672e-08  -0.100 0.920122    
age_grp55-64                  -4.309e-10  7.688e-08  -0.006 0.995528    
age_grp65-74                  -1.576e-09  7.740e-08  -0.020 0.983754    
age_grp75-84                   2.143e-09  7.878e-08   0.027 0.978300    
age_grp85-89                   3.927e-09  9.705e-08   0.040 0.967727    
age_grp90-199                  5.077e-09  1.640e-07   0.031 0.975298    
policyTRUE                     3.725e-09  1.093e-07   0.034 0.972809    
curr_pts_grp1                  1.068e-08  3.840e-08   0.278 0.780899    
curr_pts_grp2                  6.772e-08  1.779e-08   3.806 0.000141 ***
curr_pts_grp3                  7.505e-08  1.536e-08   4.888 1.02e-06 ***
curr_pts_grp4                  1.385e-07  3.925e-08   3.530 0.000415 ***
curr_pts_grp5                  2.396e-07  2.938e-08   8.153 3.56e-16 ***
curr_pts_grp6                  1.618e-07  3.323e-08   4.869 1.12e-06 ***
curr_pts_grp7                  4.223e-07  5.388e-08   7.838 4.60e-15 ***
curr_pts_grp8                  1.264e-07  5.042e-08   2.507 0.012185 *  
curr_pts_grp9                  3.099e-07  5.563e-08   5.571 2.54e-08 ***
curr_pts_grp10                 3.996e-07  8.103e-08   4.931 8.18e-07 ***
curr_pts_grp11-20              4.977e-07  4.532e-08  10.982  < 2e-16 ***
curr_pts_grp21-30              2.697e-06  1.721e-07  15.671  < 2e-16 ***
curr_pts_grp30-150             3.400e-06  3.850e-07   8.831  < 2e-16 ***
age_grp16-19:policyTRUE        2.752e-08  1.147e-07   0.240 0.810338    
age_grp20-24:policyTRUE       -5.766e-08  1.114e-07  -0.518 0.604801    
age_grp25-34:policyTRUE       -3.630e-08  1.101e-07  -0.330 0.741680    
age_grp35-44:policyTRUE       -5.244e-09  1.100e-07  -0.048 0.961985    
age_grp45-54:policyTRUE       -1.891e-09  1.099e-07  -0.017 0.986278    
age_grp55-64:policyTRUE       -3.235e-09  1.101e-07  -0.029 0.976569    
age_grp65-74:policyTRUE        2.520e-11  1.108e-07   0.000 0.999819    
age_grp75-84:policyTRUE       -8.610e-10  1.127e-07  -0.008 0.993902    
age_grp85-89:policyTRUE       -1.141e-09  1.360e-07  -0.008 0.993304    
age_grp90-199:policyTRUE      -2.118e-09  2.242e-07  -0.009 0.992463    
policyTRUE:curr_pts_grp1       6.444e-09  5.245e-08   0.123 0.902220    
policyTRUE:curr_pts_grp2      -4.175e-08  2.395e-08  -1.743 0.081354 .  
policyTRUE:curr_pts_grp3      -4.088e-08  2.158e-08  -1.895 0.058138 .  
policyTRUE:curr_pts_grp4      -8.459e-08  5.164e-08  -1.638 0.101437    
policyTRUE:curr_pts_grp5      -9.502e-08  3.990e-08  -2.382 0.017241 *  
policyTRUE:curr_pts_grp6      -9.971e-08  4.544e-08  -2.194 0.028210 *  
policyTRUE:curr_pts_grp7      -2.934e-07  7.198e-08  -4.076 4.58e-05 ***
policyTRUE:curr_pts_grp8      -1.084e-07  6.798e-08  -1.594 0.110985    
policyTRUE:curr_pts_grp9      -9.601e-08  7.575e-08  -1.267 0.205009    
policyTRUE:curr_pts_grp10     -2.394e-07  1.041e-07  -2.300 0.021462 *  
policyTRUE:curr_pts_grp11-20   3.233e-07  5.917e-08   5.465 4.64e-08 ***
policyTRUE:curr_pts_grp21-30  -5.616e-07  2.126e-07  -2.641 0.008258 **
policyTRUE:curr_pts_grp30-150  3.701e-06  4.571e-07   8.096 5.70e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0002054 on 5335033173 degrees of freedom
Multiple R-squared:  5.527e-07,	Adjusted R-squared:  5.439e-07
F-statistic: 62.74 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

Now we have lower event rates but the results are broadly consistent with the above.
Some of the statistically significant coefficients contradict some of the above.


### Twelve-points and up (speeding 100 or more and 3 other 12-point offences)

Combining with the more excessive speeding offences, the number of events is larger.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.243e-08  1.461e-07  -0.085 0.932189    
age_grp16-19                   2.243e-07  1.539e-07   1.458 0.144830    
age_grp20-24                   2.443e-07  1.490e-07   1.639 0.101111    
age_grp25-34                   7.066e-08  1.472e-07   0.480 0.631301    
age_grp35-44                   7.509e-09  1.471e-07   0.051 0.959282    
age_grp45-54                  -8.958e-09  1.470e-07  -0.061 0.951407    
age_grp55-64                  -8.399e-10  1.473e-07  -0.006 0.995451    
age_grp65-74                  -1.257e-09  1.483e-07  -0.008 0.993235    
age_grp75-84                   2.919e-09  1.509e-07   0.019 0.984572    
age_grp85-89                   4.881e-09  1.860e-07   0.026 0.979059    
age_grp90-199                  6.196e-09  3.142e-07   0.020 0.984266    
policyTRUE                     1.042e-07  2.094e-07   0.498 0.618630    
curr_pts_grp1                  6.139e-09  7.358e-08   0.083 0.933508    
curr_pts_grp2                  7.733e-08  3.409e-08   2.268 0.023320 *  
curr_pts_grp3                  7.955e-08  2.942e-08   2.704 0.006856 **
curr_pts_grp4                  2.031e-07  7.520e-08   2.700 0.006925 **
curr_pts_grp5                  2.331e-07  5.630e-08   4.141 3.46e-05 ***
curr_pts_grp6                  1.805e-07  6.366e-08   2.835 0.004582 **
curr_pts_grp7                  4.816e-07  1.032e-07   4.665 3.08e-06 ***
curr_pts_grp8                  1.779e-07  9.660e-08   1.842 0.065529 .  
curr_pts_grp9                  3.743e-07  1.066e-07   3.512 0.000445 ***
curr_pts_grp10                 3.899e-07  1.553e-07   2.511 0.012038 *  
curr_pts_grp11-20              5.823e-07  8.683e-08   6.707 1.99e-11 ***
curr_pts_grp21-30              4.083e-06  3.297e-07  12.385  < 2e-16 ***
curr_pts_grp30-150             6.898e-06  7.378e-07   9.350  < 2e-16 ***
age_grp16-19:policyTRUE        1.058e-06  2.197e-07   4.818 1.45e-06 ***
age_grp20-24:policyTRUE        4.984e-07  2.135e-07   2.335 0.019562 *  
age_grp25-34:policyTRUE        3.930e-08  2.110e-07   0.186 0.852278    
age_grp35-44:policyTRUE       -1.378e-07  2.108e-07  -0.653 0.513447    
age_grp45-54:policyTRUE       -1.627e-07  2.107e-07  -0.773 0.439808    
age_grp55-64:policyTRUE       -1.711e-07  2.110e-07  -0.811 0.417646    
age_grp65-74:policyTRUE       -1.373e-07  2.124e-07  -0.647 0.517833    
age_grp75-84:policyTRUE       -1.341e-07  2.158e-07  -0.621 0.534396    
age_grp85-89:policyTRUE       -1.266e-07  2.605e-07  -0.486 0.627044    
age_grp90-199:policyTRUE      -1.275e-07  4.296e-07  -0.297 0.766636    
policyTRUE:curr_pts_grp1       1.024e-07  1.005e-07   1.019 0.308428    
policyTRUE:curr_pts_grp2       2.173e-08  4.590e-08   0.474 0.635844    
policyTRUE:curr_pts_grp3       2.577e-07  4.134e-08   6.234 4.56e-10 ***
policyTRUE:curr_pts_grp4       3.294e-07  9.895e-08   3.329 0.000872 ***
policyTRUE:curr_pts_grp5       3.260e-07  7.645e-08   4.264 2.01e-05 ***
policyTRUE:curr_pts_grp6       5.896e-07  8.706e-08   6.772 1.27e-11 ***
policyTRUE:curr_pts_grp7       6.938e-07  1.379e-07   5.031 4.88e-07 ***
policyTRUE:curr_pts_grp8       9.781e-07  1.303e-07   7.509 5.95e-14 ***
policyTRUE:curr_pts_grp9       4.514e-07  1.451e-07   3.110 0.001868 **
policyTRUE:curr_pts_grp10      1.852e-06  1.995e-07   9.287  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   3.384e-06  1.134e-07  29.851  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   1.018e-05  4.074e-07  24.995  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  3.569e-05  8.758e-07  40.753  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0003935 on 5335033173 degrees of freedom
Multiple R-squared:  3.597e-06,	Adjusted R-squared:  3.588e-06
F-statistic: 408.3 on 47 and 5335033173 DF,  p-value: < 2.2e-16

```

This gives the unusual result of an increase in event rates with the policy change?!
I will need some help to interpret this.


### More than Twelve points (only speeding 120 or more)

This category includes speeding 120-139 over (15, changed to 30 points after policy change),
speeding 140-159 over (18, changed to 36 points after policy change),


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.701e-09  1.246e-07  -0.014  0.98911    
age_grp16-19                   4.971e-08  1.312e-07   0.379  0.70486    
age_grp20-24                   2.062e-08  1.271e-07   0.162  0.87114    
age_grp25-34                   1.243e-08  1.256e-07   0.099  0.92115    
age_grp35-44                   3.094e-09  1.255e-07   0.025  0.98032    
age_grp45-54                  -1.264e-09  1.254e-07  -0.010  0.99195    
age_grp55-64                  -4.090e-10  1.256e-07  -0.003  0.99740    
age_grp65-74                   3.187e-10  1.265e-07   0.003  0.99799    
age_grp75-84                   7.760e-10  1.288e-07   0.006  0.99519    
age_grp85-89                   9.545e-10  1.586e-07   0.006  0.99520    
age_grp90-199                  1.119e-09  2.680e-07   0.004  0.99667    
policyTRUE                     1.005e-07  1.786e-07   0.563  0.57362    
curr_pts_grp1                 -4.543e-09  6.276e-08  -0.072  0.94230    
curr_pts_grp2                  9.607e-09  2.908e-08   0.330  0.74114    
curr_pts_grp3                  4.498e-09  2.510e-08   0.179  0.85776    
curr_pts_grp4                  6.452e-08  6.414e-08   1.006  0.31448    
curr_pts_grp5                 -6.439e-09  4.802e-08  -0.134  0.89334    
curr_pts_grp6                  1.870e-08  5.431e-08   0.344  0.73054    
curr_pts_grp7                  5.931e-08  8.805e-08   0.674  0.50057    
curr_pts_grp8                  5.152e-08  8.240e-08   0.625  0.53182    
curr_pts_grp9                  6.439e-08  9.092e-08   0.708  0.47877    
curr_pts_grp10                -9.714e-09  1.324e-07  -0.073  0.94153    
curr_pts_grp11-20              8.466e-08  7.406e-08   1.143  0.25301    
curr_pts_grp21-30              1.387e-06  2.812e-07   4.931 8.19e-07 ***
curr_pts_grp30-150             3.498e-06  6.293e-07   5.558 2.73e-08 ***
age_grp16-19:policyTRUE        1.031e-06  1.874e-07   5.501 3.77e-08 ***
age_grp20-24:policyTRUE        5.560e-07  1.821e-07   3.054  0.00226 **
age_grp25-34:policyTRUE        7.560e-08  1.800e-07   0.420  0.67449    
age_grp35-44:policyTRUE       -1.325e-07  1.798e-07  -0.737  0.46116    
age_grp45-54:policyTRUE       -1.608e-07  1.797e-07  -0.895  0.37072    
age_grp55-64:policyTRUE       -1.678e-07  1.800e-07  -0.932  0.35122    
age_grp65-74:policyTRUE       -1.374e-07  1.811e-07  -0.758  0.44829    
age_grp75-84:policyTRUE       -1.332e-07  1.841e-07  -0.724  0.46924    
age_grp85-89:policyTRUE       -1.254e-07  2.222e-07  -0.564  0.57242    
age_grp90-199:policyTRUE      -1.254e-07  3.664e-07  -0.342  0.73224    
policyTRUE:curr_pts_grp1       9.591e-08  8.572e-08   1.119  0.26319    
policyTRUE:curr_pts_grp2       6.348e-08  3.915e-08   1.622  0.10490    
policyTRUE:curr_pts_grp3       2.986e-07  3.526e-08   8.467  < 2e-16 ***
policyTRUE:curr_pts_grp4       4.140e-07  8.440e-08   4.905 9.36e-07 ***
policyTRUE:curr_pts_grp5       4.210e-07  6.521e-08   6.456 1.08e-10 ***
policyTRUE:curr_pts_grp6       6.893e-07  7.426e-08   9.282  < 2e-16 ***
policyTRUE:curr_pts_grp7       9.872e-07  1.176e-07   8.392  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.086e-06  1.111e-07   9.778  < 2e-16 ***
policyTRUE:curr_pts_grp9       5.475e-07  1.238e-07   4.422 9.78e-06 ***
policyTRUE:curr_pts_grp10      2.092e-06  1.701e-07  12.295  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   3.061e-06  9.670e-08  31.652  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   1.074e-05  3.475e-07  30.919  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  3.199e-05  7.471e-07  42.823  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0003356 on 5335033173 degrees of freedom
Multiple R-squared:  3.408e-06,	Adjusted R-squared:  3.399e-06
F-statistic: 386.8 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

It is mostly the young and the reckless committing these infractions.
Still, the incidence for the high point group is increasing in point history.
What's going on?


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    5.252e-06  6.014e-07   8.734  < 2e-16 ***
age_grp16-19                   7.434e-06  6.334e-07  11.736  < 2e-16 ***
age_grp20-24                   1.150e-06  6.134e-07   1.875 0.060861 .  
age_grp25-34                  -2.945e-06  6.062e-07  -4.858 1.19e-06 ***
age_grp35-44                  -4.141e-06  6.055e-07  -6.838 8.00e-12 ***
age_grp45-54                  -4.384e-06  6.052e-07  -7.244 4.35e-13 ***
age_grp55-64                  -4.615e-06  6.064e-07  -7.610 2.73e-14 ***
age_grp65-74                  -4.385e-06  6.105e-07  -7.181 6.90e-13 ***
age_grp75-84                  -3.409e-06  6.214e-07  -5.486 4.10e-08 ***
age_grp85-89                  -1.638e-06  7.655e-07  -2.139 0.032416 *  
age_grp90-199                 -1.958e-06  1.293e-06  -1.514 0.130076    
policyTRUE                    -1.675e-06  8.621e-07  -1.943 0.052026 .  
curr_pts_grp1                  7.973e-07  3.029e-07   2.632 0.008482 **
curr_pts_grp2                  1.661e-06  1.404e-07  11.837  < 2e-16 ***
curr_pts_grp3                  3.061e-06  1.211e-07  25.269  < 2e-16 ***
curr_pts_grp4                  5.948e-06  3.096e-07  19.212  < 2e-16 ***
curr_pts_grp5                  4.926e-06  2.318e-07  21.253  < 2e-16 ***
curr_pts_grp6                  5.441e-06  2.621e-07  20.758  < 2e-16 ***
curr_pts_grp7                  9.305e-06  4.250e-07  21.895  < 2e-16 ***
curr_pts_grp8                  8.139e-06  3.977e-07  20.466  < 2e-16 ***
curr_pts_grp9                  1.147e-05  4.388e-07  26.130  < 2e-16 ***
curr_pts_grp10                 1.103e-05  6.392e-07  17.259  < 2e-16 ***
curr_pts_grp11-20              2.142e-05  3.574e-07  59.926  < 2e-16 ***
curr_pts_grp21-30              6.768e-05  1.357e-06  49.866  < 2e-16 ***
curr_pts_grp30-150             1.462e-04  3.037e-06  48.123  < 2e-16 ***
age_grp16-19:policyTRUE       -8.563e-07  9.044e-07  -0.947 0.343768    
age_grp20-24:policyTRUE        5.407e-07  8.788e-07   0.615 0.538418    
age_grp25-34:policyTRUE        1.120e-06  8.687e-07   1.289 0.197415    
age_grp35-44:policyTRUE        1.490e-06  8.679e-07   1.716 0.086098 .  
age_grp45-54:policyTRUE        1.437e-06  8.673e-07   1.657 0.097609 .  
age_grp55-64:policyTRUE        1.554e-06  8.688e-07   1.788 0.073757 .  
age_grp65-74:policyTRUE        1.577e-06  8.742e-07   1.804 0.071162 .  
age_grp75-84:policyTRUE        1.667e-06  8.886e-07   1.876 0.060713 .  
age_grp85-89:policyTRUE       -1.340e-07  1.072e-06  -0.125 0.900553    
age_grp90-199:policyTRUE       1.038e-06  1.768e-06   0.587 0.557145    
policyTRUE:curr_pts_grp1       1.360e-07  4.137e-07   0.329 0.742388    
policyTRUE:curr_pts_grp2      -4.110e-07  1.889e-07  -2.175 0.029624 *  
policyTRUE:curr_pts_grp3      -5.904e-07  1.702e-07  -3.469 0.000522 ***
policyTRUE:curr_pts_grp4      -1.560e-06  4.073e-07  -3.830 0.000128 ***
policyTRUE:curr_pts_grp5      -1.868e-06  3.147e-07  -5.935 2.94e-09 ***
policyTRUE:curr_pts_grp6      -9.730e-07  3.584e-07  -2.715 0.006631 **
policyTRUE:curr_pts_grp7      -3.359e-06  5.677e-07  -5.916 3.29e-09 ***
policyTRUE:curr_pts_grp8      -2.555e-06  5.362e-07  -4.764 1.90e-06 ***
policyTRUE:curr_pts_grp9      -3.924e-06  5.975e-07  -6.567 5.13e-11 ***
policyTRUE:curr_pts_grp10     -3.457e-06  8.211e-07  -4.211 2.55e-05 ***
policyTRUE:curr_pts_grp11-20  -6.901e-06  4.667e-07 -14.788  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.851e-05  1.677e-06 -17.003  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.677e-05  3.606e-06 -21.292  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00162 on 5335033173 degrees of freedom
Multiple R-squared:  5.716e-06,	Adjusted R-squared:  5.708e-06
F-statistic: 648.9 on 47 and 5335033173 DF,  p-value: < 2.2e-16
```

If we lump together all violations 9 points and up, everything is back to normal.
Any thoughts on the above? 
