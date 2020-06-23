
# Linear Probability Models - All Drivers with High Past Balances

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
(Intercept)              -0.0001295216 6.296061e-05  -2.057185  3.966842e-02
policyTRUE               -0.0009702896 6.296470e-05 -15.410056  1.400920e-53
age_grp16-19              0.0014096903 6.425135e-05  21.940246 1.073244e-106
age_grp20-24              0.0010058345 6.310354e-05  15.939430  3.374216e-57
age_grp25-34              0.0008299438 6.299606e-05  13.174536  1.229825e-39
age_grp35-44              0.0007365194 6.299943e-05  11.690890  1.418925e-31
age_grp45-54              0.0006821894 6.301199e-05  10.826344  2.582639e-27
age_grp55-64              0.0005835250 6.305554e-05   9.254142  2.159576e-20
age_grp65-199             0.0004125561 6.313349e-05   6.534663  6.375287e-11
curr_pts_grp1-3           0.0003854830 1.900656e-06 202.815776  0.000000e+00
curr_pts_grp4-6           0.0008351965 2.715010e-06 307.621904  0.000000e+00
curr_pts_grp7-9           0.0012498895 4.148460e-06 301.290016  0.000000e+00
curr_pts_grp10-150        0.0020624829 6.037672e-06 341.602344  0.000000e+00
policyTRUE:age_grp16-19  -0.0008784435 6.515378e-05 -13.482618  1.979580e-41
policyTRUE:age_grp20-24   0.0002419874 6.323927e-05   3.826537  1.299586e-04
policyTRUE:age_grp25-34   0.0006324758 6.306060e-05  10.029651  1.129155e-23
policyTRUE:age_grp35-44   0.0006822263 6.307062e-05  10.816864  2.864115e-27
policyTRUE:age_grp45-54   0.0006990719 6.308819e-05  11.080869  1.553577e-28
policyTRUE:age_grp55-64   0.0007451114 6.315684e-05  11.797794  4.006782e-32
policyTRUE:age_grp65-199  0.0008238008 6.326999e-05  13.020403  9.367551e-39

Residual standard error: 0.03083 on 1170426419 degrees of freedom
Multiple R-squared:  0.0004073,	Adjusted R-squared:  0.0004073
F-statistic: 2.51e+04 on 19 and 1170426419 DF,  p-value: < 2.2e-16
```

Repeat without the policy-age interaction.

```R
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)        -0.0002502353 5.087393e-05   -4.918734  8.710565e-07
policyTRUE         -0.0003522462 1.794524e-06 -196.289484  0.000000e+00
age_grp16-19        0.0011192001 5.177577e-05   21.616290 1.262308e-103
age_grp20-24        0.0009570839 5.093448e-05   18.790492  9.034084e-79
age_grp25-34        0.0009568949 5.087902e-05   18.807261  6.585577e-79
age_grp35-44        0.0008881162 5.088056e-05   17.454923  3.158120e-68
age_grp45-54        0.0008438584 5.088555e-05   16.583460  9.179046e-62
age_grp55-64        0.0007701854 5.090769e-05   15.129060  1.041737e-51
age_grp65-199       0.0006464062 5.094268e-05   12.688893  6.814246e-37
curr_pts_grp1-3     0.0003906436 1.898894e-06  205.721600  0.000000e+00
curr_pts_grp4-6     0.0008382311 2.714737e-06  308.770698  0.000000e+00
curr_pts_grp7-9     0.0012486857 4.148990e-06  300.961360  0.000000e+00
curr_pts_grp10-150  0.0020519911 6.037227e-06  339.889672  0.000000e+00

