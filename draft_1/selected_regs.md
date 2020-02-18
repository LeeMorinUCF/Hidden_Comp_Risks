# Selected Regression Tables

## Main Regressions

### Pooled Regressions (policy indicator only)

```R
Coefficients:
                     Estimate Std. Error  t value Pr(>|t|)    
(Intercept)         1.087e-04  4.641e-06   23.418  < 2e-16 ***
policyTRUE         -3.823e-05  4.112e-07  -92.992  < 2e-16 ***
age_grp16-19        4.360e-04  4.808e-06   90.677  < 2e-16 ***
age_grp20-24        3.462e-04  4.702e-06   73.619  < 2e-16 ***
age_grp25-34        2.278e-04  4.662e-06   48.853  < 2e-16 ***
age_grp35-44        1.857e-04  4.659e-06   39.861  < 2e-16 ***
age_grp45-54        1.397e-04  4.657e-06   30.002  < 2e-16 ***
age_grp55-64        9.031e-05  4.664e-06   19.365  < 2e-16 ***
age_grp65-199       2.828e-05  4.671e-06    6.055 1.41e-09 ***
curr_pts_grp1-3     5.673e-04  6.217e-07  912.563  < 2e-16 ***
curr_pts_grp4-6     1.152e-03  1.100e-06 1047.595  < 2e-16 ***
curr_pts_grp7-9     1.637e-03  1.818e-06  900.261  < 2e-16 ***
curr_pts_grp10-150  2.271e-03  2.240e-06 1013.695  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245481 degrees of freedom
Multiple R-squared:  0.0004007,	Adjusted R-squared:  0.0004007
F-statistic: 3.232e+05 on 12 and 9675245481 DF,  p-value: < 2.2e-16
```

Disclosure of negative predicted probabilities:

None to report.

### Pooled Regressions (policy indicator interacted with age)

```R
Coefficients:
                           Estimate Std. Error  t value Pr(>|t|)    
(Intercept)               9.526e-05  6.529e-06   14.589  < 2e-16 ***
policyTRUE               -1.115e-05  9.273e-06   -1.203 0.229157    
age_grp16-19              4.685e-04  6.789e-06   69.000  < 2e-16 ***
age_grp20-24              3.802e-04  6.622e-06   57.417  < 2e-16 ***
age_grp25-34              2.536e-04  6.566e-06   38.630  < 2e-16 ***
age_grp35-44              1.991e-04  6.561e-06   30.348  < 2e-16 ***
age_grp45-54              1.493e-04  6.558e-06   22.769  < 2e-16 ***
age_grp55-64              9.605e-05  6.569e-06   14.620  < 2e-16 ***
age_grp65-199             2.542e-05  6.581e-06    3.863 0.000112 ***
curr_pts_grp1-3           5.673e-04  6.217e-07  912.501  < 2e-16 ***
curr_pts_grp4-6           1.152e-03  1.100e-06 1047.702  < 2e-16 ***
curr_pts_grp7-9           1.637e-03  1.818e-06  900.353  < 2e-16 ***
curr_pts_grp10-150        2.272e-03  2.241e-06 1014.204  < 2e-16 ***
policyTRUE:age_grp16-19  -6.281e-05  9.616e-06   -6.531 6.52e-11 ***
policyTRUE:age_grp20-24  -6.806e-05  9.402e-06   -7.239 4.53e-13 ***
policyTRUE:age_grp25-34  -5.168e-05  9.324e-06   -5.542 2.98e-08 ***
policyTRUE:age_grp35-44  -2.702e-05  9.318e-06   -2.899 0.003738 **
policyTRUE:age_grp45-54  -1.965e-05  9.313e-06   -2.110 0.034892 *  
policyTRUE:age_grp55-64  -1.234e-05  9.328e-06   -1.323 0.185935    
policyTRUE:age_grp65-199  3.594e-06  9.343e-06    0.385 0.700458    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245474 degrees of freedom
Multiple R-squared:  0.000401,	Adjusted R-squared:  0.000401
F-statistic: 2.043e+05 on 19 and 9675245474 DF,  p-value: < 2.2e-16
```
Disclosure of negative predicted probabilities:

None to report.

### Separate Regressions by Gender (policy indicator only)


