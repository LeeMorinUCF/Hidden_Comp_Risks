
# Linear Probability Models - All Male Drivers with High Past Balances

Here, I am defining drivers with high past balances as any driver who, at any time
in the pre-period, had a current points balance between 6 and 10 points.
However, I was not so careful as to include those drivers who have ever had a
points balance above 10 points.
For example, someone who gets a 12-point as their first infraction jumps right over
this category and is not included.
On the other hand, someone who gets 10 3-point tickets in a year is included,
even though the total gets them up to 30 points.
They still have between 6 and 10 points at one time.
We could revise this definition, if necessary, but it is computationally expensive.

## Linear Regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)              -0.0001536148 6.423505e-05  -2.391449  1.678202e-02
policyTRUE               -0.0009947244 6.423318e-05 -15.486144  4.303442e-54
age_grp16-19              0.0014987062 6.576247e-05  22.789688 5.803163e-115
age_grp20-24              0.0010819465 6.441540e-05  16.796395  2.593414e-63
age_grp25-34              0.0009136942 6.428252e-05  14.213727  7.530918e-46
age_grp35-44              0.0008195494 6.429161e-05  12.747379  3.224075e-37
age_grp45-54              0.0007600599 6.430688e-05  11.819263  3.103988e-32
age_grp55-64              0.0006503469 6.436104e-05  10.104667  5.267425e-24
age_grp65-199             0.0004627156 6.445407e-05   7.178998  7.022398e-13
curr_pts_grp1-3           0.0004114336 2.245026e-06 183.264497  0.000000e+00
curr_pts_grp4-6           0.0008869449 3.173496e-06 279.485137  0.000000e+00
curr_pts_grp7-9           0.0013148351 4.755202e-06 276.504566  0.000000e+00
curr_pts_grp10-150        0.0021022578 6.551344e-06 320.889533  0.000000e+00
policyTRUE:age_grp16-19  -0.0009354040 6.684656e-05 -13.993300  1.712780e-44
policyTRUE:age_grp20-24   0.0002363921 6.458539e-05   3.660148  2.520701e-04
policyTRUE:age_grp25-34   0.0006345946 6.436228e-05   9.859729  6.221753e-23
policyTRUE:age_grp35-44   0.0006860276 6.438436e-05  10.655190  1.649079e-26
policyTRUE:age_grp45-54   0.0007025405 6.440592e-05  10.908012  1.055394e-27
policyTRUE:age_grp55-64   0.0007501935 6.449125e-05  11.632485  2.817757e-31
policyTRUE:age_grp65-199  0.0008333253 6.462331e-05  12.895119  4.795235e-38

Residual standard error: 0.03221 on 921131792 degrees of freedom
Multiple R-squared:  0.0004197,	Adjusted R-squared:  0.0004196
F-statistic: 2.035e+04 on 19 and 921131792 DF,  p-value: < 2.2e-16
```

Repeat without the policy-age interaction.

```R
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)        -0.0002717178 5.218779e-05   -5.206539  1.923949e-07
policyTRUE         -0.0003792339 2.114533e-06 -179.346430  0.000000e+00
age_grp16-19        0.0011872393 5.324619e-05   22.297171 3.936389e-110
age_grp20-24        0.0010285129 5.226381e-05   19.679257  3.247421e-86
age_grp25-34        0.0010402627 5.219509e-05   19.930277  2.223396e-88
age_grp35-44        0.0009715138 5.219965e-05   18.611501  2.592616e-77
age_grp45-54        0.0009218817 5.220548e-05   17.658716  8.720300e-70
age_grp55-64        0.0008379802 5.223301e-05   16.043116  6.386898e-58
age_grp65-199       0.0007003133 5.227477e-05   13.396776  6.314781e-41
curr_pts_grp1-3     0.0004170029 2.242939e-06  185.918078  0.000000e+00
curr_pts_grp4-6     0.0008906334 3.172979e-06  280.693153  0.000000e+00
curr_pts_grp7-9     0.0013142762 4.755903e-06  276.346272  0.000000e+00
curr_pts_grp10-150  0.0020916783 6.551100e-06  319.286592  0.000000e+00

Residual standard error: 0.03221 on 921131799 degrees of freedom
Multiple R-squared:  0.0004061,	Adjusted R-squared:  0.0004061
F-statistic: 3.118e+04 on 12 and 921131799 DF,  p-value: < 2.2e-16
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                        Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)        -6.425691e-05 6.931291e-06  -9.270554 1.851812e-20
policyTRUE         -5.327493e-06 5.722699e-07  -9.309406 1.285490e-20
age_grp16-19        7.082070e-05 7.333633e-06   9.656974 4.592311e-22
age_grp20-24        7.871860e-05 6.963817e-06  11.303945 1.254540e-29
age_grp25-34        9.992722e-05 6.939816e-06  14.399117 5.240979e-47
age_grp35-44        1.045416e-04 6.946048e-06  15.050518 3.425478e-51
age_grp45-54        1.039346e-04 6.951130e-06  14.952189 1.507139e-50
age_grp55-64        9.812665e-05 6.968797e-06  14.080860 4.980092e-45
age_grp65-199       8.035944e-05 6.985052e-06  11.504486 1.252332e-30
curr_pts_grp1-3     2.948931e-05 5.747551e-07  51.307608 0.000000e+00
curr_pts_grp4-6     7.038747e-05 8.454245e-07  83.256960 0.000000e+00
curr_pts_grp7-9     1.160054e-04 1.332959e-06  87.028484 0.000000e+00
curr_pts_grp10-150  1.983066e-04 1.933433e-06 102.567078 0.000000e+00