Residual standard error: 0.03083 on 1170426426 degrees of freedom
Multiple R-squared:  0.0003944,	Adjusted R-squared:  0.0003944
F-statistic: 3.848e+04 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                        Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)        -6.100892e-05 6.753123e-06  -9.034179 1.652386e-19
policyTRUE         -4.269087e-06 4.838923e-07  -8.822391 1.120415e-18
age_grp16-19        6.959756e-05 7.102974e-06   9.798368 1.144194e-22
age_grp20-24        7.634926e-05 6.779954e-06  11.261029 2.043591e-29
age_grp25-34        9.422574e-05 6.759604e-06  13.939537 3.643001e-44
age_grp35-44        9.589269e-05 6.762609e-06  14.179836 1.221330e-45
age_grp45-54        9.522850e-05 6.766565e-06  14.073389 5.535252e-45
age_grp55-64        9.037635e-05 6.780332e-06  13.329193 1.565833e-40
age_grp65-199       7.525010e-05 6.794989e-06  11.074352 1.670843e-28
curr_pts_grp1-3     2.713790e-05 4.844892e-07  56.013419 0.000000e+00
curr_pts_grp4-6     6.583817e-05 7.219587e-07  91.193816 0.000000e+00
curr_pts_grp7-9     1.090701e-04 1.160103e-06  94.017610 0.000000e+00
curr_pts_grp10-150  1.950198e-04 1.789627e-06 108.972328 0.000000e+00
Residual standard error: 0.008298 on 1170426426 degrees of freedom
Multiple R-squared:  3.922e-05,	Adjusted R-squared:  3.921e-05
F-statistic:  3826 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                        Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)        -2.693979e-04 1.351388e-05 -19.93491  2.026823e-88
policyTRUE         -7.245787e-05 1.077505e-06 -67.24596  0.000000e+00
age_grp16-19        3.248325e-04 1.425345e-05  22.78975 5.795069e-115
age_grp20-24        4.183718e-04 1.358641e-05  30.79341 3.211488e-208
age_grp25-34        4.868716e-04 1.353311e-05  35.97632 1.963268e-283
age_grp35-44        4.849087e-04 1.353987e-05  35.81340 6.836080e-281
age_grp45-54        4.784126e-04 1.354944e-05  35.30865 4.327485e-273
age_grp55-64        4.514411e-04 1.358239e-05  33.23724 3.121680e-242
age_grp65-199       3.876022e-04 1.362527e-05  28.44731 5.262050e-178
curr_pts_grp1-3     1.335257e-04 1.127299e-06 118.44746  0.000000e+00
curr_pts_grp4-6     3.308858e-04 1.659565e-06 199.38105  0.000000e+00
curr_pts_grp7-9     4.799802e-04 2.520729e-06 190.41327  0.000000e+00
curr_pts_grp10-150  6.839852e-04 3.487861e-06 196.10449  0.000000e+00
Residual standard error: 0.01845 on 1170426426 degrees of freedom
Multiple R-squared:  0.0001259,	Adjusted R-squared:  0.0001259
F-statistic: 1.228e+04 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                        Estimate   Std. Error      t value     Pr(>|t|)
(Intercept)        -0.0000113382 4.233803e-05   -0.2678019 7.888518e-01
policyTRUE         -0.0002289550 1.288322e-06 -177.7156615 0.000000e+00
age_grp16-19        0.0005173051 4.291344e-05   12.0546182 1.833811e-33
age_grp20-24        0.0004460935 4.237624e-05   10.5269721 6.488837e-26
age_grp25-34        0.0004057498 4.233847e-05    9.5834788 9.383024e-22
age_grp35-44        0.0003606544 4.233880e-05    8.5182963 1.619178e-17
age_grp45-54        0.0003315248 4.234140e-05    7.8298023 4.886380e-15
age_grp55-64        0.0002949090 4.235485e-05    6.9628160 3.335375e-12
age_grp65-199       0.0002517123 4.237975e-05    5.9394481 2.859833e-09
curr_pts_grp1-3     0.0002152222 1.384513e-06  155.4497600 0.000000e+00
curr_pts_grp4-6     0.0004148056 1.937656e-06  214.0759479 0.000000e+00
curr_pts_grp7-9     0.0006080823 2.938139e-06  206.9617185 0.000000e+00
curr_pts_grp10-150  0.0010222473 4.291568e-06  238.1990273 0.000000e+00

Residual standard error: 0.02214 on 1170426426 degrees of freedom
Multiple R-squared:  0.0002032,	Adjusted R-squared:  0.0002032
F-statistic: 1.982e+04 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                        Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)         8.599745e-05 2.075200e-05   4.144056 3.412159e-05
policyTRUE         -7.109928e-06 1.655001e-07 -42.960260 0.000000e+00
age_grp16-19        3.848882e-05 2.092140e-05   1.839687 6.581425e-02
age_grp20-24       -6.390201e-05 2.075203e-05  -3.079314 2.074780e-03
age_grp25-34       -7.729865e-05 2.074795e-05  -3.725604 1.948484e-04
age_grp35-44       -8.139741e-05 2.074732e-05  -3.923273 8.735416e-05
age_grp45-54       -8.273731e-05 2.074707e-05  -3.987903 6.665986e-05
age_grp55-64       -8.298484e-05 2.074727e-05  -3.999795 6.339729e-05
age_grp65-199      -8.273617e-05 2.074783e-05  -3.987703 6.671609e-05
curr_pts_grp1-3     1.612014e-06 1.691923e-07   9.527701 1.608048e-21
curr_pts_grp4-6     3.493594e-06 2.396685e-07  14.576775 3.947322e-48
curr_pts_grp7-9     8.533164e-06 4.122090e-07  20.701062 3.388340e-95
curr_pts_grp10-150  3.095804e-05 7.507354e-07  41.236953 0.000000e+00