#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.344e-04  6.094e-06   22.05  < 2e-16 ***
policyTRUE         -5.924e-05  6.273e-07  -94.42  < 2e-16 ***
age_grp16-19        5.991e-04  6.384e-06   93.84  < 2e-16 ***
age_grp20-24        4.560e-04  6.204e-06   73.50  < 2e-16 ***
age_grp25-34        2.880e-04  6.133e-06   46.95  < 2e-16 ***
age_grp35-44        2.256e-04  6.127e-06   36.81  < 2e-16 ***
age_grp45-54        1.799e-04  6.123e-06   29.39  < 2e-16 ***
age_grp55-64        1.224e-04  6.134e-06   19.96  < 2e-16 ***
age_grp65-199       3.931e-05  6.142e-06    6.40 1.56e-10 ***
curr_pts_grp1-3     6.167e-04  8.956e-07  688.56  < 2e-16 ***
curr_pts_grp4-6     1.198e-03  1.471e-06  814.48  < 2e-16 ***
curr_pts_grp7-9     1.672e-03  2.318e-06  721.03  < 2e-16 ***
curr_pts_grp10-150  2.275e-03  2.733e-06  832.60  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033208 degrees of freedom
Multiple R-squared:  0.0004561,	Adjusted R-squared:  0.0004561
F-statistic: 2.029e+05 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```
Disclosure of negative predicted probabilities:

None to report.

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         3.688e-05  7.415e-06   4.973 6.58e-07 ***
policyTRUE         -7.589e-06  4.955e-07 -15.315  < 2e-16 ***
age_grp16-19        2.721e-04  7.572e-06  35.940  < 2e-16 ***
age_grp20-24        2.694e-04  7.469e-06  36.068  < 2e-16 ***
age_grp25-34        2.099e-04  7.434e-06  28.238  < 2e-16 ***
age_grp35-44        1.918e-04  7.431e-06  25.813  < 2e-16 ***
age_grp45-54        1.398e-04  7.429e-06  18.825  < 2e-16 ***
age_grp55-64        9.217e-05  7.436e-06  12.395  < 2e-16 ***
age_grp65-199       4.665e-05  7.446e-06   6.265 3.73e-10 ***
curr_pts_grp1-3     4.339e-04  8.203e-07 528.931  < 2e-16 ***
curr_pts_grp4-6     9.029e-04  1.699e-06 531.491  < 2e-16 ***
curr_pts_grp7-9     1.273e-03  3.251e-06 391.704  < 2e-16 ***
curr_pts_grp10-150  1.744e-03  5.059e-06 344.766  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0163 on 4340212260 degrees of freedom
Multiple R-squared:  0.0002094,	Adjusted R-squared:  0.0002094
F-statistic: 7.576e+04 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```
Disclosure of negative predicted probabilities:

None to report.


### Separate Regressions by Gender (policy indicator interacted with age)


#### Male drivers:
```R
Coefficients:
                           Estimate Std. Error t value Pr(>|t|)    
(Intercept)               1.106e-04  8.500e-06  13.011  < 2e-16 ***
policyTRUE               -1.036e-05  1.217e-05  -0.851  0.39490    
age_grp16-19              6.561e-04  8.950e-06  73.306  < 2e-16 ***
age_grp20-24              5.151e-04  8.667e-06  59.439  < 2e-16 ***
age_grp25-34              3.306e-04  8.567e-06  38.593  < 2e-16 ***
age_grp35-44              2.501e-04  8.557e-06  29.230  < 2e-16 ***
age_grp45-54              1.971e-04  8.553e-06  23.043  < 2e-16 ***
age_grp55-64              1.340e-04  8.571e-06  15.639  < 2e-16 ***
age_grp65-199             3.884e-05  8.585e-06   4.524 6.06e-06 ***
curr_pts_grp1-3           6.165e-04  8.956e-07 688.378  < 2e-16 ***
curr_pts_grp4-6           1.198e-03  1.471e-06 814.524  < 2e-16 ***
curr_pts_grp7-9           1.672e-03  2.318e-06 721.081  < 2e-16 ***
curr_pts_grp10-150        2.277e-03  2.733e-06 833.280  < 2e-16 ***
policyTRUE:age_grp16-19  -1.116e-04  1.277e-05  -8.738  < 2e-16 ***
policyTRUE:age_grp20-24  -1.195e-04  1.240e-05  -9.636  < 2e-16 ***
policyTRUE:age_grp25-34  -8.630e-05  1.227e-05  -7.036 1.99e-12 ***
policyTRUE:age_grp35-44  -5.045e-05  1.226e-05  -4.116 3.85e-05 ***
policyTRUE:age_grp45-54  -3.583e-05  1.225e-05  -2.925  0.00344 **
policyTRUE:age_grp55-64  -2.532e-05  1.227e-05  -2.063  0.03910 *  
policyTRUE:age_grp65-199 -2.913e-06  1.229e-05  -0.237  0.81261    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033201 degrees of freedom
Multiple R-squared:  0.0004567,	Adjusted R-squared:  0.0004566
F-statistic: 1.283e+05 on 19 and 5335033201 DF,  p-value: < 2.2e-16
```
Disclosure of negative predicted probabilities:

None to report.

