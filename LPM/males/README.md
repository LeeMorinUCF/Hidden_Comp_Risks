
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
(Intercept)                    8.948e-05  7.948e-06  11.258  < 2e-16 ***
age_grp16-19                   6.031e-04  8.373e-06  72.031  < 2e-16 ***
age_grp20-24                   4.749e-04  8.107e-06  58.580  < 2e-16 ***
age_grp25-34                   3.160e-04  8.012e-06  39.441  < 2e-16 ***
age_grp35-44                   2.453e-04  8.002e-06  30.651  < 2e-16 ***
age_grp45-54                   1.981e-04  7.998e-06  24.774  < 2e-16 ***
age_grp55-64                   1.395e-04  8.015e-06  17.403  < 2e-16 ***
age_grp65-74                   6.905e-05  8.070e-06   8.556  < 2e-16 ***
age_grp75-84                   1.722e-05  8.214e-06   2.097 0.036018 *  
age_grp85-89                  -7.602e-06  1.014e-05  -0.750 0.453462    
age_grp90-199                 -2.441e-05  1.716e-05  -1.422 0.154985    
policyTRUE                     1.386e-05  1.174e-05   1.181 0.237735    
curr_pts_grp1                  5.494e-04  3.998e-06 137.430  < 2e-16 ***
curr_pts_grp2                  5.910e-04  1.859e-06 317.998  < 2e-16 ***
curr_pts_grp3                  6.666e-04  1.603e-06 415.949  < 2e-16 ***
curr_pts_grp4                  1.074e-03  4.103e-06 261.691  < 2e-16 ***
curr_pts_grp5                  1.196e-03  3.073e-06 389.077  < 2e-16 ***
curr_pts_grp6                  1.368e-03  3.475e-06 393.621  < 2e-16 ***
curr_pts_grp7                  1.617e-03  5.635e-06 286.958  < 2e-16 ***
curr_pts_grp8                  1.789e-03  5.284e-06 338.597  < 2e-16 ***
curr_pts_grp9                  1.645e-03  5.827e-06 282.268  < 2e-16 ***
curr_pts_grp10                 2.103e-03  8.500e-06 247.394  < 2e-16 ***
curr_pts_grp11-20              2.457e-03  4.755e-06 516.624  < 2e-16 ***
curr_pts_grp21-30              4.131e-03  1.805e-05 228.792  < 2e-16 ***
curr_pts_grp30-150             5.912e-03  4.043e-05 146.234  < 2e-16 ***
age_grp16-19:policyTRUE       -4.108e-05  1.231e-05  -3.337 0.000848 ***
age_grp20-24:policyTRUE       -6.179e-05  1.196e-05  -5.164 2.42e-07 ***
age_grp25-34:policyTRUE       -5.860e-05  1.183e-05  -4.954 7.27e-07 ***
age_grp35-44:policyTRUE       -3.448e-05  1.182e-05  -2.918 0.003519 **
age_grp45-54:policyTRUE       -2.779e-05  1.181e-05  -2.354 0.018590 *  
age_grp55-64:policyTRUE       -2.415e-05  1.183e-05  -2.042 0.041175 *  
age_grp65-74:policyTRUE       -1.093e-05  1.190e-05  -0.919 0.358230    
age_grp75-84:policyTRUE       -1.216e-05  1.210e-05  -1.005 0.314996    
age_grp85-89:policyTRUE       -1.616e-05  1.460e-05  -1.107 0.268346    
age_grp90-199:policyTRUE      -1.481e-05  2.406e-05  -0.616 0.538177    
policyTRUE:curr_pts_grp1      -2.865e-05  5.613e-06  -5.104 3.33e-07 ***
policyTRUE:curr_pts_grp2      -3.863e-05  2.566e-06 -15.057  < 2e-16 ***
policyTRUE:curr_pts_grp3      -4.479e-05  2.316e-06 -19.339  < 2e-16 ***
policyTRUE:curr_pts_grp4      -4.895e-05  5.526e-06  -8.857  < 2e-16 ***
policyTRUE:curr_pts_grp5      -7.560e-05  4.279e-06 -17.670  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.075e-04  4.875e-06 -22.048  < 2e-16 ***
policyTRUE:curr_pts_grp7      -5.777e-05  7.712e-06  -7.491 6.81e-14 ***
policyTRUE:curr_pts_grp8      -1.305e-04  7.295e-06 -17.894  < 2e-16 ***
policyTRUE:curr_pts_grp9      -5.354e-05  8.132e-06  -6.584 4.57e-11 ***
policyTRUE:curr_pts_grp10     -3.951e-04  1.114e-05 -35.451  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -4.030e-04  6.342e-06 -63.548  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.044e-03  2.271e-05 -45.992  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.950e-03  4.871e-05 -40.040  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02265 on 5646904624 degrees of freedom
Multiple R-squared:  0.0004562,	Adjusted R-squared:  0.0004562
F-statistic: 5.483e+04 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```



### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.401e-06  2.251e-06   0.622 0.533674    
age_grp16-19                   4.560e-05  2.371e-06  19.230  < 2e-16 ***
age_grp20-24                   2.695e-05  2.296e-06  11.739  < 2e-16 ***
age_grp25-34                   2.506e-05  2.269e-06  11.044  < 2e-16 ***
age_grp35-44                   2.466e-05  2.266e-06  10.884  < 2e-16 ***
age_grp45-54                   2.218e-05  2.265e-06   9.791  < 2e-16 ***
age_grp55-64                   1.771e-05  2.270e-06   7.805 5.97e-15 ***
age_grp65-74                   1.043e-05  2.285e-06   4.565 5.00e-06 ***
age_grp75-84                   5.306e-06  2.326e-06   2.281 0.022559 *  
age_grp85-89                   1.292e-06  2.872e-06   0.450 0.652864    
age_grp90-199                 -1.682e-06  4.860e-06  -0.346 0.729291    
policyTRUE                     2.540e-06  3.324e-06   0.764 0.444756    
curr_pts_grp1                  1.071e-04  1.132e-06  94.575  < 2e-16 ***
curr_pts_grp2                  4.734e-05  5.263e-07  89.950  < 2e-16 ***
curr_pts_grp3                  3.644e-05  4.538e-07  80.297  < 2e-16 ***
curr_pts_grp4                  1.008e-04  1.162e-06  86.712  < 2e-16 ***
curr_pts_grp5                  7.743e-05  8.702e-07  88.977  < 2e-16 ***
curr_pts_grp6                  7.804e-05  9.842e-07  79.299  < 2e-16 ***
curr_pts_grp7                  1.297e-04  1.596e-06  81.296  < 2e-16 ***
curr_pts_grp8                  1.237e-04  1.496e-06  82.691  < 2e-16 ***
curr_pts_grp9                  1.123e-04  1.650e-06  68.030  < 2e-16 ***
curr_pts_grp10                 1.809e-04  2.407e-06  75.152  < 2e-16 ***
curr_pts_grp11-20              2.003e-04  1.347e-06 148.734  < 2e-16 ***
curr_pts_grp21-30              2.529e-04  5.113e-06  49.473  < 2e-16 ***
curr_pts_grp30-150             2.667e-04  1.145e-05  23.292  < 2e-16 ***
age_grp16-19:policyTRUE        1.488e-06  3.487e-06   0.427 0.669579    
age_grp20-24:policyTRUE       -4.721e-06  3.388e-06  -1.393 0.163550    
age_grp25-34:policyTRUE       -1.230e-06  3.350e-06  -0.367 0.713405    
age_grp35-44:policyTRUE        1.587e-06  3.346e-06   0.474 0.635403    
age_grp45-54:policyTRUE        2.510e-06  3.344e-06   0.751 0.452878    
age_grp55-64:policyTRUE        2.358e-06  3.350e-06   0.704 0.481464    
age_grp65-74:policyTRUE        2.667e-06  3.371e-06   0.791 0.428863    
age_grp75-84:policyTRUE        2.053e-06  3.426e-06   0.599 0.548993    
age_grp85-89:policyTRUE        1.292e-06  4.134e-06   0.313 0.754542    
age_grp90-199:policyTRUE       3.340e-06  6.814e-06   0.490 0.624032    
policyTRUE:curr_pts_grp1      -9.093e-06  1.590e-06  -5.721 1.06e-08 ***
policyTRUE:curr_pts_grp2       4.331e-06  7.266e-07   5.961 2.51e-09 ***
policyTRUE:curr_pts_grp3       8.534e-06  6.558e-07  13.013  < 2e-16 ***
policyTRUE:curr_pts_grp4       3.846e-06  1.565e-06   2.458 0.013990 *  
policyTRUE:curr_pts_grp5       1.156e-05  1.212e-06   9.537  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.496e-05  1.380e-06  10.839  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.501e-05  2.184e-06   6.872 6.32e-12 ***
policyTRUE:curr_pts_grp8       8.847e-06  2.066e-06   4.282 1.85e-05 ***
policyTRUE:curr_pts_grp9       2.375e-05  2.303e-06  10.313  < 2e-16 ***
policyTRUE:curr_pts_grp10     -1.122e-05  3.156e-06  -3.555 0.000378 ***
policyTRUE:curr_pts_grp11-20   2.315e-06  1.796e-06   1.289 0.197423    
policyTRUE:curr_pts_grp21-30  -5.284e-05  6.431e-06  -8.217  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.255e-05  1.379e-05  -5.259 1.45e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006415 on 5646904624 degrees of freedom
Multiple R-squared:  3.576e-05,	Adjusted R-squared:  3.575e-05
F-statistic:  4296 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -7.050e-06  4.982e-06  -1.415  0.15701    
age_grp16-19                   1.747e-04  5.248e-06  33.288  < 2e-16 ***
age_grp20-24                   1.667e-04  5.081e-06  32.799  < 2e-16 ***
age_grp25-34                   1.523e-04  5.022e-06  30.326  < 2e-16 ***
age_grp35-44                   1.435e-04  5.015e-06  28.605  < 2e-16 ***
age_grp45-54                   1.333e-04  5.013e-06  26.583  < 2e-16 ***
age_grp55-64                   1.108e-04  5.024e-06  22.057  < 2e-16 ***
age_grp65-74                   7.666e-05  5.058e-06  15.156  < 2e-16 ***
age_grp75-84                   4.807e-05  5.148e-06   9.337  < 2e-16 ***
age_grp85-89                   3.306e-05  6.356e-06   5.201 1.99e-07 ***
age_grp90-199                  1.563e-05  1.076e-05   1.453  0.14618    
policyTRUE                     9.573e-07  7.357e-06   0.130  0.89647    
curr_pts_grp1                  2.231e-04  2.506e-06  89.046  < 2e-16 ***
curr_pts_grp2                  2.519e-04  1.165e-06 216.291  < 2e-16 ***
curr_pts_grp3                  2.336e-04  1.005e-06 232.532  < 2e-16 ***
curr_pts_grp4                  4.227e-04  2.572e-06 164.379  < 2e-16 ***
curr_pts_grp5                  4.424e-04  1.926e-06 229.713  < 2e-16 ***
curr_pts_grp6                  4.482e-04  2.178e-06 205.787  < 2e-16 ***
curr_pts_grp7                  5.874e-04  3.532e-06 166.310  < 2e-16 ***
curr_pts_grp8                  6.052e-04  3.312e-06 182.741  < 2e-16 ***
curr_pts_grp9                  5.310e-04  3.652e-06 145.400  < 2e-16 ***
curr_pts_grp10                 7.095e-04  5.327e-06 133.185  < 2e-16 ***
curr_pts_grp11-20              7.463e-04  2.981e-06 250.382  < 2e-16 ***
curr_pts_grp21-30              9.518e-04  1.132e-05  84.116  < 2e-16 ***
curr_pts_grp30-150             1.075e-03  2.534e-05  42.430  < 2e-16 ***
age_grp16-19:policyTRUE        1.589e-05  7.717e-06   2.059  0.03952 *  
age_grp20-24:policyTRUE        8.763e-06  7.499e-06   1.168  0.24263    
age_grp25-34:policyTRUE       -3.115e-07  7.414e-06  -0.042  0.96648    
age_grp35-44:policyTRUE        2.829e-06  7.406e-06   0.382  0.70252    
age_grp45-54:policyTRUE        4.253e-06  7.401e-06   0.575  0.56553    
age_grp55-64:policyTRUE        3.293e-06  7.414e-06   0.444  0.65699    
age_grp65-74:policyTRUE        6.398e-06  7.460e-06   0.858  0.39111    
age_grp75-84:policyTRUE        8.446e-07  7.583e-06   0.111  0.91131    
age_grp85-89:policyTRUE       -2.937e-06  9.150e-06  -0.321  0.74820    
age_grp90-199:policyTRUE       5.885e-06  1.508e-05   0.390  0.69637    
policyTRUE:curr_pts_grp1      -5.069e-07  3.518e-06  -0.144  0.88543    
policyTRUE:curr_pts_grp2       5.039e-06  1.608e-06   3.133  0.00173 **
policyTRUE:curr_pts_grp3       8.687e-06  1.451e-06   5.985 2.16e-09 ***
policyTRUE:curr_pts_grp4       1.665e-05  3.464e-06   4.806 1.54e-06 ***
policyTRUE:curr_pts_grp5       1.568e-05  2.682e-06   5.849 4.95e-09 ***
policyTRUE:curr_pts_grp6       1.968e-05  3.055e-06   6.440 1.19e-10 ***
policyTRUE:curr_pts_grp7       3.318e-05  4.834e-06   6.864 6.71e-12 ***
policyTRUE:curr_pts_grp8       2.016e-05  4.572e-06   4.408 1.04e-05 ***
policyTRUE:curr_pts_grp9       4.027e-05  5.097e-06   7.901 2.77e-15 ***
policyTRUE:curr_pts_grp10     -7.767e-05  6.985e-06 -11.119  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -7.346e-05  3.975e-06 -18.480  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.128e-04  1.423e-05  -7.922 2.33e-15 ***
policyTRUE:curr_pts_grp30-150 -3.081e-04  3.053e-05 -10.093  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0142 on 5646904624 degrees of freedom
Multiple R-squared:  0.0001409,	Adjusted R-squared:  0.0001409
F-statistic: 1.693e+04 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    7.783e-05  5.499e-06  14.153  < 2e-16 ***
age_grp16-19                   2.653e-04  5.793e-06  45.794  < 2e-16 ***
age_grp20-24                   2.310e-04  5.609e-06  41.190  < 2e-16 ***
age_grp25-34                   1.312e-04  5.543e-06  23.666  < 2e-16 ***
age_grp35-44                   8.639e-05  5.537e-06  15.603  < 2e-16 ***
age_grp45-54                   5.673e-05  5.534e-06  10.252  < 2e-16 ***
age_grp55-64                   2.775e-05  5.545e-06   5.005 5.58e-07 ***
age_grp65-74                  -6.141e-07  5.583e-06  -0.110 0.912420    
age_grp75-84                  -1.966e-05  5.683e-06  -3.459 0.000543 ***
age_grp85-89                  -2.744e-05  7.016e-06  -3.911 9.18e-05 ***
age_grp90-199                 -2.414e-05  1.187e-05  -2.033 0.042052 *  
policyTRUE                     1.411e-05  8.121e-06   1.737 0.082411 .  
curr_pts_grp1                  2.035e-04  2.766e-06  73.553  < 2e-16 ***
curr_pts_grp2                  2.711e-04  1.286e-06 210.834  < 2e-16 ***
curr_pts_grp3                  3.626e-04  1.109e-06 326.988  < 2e-16 ***
curr_pts_grp4                  4.799e-04  2.839e-06 169.052  < 2e-16 ***
curr_pts_grp5                  6.124e-04  2.126e-06 288.053  < 2e-16 ***
curr_pts_grp6                  7.626e-04  2.405e-06 317.162  < 2e-16 ***
curr_pts_grp7                  7.870e-04  3.899e-06 201.852  < 2e-16 ***
curr_pts_grp8                  9.396e-04  3.656e-06 257.034  < 2e-16 ***
curr_pts_grp9                  8.882e-04  4.032e-06 220.312  < 2e-16 ***
curr_pts_grp10                 1.057e-03  5.881e-06 179.757  < 2e-16 ***
curr_pts_grp11-20              1.272e-03  3.290e-06 386.504  < 2e-16 ***
curr_pts_grp21-30              2.283e-03  1.249e-05 182.733  < 2e-16 ***
curr_pts_grp30-150             3.456e-03  2.797e-05 123.564  < 2e-16 ***
age_grp16-19:policyTRUE       -5.347e-05  8.519e-06  -6.276 3.47e-10 ***
age_grp20-24:policyTRUE       -5.943e-05  8.279e-06  -7.179 7.04e-13 ***
age_grp25-34:policyTRUE       -5.512e-05  8.184e-06  -6.735 1.64e-11 ***
age_grp35-44:policyTRUE       -4.137e-05  8.176e-06  -5.060 4.19e-07 ***
age_grp45-54:policyTRUE       -3.780e-05  8.170e-06  -4.627 3.71e-06 ***
age_grp55-64:policyTRUE       -3.379e-05  8.185e-06  -4.128 3.65e-05 ***
age_grp65-74:policyTRUE       -2.376e-05  8.235e-06  -2.885 0.003915 **
age_grp75-84:policyTRUE       -1.915e-05  8.371e-06  -2.288 0.022135 *  
age_grp85-89:policyTRUE       -1.686e-05  1.010e-05  -1.669 0.095160 .  
age_grp90-199:policyTRUE      -2.605e-05  1.665e-05  -1.565 0.117624    
policyTRUE:curr_pts_grp1      -1.588e-05  3.884e-06  -4.089 4.33e-05 ***
policyTRUE:curr_pts_grp2      -4.282e-05  1.775e-06 -24.124  < 2e-16 ***
policyTRUE:curr_pts_grp3      -5.337e-05  1.602e-06 -33.309  < 2e-16 ***
policyTRUE:curr_pts_grp4      -5.135e-05  3.824e-06 -13.429  < 2e-16 ***
policyTRUE:curr_pts_grp5      -8.225e-05  2.960e-06 -27.783  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.223e-04  3.373e-06 -36.259  < 2e-16 ***
policyTRUE:curr_pts_grp7      -7.485e-05  5.336e-06 -14.028  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.272e-04  5.048e-06 -25.200  < 2e-16 ***
policyTRUE:curr_pts_grp9      -9.029e-05  5.626e-06 -16.049  < 2e-16 ***
policyTRUE:curr_pts_grp10     -2.516e-04  7.710e-06 -32.635  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -2.655e-04  4.388e-06 -60.509  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -6.576e-04  1.571e-05 -41.853  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.188e-03  3.370e-05 -35.254  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01567 on 5646904624 degrees of freedom
Multiple R-squared:  0.0002449,	Adjusted R-squared:  0.0002448
F-statistic: 2.943e+04 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


This will be revisited with the 6-point violations below.


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.535e-05  8.375e-07  18.328  < 2e-16 ***
age_grp16-19                   5.028e-05  8.823e-07  56.984  < 2e-16 ***
age_grp20-24                   2.154e-06  8.542e-07   2.522 0.011676 *  
age_grp25-34                  -1.157e-05  8.442e-07 -13.703  < 2e-16 ***
age_grp35-44                  -1.457e-05  8.432e-07 -17.286  < 2e-16 ***
age_grp45-54                  -1.532e-05  8.427e-07 -18.179  < 2e-16 ***
age_grp55-64                  -1.537e-05  8.445e-07 -18.206  < 2e-16 ***
age_grp65-74                  -1.530e-05  8.503e-07 -17.991  < 2e-16 ***
age_grp75-84                  -1.504e-05  8.655e-07 -17.380  < 2e-16 ***
age_grp85-89                  -1.512e-05  1.069e-06 -14.148  < 2e-16 ***
age_grp90-199                 -1.523e-05  1.808e-06  -8.423  < 2e-16 ***
policyTRUE                    -3.410e-06  1.237e-06  -2.757 0.005831 **
curr_pts_grp1                  1.242e-06  4.212e-07   2.948 0.003197 **
curr_pts_grp2                  1.456e-06  1.958e-07   7.435 1.04e-13 ***
curr_pts_grp3                  4.711e-06  1.689e-07  27.900  < 2e-16 ***
curr_pts_grp4                  2.506e-05  4.323e-07  57.956  < 2e-16 ***
curr_pts_grp5                  5.491e-06  3.238e-07  16.957  < 2e-16 ***
curr_pts_grp6                  1.124e-05  3.662e-07  30.691  < 2e-16 ***
curr_pts_grp7                  2.651e-05  5.937e-07  44.641  < 2e-16 ***
curr_pts_grp8                  2.164e-05  5.567e-07  38.871  < 2e-16 ***
curr_pts_grp9                  1.902e-05  6.140e-07  30.978  < 2e-16 ***
curr_pts_grp10                 3.149e-05  8.956e-07  35.166  < 2e-16 ***
curr_pts_grp11-20              5.156e-05  5.011e-07 102.909  < 2e-16 ***
curr_pts_grp21-30              1.523e-04  1.902e-06  80.050  < 2e-16 ***
curr_pts_grp30-150             2.958e-04  4.260e-06  69.441  < 2e-16 ***
age_grp16-19:policyTRUE        4.032e-07  1.297e-06   0.311 0.755978    
age_grp20-24:policyTRUE        3.158e-06  1.261e-06   2.505 0.012261 *  
age_grp25-34:policyTRUE        3.438e-06  1.246e-06   2.759 0.005802 **
age_grp35-44:policyTRUE        3.415e-06  1.245e-06   2.742 0.006098 **
age_grp45-54:policyTRUE        3.364e-06  1.244e-06   2.704 0.006853 **
age_grp55-64:policyTRUE        3.273e-06  1.247e-06   2.626 0.008642 **
age_grp65-74:policyTRUE        3.262e-06  1.254e-06   2.601 0.009300 **
age_grp75-84:policyTRUE        3.276e-06  1.275e-06   2.570 0.010169 *  
age_grp85-89:policyTRUE        3.638e-06  1.538e-06   2.365 0.018029 *  
age_grp90-199:policyTRUE       2.930e-06  2.535e-06   1.156 0.247782    
policyTRUE:curr_pts_grp1      -6.169e-07  5.914e-07  -1.043 0.296916    
policyTRUE:curr_pts_grp2      -3.918e-07  2.703e-07  -1.449 0.147282    
policyTRUE:curr_pts_grp3      -9.257e-07  2.440e-07  -3.794 0.000148 ***
policyTRUE:curr_pts_grp4      -5.680e-06  5.823e-07  -9.754  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.121e-06  4.508e-07  -2.487 0.012872 *  
policyTRUE:curr_pts_grp6      -1.477e-06  5.137e-07  -2.875 0.004040 **
policyTRUE:curr_pts_grp7      -5.739e-06  8.126e-07  -7.063 1.63e-12 ***
policyTRUE:curr_pts_grp8      -2.099e-06  7.687e-07  -2.731 0.006310 **
policyTRUE:curr_pts_grp9      -3.731e-06  8.568e-07  -4.354 1.34e-05 ***
policyTRUE:curr_pts_grp10     -1.190e-05  1.174e-06 -10.133  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.522e-05  6.682e-07 -22.773  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -4.504e-05  2.393e-06 -18.823  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.085e-04  5.133e-06 -21.130  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002387 on 5646904624 degrees of freedom
Multiple R-squared:  3.329e-05,	Adjusted R-squared:  3.329e-05
F-statistic:  4000 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```