Residual standard error: 0.003032 on 1170426426 degrees of freedom
Multiple R-squared:  3.723e-05,	Adjusted R-squared:  3.722e-05
F-statistic:  3631 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                        Estimate   Std. Error   t value Pr(>|t|)
(Intercept)        -2.065112e-05 3.215680e-07 -64.22006        0
policyTRUE         -2.948456e-05 3.245597e-07 -90.84482        0
age_grp16-19        1.227396e-04 2.661711e-06  46.11306        0
age_grp20-24        7.880269e-05 7.715059e-07 102.14140        0
age_grp25-34        5.868704e-05 4.543502e-07 129.16698        0
age_grp35-44        4.513439e-05 4.021806e-07 112.22420        0
age_grp45-54        4.036288e-05 3.914804e-07 103.10320        0
age_grp55-64        3.587056e-05 4.124902e-07  86.96100        0
age_grp65-199       3.318126e-05 4.421152e-07  75.05117        0
curr_pts_grp1-3     1.353166e-05 3.436986e-07  39.37071        0
curr_pts_grp4-6     2.195866e-05 4.702194e-07  46.69875        0
curr_pts_grp7-9     3.547765e-05 7.389471e-07  48.01107        0
curr_pts_grp10-150  8.557901e-05 1.229914e-06  69.58129        0

Residual standard error: 0.005645 on 1170426426 degrees of freedom
Multiple R-squared:  3.265e-05,	Adjusted R-squared:  3.264e-05
F-statistic:  3185 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                        Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)        -1.758441e-06 1.464223e-07 -12.009375  3.172346e-33
policyTRUE         -6.122619e-06 1.397421e-07 -43.813712  0.000000e+00
age_grp16-19        4.294860e-05 1.577852e-06  27.219662 3.801589e-163
age_grp20-24        1.819825e-05 3.788714e-07  48.032785  0.000000e+00
age_grp25-34        1.039866e-05 1.963690e-07  52.954684  0.000000e+00
age_grp35-44        6.535326e-06 1.527629e-07  42.780847  0.000000e+00
age_grp45-54        5.179151e-06 1.350553e-07  38.348379 9.584874e-322
age_grp55-64        4.568443e-06 1.331981e-07  34.298106 8.377072e-258
age_grp65-199       4.629622e-06 1.490144e-07  31.068281 6.463512e-212
curr_pts_grp1-3     7.368078e-07 1.470935e-07   5.009111  5.468215e-07
curr_pts_grp4-6     1.088815e-06 1.902599e-07   5.722775  1.047980e-08
curr_pts_grp7-9     4.154505e-06 3.144088e-07  13.213704  7.313548e-40
curr_pts_grp10-150  2.061428e-05 6.141069e-07  33.567898 4.936493e-247

Residual standard error: 0.002468 on 1170426426 degrees of freedom
Multiple R-squared:  1.281e-05,	Adjusted R-squared:  1.28e-05
F-statistic:  1250 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                        Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         2.790497e-05 1.166249e-05   2.3927111  1.672441e-02
policyTRUE         -3.320869e-06 1.220040e-07 -27.2193519 3.833831e-163
age_grp16-19       -2.498886e-06 1.172248e-05  -0.2131705  8.311940e-01
age_grp20-24       -1.818471e-05 1.166178e-05  -1.5593421  1.189154e-01
age_grp25-34       -2.216068e-05 1.165922e-05  -1.9006999  5.734133e-02
age_grp35-44       -2.385487e-05 1.165890e-05  -2.0460646  4.075002e-02
age_grp45-54       -2.433992e-05 1.165882e-05  -2.0876827  3.682647e-02
age_grp55-64       -2.423810e-05 1.165926e-05  -2.0788703  3.762927e-02
age_grp65-199      -2.348097e-05 1.166082e-05  -2.0136627  4.404496e-02
curr_pts_grp1-3    -1.119333e-06 1.247131e-07  -8.9752644  2.826726e-19
curr_pts_grp4-6     1.659351e-07 1.693449e-07   0.9798643  3.271531e-01
curr_pts_grp7-9     3.230313e-06 2.808269e-07  11.5028629  1.276118e-30
curr_pts_grp10-150  1.283671e-05 4.987712e-07  25.7366726 4.545537e-146

Residual standard error: 0.002122 on 1170426426 degrees of freedom
Multiple R-squared:  5.88e-06,	Adjusted R-squared:  5.87e-06
F-statistic: 573.5 on 12 and 1170426426 DF,  p-value: < 2.2e-16
```