#### Female drivers:
```R
Coefficients:
                           Estimate Std. Error t value Pr(>|t|)    
(Intercept)               3.642e-05  1.070e-05   3.404 0.000665 ***
policyTRUE               -6.705e-06  1.483e-05  -0.452 0.651257    
age_grp16-19              2.681e-04  1.094e-05  24.506  < 2e-16 ***
age_grp20-24              2.699e-04  1.078e-05  25.031  < 2e-16 ***
age_grp25-34              2.150e-04  1.073e-05  20.033  < 2e-16 ***
age_grp35-44              1.918e-04  1.073e-05  17.877  < 2e-16 ***
age_grp45-54              1.410e-04  1.072e-05  13.143  < 2e-16 ***
age_grp55-64              9.164e-05  1.074e-05   8.536  < 2e-16 ***
age_grp65-199             4.162e-05  1.075e-05   3.871 0.000108 ***
curr_pts_grp1-3           4.339e-04  8.203e-07 528.945  < 2e-16 ***
curr_pts_grp4-6           9.030e-04  1.699e-06 531.524  < 2e-16 ***
curr_pts_grp7-9           1.273e-03  3.251e-06 391.737  < 2e-16 ***
curr_pts_grp10-150        1.744e-03  5.059e-06 344.801  < 2e-16 ***
policyTRUE:age_grp16-19   7.469e-06  1.516e-05   0.493 0.622128    
policyTRUE:age_grp20-24  -8.985e-07  1.495e-05  -0.060 0.952072    
policyTRUE:age_grp25-34  -9.927e-06  1.488e-05  -0.667 0.504641    
policyTRUE:age_grp35-44   1.570e-07  1.487e-05   0.011 0.991575    
policyTRUE:age_grp45-54  -2.157e-06  1.487e-05  -0.145 0.884670    
policyTRUE:age_grp55-64   9.916e-07  1.488e-05   0.067 0.946881    
policyTRUE:age_grp65-199  9.380e-06  1.490e-05   0.629 0.529119    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0163 on 4340212253 degrees of freedom
Multiple R-squared:  0.0002094,	Adjusted R-squared:  0.0002094
F-statistic: 4.785e+04 on 19 and 4340212253 DF,  p-value: < 2.2e-16
```
Disclosure of negative predicted probabilities:

None to report.


## Placebo Regressions


### Separate Regressions by Gender (policy indicator only)


#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.070e-04  8.627e-06  12.400  < 2e-16 ***
placeboTRUE        -2.008e-06  9.072e-07  -2.214   0.0268 *  
age_grp16-19        6.360e-04  9.074e-06  70.095  < 2e-16 ***
age_grp20-24        4.918e-04  8.787e-06  55.968  < 2e-16 ***
age_grp25-34        3.176e-04  8.684e-06  36.578  < 2e-16 ***
age_grp35-44        2.414e-04  8.673e-06  27.835  < 2e-16 ***
age_grp45-54        1.912e-04  8.669e-06  22.059  < 2e-16 ***
age_grp55-64        1.305e-04  8.687e-06  15.025  < 2e-16 ***
age_grp65-199       3.849e-05  8.702e-06   4.423 9.72e-06 ***
curr_pts_grp1-3     6.517e-04  1.318e-06 494.348  < 2e-16 ***
curr_pts_grp4-6     1.268e-03  2.217e-06 571.748  < 2e-16 ***
curr_pts_grp7-9     1.751e-03  3.505e-06 499.500  < 2e-16 ***
curr_pts_grp10-150  2.579e-03  4.360e-06 591.565  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02319 on 2618869394 degrees of freedom
Multiple R-squared:  0.0004736,	Adjusted R-squared:  0.0004736
F-statistic: 1.034e+05 on 12 and 2618869394 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         3.717e-05  1.066e-05   3.485 0.000492 ***
placeboTRUE        -1.734e-06  7.076e-07  -2.450 0.014276 *  
age_grp16-19        2.670e-04  1.090e-05  24.496  < 2e-16 ***
age_grp20-24        2.683e-04  1.074e-05  24.984  < 2e-16 ***
age_grp25-34        2.138e-04  1.069e-05  20.001  < 2e-16 ***
age_grp35-44        1.907e-04  1.069e-05  17.849  < 2e-16 ***
age_grp45-54        1.403e-04  1.068e-05  13.129  < 2e-16 ***
age_grp55-64        9.120e-05  1.069e-05   8.528  < 2e-16 ***
age_grp65-199       4.142e-05  1.071e-05   3.867 0.000110 ***
curr_pts_grp1-3     4.397e-04  1.204e-06 365.160  < 2e-16 ***
curr_pts_grp4-6     9.110e-04  2.576e-06 353.599  < 2e-16 ***
curr_pts_grp7-9     1.275e-03  4.987e-06 255.568  < 2e-16 ***
curr_pts_grp10-150  1.877e-03  8.383e-06 223.870  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01624 on 2109880942 degrees of freedom
Multiple R-squared:  0.0001961,	Adjusted R-squared:  0.0001961
F-statistic: 3.448e+04 on 12 and 2109880942 DF,  p-value: < 2.2e-16
```

### Separate Regressions by Gender (policy indicator interacted with age)


#### Male drivers:
```R
Coefficients:
                            Estimate Std. Error t value Pr(>|t|)    
