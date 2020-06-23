
# Linear Probability Models - All Female Drivers with High Past Balances

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
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)              -7.971864e-04 6.808413e-06 -117.088430  0.000000e+00
policyTRUE               -1.017591e-04 4.611722e-06  -22.065316 6.810783e-108
age_grp16-19              1.541736e-03 2.878563e-05   53.559229  0.000000e+00
age_grp20-24              1.431069e-03 1.101541e-05  129.915212  0.000000e+00
age_grp25-34              1.287230e-03 8.109743e-06  158.726405  0.000000e+00
age_grp35-44              1.256070e-03 8.048376e-06  156.064981  0.000000e+00
age_grp45-54              1.190004e-03 8.400853e-06  141.652793  0.000000e+00
age_grp55-64              1.081198e-03 9.458055e-06  114.315031  0.000000e+00
age_grp65-199             9.392817e-04 1.127235e-05   83.326174  0.000000e+00
curr_pts_grp1-3           2.812848e-04 3.378008e-06   83.269440  0.000000e+00
curr_pts_grp4-6           6.250173e-04 5.004951e-06  124.879807  0.000000e+00
curr_pts_grp7-9           9.290088e-04 8.126635e-06  114.316539  0.000000e+00
curr_pts_grp10-150        1.587146e-03 1.521073e-05  104.343883  0.000000e+00
policyTRUE:age_grp16-19  -1.170040e-03 3.383173e-05  -34.584121 4.384208e-262
policyTRUE:age_grp20-24  -4.940161e-04 1.206807e-05  -40.935799  0.000000e+00
policyTRUE:age_grp25-34  -1.623955e-04 7.761312e-06  -20.923719  3.257633e-97
policyTRUE:age_grp35-44  -1.284556e-04 7.728187e-06  -16.621703  4.853763e-62
policyTRUE:age_grp45-54  -1.001738e-04 8.193126e-06  -12.226561  2.242382e-34
policyTRUE:age_grp55-64  -4.623797e-05 9.858289e-06   -4.690263  2.728537e-06
policyTRUE:age_grp65-199  2.320073e-05 1.254767e-05    1.849008  6.445666e-02

Residual standard error: 0.02504 on 249294607 degrees of freedom
Multiple R-squared:  0.0002813,	Adjusted R-squared:  0.0002812
F-statistic:  3692 on 19 and 249294607 DF,  p-value: < 2.2e-16
```

Repeat without the policy-age interaction.

```R
                        Estimate   Std. Error    t value Pr(>|t|)
(Intercept)        -0.0007389583 6.907934e-06 -106.97241        0
policyTRUE         -0.0002588862 3.153421e-06  -82.09692        0
age_grp16-19        0.0012193920 2.196477e-05   55.51582        0
age_grp20-24        0.0012232890 8.544097e-06  143.17359        0
age_grp25-34        0.0012255719 7.236468e-06  169.36051        0
age_grp35-44        0.0012113695 7.210949e-06  167.99029        0
age_grp45-54        0.0011609997 7.352155e-06  157.91284        0
age_grp55-64        0.0010816312 7.837656e-06  138.00443        0
age_grp65-199       0.0009811436 8.560130e-06  114.61785        0
curr_pts_grp1-3     0.0002848003 3.375098e-06   84.38281        0
curr_pts_grp4-6     0.0006265306 5.005422e-06  125.17038        0
curr_pts_grp7-9     0.0009267902 8.126488e-06  114.04560        0
curr_pts_grp10-150  0.0015800124 1.520967e-05  103.88208        0

Residual standard error: 0.02504 on 249294614 degrees of freedom
Multiple R-squared:  0.000273,	Adjusted R-squared:  0.000273
F-statistic:  5673 on 12 and 249294614 DF,  p-value: < 2.2e-16
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)        -6.693390e-05 1.768452e-06 -37.8488613 1.791325e-313
policyTRUE         -8.082082e-07 8.302640e-07  -0.9734352  3.303370e-01
age_grp16-19        8.171772e-05 5.515192e-06  14.8168402  1.140288e-49
age_grp20-24        8.641910e-05 2.181284e-06  39.6184577  0.000000e+00
age_grp25-34        9.191503e-05 1.859135e-06  49.4396703  0.000000e+00
age_grp35-44        8.764504e-05 1.848914e-06  47.4035324  0.000000e+00
age_grp45-54        8.456214e-05 1.885844e-06  44.8404614  0.000000e+00
age_grp55-64        7.869381e-05 1.989442e-06  39.5557206  0.000000e+00
age_grp65-199       7.145321e-05 2.162321e-06  33.0446812 1.857057e-239
curr_pts_grp1-3     1.761959e-05 8.388807e-07  21.0036875  6.069927e-98
curr_pts_grp4-6     4.713445e-05 1.313635e-06  35.8809396 6.067667e-282
curr_pts_grp7-9     7.605612e-05 2.231393e-06  34.0845970 1.249319e-254
curr_pts_grp10-150  1.620210e-04 4.704847e-06  34.4370471 7.047452e-260