Note that there are no changes to the penalties for these offences and the swapping out of the 3-point speeding 40-45 over in a 100km/hr zone, which was changed to 6 points, is not a possibility, since the driver can only be awarded points for a single speeding infraction.


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.


```R
Estimate Std. Error  t value Pr(>|t|)    
(Intercept)                   -2.429e-06  1.118e-06   -2.173 0.029777 *  
age_grp16-19                   4.398e-05  1.178e-06   37.348  < 2e-16 ***
age_grp20-24                   3.676e-05  1.140e-06   32.239  < 2e-16 ***
age_grp25-34                   1.812e-05  1.127e-06   16.083  < 2e-16 ***
age_grp35-44                   8.354e-06  1.126e-06    7.422 1.15e-13 ***
age_grp45-54                   5.131e-06  1.125e-06    4.561 5.10e-06 ***
age_grp55-64                   2.873e-06  1.127e-06    2.548 0.010825 *  
age_grp65-74                   1.786e-06  1.135e-06    1.574 0.115588    
age_grp75-84                   1.448e-06  1.155e-06    1.253 0.210027    
age_grp85-89                   1.900e-06  1.426e-06    1.332 0.182789    
age_grp90-199                  2.257e-06  2.414e-06    0.935 0.349669    
policyTRUE                     1.549e-06  1.651e-06    0.938 0.348090    
curr_pts_grp1                  1.177e-05  5.623e-07   20.926  < 2e-16 ***
curr_pts_grp2                  1.542e-05  2.614e-07   58.991  < 2e-16 ***
curr_pts_grp3                  2.240e-05  2.254e-07   99.392  < 2e-16 ***
curr_pts_grp4                  3.324e-05  5.771e-07   57.596  < 2e-16 ***
curr_pts_grp5                  4.502e-05  4.322e-07  104.155  < 2e-16 ***
curr_pts_grp6                  5.174e-05  4.888e-07  105.856  < 2e-16 ***
curr_pts_grp7                  6.155e-05  7.926e-07   77.665  < 2e-16 ***
curr_pts_grp8                  7.689e-05  7.431e-07  103.468  < 2e-16 ***
curr_pts_grp9                  7.089e-05  8.196e-07   86.496  < 2e-16 ***
curr_pts_grp10                 9.093e-05  1.195e-06   76.064  < 2e-16 ***
curr_pts_grp11-20              1.292e-04  6.688e-07  193.095  < 2e-16 ***
curr_pts_grp21-30              3.256e-04  2.539e-06  128.247  < 2e-16 ***
curr_pts_grp30-150             4.441e-04  5.686e-06   78.104  < 2e-16 ***
age_grp16-19:policyTRUE       -3.028e-05  1.732e-06  -17.487  < 2e-16 ***
age_grp20-24:policyTRUE       -2.524e-05  1.683e-06  -15.000  < 2e-16 ***
age_grp25-34:policyTRUE       -1.266e-05  1.664e-06   -7.612 2.71e-14 ***
age_grp35-44:policyTRUE       -5.878e-06  1.662e-06   -3.537 0.000405 ***
age_grp45-54:policyTRUE       -3.669e-06  1.661e-06   -2.209 0.027145 *  
age_grp55-64:policyTRUE       -2.099e-06  1.664e-06   -1.261 0.207155    
age_grp65-74:policyTRUE       -1.230e-06  1.674e-06   -0.735 0.462643    
age_grp75-84:policyTRUE       -1.005e-06  1.702e-06   -0.591 0.554590    
age_grp85-89:policyTRUE       -1.464e-06  2.053e-06   -0.713 0.475927    
age_grp90-199:policyTRUE      -1.930e-06  3.384e-06   -0.570 0.568506    
policyTRUE:curr_pts_grp1      -8.551e-06  7.895e-07  -10.831  < 2e-16 ***
policyTRUE:curr_pts_grp2      -1.118e-05  3.609e-07  -30.983  < 2e-16 ***
policyTRUE:curr_pts_grp3      -1.631e-05  3.257e-07  -50.071  < 2e-16 ***
policyTRUE:curr_pts_grp4      -2.468e-05  7.773e-07  -31.750  < 2e-16 ***
policyTRUE:curr_pts_grp5      -3.310e-05  6.018e-07  -55.011  < 2e-16 ***
policyTRUE:curr_pts_grp6      -3.730e-05  6.857e-07  -54.406  < 2e-16 ***
policyTRUE:curr_pts_grp7      -4.358e-05  1.085e-06  -40.183  < 2e-16 ***
policyTRUE:curr_pts_grp8      -5.671e-05  1.026e-06  -55.273  < 2e-16 ***
policyTRUE:curr_pts_grp9      -5.253e-05  1.144e-06  -45.927  < 2e-16 ***
policyTRUE:curr_pts_grp10     -6.946e-05  1.567e-06  -44.315  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -9.616e-05  8.920e-07 -107.803  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.600e-04  3.194e-06  -81.422  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -3.321e-04  6.851e-06  -48.467  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003186 on 5646904624 degrees of freedom
Multiple R-squared:  3.558e-05,	Adjusted R-squared:  3.557e-05
F-statistic:  4275 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```