(Intercept)                1.150e-04  1.219e-05   9.432   <2e-16 ***
placeboTRUE               -1.797e-05  1.723e-05  -1.043   0.2969    
age_grp16-19               6.514e-04  1.285e-05  50.680   <2e-16 ***
age_grp20-24               4.922e-04  1.243e-05  39.612   <2e-16 ***
age_grp25-34               3.109e-04  1.228e-05  25.308   <2e-16 ***
age_grp35-44               2.352e-04  1.227e-05  19.170   <2e-16 ***
age_grp45-54               1.813e-04  1.227e-05  14.783   <2e-16 ***
age_grp55-64               1.188e-04  1.229e-05   9.663   <2e-16 ***
age_grp65-199              2.468e-05  1.231e-05   2.004   0.0451 *  
curr_pts_grp1-3            6.517e-04  1.318e-06 494.357   <2e-16 ***
curr_pts_grp4-6            1.268e-03  2.217e-06 571.787   <2e-16 ***
curr_pts_grp7-9            1.751e-03  3.505e-06 499.556   <2e-16 ***
curr_pts_grp10-150         2.580e-03  4.361e-06 591.638   <2e-16 ***
placeboTRUE:age_grp16-19  -2.941e-05  1.814e-05  -1.621   0.1050    
placeboTRUE:age_grp20-24  -1.012e-06  1.756e-05  -0.058   0.9540    
placeboTRUE:age_grp25-34   1.343e-05  1.736e-05   0.773   0.4393    
placeboTRUE:age_grp35-44   1.236e-05  1.734e-05   0.713   0.4761    
placeboTRUE:age_grp45-54   1.978e-05  1.734e-05   1.141   0.2540    
placeboTRUE:age_grp55-64   2.332e-05  1.737e-05   1.342   0.1795    
placeboTRUE:age_grp65-199  2.729e-05  1.740e-05   1.568   0.1168    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02319 on 2618869387 degrees of freedom
Multiple R-squared:  0.0004736,	Adjusted R-squared:  0.0004736
F-statistic: 6.531e+04 on 19 and 2618869387 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                            Estimate Std. Error t value Pr(>|t|)    
(Intercept)                3.242e-05  1.547e-05   2.097  0.03604 *  
placeboTRUE                7.296e-06  2.134e-05   0.342  0.73246    
age_grp16-19               2.731e-04  1.581e-05  17.272  < 2e-16 ***
age_grp20-24               2.691e-04  1.558e-05  17.275  < 2e-16 ***
age_grp25-34               2.194e-04  1.551e-05  14.142  < 2e-16 ***
age_grp35-44               1.985e-04  1.550e-05  12.803  < 2e-16 ***
age_grp45-54               1.448e-04  1.550e-05   9.342  < 2e-16 ***
age_grp55-64               9.475e-05  1.552e-05   6.106 1.02e-09 ***
age_grp65-199              4.328e-05  1.554e-05   2.785  0.00535 **
curr_pts_grp1-3            4.397e-04  1.204e-06 365.170  < 2e-16 ***
curr_pts_grp4-6            9.110e-04  2.576e-06 353.611  < 2e-16 ***
curr_pts_grp7-9            1.275e-03  4.987e-06 255.574  < 2e-16 ***
curr_pts_grp10-150         1.877e-03  8.383e-06 223.871  < 2e-16 ***
placeboTRUE:age_grp16-19  -1.165e-05  2.182e-05  -0.534  0.59350    
placeboTRUE:age_grp20-24  -1.143e-06  2.151e-05  -0.053  0.95762    
placeboTRUE:age_grp25-34  -1.059e-05  2.141e-05  -0.495  0.62068    
placeboTRUE:age_grp35-44  -1.510e-05  2.140e-05  -0.706  0.48027    
placeboTRUE:age_grp45-54  -8.679e-06  2.139e-05  -0.406  0.68497    
placeboTRUE:age_grp55-64  -6.708e-06  2.142e-05  -0.313  0.75410    
placeboTRUE:age_grp65-199 -3.472e-06  2.145e-05  -0.162  0.87138    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01624 on 2109880935 degrees of freedom
Multiple R-squared:  0.0001961,	Adjusted R-squared:  0.0001961
F-statistic: 2.178e+04 on 19 and 2109880935 DF,  p-value: < 2.2e-16
```



## Specific Point-value Combinations (policy indicator only)


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.

#### Male drivers:
```R
Coefficients:
                    Estimate Std. Error t value Pr(>|t|)    