Residual standard error: 0.006605 on 249294614 degrees of freedom
Multiple R-squared:  2.853e-05,	Adjusted R-squared:  2.848e-05
F-statistic: 592.7 on 12 and 249294614 DF,  p-value: < 2.2e-16
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                        Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)        -3.309145e-04 4.198315e-06 -78.82081  0.000000e+00
policyTRUE         -5.845118e-05 1.970500e-06 -29.66312 2.299122e-193
age_grp16-19        3.542286e-04 1.111159e-05  31.87921 5.190628e-223
age_grp20-24        4.589369e-04 5.086257e-06  90.23077  0.000000e+00
age_grp25-34        4.967889e-04 4.403463e-06 112.81779  0.000000e+00
age_grp35-44        4.973961e-04 4.420221e-06 112.52743  0.000000e+00
age_grp45-54        4.796815e-04 4.525099e-06 106.00464  0.000000e+00
age_grp55-64        4.449541e-04 4.828467e-06  92.15226  0.000000e+00
age_grp65-199       3.988490e-04 5.246300e-06  76.02481  0.000000e+00
curr_pts_grp1-3     9.886461e-05 2.057649e-06  48.04736  0.000000e+00
curr_pts_grp4-6     2.700769e-04 3.190878e-06  84.64033  0.000000e+00
curr_pts_grp7-9     3.923478e-04 5.181668e-06  75.71842  0.000000e+00
curr_pts_grp10-150  5.981399e-04 9.349920e-06  63.97273  0.000000e+00

Residual standard error: 0.01563 on 249294614 degrees of freedom
Multiple R-squared:  0.000105,	Adjusted R-squared:  0.0001049
F-statistic:  2181 on 12 and 249294614 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                        Estimate   Std. Error   t value Pr(>|t|)
(Intercept)        -0.0003304780 4.673409e-06 -70.71455        0
policyTRUE         -0.0001761885 2.249506e-06 -78.32317        0
age_grp16-19        0.0006494143 1.629118e-05  39.86293        0
age_grp20-24        0.0006192106 5.952666e-06 104.02240        0
age_grp25-34        0.0005984665 4.919389e-06 121.65465        0
age_grp35-44        0.0005942740 4.885236e-06 121.64694        0
age_grp45-54        0.0005682141 4.983729e-06 114.01385        0
age_grp55-64        0.0005309008 5.369532e-06  98.87282        0
age_grp65-199       0.0004853566 5.959556e-06  81.44173        0
curr_pts_grp1-3     0.0001622957 2.465422e-06  65.82877        0
curr_pts_grp4-6     0.0002987854 3.528070e-06  84.68807        0
curr_pts_grp7-9     0.0004361322 5.672255e-06  76.88868        0
curr_pts_grp10-150  0.0007530523 1.058159e-05  71.16628        0

Residual standard error: 0.01786 on 249294614 degrees of freedom
Multiple R-squared:  0.0001363,	Adjusted R-squared:  0.0001363
F-statistic:  2832 on 12 and 249294614 DF,  p-value: < 2.2e-16
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                        Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)        -1.185719e-06 3.836026e-07  -3.091009 1.994776e-03
policyTRUE         -2.417589e-06 1.809114e-07 -13.363385 9.896297e-41
age_grp16-19        3.788114e-05 4.116521e-06   9.202223 3.506222e-20
age_grp20-24        6.938387e-06 6.189950e-07  11.209118 3.678482e-29
age_grp25-34        3.978724e-06 4.198577e-07   9.476363 2.633036e-21
age_grp35-44        3.098751e-06 3.875802e-07   7.995124 1.294440e-15
age_grp45-54        2.564886e-06 3.782118e-07   6.781612 1.188422e-11
age_grp55-64        2.362378e-06 3.805470e-07   6.207848 5.371523e-10
age_grp65-199       2.504023e-06 4.258302e-07   5.880332 4.094456e-09
curr_pts_grp1-3     6.400155e-07 1.953940e-07   3.275512 1.054706e-03
curr_pts_grp4-6     9.516342e-07 2.673791e-07   3.559119 3.721010e-04
curr_pts_grp7-9     2.443281e-06 4.941564e-07   4.944347 7.639956e-07
curr_pts_grp10-150  1.133621e-05 1.275932e-06   8.884648 6.412403e-19

