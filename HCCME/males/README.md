
# Linear Probability Models - Male Drivers


## Linear Regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                             Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)               1.105860e-04 5.108363e-06  21.6480257 6.344083e-104
policyTRUE               -1.035787e-05 7.341795e-06  -1.4108093  1.583009e-01
age_grp16-19              6.560960e-04 6.548813e-06 100.1854729  0.000000e+00
age_grp20-24              5.151416e-04 5.602148e-06  91.9543155  0.000000e+00
age_grp25-34              3.306153e-04 5.248588e-06  62.9912825  0.000000e+00
age_grp35-44              2.501230e-04 5.207004e-06  48.0358822  0.000000e+00
age_grp45-54              1.970862e-04 5.185928e-06  38.0040381 4.949843e-316
age_grp55-64              1.340338e-04 5.192020e-06  25.8153510 5.963160e-147
age_grp65-199             3.884437e-05 5.171179e-06   7.5117043  5.836250e-14
curr_pts_grp1-3           6.165224e-04 1.133705e-06 543.8119214  0.000000e+00
curr_pts_grp4-6           1.197873e-03 2.460447e-06 486.8518612  0.000000e+00
curr_pts_grp7-9           1.671783e-03 4.518839e-06 369.9586186  0.000000e+00
curr_pts_grp10-150        2.277159e-03 6.099223e-06 373.3522373  0.000000e+00
policyTRUE:age_grp16-19  -1.115692e-04 9.191249e-06 -12.1386342  6.591721e-34
policyTRUE:age_grp20-24  -1.195323e-04 8.017372e-06 -14.9091671  2.873147e-50
policyTRUE:age_grp25-34  -8.630412e-05 7.535793e-06 -11.4525599  2.283024e-30
policyTRUE:age_grp35-44  -5.044617e-05 7.484153e-06  -6.7403981  1.579533e-11
policyTRUE:age_grp45-54  -3.582661e-05 7.450501e-06  -4.8086168  1.519782e-06
policyTRUE:age_grp55-64  -2.531632e-05 7.455397e-06  -3.3957032  6.845255e-04
policyTRUE:age_grp65-199 -2.913190e-06 7.427043e-06  -0.3922409  6.948802e-01
```

Repeat without the policy-age interaction.

```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.343969e-04 3.682903e-06  36.49210 1.479898e-291
policyTRUE         -5.923529e-05 6.279135e-07 -94.33670  0.000000e+00
age_grp16-19        5.991473e-04 4.590313e-06 130.52428  0.000000e+00
age_grp20-24        4.560018e-04 3.992981e-06 114.20086  0.000000e+00
age_grp25-34        2.879572e-04 3.759163e-06  76.60141  0.000000e+00
age_grp35-44        2.255503e-04 3.736100e-06  60.37053  0.000000e+00
age_grp45-54        1.799199e-04 3.720805e-06  48.35510  0.000000e+00
age_grp55-64        1.224448e-04 3.724472e-06  32.87576 4.881382e-237
age_grp65-199       3.930913e-05 3.711633e-06  10.59079  3.287991e-26
curr_pts_grp1-3     6.166781e-04 1.133722e-06 543.94098  0.000000e+00
curr_pts_grp4-6     1.197790e-03 2.460418e-06 486.82389  0.000000e+00
curr_pts_grp7-9     1.671641e-03 4.518805e-06 369.92980  0.000000e+00
curr_pts_grp10-150  2.275057e-03 6.098052e-06 373.07925  0.000000e+00
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)        6.819999e-07 8.205709e-07   0.8311286  4.059010e-01
policyTRUE         3.976451e-06 1.770435e-07  22.4603001 1.015016e-111
age_grp16-19       4.783003e-05 1.112831e-06  42.9804767  0.000000e+00
age_grp20-24       2.469989e-05 9.073744e-07  27.2212798 3.637233e-163
age_grp25-34       2.467088e-05 8.456501e-07  29.1738573 4.162998e-187
age_grp35-44       2.587346e-05 8.406509e-07  30.7778863 5.180798e-208
age_grp45-54       2.385865e-05 8.360354e-07  28.5378397 3.976365e-179
age_grp55-64       1.932950e-05 8.381633e-07  23.0617342 1.121692e-117
age_grp65-199      1.002299e-05 8.321812e-07  12.0442403  2.079838e-33
curr_pts_grp1-3    5.007283e-05 3.215901e-07 155.7038688  0.000000e+00
curr_pts_grp4-6    9.051601e-05 6.790399e-07 133.2999915  0.000000e+00
curr_pts_grp7-9    1.326965e-04 1.268065e-06 104.6448978  0.000000e+00
curr_pts_grp10-150 1.997082e-04 1.786820e-06 111.7673408  0.000000e+00
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)        -4.695109e-06 1.384671e-06  -3.390777 6.969483e-04
policyTRUE         -4.107698e-06 3.941533e-07 -10.421577 1.976487e-25
age_grp16-19        1.892880e-04 2.043097e-06  92.647583 0.000000e+00
age_grp20-24        1.765071e-04 1.645923e-06 107.238974 0.000000e+00
age_grp25-34        1.563463e-04 1.460256e-06 107.067723 0.000000e+00
age_grp35-44        1.486871e-04 1.442240e-06 103.094570 0.000000e+00
age_grp45-54        1.387009e-04 1.428965e-06  97.063936 0.000000e+00
age_grp55-64        1.152271e-04 1.434622e-06  80.318780 0.000000e+00
age_grp65-199       7.025612e-05 1.417755e-06  49.554482 0.000000e+00
curr_pts_grp1-3     2.492910e-04 7.207042e-07 345.899210 0.000000e+00
curr_pts_grp4-6     4.579978e-04 1.527934e-06 299.749643 0.000000e+00
curr_pts_grp7-9     6.058217e-04 2.737216e-06 221.327664 0.000000e+00
curr_pts_grp10-150  7.185760e-04 3.477069e-06 206.661440 0.000000e+00
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.158139e-04 3.084725e-06   37.544308 1.744967e-308
policyTRUE         -4.759100e-05 4.355575e-07 -109.264555  0.000000e+00
age_grp16-19        2.507004e-04 3.631839e-06   69.028497  0.000000e+00
age_grp20-24        2.096315e-04 3.279033e-06   63.930885  0.000000e+00
age_grp25-34        1.025736e-04 3.130044e-06   32.770661 1.542185e-235
age_grp35-44        6.125863e-05 3.115025e-06   19.665538  4.256340e-86
age_grp45-54        3.207647e-05 3.105192e-06   10.329946  5.158942e-25
age_grp55-64        4.586059e-06 3.106688e-06    1.476189  1.398931e-01
age_grp65-199      -2.445668e-05 3.101001e-06   -7.886705  3.102705e-15
curr_pts_grp1-3     2.954162e-04 7.827166e-07  377.424272  0.000000e+00
curr_pts_grp4-6     5.942798e-04 1.725496e-06  344.411063  0.000000e+00
curr_pts_grp7-9     8.405666e-04 3.193546e-06  263.207920  0.000000e+00
curr_pts_grp10-150  1.162611e-03 4.346159e-06  267.502965  0.000000e+00
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.508658e-05 1.040480e-06  14.499644  1.217808e-47
policyTRUE         -8.086005e-07 6.619765e-08 -12.214943  2.586844e-34
age_grp16-19        5.087140e-05 1.249833e-06  40.702575  0.000000e+00
age_grp20-24        3.193248e-06 1.066788e-06   2.993329  2.759524e-03
age_grp25-34       -1.083737e-05 1.043146e-06 -10.389125  2.778914e-25
age_grp35-44       -1.393488e-05 1.041167e-06 -13.383904  7.509739e-41
age_grp45-54       -1.473477e-05 1.040451e-06 -14.161904  1.576641e-45
age_grp55-64       -1.481386e-05 1.040290e-06 -14.240127  5.163316e-46
age_grp65-199      -1.462379e-05 1.040081e-06 -14.060233  6.666646e-45
curr_pts_grp1-3     2.790903e-06 1.029870e-07  27.099568 9.962661e-162
curr_pts_grp4-6     1.111201e-05 2.567024e-07  43.287504  0.000000e+00
curr_pts_grp7-9     2.067767e-05 5.254877e-07  39.349476  0.000000e+00
curr_pts_grp10-150  4.603121e-05 8.739549e-07  52.670004  0.000000e+00
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         2.032079e-06 1.495981e-07  13.583585  5.011267e-42
policyTRUE         -8.200932e-06 9.950776e-08 -82.414998  0.000000e+00
age_grp16-19        4.063773e-05 6.054553e-07  67.119289  0.000000e+00
age_grp20-24        3.221570e-05 3.556981e-07  90.570343  0.000000e+00
age_grp25-34        1.505375e-05 2.012006e-07  74.819598  0.000000e+00
age_grp35-44        6.717562e-06 1.731804e-07  38.789381  0.000000e+00
age_grp45-54        3.835754e-06 1.604014e-07  23.913476 2.217984e-126
age_grp55-64        2.200900e-06 1.566490e-07  14.049882  7.716266e-45
age_grp65-199       1.431295e-06 1.492010e-07   9.593067  8.550462e-22
curr_pts_grp1-3     1.484139e-05 1.725005e-07  86.036791  0.000000e+00
curr_pts_grp4-6     3.362024e-05 4.067353e-07  82.658777  0.000000e+00
curr_pts_grp7-9     5.351641e-05 8.002634e-07  66.873495  0.000000e+00
curr_pts_grp10-150  1.020340e-04 1.263241e-06  80.771612  0.000000e+00
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         5.032049e-07 7.366231e-08   6.8312400  8.418376e-12
policyTRUE         -1.628000e-06 4.174014e-08 -39.0032130  0.000000e+00
age_grp16-19        1.197918e-05 3.171027e-07  37.7769742 2.714378e-312
age_grp20-24        7.839098e-06 1.712890e-07  45.7653442  0.000000e+00
age_grp25-34        2.606000e-06 9.283788e-08  28.0704398 2.249443e-173
age_grp35-44        5.166155e-07 7.912081e-08   6.5294510  6.601122e-11
age_grp45-54        2.524177e-08 7.442499e-08   0.3391571  7.344914e-01
age_grp55-64       -8.782449e-08 7.283417e-08  -1.2058145  2.278890e-01
age_grp65-199       2.069061e-08 7.149441e-08   0.2894019  7.722739e-01
curr_pts_grp1-3     2.118541e-06 6.771689e-08  31.2852691 7.402737e-215
curr_pts_grp4-6     5.456187e-06 1.664244e-07  32.7847825 9.703328e-236
curr_pts_grp7-9     1.012568e-05 3.494155e-07  28.9788946 1.214070e-184
curr_pts_grp10-150  2.677240e-05 6.387970e-07  41.9106616  0.000000e+00
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         4.821786e-06 5.840639e-07   8.255580  1.511662e-16
policyTRUE         -6.748841e-07 4.466423e-08 -15.110171  1.387798e-51
age_grp16-19        6.979776e-06 6.569944e-07  10.623799  2.309664e-26
age_grp20-24        1.473013e-06 6.000476e-07   2.454827  1.409525e-02
age_grp25-34       -2.438098e-06 5.861932e-07  -4.159205  3.193567e-05
age_grp35-44       -3.479699e-06 5.849602e-07  -5.948608  2.704321e-09
age_grp45-54       -3.755408e-06 5.844234e-07  -6.425834  1.311488e-10
age_grp55-64       -3.919606e-06 5.844124e-07  -6.706918  1.987777e-11
age_grp65-199      -3.276474e-06 5.850689e-07  -5.600151  2.141656e-08
curr_pts_grp1-3     2.062242e-06 7.372325e-08  27.972745 3.487295e-172
curr_pts_grp4-6     4.519232e-06 1.608473e-07  28.096416 1.083565e-173
curr_pts_grp7-9     7.730298e-06 3.182590e-07  24.289330 2.541583e-130
curr_pts_grp10-150  1.823804e-05 5.406728e-07  33.732124 1.955294e-249
```



## Placebo regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                              Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)                1.149554e-04 7.277520e-06  15.79595915  3.317112e-56
placeboTRUE               -1.797079e-05 1.021525e-05  -1.75921237  7.854144e-02
age_grp16-19               6.514339e-04 9.353429e-06  69.64652826  0.000000e+00
age_grp20-24               4.922013e-04 7.952435e-06  61.89315242  0.000000e+00
age_grp25-34               3.108961e-04 7.469908e-06  41.61980564  0.000000e+00
age_grp35-44               2.352070e-04 7.410972e-06  31.73767662 4.697628e-221
age_grp45-54               1.813057e-04 7.383475e-06  24.55560366 3.768337e-133
age_grp55-64               1.187772e-04 7.392461e-06  16.06734570  4.322033e-58
age_grp65-199              2.467607e-05 7.363083e-06   3.35132380  8.042620e-04
curr_pts_grp1-3            6.516915e-04 1.700882e-06 383.14914112  0.000000e+00
curr_pts_grp4-6            1.267644e-03 3.781511e-06 335.22162130  0.000000e+00
curr_pts_grp7-9            1.750863e-03 6.926532e-06 252.77634071  0.000000e+00
curr_pts_grp10-150         2.579855e-03 1.020644e-05 252.76747140  0.000000e+00
placeboTRUE:age_grp16-19  -2.940797e-05 1.309724e-05  -2.24535726  2.474521e-02
placeboTRUE:age_grp20-24  -1.012036e-06 1.122610e-05  -0.09015025  9.281678e-01
placeboTRUE:age_grp25-34   1.342758e-05 1.050719e-05   1.27794154  2.012700e-01
placeboTRUE:age_grp35-44   1.235846e-05 1.042003e-05   1.18602948  2.356107e-01
placeboTRUE:age_grp45-54   1.977586e-05 1.037544e-05   1.90602631  5.664679e-02
placeboTRUE:age_grp55-64   2.331735e-05 1.038589e-05   2.24509934  2.476176e-02
placeboTRUE:age_grp65-199  2.729378e-05 1.034248e-05   2.63899840  8.315137e-03
```


Repeat without the policy-age interaction.

```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         1.069724e-04 5.129576e-06  20.854041  1.400797e-96
placeboTRUE        -2.008517e-06 9.056199e-07  -2.217837  2.656597e-02
age_grp16-19        6.360468e-04 6.551614e-06  97.082473  0.000000e+00
age_grp20-24        4.918031e-04 5.591238e-06  87.959596  0.000000e+00
age_grp25-34        3.176350e-04 5.243462e-06  60.577351  0.000000e+00
age_grp35-44        2.414247e-04 5.204149e-06  46.390811  0.000000e+00
age_grp45-54        1.912258e-04 5.184206e-06  36.886217 7.688121e-298
age_grp55-64        1.305169e-04 5.191160e-06  25.142136 1.722817e-139
age_grp65-199       3.848933e-05 5.171200e-06   7.443016  9.841243e-14
curr_pts_grp1-3     6.516769e-04 1.700879e-06 383.141331  0.000000e+00
curr_pts_grp4-6     1.267537e-03 3.781424e-06 335.200919  0.000000e+00
curr_pts_grp7-9     1.750610e-03 6.926327e-06 252.747258  0.000000e+00
curr_pts_grp10-150  2.579242e-03 1.020601e-05 252.718043  0.000000e+00
```