(Intercept)        6.820e-07  1.726e-06   0.395    0.693    
policyTRUE         3.976e-06  1.777e-07  22.374  < 2e-16 ***
age_grp16-19       4.783e-05  1.809e-06  26.443  < 2e-16 ***
age_grp20-24       2.470e-05  1.758e-06  14.052  < 2e-16 ***
age_grp25-34       2.467e-05  1.738e-06  14.198  < 2e-16 ***
age_grp35-44       2.587e-05  1.736e-06  14.905  < 2e-16 ***
age_grp45-54       2.386e-05  1.735e-06  13.755  < 2e-16 ***
age_grp55-64       1.933e-05  1.738e-06  11.123  < 2e-16 ***
age_grp65-199      1.002e-05  1.740e-06   5.760 8.43e-09 ***
curr_pts_grp1-3    5.007e-05  2.537e-07 197.342  < 2e-16 ***
curr_pts_grp4-6    9.052e-05  4.166e-07 217.250  < 2e-16 ***
curr_pts_grp7-9    1.327e-04  6.568e-07 202.025  < 2e-16 ***
curr_pts_grp10-150 1.997e-04  7.741e-07 257.974  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006482 on 5335033208 degrees of freedom
Multiple R-squared:  3.51e-05,	Adjusted R-squared:  3.51e-05
F-statistic: 1.56e+04 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)        -2.409e-06  2.260e-06  -1.066 0.286426    
policyTRUE          5.217e-06  1.510e-07  34.541  < 2e-16 ***
age_grp16-19        3.573e-05  2.308e-06  15.482  < 2e-16 ***
age_grp20-24        2.726e-05  2.277e-06  11.973  < 2e-16 ***
age_grp25-34        2.315e-05  2.266e-06  10.217  < 2e-16 ***
age_grp35-44        2.069e-05  2.265e-06   9.135  < 2e-16 ***
age_grp45-54        1.639e-05  2.264e-06   7.239 4.51e-13 ***
age_grp55-64        1.218e-05  2.266e-06   5.374 7.71e-08 ***
age_grp65-199       7.471e-06  2.269e-06   3.292 0.000995 ***
curr_pts_grp1-3     3.848e-05  2.500e-07 153.931  < 2e-16 ***
curr_pts_grp4-6     6.825e-05  5.178e-07 131.818  < 2e-16 ***
curr_pts_grp7-9     9.522e-05  9.908e-07  96.103  < 2e-16 ***
curr_pts_grp10-150  1.665e-04  1.542e-06 107.951  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004969 on 4340212260 degrees of freedom
Multiple R-squared:  1.651e-05,	Adjusted R-squared:  1.651e-05
F-statistic:  5971 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```

### Two-point violations (speeding 21-30 over or 7 other violations)

#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)        -4.695e-06  3.833e-06  -1.225    0.221    
policyTRUE         -4.108e-06  3.946e-07 -10.410   <2e-16 ***
age_grp16-19        1.893e-04  4.016e-06  47.137   <2e-16 ***
age_grp20-24        1.765e-04  3.903e-06  45.229   <2e-16 ***
age_grp25-34        1.563e-04  3.858e-06  40.529   <2e-16 ***
age_grp35-44        1.487e-04  3.854e-06  38.582   <2e-16 ***
age_grp45-54        1.387e-04  3.851e-06  36.017   <2e-16 ***
age_grp55-64        1.152e-04  3.858e-06  29.867   <2e-16 ***
age_grp65-199       7.026e-05  3.864e-06  18.185   <2e-16 ***
curr_pts_grp1-3     2.493e-04  5.633e-07 442.534   <2e-16 ***
curr_pts_grp4-6     4.580e-04  9.250e-07 495.131   <2e-16 ***
curr_pts_grp7-9     6.058e-04  1.458e-06 415.444   <2e-16 ***
curr_pts_grp10-150  7.186e-04  1.719e-06 418.095   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01439 on 5335033208 degrees of freedom
Multiple R-squared:  0.000143,	Adjusted R-squared:  0.000143
F-statistic: 6.357e+04 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)        -5.054e-06  5.039e-06  -1.003    0.316    
policyTRUE          3.814e-06  3.367e-07  11.328  < 2e-16 ***
age_grp16-19        1.229e-04  5.145e-06  23.893  < 2e-16 ***
age_grp20-24        1.308e-04  5.076e-06  25.762  < 2e-16 ***
age_grp25-34        1.171e-04  5.052e-06  23.174  < 2e-16 ***
age_grp35-44        1.112e-04  5.050e-06  22.019  < 2e-16 ***
age_grp45-54        8.934e-05  5.048e-06  17.697  < 2e-16 ***
age_grp55-64        6.444e-05  5.053e-06  12.754  < 2e-16 ***
age_grp65-199       3.776e-05  5.060e-06   7.463 8.43e-14 ***
curr_pts_grp1-3     1.971e-04  5.574e-07 353.532  < 2e-16 ***
curr_pts_grp4-6     3.932e-04  1.154e-06 340.612  < 2e-16 ***
curr_pts_grp7-9     5.182e-04  2.209e-06 234.567  < 2e-16 ***
curr_pts_grp10-150  6.377e-04  3.438e-06 185.475  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01108 on 4340212260 degrees of freedom
Multiple R-squared:  8.344e-05,	Adjusted R-squared:  8.343e-05
F-statistic: 3.018e+04 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)


This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change. That is, the 6-point violations are not included in the sample before the window.

#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error  t value Pr(>|t|)    
(Intercept)         1.158e-04  4.221e-06   27.437  < 2e-16 ***
policyTRUE         -4.759e-05  4.346e-07 -109.517  < 2e-16 ***
age_grp16-19        2.507e-04  4.422e-06   56.687  < 2e-16 ***
age_grp20-24        2.096e-04  4.298e-06   48.776  < 2e-16 ***
age_grp25-34        1.026e-04  4.248e-06   24.144  < 2e-16 ***
age_grp35-44        6.126e-05  4.244e-06   14.433  < 2e-16 ***
age_grp45-54        3.208e-05  4.241e-06    7.563 3.93e-14 ***
age_grp55-64        4.586e-06  4.249e-06    1.079     0.28    
age_grp65-199      -2.446e-05  4.255e-06   -5.748 9.03e-09 ***
curr_pts_grp1-3     2.954e-04  6.204e-07  476.175  < 2e-16 ***
curr_pts_grp4-6     5.943e-04  1.019e-06  583.364  < 2e-16 ***
curr_pts_grp7-9     8.406e-04  1.606e-06  523.398  < 2e-16 ***
curr_pts_grp10-150  1.163e-03  1.893e-06  614.225  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01585 on 5335033208 degrees of freedom
Multiple R-squared:  0.0002431,	Adjusted R-squared:  0.0002431
F-statistic: 1.081e+05 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         4.046e-05  4.836e-06   8.365  < 2e-16 ***
policyTRUE         -1.412e-05  3.232e-07 -43.696  < 2e-16 ***
age_grp16-19        9.603e-05  4.938e-06  19.446  < 2e-16 ***
age_grp20-24        1.019e-04  4.872e-06  20.924  < 2e-16 ***
age_grp25-34        6.686e-05  4.849e-06  13.790  < 2e-16 ***
age_grp35-44        5.956e-05  4.847e-06  12.289  < 2e-16 ***
age_grp45-54        3.520e-05  4.845e-06   7.264 3.75e-13 ***
age_grp55-64        1.718e-05  4.850e-06   3.543 0.000396 ***
age_grp65-199       2.627e-06  4.856e-06   0.541 0.588499    
curr_pts_grp1-3     1.905e-04  5.350e-07 356.091  < 2e-16 ***
curr_pts_grp4-6     4.191e-04  1.108e-06 378.269  < 2e-16 ***
curr_pts_grp7-9     6.209e-04  2.120e-06 292.843  < 2e-16 ***
curr_pts_grp10-150  8.566e-04  3.300e-06 259.599  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01063 on 4340212260 degrees of freedom
Multiple R-squared:  0.0001048,	Adjusted R-squared:  0.0001048
F-statistic: 3.791e+04 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.509e-05  6.404e-07  23.559  < 2e-16 ***
policyTRUE         -8.086e-07  6.592e-08 -12.266  < 2e-16 ***
age_grp16-19        5.087e-05  6.709e-07  75.823  < 2e-16 ***
age_grp20-24        3.193e-06  6.520e-07   4.898  9.7e-07 ***
age_grp25-34       -1.084e-05  6.445e-07 -16.815  < 2e-16 ***
age_grp35-44       -1.393e-05  6.439e-07 -21.642  < 2e-16 ***
age_grp45-54       -1.473e-05  6.434e-07 -22.901  < 2e-16 ***
age_grp55-64       -1.481e-05  6.446e-07 -22.982  < 2e-16 ***
age_grp65-199      -1.462e-05  6.455e-07 -22.656  < 2e-16 ***
curr_pts_grp1-3     2.791e-06  9.412e-08  29.654  < 2e-16 ***
curr_pts_grp4-6     1.111e-05  1.545e-07  71.902  < 2e-16 ***
curr_pts_grp7-9     2.068e-05  2.436e-07  84.871  < 2e-16 ***
curr_pts_grp10-150  4.603e-05  2.871e-07 160.305  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002404 on 5335033208 degrees of freedom
Multiple R-squared:  3.109e-05,	Adjusted R-squared:  3.109e-05
F-statistic: 1.382e+04 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.203e-06  4.726e-07   2.546   0.0109 *  
policyTRUE         -1.011e-08  3.158e-08  -0.320   0.7488    
age_grp16-19        7.898e-06  4.826e-07  16.366  < 2e-16 ***
age_grp20-24        1.876e-06  4.761e-07   3.940 8.14e-05 ***
age_grp25-34       -1.651e-07  4.738e-07  -0.349   0.7275    
age_grp35-44       -6.824e-07  4.736e-07  -1.441   0.1496    
age_grp45-54       -9.857e-07  4.735e-07  -2.082   0.0374 *  
age_grp55-64       -1.117e-06  4.739e-07  -2.358   0.0184 *  
age_grp65-199      -1.045e-06  4.746e-07  -2.203   0.0276 *  
curr_pts_grp1-3     1.002e-06  5.228e-08  19.169  < 2e-16 ***
curr_pts_grp4-6     3.415e-06  1.083e-07  31.536  < 2e-16 ***
curr_pts_grp7-9     5.867e-06  2.072e-07  28.316  < 2e-16 ***
curr_pts_grp10-150  1.701e-05  3.225e-07  52.758  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001039 on 4340212260 degrees of freedom
Multiple R-squared:  3.435e-06,	Adjusted R-squared:  3.432e-06
F-statistic:  1242 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.

#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         2.032e-06  9.516e-07   2.135   0.0327 *  
policyTRUE         -8.201e-06  9.797e-08 -83.709  < 2e-16 ***
age_grp16-19        4.064e-05  9.971e-07  40.758  < 2e-16 ***
age_grp20-24        3.222e-05  9.689e-07  33.248  < 2e-16 ***
age_grp25-34        1.505e-05  9.578e-07  15.717  < 2e-16 ***
age_grp35-44        6.718e-06  9.568e-07   7.020 2.21e-12 ***
age_grp45-54        3.836e-06  9.562e-07   4.012 6.03e-05 ***
age_grp55-64        2.201e-06  9.579e-07   2.298   0.0216 *  
age_grp65-199       1.431e-06  9.592e-07   1.492   0.1357    
curr_pts_grp1-3     1.484e-05  1.399e-07 106.111  < 2e-16 ***
curr_pts_grp4-6     3.362e-05  2.297e-07 146.387  < 2e-16 ***
curr_pts_grp7-9     5.352e-05  3.621e-07 147.809  < 2e-16 ***
curr_pts_grp10-150  1.020e-04  4.267e-07 239.107  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003573 on 5335033208 degrees of freedom
Multiple R-squared:  3.133e-05,	Adjusted R-squared:  3.133e-05
F-statistic: 1.393e+04 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         8.827e-07  7.744e-07   1.140   0.2543    
policyTRUE         -2.107e-06  5.175e-08 -40.705  < 2e-16 ***
age_grp16-19        6.771e-06  7.907e-07   8.564  < 2e-16 ***
age_grp20-24        6.663e-06  7.801e-07   8.541  < 2e-16 ***
age_grp25-34        3.305e-06  7.763e-07   4.256 2.08e-05 ***
age_grp35-44        1.837e-06  7.760e-07   2.367   0.0179 *  
age_grp45-54        9.252e-07  7.758e-07   1.193   0.2330    
age_grp55-64        5.302e-07  7.765e-07   0.683   0.4947    
age_grp65-199       2.266e-07  7.776e-07   0.291   0.7707    
curr_pts_grp1-3     5.428e-06  8.566e-08  63.368  < 2e-16 ***
curr_pts_grp4-6     1.436e-05  1.774e-07  80.945  < 2e-16 ***
curr_pts_grp7-9     2.621e-05  3.395e-07  77.190  < 2e-16 ***
curr_pts_grp10-150  4.911e-05  5.284e-07  92.954  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001703 on 4340212260 degrees of freedom
Multiple R-squared:  7.481e-06,	Adjusted R-squared:  7.479e-06
F-statistic:  2706 on 12 and 4340212260 DF,  p-value: < 2.2e-16
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
(Intercept)         5.032e-07  3.969e-07   1.268    0.205    
policyTRUE         -1.628e-06  4.086e-08 -39.840  < 2e-16 ***
age_grp16-19        1.198e-05  4.159e-07  28.805  < 2e-16 ***
age_grp20-24        7.839e-06  4.041e-07  19.396  < 2e-16 ***
age_grp25-34        2.606e-06  3.995e-07   6.523 6.89e-11 ***
age_grp35-44        5.166e-07  3.991e-07   1.294    0.196    
age_grp45-54        2.524e-08  3.988e-07   0.063    0.950    
age_grp55-64       -8.782e-08  3.995e-07  -0.220    0.826    
age_grp65-199       2.069e-08  4.001e-07   0.052    0.959    
curr_pts_grp1-3     2.119e-06  5.834e-08  36.314  < 2e-16 ***
curr_pts_grp4-6     5.456e-06  9.579e-08  56.957  < 2e-16 ***
curr_pts_grp7-9     1.013e-05  1.510e-07  67.049  < 2e-16 ***
curr_pts_grp10-150  2.677e-05  1.780e-07 150.415  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00149 on 5335033208 degrees of freedom
Multiple R-squared:  1.036e-05,	Adjusted R-squared:  1.036e-05
F-statistic:  4607 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         8.527e-08  2.135e-07   0.399 0.689572    
policyTRUE         -1.918e-07  1.427e-08 -13.444  < 2e-16 ***
age_grp16-19        1.194e-06  2.180e-07   5.479 4.29e-08 ***
age_grp20-24        7.475e-07  2.150e-07   3.476 0.000509 ***
age_grp25-34        2.235e-07  2.140e-07   1.044 0.296328    
age_grp35-44        6.098e-08  2.139e-07   0.285 0.775602    
age_grp45-54        1.937e-08  2.139e-07   0.091 0.927820    
age_grp55-64       -1.243e-08  2.141e-07  -0.058 0.953689    
age_grp65-199      -4.112e-09  2.143e-07  -0.019 0.984694    
curr_pts_grp1-3     3.420e-07  2.361e-08  14.485  < 2e-16 ***
curr_pts_grp4-6     1.404e-06  4.891e-08  28.709  < 2e-16 ***
curr_pts_grp7-9     2.010e-06  9.359e-08  21.478  < 2e-16 ***
curr_pts_grp10-150  7.150e-06  1.456e-07  49.092  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0004693 on 4340212260 degrees of freedom
Multiple R-squared:  1.269e-06,	Adjusted R-squared:  1.266e-06
F-statistic: 459.1 on 12 and 4340212260 DF,  p-value: < 2.2e-16
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

#### Male drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         4.822e-06  4.314e-07  11.177  < 2e-16 ***
policyTRUE         -6.749e-07  4.441e-08 -15.196  < 2e-16 ***
age_grp16-19        6.980e-06  4.520e-07  15.442  < 2e-16 ***
age_grp20-24        1.473e-06  4.393e-07   3.353 0.000798 ***
age_grp25-34       -2.438e-06  4.342e-07  -5.615 1.96e-08 ***
age_grp35-44       -3.480e-06  4.338e-07  -8.022 1.04e-15 ***
age_grp45-54       -3.755e-06  4.335e-07  -8.664  < 2e-16 ***
age_grp55-64       -3.920e-06  4.342e-07  -9.026  < 2e-16 ***
age_grp65-199      -3.276e-06  4.349e-07  -7.535 4.90e-14 ***
curr_pts_grp1-3     2.062e-06  6.341e-08  32.524  < 2e-16 ***
curr_pts_grp4-6     4.519e-06  1.041e-07  43.406  < 2e-16 ***
curr_pts_grp7-9     7.730e-06  1.641e-07  47.097  < 2e-16 ***
curr_pts_grp10-150  1.824e-05  1.935e-07  94.278  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00162 on 5335033208 degrees of freedom
Multiple R-squared:  4.655e-06,	Adjusted R-squared:  4.652e-06
F-statistic:  2069 on 12 and 5335033208 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         1.705e-06  4.905e-07   3.476  0.00051 ***
policyTRUE         -1.780e-07  3.278e-08  -5.430 5.62e-08 ***
age_grp16-19        1.473e-06  5.008e-07   2.941  0.00327 **
age_grp20-24        1.417e-07  4.941e-07   0.287  0.77429    
age_grp25-34       -5.223e-07  4.917e-07  -1.062  0.28816    
age_grp35-44       -8.359e-07  4.915e-07  -1.701  0.08902 .  
age_grp45-54       -1.036e-06  4.914e-07  -2.108  0.03503 *  
age_grp55-64       -1.036e-06  4.918e-07  -2.107  0.03515 *  
age_grp65-199      -3.891e-07  4.925e-07  -0.790  0.42946    
curr_pts_grp1-3     1.033e-06  5.426e-08  19.040  < 2e-16 ***
curr_pts_grp4-6     3.111e-06  1.124e-07  27.684  < 2e-16 ***
curr_pts_grp7-9     4.886e-06  2.150e-07  22.724  < 2e-16 ***
curr_pts_grp10-150  9.653e-06  3.346e-07  28.845  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001078 on 4340212260 degrees of freedom
Multiple R-squared:  7.774e-07,	Adjusted R-squared:  7.746e-07
F-statistic: 281.2 on 12 and 4340212260 DF,  p-value: < 2.2e-16
```