Notice the sharp drop as several of the offences are moved to 10 points.
Repeat the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.430e-06  1.236e-06  -1.966   0.0493 *  
age_grp16-19                   4.402e-05  1.302e-06  33.806  < 2e-16 ***
age_grp20-24                   3.677e-05  1.261e-06  29.168  < 2e-16 ***
age_grp25-34                   1.813e-05  1.246e-06  14.549  < 2e-16 ***
age_grp35-44                   8.354e-06  1.244e-06   6.714 1.89e-11 ***
age_grp45-54                   5.135e-06  1.244e-06   4.129 3.64e-05 ***
age_grp55-64                   2.872e-06  1.246e-06   2.304   0.0212 *  
age_grp65-74                   1.786e-06  1.255e-06   1.423   0.1547    
age_grp75-84                   1.448e-06  1.277e-06   1.134   0.2568    
age_grp85-89                   1.900e-06  1.577e-06   1.205   0.2282    
age_grp90-199                  2.258e-06  2.669e-06   0.846   0.3975    
policyTRUE                     8.320e-07  1.825e-06   0.456   0.6485    
curr_pts_grp1                  1.176e-05  6.217e-07  18.922  < 2e-16 ***
curr_pts_grp2                  1.542e-05  2.890e-07  53.345  < 2e-16 ***
curr_pts_grp3                  2.241e-05  2.492e-07  89.919  < 2e-16 ***
curr_pts_grp4                  3.323e-05  6.380e-07  52.087  < 2e-16 ***
curr_pts_grp5                  4.507e-05  4.778e-07  94.310  < 2e-16 ***
curr_pts_grp6                  5.176e-05  5.404e-07  95.779  < 2e-16 ***
curr_pts_grp7                  6.161e-05  8.763e-07  70.310  < 2e-16 ***
curr_pts_grp8                  7.689e-05  8.216e-07  93.579  < 2e-16 ***
curr_pts_grp9                  7.095e-05  9.061e-07  78.301  < 2e-16 ***
curr_pts_grp10                 9.092e-05  1.322e-06  68.794  < 2e-16 ***
curr_pts_grp11-20              1.293e-04  7.395e-07 174.817  < 2e-16 ***
curr_pts_grp21-30              3.263e-04  2.807e-06 116.219  < 2e-16 ***
curr_pts_grp30-150             4.441e-04  6.287e-06  70.641  < 2e-16 ***
age_grp16-19:policyTRUE       -1.029e-05  1.915e-06  -5.373 7.73e-08 ***
age_grp20-24:policyTRUE       -1.313e-05  1.861e-06  -7.058 1.69e-12 ***
age_grp25-34:policyTRUE       -7.600e-06  1.839e-06  -4.132 3.60e-05 ***
age_grp35-44:policyTRUE       -3.633e-06  1.837e-06  -1.977   0.0480 *  
age_grp45-54:policyTRUE       -2.621e-06  1.836e-06  -1.427   0.1535    
age_grp55-64:policyTRUE       -1.380e-06  1.839e-06  -0.750   0.4532    
age_grp65-74:policyTRUE       -8.578e-07  1.851e-06  -0.463   0.6430    
age_grp75-84:policyTRUE       -5.670e-07  1.881e-06  -0.301   0.7631    
age_grp85-89:policyTRUE       -1.089e-06  2.270e-06  -0.480   0.6314    
age_grp90-199:policyTRUE      -1.332e-06  3.742e-06  -0.356   0.7219    
policyTRUE:curr_pts_grp1      -5.389e-06  8.729e-07  -6.175 6.64e-10 ***
policyTRUE:curr_pts_grp2      -7.413e-06  3.990e-07 -18.581  < 2e-16 ***
policyTRUE:curr_pts_grp3      -1.047e-05  3.601e-07 -29.061  < 2e-16 ***
policyTRUE:curr_pts_grp4      -1.571e-05  8.594e-07 -18.283  < 2e-16 ***
policyTRUE:curr_pts_grp5      -2.376e-05  6.653e-07 -35.714  < 2e-16 ***
policyTRUE:curr_pts_grp6      -2.412e-05  7.581e-07 -31.823  < 2e-16 ***
policyTRUE:curr_pts_grp7      -2.795e-05  1.199e-06 -23.306  < 2e-16 ***
policyTRUE:curr_pts_grp8      -3.953e-05  1.134e-06 -34.849  < 2e-16 ***
policyTRUE:curr_pts_grp9      -3.360e-05  1.264e-06 -26.573  < 2e-16 ***
policyTRUE:curr_pts_grp10     -4.472e-05  1.733e-06 -25.805  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -5.569e-05  9.862e-07 -56.473  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -1.635e-04  3.531e-06 -46.297  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.592e-04  7.575e-06 -21.011  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003522 on 5646904624 degrees of freedom
Multiple R-squared:  3.513e-05,	Adjusted R-squared:  3.512e-05
F-statistic:  4221 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```



### Six-point violations (combinations)

The only offence that merits precisely 6 demerit points is speeding 40-45 over in a 100+ zone, only after the policy change.
Other than that, a driver can only get 6 points for a combination of 1-5 point offences.
Among these, the above offence (40-45 over in a 100+ zone) can be one of two 3-point offences that add to 6 points.

Since the 6 point combination with multiple tickets is rare, the former 3 point violation (fairly common) dominates in the post-policy change period.


The regression with only 6 points as the event is as follows.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    9.256e-08  5.227e-07   0.177  0.85945    
age_grp16-19                   1.772e-06  5.507e-07   3.217  0.00129 **
age_grp20-24                   8.426e-07  5.331e-07   1.580  0.11401    
age_grp25-34                  -2.477e-08  5.269e-07  -0.047  0.96250    
age_grp35-44                  -1.409e-07  5.262e-07  -0.268  0.78889    
age_grp45-54                  -1.549e-07  5.260e-07  -0.294  0.76841    
age_grp55-64                  -1.467e-07  5.271e-07  -0.278  0.78070    
age_grp65-74                  -1.268e-07  5.307e-07  -0.239  0.81122    
age_grp75-84                  -1.176e-07  5.402e-07  -0.218  0.82759    
age_grp85-89                  -1.114e-07  6.669e-07  -0.167  0.86737    
age_grp90-199                 -1.081e-07  1.129e-06  -0.096  0.92371    
policyTRUE                    -2.099e-07  7.719e-07  -0.272  0.78564    
curr_pts_grp1                  1.876e-07  2.629e-07   0.714  0.47542    
curr_pts_grp2                  2.064e-07  1.222e-07   1.689  0.09124 .  
curr_pts_grp3                  1.447e-07  1.054e-07   1.373  0.16986    
curr_pts_grp4                  6.767e-07  2.698e-07   2.508  0.01215 *  
curr_pts_grp5                  5.686e-07  2.021e-07   2.813  0.00490 **
curr_pts_grp6                  7.885e-07  2.285e-07   3.450  0.00056 ***
curr_pts_grp7                  1.560e-06  3.706e-07   4.210 2.56e-05 ***
curr_pts_grp8                  1.047e-06  3.475e-07   3.012  0.00259 **
curr_pts_grp9                  4.605e-07  3.832e-07   1.202  0.22955    
curr_pts_grp10                 1.091e-06  5.589e-07   1.953  0.05086 .  
curr_pts_grp11-20              2.666e-06  3.127e-07   8.524  < 2e-16 ***
curr_pts_grp21-30              8.349e-06  1.187e-06   7.032 2.04e-12 ***
curr_pts_grp30-150             1.213e-05  2.659e-06   4.563 5.03e-06 ***
age_grp16-19:policyTRUE        1.086e-05  8.097e-07  13.412  < 2e-16 ***
age_grp20-24:policyTRUE        6.789e-06  7.869e-07   8.627  < 2e-16 ***
age_grp25-34:policyTRUE        3.382e-06  7.779e-07   4.348 1.38e-05 ***
age_grp35-44:policyTRUE        2.064e-06  7.771e-07   2.656  0.00791 **
age_grp45-54:policyTRUE        1.700e-06  7.766e-07   2.189  0.02861 *  
age_grp55-64:policyTRUE        1.018e-06  7.780e-07   1.308  0.19073    
age_grp65-74:policyTRUE        3.878e-07  7.828e-07   0.495  0.62029    
age_grp75-84:policyTRUE        2.971e-07  7.956e-07   0.373  0.70882    
age_grp85-89:policyTRUE        2.943e-07  9.600e-07   0.307  0.75919    
age_grp90-199:policyTRUE       1.038e-07  1.582e-06   0.066  0.94770    
policyTRUE:curr_pts_grp1       3.498e-06  3.691e-07   9.476  < 2e-16 ***
policyTRUE:curr_pts_grp2       3.915e-06  1.687e-07  23.204  < 2e-16 ***
policyTRUE:curr_pts_grp3       5.724e-06  1.523e-07  37.586  < 2e-16 ***
policyTRUE:curr_pts_grp4       7.837e-06  3.634e-07  21.563  < 2e-16 ***
policyTRUE:curr_pts_grp5       1.076e-05  2.814e-07  38.228  < 2e-16 ***
policyTRUE:curr_pts_grp6       1.262e-05  3.206e-07  39.351  < 2e-16 ***
policyTRUE:curr_pts_grp7       1.364e-05  5.071e-07  26.902  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.788e-05  4.798e-07  37.263  < 2e-16 ***
policyTRUE:curr_pts_grp9       1.754e-05  5.348e-07  32.793  < 2e-16 ***
policyTRUE:curr_pts_grp10      1.797e-05  7.329e-07  24.519  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   2.749e-05  4.171e-07  65.911  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   4.943e-05  1.493e-06  33.103  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  7.994e-05  3.204e-06  24.954  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00149 on 5646904624 degrees of freedom
Multiple R-squared:  1.063e-05,	Adjusted R-squared:  1.063e-05
F-statistic:  1278 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


Consider next the combined event with either 3 or 6 points at a single roadside stop.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    7.792e-05  5.524e-06  14.106  < 2e-16 ***
age_grp16-19                   2.671e-04  5.819e-06  45.893  < 2e-16 ***
age_grp20-24                   2.319e-04  5.634e-06  41.155  < 2e-16 ***
age_grp25-34                   1.312e-04  5.568e-06  23.556  < 2e-16 ***
age_grp35-44                   8.625e-05  5.561e-06  15.508  < 2e-16 ***
age_grp45-54                   5.658e-05  5.559e-06  10.179  < 2e-16 ***
age_grp55-64                   2.761e-05  5.570e-06   4.956 7.19e-07 ***
age_grp65-74                  -7.408e-07  5.608e-06  -0.132 0.894909    
age_grp75-84                  -1.977e-05  5.709e-06  -3.464 0.000533 ***
age_grp85-89                  -2.755e-05  7.048e-06  -3.909 9.25e-05 ***
age_grp90-199                 -2.425e-05  1.193e-05  -2.033 0.042057 *  
policyTRUE                     1.390e-05  8.158e-06   1.703 0.088504 .  
curr_pts_grp1                  2.036e-04  2.779e-06  73.291  < 2e-16 ***
curr_pts_grp2                  2.713e-04  1.292e-06 210.049  < 2e-16 ***
curr_pts_grp3                  3.627e-04  1.114e-06 325.652  < 2e-16 ***
curr_pts_grp4                  4.806e-04  2.852e-06 168.532  < 2e-16 ***
curr_pts_grp5                  6.130e-04  2.136e-06 287.028  < 2e-16 ***
curr_pts_grp6                  7.634e-04  2.415e-06 316.067  < 2e-16 ***
curr_pts_grp7                  7.885e-04  3.916e-06 201.346  < 2e-16 ***
curr_pts_grp8                  9.407e-04  3.672e-06 256.167  < 2e-16 ***
curr_pts_grp9                  8.887e-04  4.050e-06 219.439  < 2e-16 ***
curr_pts_grp10                 1.058e-03  5.907e-06 179.136  < 2e-16 ***
curr_pts_grp11-20              1.274e-03  3.305e-06 385.578  < 2e-16 ***
curr_pts_grp21-30              2.291e-03  1.255e-05 182.579  < 2e-16 ***
curr_pts_grp30-150             3.469e-03  2.810e-05 123.442  < 2e-16 ***
age_grp16-19:policyTRUE       -4.261e-05  8.558e-06  -4.979 6.39e-07 ***
age_grp20-24:policyTRUE       -5.264e-05  8.316e-06  -6.330 2.45e-10 ***
age_grp25-34:policyTRUE       -5.174e-05  8.221e-06  -6.293 3.11e-10 ***
age_grp35-44:policyTRUE       -3.931e-05  8.213e-06  -4.786 1.70e-06 ***
age_grp45-54:policyTRUE       -3.610e-05  8.207e-06  -4.399 1.09e-05 ***
age_grp55-64:policyTRUE       -3.277e-05  8.222e-06  -3.986 6.72e-05 ***
age_grp65-74:policyTRUE       -2.337e-05  8.272e-06  -2.825 0.004727 **
age_grp75-84:policyTRUE       -1.885e-05  8.408e-06  -2.242 0.024932 *  
age_grp85-89:policyTRUE       -1.656e-05  1.015e-05  -1.632 0.102617    
age_grp90-199:policyTRUE      -2.595e-05  1.672e-05  -1.552 0.120757    
policyTRUE:curr_pts_grp1      -1.238e-05  3.901e-06  -3.174 0.001502 **
policyTRUE:curr_pts_grp2      -3.891e-05  1.783e-06 -21.820  < 2e-16 ***
policyTRUE:curr_pts_grp3      -4.765e-05  1.610e-06 -29.603  < 2e-16 ***
policyTRUE:curr_pts_grp4      -4.351e-05  3.841e-06 -11.328  < 2e-16 ***
policyTRUE:curr_pts_grp5      -7.149e-05  2.974e-06 -24.041  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.097e-04  3.388e-06 -32.373  < 2e-16 ***
policyTRUE:curr_pts_grp7      -6.120e-05  5.360e-06 -11.420  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.093e-04  5.070e-06 -21.561  < 2e-16 ***
policyTRUE:curr_pts_grp9      -7.276e-05  5.651e-06 -12.874  < 2e-16 ***
policyTRUE:curr_pts_grp10     -2.337e-04  7.745e-06 -30.168  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -2.380e-04  4.408e-06 -54.001  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -6.081e-04  1.578e-05 -38.533  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.108e-03  3.386e-05 -32.734  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01574 on 5646904624 degrees of freedom
Multiple R-squared:  0.0002484,	Adjusted R-squared:  0.0002484
F-statistic: 2.986e+04 on 47 and 5646904624 DF,  p-value: < 2.2e-16
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
(Intercept)                   -3.798e-07  5.133e-07  -0.740   0.4593    
age_grp16-19                   1.403e-05  5.407e-07  25.955  < 2e-16 ***
age_grp20-24                   8.898e-06  5.235e-07  16.997  < 2e-16 ***
age_grp25-34                   3.310e-06  5.174e-07   6.399 1.57e-10 ***
age_grp35-44                   6.562e-07  5.167e-07   1.270   0.2041    
age_grp45-54                   8.869e-08  5.165e-07   0.172   0.8637    
age_grp55-64                  -1.065e-07  5.176e-07  -0.206   0.8369    
age_grp65-74                   7.591e-09  5.211e-07   0.015   0.9884    
age_grp75-84                   4.380e-08  5.305e-07   0.083   0.9342    
age_grp85-89                   1.559e-07  6.549e-07   0.238   0.8119    
age_grp90-199                  1.179e-07  1.108e-06   0.106   0.9153    
policyTRUE                     1.333e-07  7.580e-07   0.176   0.8604    
curr_pts_grp1                  1.768e-06  2.582e-07   6.847 7.54e-12 ***
curr_pts_grp2                  1.885e-06  1.200e-07  15.708  < 2e-16 ***
curr_pts_grp3                  3.851e-06  1.035e-07  37.207  < 2e-16 ***
curr_pts_grp4                  5.339e-06  2.650e-07  20.149  < 2e-16 ***
curr_pts_grp5                  7.415e-06  1.984e-07  37.366  < 2e-16 ***
curr_pts_grp6                  9.833e-06  2.244e-07  43.814  < 2e-16 ***
curr_pts_grp7                  1.434e-05  3.639e-07  39.419  < 2e-16 ***
curr_pts_grp8                  1.307e-05  3.412e-07  38.308  < 2e-16 ***
curr_pts_grp9                  1.190e-05  3.763e-07  31.633  < 2e-16 ***
curr_pts_grp10                 2.075e-05  5.489e-07  37.810  < 2e-16 ***
curr_pts_grp11-20              3.391e-05  3.071e-07 110.431  < 2e-16 ***
curr_pts_grp21-30              9.167e-05  1.166e-06  78.627  < 2e-16 ***
curr_pts_grp30-150             2.202e-04  2.611e-06  84.347  < 2e-16 ***
age_grp16-19:policyTRUE       -5.100e-06  7.951e-07  -6.414 1.42e-10 ***
age_grp20-24:policyTRUE       -3.303e-06  7.727e-07  -4.274 1.92e-05 ***
age_grp25-34:policyTRUE       -1.706e-06  7.638e-07  -2.233   0.0255 *  
age_grp35-44:policyTRUE       -2.604e-07  7.631e-07  -0.341   0.7329    
age_grp45-54:policyTRUE       -2.665e-08  7.625e-07  -0.035   0.9721    
age_grp55-64:policyTRUE        1.036e-07  7.639e-07   0.136   0.8922    
age_grp65-74:policyTRUE       -2.452e-08  7.686e-07  -0.032   0.9745    
age_grp75-84:policyTRUE        5.832e-09  7.813e-07   0.007   0.9940    
age_grp85-89:policyTRUE       -6.351e-08  9.427e-07  -0.067   0.9463    
age_grp90-199:policyTRUE      -2.008e-08  1.554e-06  -0.013   0.9897    
policyTRUE:curr_pts_grp1      -7.767e-07  3.625e-07  -2.143   0.0321 *  
policyTRUE:curr_pts_grp2      -8.925e-07  1.657e-07  -5.387 7.16e-08 ***
policyTRUE:curr_pts_grp3      -2.531e-06  1.495e-07 -16.926  < 2e-16 ***
policyTRUE:curr_pts_grp4      -2.883e-06  3.569e-07  -8.080 6.49e-16 ***
policyTRUE:curr_pts_grp5      -4.745e-06  2.763e-07 -17.172  < 2e-16 ***
policyTRUE:curr_pts_grp6      -5.878e-06  3.148e-07 -18.672  < 2e-16 ***
policyTRUE:curr_pts_grp7      -8.100e-06  4.980e-07 -16.264  < 2e-16 ***
policyTRUE:curr_pts_grp8      -6.308e-06  4.711e-07 -13.390  < 2e-16 ***
policyTRUE:curr_pts_grp9      -4.053e-06  5.251e-07  -7.719 1.17e-14 ***
policyTRUE:curr_pts_grp10     -1.250e-05  7.196e-07 -17.372  < 2e-16 ***
policyTRUE:curr_pts_grp11-20  -1.635e-05  4.096e-07 -39.929  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -3.658e-05  1.466e-06 -24.946  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -1.217e-04  3.146e-06 -38.676  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001463 on 5646904624 degrees of freedom
Multiple R-squared:  1.312e-05,	Adjusted R-squared:  1.311e-05
F-statistic:  1576 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


### Nine-point violations (speeding 81-100 over or combinations)

One offence that merits 9 demerit points is speeding 80-100 over, only before the policy change, after which it was changed to a 18-point offence.
Other than that, there 7 other violations that result in 9 demerit points, none of which were changed with the excessive speeding policy.

The combined 9- and 18-point event is analyzed in the following logistic regression:

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    4.677e-06  5.619e-07   8.325  < 2e-16 ***
age_grp16-19                   7.241e-06  5.919e-07  12.233  < 2e-16 ***
age_grp20-24                   1.390e-06  5.731e-07   2.426  0.01528 *  
age_grp25-34                  -2.435e-06  5.663e-07  -4.299 1.71e-05 ***
age_grp35-44                  -3.540e-06  5.657e-07  -6.259 3.87e-10 ***
age_grp45-54                  -3.769e-06  5.654e-07  -6.666 2.63e-11 ***
age_grp55-64                  -4.031e-06  5.666e-07  -7.115 1.12e-12 ***
age_grp65-74                  -3.796e-06  5.704e-07  -6.655 2.84e-11 ***
age_grp75-84                  -2.831e-06  5.806e-07  -4.876 1.08e-06 ***
age_grp85-89                  -1.337e-06  7.169e-07  -1.866  0.06210 .  
age_grp90-199                 -1.257e-06  1.213e-06  -1.036  0.30007    
policyTRUE                    -1.092e-06  8.297e-07  -1.316  0.18816    
curr_pts_grp1                  8.103e-07  2.826e-07   2.867  0.00414 **
curr_pts_grp2                  1.577e-06  1.314e-07  12.003  < 2e-16 ***
curr_pts_grp3                  2.842e-06  1.133e-07  25.089  < 2e-16 ***
curr_pts_grp4                  5.892e-06  2.900e-07  20.315  < 2e-16 ***
curr_pts_grp5                  4.572e-06  2.172e-07  21.049  < 2e-16 ***
curr_pts_grp6                  5.265e-06  2.457e-07  21.433  < 2e-16 ***
curr_pts_grp7                  8.476e-06  3.983e-07  21.278  < 2e-16 ***
curr_pts_grp8                  7.703e-06  3.735e-07  20.625  < 2e-16 ***
curr_pts_grp9                  1.061e-05  4.119e-07  25.770  < 2e-16 ***
curr_pts_grp10                 1.064e-05  6.008e-07  17.701  < 2e-16 ***
curr_pts_grp11-20              2.054e-05  3.362e-07  61.109  < 2e-16 ***
curr_pts_grp21-30              6.166e-05  1.276e-06  48.315  < 2e-16 ***
curr_pts_grp30-150             1.354e-04  2.858e-06  47.379  < 2e-16 ***
age_grp16-19:policyTRUE       -8.905e-07  8.704e-07  -1.023  0.30623    
age_grp20-24:policyTRUE        1.166e-07  8.458e-07   0.138  0.89034    
age_grp25-34:policyTRUE        5.778e-07  8.361e-07   0.691  0.48951    
age_grp35-44:policyTRUE        8.932e-07  8.353e-07   1.069  0.28495    
age_grp45-54:policyTRUE        8.320e-07  8.347e-07   0.997  0.31889    
age_grp55-64:policyTRUE        9.745e-07  8.362e-07   1.165  0.24385    
age_grp65-74:policyTRUE        9.909e-07  8.414e-07   1.178  0.23890    
age_grp75-84:policyTRUE        1.087e-06  8.552e-07   1.271  0.20381    
age_grp85-89:policyTRUE       -4.378e-07  1.032e-06  -0.424  0.67140    
age_grp90-199:policyTRUE       3.338e-07  1.701e-06   0.196  0.84442    
policyTRUE:curr_pts_grp1       1.076e-07  3.968e-07   0.271  0.78631    
policyTRUE:curr_pts_grp2      -3.506e-07  1.814e-07  -1.933  0.05320 .  
policyTRUE:curr_pts_grp3      -4.083e-07  1.637e-07  -2.494  0.01263 *  
policyTRUE:curr_pts_grp4      -1.581e-06  3.906e-07  -4.048 5.16e-05 ***
policyTRUE:curr_pts_grp5      -1.689e-06  3.024e-07  -5.585 2.34e-08 ***
policyTRUE:curr_pts_grp6      -9.004e-07  3.446e-07  -2.613  0.00898 **
policyTRUE:curr_pts_grp7      -2.655e-06  5.451e-07  -4.870 1.12e-06 ***
policyTRUE:curr_pts_grp8      -2.181e-06  5.157e-07  -4.230 2.34e-05 ***
policyTRUE:curr_pts_grp9      -3.283e-06  5.748e-07  -5.711 1.12e-08 ***
policyTRUE:curr_pts_grp10     -3.316e-06  7.877e-07  -4.209 2.56e-05 ***
policyTRUE:curr_pts_grp11-20  -7.072e-06  4.483e-07 -15.775  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.499e-05  1.605e-06 -15.566  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.742e-05  3.443e-06 -22.483  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001601 on 5646904624 degrees of freedom
Multiple R-squared:  5.201e-06,	Adjusted R-squared:  5.192e-06
F-statistic: 624.8 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```