Residual standard error: 0.001515 on 249294614 degrees of freedom
Multiple R-squared:  8.396e-06,	Adjusted R-squared:  8.348e-06
F-statistic: 174.4 on 12 and 249294614 DF,  p-value: < 2.2e-16
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                        Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)        -1.008042e-05 9.483494e-07 -10.62944  2.174221e-26
policyTRUE         -1.636294e-05 4.687461e-07 -34.90790 5.649594e-267
age_grp16-19        6.153154e-05 5.198060e-06  11.83740  2.500795e-32
age_grp20-24        4.211911e-05 1.488817e-06  28.29031 4.550456e-176
age_grp25-34        2.838825e-05 1.033976e-06  27.45542 5.988898e-166
age_grp35-44        2.399436e-05 9.832883e-07  24.40216 1.622638e-131
age_grp45-54        2.160042e-05 9.922504e-07  21.76912 4.554239e-105
age_grp55-64        2.034133e-05 1.033938e-06  19.67365  3.627892e-86
age_grp65-199       1.825679e-05 1.060382e-06  17.21718  1.973950e-66
curr_pts_grp1-3     6.976486e-06 5.184234e-07  13.45712  2.796148e-41
curr_pts_grp4-6     9.913639e-06 7.083571e-07  13.99526  1.666366e-44
curr_pts_grp7-9     1.820800e-05 1.212245e-06  15.02006  5.426087e-51
curr_pts_grp10-150  4.267035e-05 2.512985e-06  16.97994  1.156083e-64

Residual standard error: 0.003774 on 249294614 degrees of freedom
Multiple R-squared:  1.493e-05,	Adjusted R-squared:  1.488e-05
F-statistic: 310.1 on 12 and 249294614 DF,  p-value: < 2.2e-16
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                        Estimate   Std. Error     t value     Pr(>|t|)
(Intercept)         4.416821e-07 2.898465e-07   1.5238483 1.275466e-01
policyTRUE         -2.018770e-06 1.513524e-07 -13.3382145 1.387474e-40
age_grp16-19        1.380707e-05 2.507298e-06   5.5067543 3.655102e-08
age_grp20-24        4.471874e-06 4.919253e-07   9.0905551 9.853537e-20
age_grp25-34        2.266442e-06 2.987161e-07   7.5872764 3.267009e-14
age_grp35-44        1.303963e-06 2.732603e-07   4.7718721 1.825215e-06
age_grp45-54        1.166539e-06 2.694691e-07   4.3290257 1.497705e-05
age_grp55-64        9.450693e-07 2.846524e-07   3.3200815 8.999117e-04
age_grp65-199       9.761082e-07 3.167797e-07   3.0813469 2.060664e-03
curr_pts_grp1-3    -1.279183e-07 1.654807e-07  -0.7730104 4.395162e-01
curr_pts_grp4-6     1.674284e-07 2.292466e-07   0.7303419 4.651812e-01
curr_pts_grp7-9     3.548003e-07 3.506806e-07   1.0117479 3.116586e-01
curr_pts_grp10-150  6.013258e-06 9.671214e-07   6.2176869 5.045378e-10

Residual standard error: 0.001236 on 249294614 degrees of freedom
Multiple R-squared:  3.166e-06,	Adjusted R-squared:  3.118e-06
F-statistic: 65.76 on 12 and 249294614 DF,  p-value: < 2.2e-16
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                        Estimate   Std. Error     t value     Pr(>|t|)
(Intercept)         1.634886e-07 4.018627e-07   0.4068269 6.841351e-01
policyTRUE         -2.563022e-06 2.019355e-07 -12.6922822 6.525788e-37
age_grp16-19        1.905135e-05 2.915797e-06   6.5338396 6.410474e-11
age_grp20-24        4.984545e-06 5.262055e-07   9.4726201 2.729129e-21
age_grp25-34        3.746455e-06 3.975828e-07   9.4230834 4.380354e-21
age_grp35-44        3.631839e-06 3.943785e-07   9.2090179 3.291247e-20
age_grp45-54        3.194000e-06 3.959064e-07   8.0675645 7.171462e-16
age_grp55-64        3.414928e-06 4.521374e-07   7.5528535 4.258253e-14
age_grp65-199       3.727160e-06 5.708047e-07   6.5296599 6.591931e-11
curr_pts_grp1-3    -1.439083e-06 2.096752e-07  -6.8633937 6.724371e-12
curr_pts_grp4-6    -4.375466e-07 2.940591e-07  -1.4879549 1.367628e-01
curr_pts_grp7-9     1.233077e-06 4.929001e-07   2.5016777 1.236064e-02
curr_pts_grp10-150  6.257887e-06 1.062533e-06   5.8895946 3.871447e-09

Residual standard error: 0.001583 on 249294614 degrees of freedom
Multiple R-squared:  2.522e-06,	Adjusted R-squared:  2.473e-06
F-statistic: 52.39 on 12 and 249294614 DF,  p-value: < 2.2e-16
```
