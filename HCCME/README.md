
# Linear Probability Models - All Drivers


## Linear Regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)               9.525722e-05 4.029032e-06  23.642709 1.402832e-123
policyTRUE               -1.115116e-05 5.700237e-06  -1.956263  5.043418e-02
age_grp16-19              4.684556e-04 4.802314e-06  97.547894  0.000000e+00
age_grp20-24              3.802194e-04 4.286049e-06  88.710915  0.000000e+00
age_grp25-34              2.536487e-04 4.103742e-06  61.809138  0.000000e+00
age_grp35-44              1.991013e-04 4.083113e-06  48.762134  0.000000e+00
age_grp45-54              1.493301e-04 4.070540e-06  36.685581 1.240130e-294
age_grp55-64              9.604708e-05 4.074160e-06  23.574695 7.008371e-123
age_grp65-199             2.542122e-05 4.066560e-06   6.251285  4.070891e-10
curr_pts_grp1-3           5.673112e-04 8.440088e-07 672.162684  0.000000e+00
curr_pts_grp4-6           1.152211e-03 2.019595e-06 570.515730  0.000000e+00
curr_pts_grp7-9           1.637122e-03 3.921391e-06 417.485020  0.000000e+00
curr_pts_grp10-150        2.272427e-03 5.597754e-06 405.953426  0.000000e+00
policyTRUE:age_grp16-19  -6.280547e-05 6.706837e-06  -9.364395  7.648729e-21
policyTRUE:age_grp20-24  -6.805654e-05 6.059369e-06 -11.231621  2.851989e-29
policyTRUE:age_grp25-34  -5.167803e-05 5.805417e-06  -8.901691  5.500229e-19
policyTRUE:age_grp35-44  -2.701707e-05 5.779730e-06  -4.674452  2.947398e-06
policyTRUE:age_grp45-54  -1.964781e-05 5.759105e-06  -3.411608  6.458095e-04
policyTRUE:age_grp55-64  -1.233759e-05 5.762194e-06  -2.141127  3.226381e-02
policyTRUE:age_grp65-199  3.594172e-06 5.751753e-06   0.624883  5.320479e-01
```

Repeat without the policy-age interaction.

```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.086843e-04 2.858063e-06  38.027256 2.046329e-316
policyTRUE         -3.823456e-05 4.114390e-07 -92.928854  0.000000e+00
age_grp16-19        4.360161e-04 3.349269e-06 130.182477  0.000000e+00
age_grp20-24        3.461691e-04 3.021563e-06 114.566229  0.000000e+00
age_grp25-34        2.277759e-04 2.899131e-06  78.566954  0.000000e+00
age_grp35-44        1.857205e-04 2.887676e-06  64.314871  0.000000e+00
age_grp45-54        1.397132e-04 2.878279e-06  48.540551  0.000000e+00
age_grp55-64        9.031110e-05 2.880486e-06  31.352733 8.929553e-216
age_grp65-199       2.828273e-05 2.875906e-06   9.834372  8.006571e-23
curr_pts_grp1-3     5.673480e-04 8.440126e-07 672.203264  0.000000e+00
curr_pts_grp4-6     1.152081e-03 2.019567e-06 570.459318  0.000000e+00
curr_pts_grp7-9     1.636939e-03 3.921361e-06 417.441514  0.000000e+00
curr_pts_grp10-150  2.271130e-03 5.597099e-06 405.769178  0.000000e+00
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
Estimate   Std. Error      t value      Pr(>|t|)
(Intercept)        5.496051e-08 6.286398e-07   0.08742767  9.303316e-01
policyTRUE         4.414568e-06 1.185881e-07  37.22606277 2.585548e-303
age_grp16-19       4.178078e-05 8.056002e-07  51.86291519  0.000000e+00
age_grp20-24       2.481116e-05 6.802017e-07  36.47618426 2.646128e-291
age_grp25-34       2.291748e-05 6.435005e-07  35.61376486 8.578535e-278
age_grp35-44       2.241197e-05 6.402824e-07  35.00325095 2.007737e-268
age_grp45-54       1.949958e-05 6.371279e-07  30.60544422 1.035956e-205
age_grp55-64       1.537723e-05 6.383671e-07  24.08838622 3.308477e-128
age_grp65-199      8.419423e-06 6.360337e-07  13.23738646  5.337408e-40
curr_pts_grp1-3    4.677431e-05 2.440028e-07 191.69580302  0.000000e+00
curr_pts_grp4-6    8.608097e-05 5.601042e-07 153.68741869  0.000000e+00
curr_pts_grp7-9    1.269834e-04 1.099507e-06 115.49117242  0.000000e+00
curr_pts_grp10-150 1.975668e-04 1.647838e-06 119.89451701  0.000000e+00
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)        -4.510724e-06 1.055032e-06  -4.275439 1.907606e-05
policyTRUE         -1.136976e-06 2.644845e-07  -4.298840 1.716946e-05
age_grp16-19        1.589278e-04 1.449569e-06 109.637972 0.000000e+00
age_grp20-24        1.535121e-04 1.207279e-06 127.155411 0.000000e+00
age_grp25-34        1.364525e-04 1.099442e-06 124.110736 0.000000e+00
age_grp35-44        1.296344e-04 1.089336e-06 119.003131 0.000000e+00
age_grp45-54        1.148572e-04 1.079988e-06 106.350412 0.000000e+00
age_grp55-64        9.195757e-05 1.083007e-06  84.909486 0.000000e+00
age_grp65-199       5.682653e-05 1.075826e-06  52.821318 0.000000e+00
curr_pts_grp1-3     2.354142e-04 5.467846e-07 430.542728 0.000000e+00
curr_pts_grp4-6     4.497627e-04 1.272886e-06 353.340987 0.000000e+00
curr_pts_grp7-9     5.999394e-04 2.399272e-06 250.050608 0.000000e+00
curr_pts_grp10-150  7.232512e-04 3.213856e-06 225.041551 0.000000e+00
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         9.579818e-05 2.411100e-06   39.732149  0.000000e+00
policyTRUE         -3.381337e-05 2.807179e-07 -120.453217  0.000000e+00
age_grp16-19        1.683335e-04 2.695317e-06   62.454069  0.000000e+00
age_grp20-24        1.428092e-04 2.508853e-06   56.922122  0.000000e+00
age_grp25-34        6.861064e-05 2.434195e-06   28.186172 8.639817e-175
age_grp35-44        4.291821e-05 2.427211e-06   17.682108  5.760157e-70
age_grp45-54        1.740984e-05 2.421585e-06    7.189441  6.505705e-13
age_grp55-64       -3.849644e-06 2.422641e-06   -1.589028  1.120541e-01
age_grp65-199      -2.418381e-05 2.421077e-06   -9.988864  1.705246e-23
curr_pts_grp1-3     2.668015e-04 5.746837e-07  464.258065  0.000000e+00
curr_pts_grp4-6     5.663556e-04 1.405133e-06  403.061813  0.000000e+00
curr_pts_grp7-9     8.227597e-04 2.761851e-06  297.901593  0.000000e+00
curr_pts_grp10-150  1.161349e-03 3.980411e-06  291.766221  0.000000e+00
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         1.150988e-05 7.855975e-07  14.6511131  1.325268e-48
policyTRUE         -5.195078e-07 3.919079e-08 -13.2558643  4.172818e-40
age_grp16-19        2.940420e-05 8.855616e-07  33.2040143 9.421318e-242
age_grp20-24       -3.762961e-07 7.973145e-07  -0.4719544  6.369593e-01
age_grp25-34       -8.925047e-06 7.868178e-07 -11.3432195  8.014091e-30
age_grp35-44       -1.082397e-05 7.859488e-07 -13.7718557  3.764189e-43
age_grp45-54       -1.132737e-05 7.855823e-07 -14.4190782  3.925509e-47
age_grp55-64       -1.137716e-05 7.854932e-07 -14.4841035  1.527022e-47
age_grp65-199      -1.119933e-05 7.854298e-07 -14.2588539  3.948867e-46
curr_pts_grp1-3     2.687685e-06 6.955910e-08  38.6388718  0.000000e+00
curr_pts_grp4-6     1.029360e-05 1.969816e-07  52.2566646  0.000000e+00
curr_pts_grp7-9     1.953687e-05 4.334184e-07  45.0762446  0.000000e+00
curr_pts_grp10-150  4.537217e-05 7.832950e-07  57.9247490  0.000000e+00
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.416332e-06 1.094730e-07  12.937722  2.756841e-38
policyTRUE         -5.582243e-06 5.986174e-08 -93.252264  0.000000e+00
age_grp16-19        2.582271e-05 3.658619e-07  70.580495  0.000000e+00
age_grp20-24        2.040855e-05 2.184234e-07  93.435715  0.000000e+00
age_grp25-34        9.504924e-06 1.347549e-07  70.534894  0.000000e+00
age_grp35-44        4.315476e-06 1.211343e-07  35.625556 5.634584e-278
age_grp45-54        2.481790e-06 1.145599e-07  21.663688 4.515960e-104
age_grp55-64        1.532372e-06 1.130193e-07  13.558497  7.056748e-42
age_grp65-199       1.017453e-06 1.097392e-07   9.271557  1.834481e-20
curr_pts_grp1-3     1.215906e-05 1.192491e-07 101.963521  0.000000e+00
curr_pts_grp4-6     3.015628e-05 3.181052e-07  94.799730  0.000000e+00
curr_pts_grp7-9     5.057022e-05 6.740349e-07  75.026121  0.000000e+00
curr_pts_grp10-150  9.934766e-05 1.139667e-06  87.172501  0.000000e+00
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
Estimate   Std. Error      t value      Pr(>|t|)
(Intercept)         3.133129e-07 5.404768e-08   5.79697122  6.752328e-09
policyTRUE         -1.011131e-06 2.401978e-08 -42.09576094  0.000000e+00
age_grp16-19        7.246196e-06 1.872533e-07  38.69729376  0.000000e+00
age_grp20-24        4.554757e-06 1.024227e-07  44.47021588  0.000000e+00
age_grp25-34        1.454961e-06 6.246828e-08  23.29119954 5.444080e-120
age_grp35-44        2.480316e-07 5.638019e-08   4.39926866  1.086163e-05
age_grp45-54       -3.894954e-09 5.432090e-08  -0.07170269  9.428385e-01
age_grp55-64       -5.811012e-08 5.363025e-08  -1.08353239  2.785722e-01
age_grp65-199       1.052677e-08 5.309268e-08   0.19827154  8.428326e-01
curr_pts_grp1-3     1.635818e-06 4.464206e-08  36.64296932 5.922197e-294
curr_pts_grp4-6     4.768746e-06 1.268155e-07  37.60380275 1.863120e-309
curr_pts_grp7-9     9.111807e-06 2.857008e-07  31.89282877 3.357128e-223
curr_pts_grp10-150  2.532048e-05 5.692893e-07  44.47734746  0.000000e+00
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         4.002023e-06 4.598056e-07   8.7037285  3.211548e-18
policyTRUE         -4.689398e-07 2.873635e-08 -16.3186981  7.266900e-60
age_grp16-19        3.992478e-06 4.956326e-07   8.0553182  7.927232e-16
age_grp20-24        2.179347e-07 4.672110e-07   0.4664588  6.408871e-01
age_grp25-34       -2.212690e-06 4.608670e-07  -4.8011469  1.577595e-06
age_grp35-44       -2.917585e-06 4.602856e-07  -6.3386401  2.318020e-10
age_grp45-54       -3.140390e-06 4.599928e-07  -6.8270417  8.668349e-12
age_grp55-64       -3.214212e-06 4.600436e-07  -6.9867560  2.813148e-12
age_grp65-199      -2.558379e-06 4.606468e-07  -5.5538854  2.793888e-08
curr_pts_grp1-3     1.812939e-06 5.301099e-08  34.1993119 2.475646e-256
curr_pts_grp4-6     4.426138e-06 1.302901e-07  33.9714141 5.890852e-253
curr_pts_grp7-9     7.585775e-06 2.723110e-07  27.8570303 8.853701e-171
curr_pts_grp10-150  1.784515e-05 4.901572e-07  36.4069881 3.300341e-290
```


## Placebo regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)                9.859269e-05 5.775639e-06  17.0704361  2.463539e-65
placeboTRUE               -1.291595e-05 8.059470e-06  -1.6025804  1.090273e-01
age_grp16-19               4.661673e-04 6.886473e-06  67.6931816  0.000000e+00
age_grp20-24               3.649972e-04 6.125985e-06  59.5817960  0.000000e+00
age_grp25-34               2.420847e-04 5.878249e-06  41.1831303  0.000000e+00
age_grp35-44               1.910565e-04 5.848942e-06  32.6651391 4.885541e-234
age_grp45-54               1.397274e-04 5.832425e-06  23.9570008 7.811481e-127
age_grp55-64               8.628763e-05 5.837712e-06  14.7810695  1.940604e-49
age_grp65-199              1.535369e-05 5.826772e-06   2.6350257  8.413092e-03
curr_pts_grp1-3            5.957077e-04 1.267189e-06 470.1016963  0.000000e+00
curr_pts_grp4-6            1.214290e-03 3.111643e-06 390.2407898  0.000000e+00
curr_pts_grp7-9            1.713666e-03 6.035563e-06 283.9281512  0.000000e+00
curr_pts_grp10-150         2.573923e-03 9.424901e-06 273.0981245  0.000000e+00
placeboTRUE:age_grp16-19  -1.910569e-05 9.608804e-06  -1.9883527  4.677270e-02
placeboTRUE:age_grp20-24   9.642604e-07 8.585644e-06   0.1123108  9.105770e-01
placeboTRUE:age_grp25-34   6.161158e-06 8.214461e-06   0.7500380  4.532318e-01
placeboTRUE:age_grp35-44   4.054125e-06 8.171345e-06   0.4961393  6.197961e-01
placeboTRUE:age_grp45-54   1.151681e-05 8.144870e-06   1.4139950  1.573634e-01
placeboTRUE:age_grp55-64   1.510675e-05 8.151199e-06   1.8533164  6.383702e-02
placeboTRUE:age_grp65-199  1.955221e-05 8.135182e-06   2.4034142  1.624278e-02
```


Repeat without the policy-age interaction.

```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         9.401514e-05 4.040766e-06  23.266664 9.647913e-120
placeboTRUE        -3.869199e-06 5.923653e-07  -6.531779  6.499295e-11
age_grp16-19        4.561996e-04 4.802107e-06  94.999876  0.000000e+00
age_grp20-24        3.655676e-04 4.279633e-06  85.420305  0.000000e+00
age_grp25-34        2.452255e-04 4.101096e-06  59.795102  0.000000e+00
age_grp35-44        1.931686e-04 4.081605e-06  47.326639  0.000000e+00
age_grp45-54        1.455630e-04 4.069690e-06  35.767593 3.525181e-280
age_grp55-64        9.396667e-05 4.073787e-06  23.066173 1.012354e-117
age_grp65-199       2.534927e-05 4.066604e-06   6.233522  4.560624e-10
curr_pts_grp1-3     5.956841e-04 1.267179e-06 470.086782  0.000000e+00
curr_pts_grp4-6     1.214194e-03 3.111586e-06 390.216906  0.000000e+00
curr_pts_grp7-9     1.713481e-03 6.035473e-06 283.901609  0.000000e+00
curr_pts_grp10-150  2.573536e-03 9.424779e-06 273.060590  0.000000e+00
```