### Twelve-point violations (speeding 100-119 over or 3 other offences)

The 12-point speeding offence was changed to a 24-point offence but the others were unchanged.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -9.545e-09  7.020e-08  -0.136 0.891844    
age_grp16-19                   1.559e-07  7.395e-08   2.108 0.035030 *  
age_grp20-24                   1.976e-07  7.160e-08   2.759 0.005789 **
age_grp25-34                   5.126e-08  7.076e-08   0.724 0.468803    
age_grp35-44                   5.184e-09  7.067e-08   0.073 0.941526    
age_grp45-54                  -7.047e-09  7.064e-08  -0.100 0.920531    
age_grp55-64                  -5.067e-10  7.079e-08  -0.007 0.994288    
age_grp65-74                  -1.446e-09  7.127e-08  -0.020 0.983818    
age_grp75-84                   1.880e-09  7.255e-08   0.026 0.979321    
age_grp85-89                   3.485e-09  8.956e-08   0.039 0.968966    
age_grp90-199                  4.539e-09  1.516e-07   0.030 0.976109    
policyTRUE                     2.541e-09  1.037e-07   0.025 0.980443    
curr_pts_grp1                  9.425e-09  3.531e-08   0.267 0.789522    
curr_pts_grp2                  6.071e-08  1.641e-08   3.699 0.000217 ***
curr_pts_grp3                  6.732e-08  1.415e-08   4.756 1.97e-06 ***
curr_pts_grp4                  1.245e-07  3.624e-08   3.435 0.000592 ***
curr_pts_grp5                  2.155e-07  2.714e-08   7.942 1.99e-15 ***
curr_pts_grp6                  1.458e-07  3.069e-08   4.751 2.02e-06 ***
curr_pts_grp7                  3.801e-07  4.977e-08   7.638 2.20e-14 ***
curr_pts_grp8                  1.146e-07  4.666e-08   2.457 0.014019 *  
curr_pts_grp9                  2.802e-07  5.146e-08   5.444 5.21e-08 ***
curr_pts_grp10                 3.624e-07  7.507e-08   4.828 1.38e-06 ***
curr_pts_grp11-20              4.951e-07  4.200e-08  11.788  < 2e-16 ***
curr_pts_grp21-30              2.442e-06  1.594e-07  15.315  < 2e-16 ***
curr_pts_grp30-150             3.083e-06  3.571e-07   8.634  < 2e-16 ***
age_grp16-19:policyTRUE        4.625e-08  1.087e-07   0.425 0.670604    
age_grp20-24:policyTRUE       -3.156e-08  1.057e-07  -0.299 0.765188    
age_grp25-34:policyTRUE       -2.933e-08  1.045e-07  -0.281 0.778879    
age_grp35-44:policyTRUE       -6.014e-09  1.044e-07  -0.058 0.954050    
age_grp45-54:policyTRUE       -2.537e-09  1.043e-07  -0.024 0.980589    
age_grp55-64:policyTRUE       -3.159e-09  1.045e-07  -0.030 0.975876    
age_grp65-74:policyTRUE       -1.054e-10  1.051e-07  -0.001 0.999200    
age_grp75-84:policyTRUE       -5.985e-10  1.068e-07  -0.006 0.995530    
age_grp85-89:policyTRUE       -6.989e-10  1.289e-07  -0.005 0.995675    
age_grp90-199:policyTRUE      -1.580e-09  2.125e-07  -0.007 0.994069    
policyTRUE:curr_pts_grp1       7.700e-09  4.957e-08   0.155 0.876563    
policyTRUE:curr_pts_grp2      -3.474e-08  2.266e-08  -1.533 0.125270    
policyTRUE:curr_pts_grp3      -3.314e-08  2.045e-08  -1.620 0.105134    
policyTRUE:curr_pts_grp4      -7.053e-08  4.881e-08  -1.445 0.148454    
policyTRUE:curr_pts_grp5      -7.101e-08  3.779e-08  -1.879 0.060206 .  
policyTRUE:curr_pts_grp6      -8.376e-08  4.305e-08  -1.945 0.051735 .  
policyTRUE:curr_pts_grp7      -2.513e-07  6.811e-08  -3.689 0.000225 ***
policyTRUE:curr_pts_grp8      -9.661e-08  6.443e-08  -1.499 0.133758    
policyTRUE:curr_pts_grp9      -6.630e-08  7.182e-08  -0.923 0.355932    
policyTRUE:curr_pts_grp10     -2.022e-07  9.842e-08  -2.054 0.039929 *  
policyTRUE:curr_pts_grp11-20   3.259e-07  5.601e-08   5.818 5.94e-09 ***
policyTRUE:curr_pts_grp21-30  -3.070e-07  2.006e-07  -1.531 0.125862    
policyTRUE:curr_pts_grp30-150  4.018e-06  4.302e-07   9.339  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0002001 on 5646904624 degrees of freedom
Multiple R-squared:  5.345e-07,	Adjusted R-squared:  5.261e-07
F-statistic: 64.21 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```



### Twelve-points and up (speeding 100 or more and 3 other 12-point offences)

Combining with the more excessive speeding offences, the results are close to the case including only the 12-point offences.



```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.106e-08  1.343e-07  -0.082 0.934333    
age_grp16-19                   2.005e-07  1.415e-07   1.418 0.156315    
age_grp20-24                   2.158e-07  1.370e-07   1.576 0.115026    
age_grp25-34                   6.235e-08  1.354e-07   0.461 0.645071    
age_grp35-44                   7.937e-09  1.352e-07   0.059 0.953186    
age_grp45-54                  -8.168e-09  1.351e-07  -0.060 0.951798    
age_grp55-64                  -8.709e-10  1.354e-07  -0.006 0.994868    
age_grp65-74                  -1.152e-09  1.363e-07  -0.008 0.993255    
age_grp75-84                   2.578e-09  1.388e-07   0.019 0.985181    
age_grp85-89                   4.334e-09  1.713e-07   0.025 0.979820    
age_grp90-199                  5.546e-09  2.899e-07   0.019 0.984739    
policyTRUE                     1.029e-07  1.983e-07   0.519 0.603924    
curr_pts_grp1                  5.362e-09  6.754e-08   0.079 0.936725    
curr_pts_grp2                  6.933e-08  3.140e-08   2.208 0.027236 *  
curr_pts_grp3                  7.136e-08  2.708e-08   2.636 0.008400 **
curr_pts_grp4                  1.824e-07  6.932e-08   2.632 0.008489 **
curr_pts_grp5                  2.098e-07  5.192e-08   4.041 5.33e-05 ***
curr_pts_grp6                  1.627e-07  5.871e-08   2.771 0.005590 **
curr_pts_grp7                  4.335e-07  9.520e-08   4.554 5.27e-06 ***
curr_pts_grp8                  1.612e-07  8.926e-08   1.806 0.070903 .  
curr_pts_grp9                  3.383e-07  9.845e-08   3.437 0.000589 ***
curr_pts_grp10                 3.537e-07  1.436e-07   2.463 0.013760 *  
curr_pts_grp11-20              5.719e-07  8.034e-08   7.118 1.09e-12 ***
curr_pts_grp21-30              3.697e-06  3.050e-07  12.120  < 2e-16 ***
curr_pts_grp30-150             6.253e-06  6.830e-07   9.154  < 2e-16 ***
age_grp16-19:policyTRUE        1.082e-06  2.080e-07   5.202 1.97e-07 ***
age_grp20-24:policyTRUE        5.268e-07  2.021e-07   2.606 0.009158 **
age_grp25-34:policyTRUE        4.761e-08  1.998e-07   0.238 0.811685    
age_grp35-44:policyTRUE       -1.382e-07  1.996e-07  -0.692 0.488806    
age_grp45-54:policyTRUE       -1.635e-07  1.995e-07  -0.820 0.412373    
age_grp55-64:policyTRUE       -1.710e-07  1.999e-07  -0.856 0.392145    
age_grp65-74:policyTRUE       -1.374e-07  2.011e-07  -0.683 0.494333    
age_grp75-84:policyTRUE       -1.338e-07  2.044e-07  -0.654 0.512818    
age_grp85-89:policyTRUE       -1.260e-07  2.466e-07  -0.511 0.609379    
age_grp90-199:policyTRUE      -1.268e-07  4.065e-07  -0.312 0.755029    
policyTRUE:curr_pts_grp1       1.031e-07  9.483e-08   1.087 0.276816    
policyTRUE:curr_pts_grp2       2.973e-08  4.335e-08   0.686 0.492760    
policyTRUE:curr_pts_grp3       2.659e-07  3.912e-08   6.796 1.08e-11 ***
policyTRUE:curr_pts_grp4       3.500e-07  9.337e-08   3.749 0.000178 ***
policyTRUE:curr_pts_grp5       3.493e-07  7.228e-08   4.832 1.35e-06 ***
policyTRUE:curr_pts_grp6       6.074e-07  8.236e-08   7.375 1.64e-13 ***
policyTRUE:curr_pts_grp7       7.419e-07  1.303e-07   5.694 1.24e-08 ***
policyTRUE:curr_pts_grp8       9.948e-07  1.233e-07   8.071 6.95e-16 ***
policyTRUE:curr_pts_grp9       4.874e-07  1.374e-07   3.548 0.000388 ***
policyTRUE:curr_pts_grp10      1.888e-06  1.883e-07  10.031  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   3.395e-06  1.071e-07  31.681  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   1.057e-05  3.836e-07  27.547  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  3.634e-05  8.230e-07  44.154  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0003827 on 5646904624 degrees of freedom
Multiple R-squared:  3.592e-06,	Adjusted R-squared:  3.584e-06
F-statistic: 431.6 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