Residual standard error: 0.008699 on 921131799 degrees of freedom
Multiple R-squared:  4.034e-05,	Adjusted R-squared:  4.033e-05
F-statistic:  3097 on 12 and 921131799 DF,  p-value: < 2.2e-16
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                        Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)        -0.0002775352 1.387127e-05 -20.00791  4.699584e-89
policyTRUE         -0.0000766478 1.260855e-06 -60.79033  0.000000e+00
age_grp16-19        0.0003354079 1.472774e-05  22.77389 8.322368e-115
age_grp20-24        0.0004317708 1.395966e-05  30.92990 4.736348e-210
age_grp25-34        0.0005098440 1.389608e-05  36.68977 1.063751e-294
age_grp35-44        0.0005117728 1.390873e-05  36.79507 2.214833e-296
age_grp45-54        0.0005064746 1.392075e-05  36.38271 7.992992e-290
age_grp55-64        0.0004772995 1.396218e-05  34.18518 4.016178e-256
age_grp65-199       0.0004059692 1.401184e-05  28.97329 1.428819e-184
curr_pts_grp1-3     0.0001419348 1.324762e-06 107.13984  0.000000e+00
curr_pts_grp4-6     0.0003453231 1.923982e-06 179.48350  0.000000e+00
curr_pts_grp7-9     0.0004971643 2.865962e-06 173.47206  0.000000e+00
curr_pts_grp10-150  0.0006891553 3.761557e-06 183.21012  0.000000e+00

Residual standard error: 0.01914 on 921131799 degrees of freedom
Multiple R-squared:  0.0001272,	Adjusted R-squared:  0.0001272
F-statistic:  9764 on 12 and 921131799 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                        Estimate   Std. Error      t value     Pr(>|t|)
(Intercept)        -2.129839e-05 4.342965e-05   -0.4904112 6.238430e-01
policyTRUE         -2.442216e-04 1.519724e-06 -160.7012440 0.000000e+00
age_grp16-19        5.490810e-04 4.410229e-05   12.4501708 1.395471e-35
age_grp20-24        4.885116e-04 4.347795e-05   11.2358455 2.718797e-29
age_grp25-34        4.510868e-04 4.343080e-05   10.3863331 2.861445e-25
age_grp35-44        4.026739e-04 4.343266e-05    9.2712229 1.840241e-20
age_grp45-54        3.688513e-04 4.343555e-05    8.4919227 2.032465e-17
age_grp55-64        3.266769e-04 4.345212e-05    7.5180871 5.558353e-14
age_grp65-199       2.797665e-04 4.348244e-05    6.4340093 1.242813e-10
curr_pts_grp1-3     2.283930e-04 1.634921e-06  139.6966962 0.000000e+00
curr_pts_grp4-6     4.437875e-04 2.270067e-06  195.4953233 0.000000e+00
curr_pts_grp7-9     6.432731e-04 3.375796e-06  190.5545196 0.000000e+00
curr_pts_grp10-150  1.045306e-03 4.666326e-06  224.0105130 0.000000e+00

Residual standard error: 0.02316 on 921131799 degrees of freedom
Multiple R-squared:  0.0002102,	Adjusted R-squared:  0.0002102
F-statistic: 1.614e+04 on 12 and 921131799 DF,  p-value: < 2.2e-16
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                        Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)         8.777289e-05 2.128423e-05   4.123846 3.725982e-05
policyTRUE         -8.424877e-06 2.046443e-07 -41.168386 0.000000e+00
age_grp16-19        4.914140e-05 2.149178e-05   2.286521 2.222379e-02
age_grp20-24       -6.209957e-05 2.128471e-05  -2.917567 3.527739e-03
age_grp25-34       -7.744112e-05 2.127916e-05  -3.639294 2.733862e-04
age_grp35-44       -8.225124e-05 2.127832e-05  -3.865494 1.108644e-04
age_grp45-54       -8.393335e-05 2.127793e-05  -3.944620 7.992646e-05
age_grp55-64       -8.426223e-05 2.127816e-05  -3.960033 7.493936e-05
age_grp65-199      -8.399205e-05 2.127892e-05  -3.947194 7.907234e-05
curr_pts_grp1-3     1.910159e-06 2.101883e-07   9.087843 1.010233e-19
curr_pts_grp4-6     4.225809e-06 2.959347e-07  14.279530 2.935790e-46
curr_pts_grp7-9     9.844593e-06 4.955123e-07  19.867504 7.777778e-88
curr_pts_grp10-150  3.271505e-05 8.341615e-07  39.219082 0.000000e+00