### More than Twelve points (only speeding 120 or more)

This category includes speeding 120-139 over (15, changed to 30 points after policy change),
speeding 140-159 over (18, changed to 36 points after policy change),


```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.519e-09  1.145e-07  -0.013  0.98941    
age_grp16-19                   4.465e-08  1.206e-07   0.370  0.71123    
age_grp20-24                   1.828e-08  1.168e-07   0.157  0.87560    
age_grp25-34                   1.109e-08  1.154e-07   0.096  0.92345    
age_grp35-44                   2.753e-09  1.152e-07   0.024  0.98095    
age_grp45-54                  -1.121e-09  1.152e-07  -0.010  0.99224    
age_grp55-64                  -3.642e-10  1.154e-07  -0.003  0.99748    
age_grp65-74                   2.930e-10  1.162e-07   0.003  0.99799    
age_grp75-84                   6.973e-10  1.183e-07   0.006  0.99530    
age_grp85-89                   8.491e-10  1.461e-07   0.006  0.99536    
age_grp90-199                  1.007e-09  2.472e-07   0.004  0.99675    
policyTRUE                     1.003e-07  1.691e-07   0.594  0.55284    
curr_pts_grp1                 -4.063e-09  5.758e-08  -0.071  0.94374    
curr_pts_grp2                  8.620e-09  2.677e-08   0.322  0.74743    
curr_pts_grp3                  4.042e-09  2.308e-08   0.175  0.86097    
curr_pts_grp4                  5.796e-08  5.909e-08   0.981  0.32669    
curr_pts_grp5                 -5.765e-09  4.426e-08  -0.130  0.89635    
curr_pts_grp6                  1.686e-08  5.005e-08   0.337  0.73627    
curr_pts_grp7                  5.337e-08  8.116e-08   0.658  0.51080    
curr_pts_grp8                  4.658e-08  7.610e-08   0.612  0.54047    
curr_pts_grp9                  5.815e-08  8.393e-08   0.693  0.48839    
curr_pts_grp10                -8.651e-09  1.224e-07  -0.071  0.94366    
curr_pts_grp11-20              7.679e-08  6.849e-08   1.121  0.26220    
curr_pts_grp21-30              1.255e-06  2.600e-07   4.826 1.39e-06 ***
curr_pts_grp30-150             3.170e-06  5.823e-07   5.444 5.22e-08 ***
age_grp16-19:policyTRUE        1.036e-06  1.773e-07   5.842 5.16e-09 ***
age_grp20-24:policyTRUE        5.584e-07  1.723e-07   3.240  0.00119 **
age_grp25-34:policyTRUE        7.694e-08  1.704e-07   0.452  0.65151    
age_grp35-44:policyTRUE       -1.322e-07  1.702e-07  -0.777  0.43736    
age_grp45-54:policyTRUE       -1.610e-07  1.701e-07  -0.947  0.34381    
age_grp55-64:policyTRUE       -1.679e-07  1.704e-07  -0.985  0.32449    
age_grp65-74:policyTRUE       -1.373e-07  1.714e-07  -0.801  0.42308    
age_grp75-84:policyTRUE       -1.332e-07  1.742e-07  -0.764  0.44470    
age_grp85-89:policyTRUE       -1.253e-07  2.103e-07  -0.596  0.55114    
age_grp90-199:policyTRUE      -1.253e-07  3.465e-07  -0.361  0.71776    
policyTRUE:curr_pts_grp1       9.543e-08  8.084e-08   1.180  0.23783    
policyTRUE:curr_pts_grp2       6.447e-08  3.695e-08   1.745  0.08104 .  
policyTRUE:curr_pts_grp3       2.990e-07  3.335e-08   8.965  < 2e-16 ***
policyTRUE:curr_pts_grp4       4.205e-07  7.959e-08   5.283 1.27e-07 ***
policyTRUE:curr_pts_grp5       4.203e-07  6.162e-08   6.821 9.06e-12 ***
policyTRUE:curr_pts_grp6       6.912e-07  7.021e-08   9.844  < 2e-16 ***
policyTRUE:curr_pts_grp7       9.932e-07  1.111e-07   8.942  < 2e-16 ***
policyTRUE:curr_pts_grp8       1.091e-06  1.051e-07  10.388  < 2e-16 ***
policyTRUE:curr_pts_grp9       5.537e-07  1.171e-07   4.728 2.27e-06 ***
policyTRUE:curr_pts_grp10      2.091e-06  1.605e-07  13.026  < 2e-16 ***
policyTRUE:curr_pts_grp11-20   3.069e-06  9.134e-08  33.596  < 2e-16 ***
policyTRUE:curr_pts_grp21-30   1.088e-05  3.270e-07  33.253  < 2e-16 ***
policyTRUE:curr_pts_grp30-150  3.232e-05  7.016e-07  46.068  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0003262 on 5646904624 degrees of freedom
Multiple R-squared:  3.413e-06,	Adjusted R-squared:  3.405e-06
F-statistic:   410 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    4.667e-06  5.670e-07   8.232  < 2e-16 ***
age_grp16-19                   7.443e-06  5.973e-07  12.462  < 2e-16 ***
age_grp20-24                   1.603e-06  5.783e-07   2.772  0.00556 **
age_grp25-34                  -2.374e-06  5.715e-07  -4.154 3.27e-05 ***
age_grp35-44                  -3.536e-06  5.708e-07  -6.194 5.86e-10 ***
age_grp45-54                  -3.777e-06  5.705e-07  -6.620 3.59e-11 ***
age_grp55-64                  -4.032e-06  5.717e-07  -7.053 1.76e-12 ***
age_grp65-74                  -3.798e-06  5.756e-07  -6.597 4.18e-11 ***
age_grp75-84                  -2.829e-06  5.859e-07  -4.828 1.38e-06 ***
age_grp85-89                  -1.333e-06  7.234e-07  -1.843  0.06528 .  
age_grp90-199                 -1.252e-06  1.224e-06  -1.023  0.30643    
policyTRUE                    -1.090e-06  8.373e-07  -1.302  0.19309    
curr_pts_grp1                  8.162e-07  2.852e-07   2.862  0.00421 **
curr_pts_grp2                  1.647e-06  1.326e-07  12.422  < 2e-16 ***
curr_pts_grp3                  2.910e-06  1.143e-07  25.453  < 2e-16 ***
curr_pts_grp4                  6.043e-06  2.927e-07  20.648  < 2e-16 ***
curr_pts_grp5                  4.783e-06  2.192e-07  21.821  < 2e-16 ***
curr_pts_grp6                  5.429e-06  2.479e-07  21.899  < 2e-16 ***
curr_pts_grp7                  8.910e-06  4.020e-07  22.168  < 2e-16 ***
curr_pts_grp8                  7.865e-06  3.769e-07  20.869  < 2e-16 ***
curr_pts_grp9                  1.095e-05  4.156e-07  26.354  < 2e-16 ***
curr_pts_grp10                 1.099e-05  6.063e-07  18.127  < 2e-16 ***
curr_pts_grp11-20              2.111e-05  3.392e-07  62.248  < 2e-16 ***
curr_pts_grp21-30              6.472e-05  1.288e-06  50.259  < 2e-16 ***
curr_pts_grp30-150             1.417e-04  2.884e-06  49.121  < 2e-16 ***
age_grp16-19:policyTRUE       -8.658e-07  8.783e-07  -0.986  0.32427    
age_grp20-24:policyTRUE        8.734e-08  8.535e-07   0.102  0.91849    
age_grp25-34:policyTRUE        5.489e-07  8.437e-07   0.651  0.51528    
age_grp35-44:policyTRUE        8.846e-07  8.429e-07   1.050  0.29393    
age_grp45-54:policyTRUE        8.295e-07  8.423e-07   0.985  0.32473    
age_grp55-64:policyTRUE        9.706e-07  8.438e-07   1.150  0.25006    
age_grp65-74:policyTRUE        9.905e-07  8.490e-07   1.167  0.24336    
age_grp75-84:policyTRUE        1.086e-06  8.630e-07   1.259  0.20816    
age_grp85-89:policyTRUE       -4.383e-07  1.041e-06  -0.421  0.67384    
age_grp90-199:policyTRUE       3.323e-07  1.716e-06   0.194  0.84649    
policyTRUE:curr_pts_grp1       1.171e-07  4.004e-07   0.292  0.76997    
policyTRUE:curr_pts_grp2      -3.964e-07  1.830e-07  -2.166  0.03033 *  
policyTRUE:curr_pts_grp3      -4.393e-07  1.652e-07  -2.660  0.00782 **
policyTRUE:curr_pts_grp4      -1.655e-06  3.942e-07  -4.199 2.68e-05 ***
policyTRUE:curr_pts_grp5      -1.725e-06  3.052e-07  -5.652 1.59e-08 ***
policyTRUE:curr_pts_grp6      -9.611e-07  3.477e-07  -2.764  0.00571 **
policyTRUE:curr_pts_grp7      -2.964e-06  5.501e-07  -5.389 7.08e-08 ***
policyTRUE:curr_pts_grp8      -2.281e-06  5.204e-07  -4.383 1.17e-05 ***
policyTRUE:curr_pts_grp9      -3.413e-06  5.800e-07  -5.884 4.00e-09 ***
policyTRUE:curr_pts_grp10     -3.415e-06  7.949e-07  -4.297 1.73e-05 ***
policyTRUE:curr_pts_grp11-20  -6.596e-06  4.524e-07 -14.581  < 2e-16 ***
policyTRUE:curr_pts_grp21-30  -2.556e-05  1.620e-06 -15.779  < 2e-16 ***
policyTRUE:curr_pts_grp30-150 -7.227e-05  3.475e-06 -20.799  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001616 on 5646904624 degrees of freedom
Multiple R-squared:  5.563e-06,	Adjusted R-squared:  5.554e-06
F-statistic: 668.3 on 47 and 5646904624 DF,  p-value: < 2.2e-16
```