Residual standard error: 0.003325 on 921131799 degrees of freedom
Multiple R-squared:  4.104e-05,	Adjusted R-squared:  4.103e-05
F-statistic:  3150 on 12 and 921131799 DF,  p-value: < 2.2e-16
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                        Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)        -2.284785e-05 3.789509e-07 -60.29238  0.000000e+00
policyTRUE         -3.316486e-05 3.926897e-07 -84.45563  0.000000e+00
age_grp16-19        1.316209e-04 2.952071e-06  44.58595  0.000000e+00
age_grp20-24        8.674681e-05 8.942798e-07  97.00187  0.000000e+00
age_grp25-34        6.624571e-05 5.399391e-07 122.69108  0.000000e+00
age_grp35-44        5.096647e-05 4.861003e-07 104.84764  0.000000e+00
age_grp45-54        4.509329e-05 4.673536e-07  96.48645  0.000000e+00
age_grp55-64        3.936244e-05 4.827828e-07  81.53241  0.000000e+00
age_grp65-199       3.648971e-05 5.116241e-07  71.32133  0.000000e+00
curr_pts_grp1-3     1.532648e-05 4.163321e-07  36.81310 1.139933e-296
curr_pts_grp4-6     2.520264e-05 5.662445e-07  44.50841  0.000000e+00
curr_pts_grp7-9     3.919603e-05 8.671372e-07  45.20165  0.000000e+00
curr_pts_grp10-150  8.992297e-05 1.355387e-06  66.34484  0.000000e+00

Residual standard error: 0.006053 on 921131799 degrees of freedom
Multiple R-squared:  3.506e-05,	Adjusted R-squared:  3.504e-05
F-statistic:  2691 on 12 and 921131799 DF,  p-value: < 2.2e-16
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)        -2.027649e-06 1.770199e-07 -11.454356  2.236204e-30
policyTRUE         -7.259448e-06 1.728721e-07 -41.993168  0.000000e+00
age_grp16-19        4.703169e-05 1.767496e-06  26.609216 5.310900e-156
age_grp20-24        2.101324e-05 4.491617e-07  46.783250  0.000000e+00
age_grp25-34        1.228470e-05 2.388307e-07  51.436853  0.000000e+00
age_grp35-44        7.798200e-06 1.892591e-07  41.203835  0.000000e+00
age_grp45-54        5.990910e-06 1.630685e-07  36.738613 1.768055e-295
age_grp55-64        5.237234e-06 1.580511e-07  33.136343 8.911925e-241
age_grp65-199       5.321584e-06 1.742902e-07  30.532882 9.545506e-205
curr_pts_grp1-3     9.775871e-07 1.831800e-07   5.336756  9.462423e-08
curr_pts_grp4-6     1.362143e-06 2.339969e-07   5.821202  5.842609e-09
curr_pts_grp7-9     4.947065e-06 3.797267e-07  13.027961  8.484568e-39
curr_pts_grp10-150  2.201901e-05 6.852218e-07  32.134132 1.471998e-226

Residual standard error: 0.002707 on 921131799 degrees of freedom
Multiple R-squared:  1.41e-05,	Adjusted R-squared:  1.408e-05
F-statistic:  1082 on 12 and 921131799 DF,  p-value: < 2.2e-16
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         2.845369e-05 1.196192e-05   2.3786889  1.737433e-02
policyTRUE         -3.538072e-06 1.451310e-07 -24.3784705 2.894069e-131
age_grp16-19       -2.236062e-06 1.203110e-05  -0.1858569  8.525570e-01
age_grp20-24       -1.775487e-05 1.196116e-05  -1.4843760  1.377092e-01
age_grp25-34       -2.220770e-05 1.195779e-05  -1.8571743  6.328636e-02
age_grp35-44       -2.428475e-05 1.195734e-05  -2.0309495  4.226011e-02
age_grp45-54       -2.480677e-05 1.195721e-05  -2.0746288  3.802095e-02
age_grp55-64       -2.475524e-05 1.195772e-05  -2.0702311  3.843071e-02
age_grp65-199      -2.390316e-05 1.195965e-05  -1.9986503  4.564620e-02
curr_pts_grp1-3    -1.034788e-06 1.487977e-07  -6.9543327  3.542349e-12
curr_pts_grp4-6     3.299655e-07 2.002130e-07   1.6480725  9.933780e-02
curr_pts_grp7-9     3.658721e-06 3.270816e-07  11.1859569  4.777261e-29
curr_pts_grp10-150  1.351406e-05 5.478928e-07  24.6655118 2.509119e-134

Residual standard error: 0.002245 on 921131799 degrees of freedom
Multiple R-squared:  6.425e-06,	Adjusted R-squared:  6.412e-06
F-statistic: 493.2 on 12 and 921131799 DF,  p-value: < 2.2e-16
```
