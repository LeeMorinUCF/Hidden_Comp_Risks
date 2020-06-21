
# Linear Probability Models - Female Drivers


## Linear Regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate   Std. Error      t value      Pr(>|t|)
(Intercept)               3.641586e-05 4.639129e-06   7.84971924  4.169698e-15
policyTRUE               -6.704852e-06 6.347766e-06  -1.05625380  2.908523e-01
age_grp16-19              2.680807e-04 5.407495e-06  49.57576917  0.000000e+00
age_grp20-24              2.698648e-04 4.920749e-06  54.84221240  0.000000e+00
age_grp25-34              2.149839e-04 4.730840e-06  45.44307588  0.000000e+00
age_grp35-44              1.917570e-04 4.710526e-06  40.70818145  0.000000e+00
age_grp45-54              1.409580e-04 4.690911e-06  30.04918356 2.237699e-198
age_grp55-64              9.164170e-05 4.692781e-06  19.52822798  6.319497e-85
age_grp65-199             4.161851e-05 4.686618e-06   8.88028515  6.668921e-19
curr_pts_grp1-3           4.338818e-04 1.219186e-06 355.87828614  0.000000e+00
curr_pts_grp4-6           9.029807e-04 3.439258e-06 262.55100430  0.000000e+00
curr_pts_grp7-9           1.273495e-03 7.670933e-06 166.01567308  0.000000e+00
curr_pts_grp10-150        1.744498e-03 1.375066e-05 126.86646385  0.000000e+00
policyTRUE:age_grp16-19   7.469018e-06 7.412258e-06   1.00765756  3.136189e-01
policyTRUE:age_grp20-24  -8.985123e-07 6.764677e-06  -0.13282413  8.943325e-01
policyTRUE:age_grp25-34  -9.927042e-06 6.482613e-06  -1.53133347  1.256870e-01
policyTRUE:age_grp35-44   1.570440e-07 6.457523e-06   0.02431954  9.805977e-01
policyTRUE:age_grp45-54  -2.156791e-06 6.423695e-06  -0.33575558  7.370552e-01
policyTRUE:age_grp55-64   9.915770e-07 6.424006e-06   0.15435493  8.773299e-01
policyTRUE:age_grp65-199  9.379720e-06 6.415782e-06   1.46197607  1.437478e-01
```

Repeat without the policy-age interaction.

```R
Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)         3.687663e-05 3.178430e-06  11.60215  4.018479e-31
policyTRUE         -7.589229e-06 4.948698e-07 -15.33581  4.407367e-53
age_grp16-19        2.721193e-04 3.700763e-06  73.53060  0.000000e+00
age_grp20-24        2.694045e-04 3.370449e-06  79.93136  0.000000e+00
age_grp25-34        2.099176e-04 3.231562e-06  64.95856  0.000000e+00
age_grp35-44        1.918183e-04 3.219665e-06  59.57710  0.000000e+00
age_grp45-54        1.398472e-04 3.204117e-06  43.64610  0.000000e+00
age_grp55-64        9.216671e-05 3.205158e-06  28.75575 7.676462e-182
age_grp65-199       4.664802e-05 3.201629e-06  14.57009  4.353238e-48
curr_pts_grp1-3     4.338680e-04 1.219180e-06 355.86872  0.000000e+00
curr_pts_grp4-6     9.029070e-04 3.439223e-06 262.53225  0.000000e+00
curr_pts_grp7-9     1.273371e-03 7.670918e-06 165.99980  0.000000e+00
curr_pts_grp10-150  1.744249e-03 1.375024e-05 126.85221  0.000000e+00
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)        -2.409139e-06 5.899178e-07  -4.083855  4.429473e-05
policyTRUE          5.216918e-06 1.499897e-07  34.781837 4.578293e-265
age_grp16-19        3.572690e-05 8.627034e-07  41.412728  0.000000e+00
age_grp20-24        2.725666e-05 6.783345e-07  40.181749  0.000000e+00
age_grp25-34        2.314823e-05 6.163778e-07  37.555259 1.156345e-308
age_grp35-44        2.069047e-05 6.099715e-07  33.920393 3.334483e-252
age_grp45-54        1.639123e-05 6.028928e-07  27.187639 9.094290e-163
age_grp55-64        1.217853e-05 6.038044e-07  20.169664  1.808661e-90
age_grp65-199       7.470829e-06 6.017647e-07  12.414866  2.170501e-35
curr_pts_grp1-3     3.848403e-05 3.685970e-07 104.406808  0.000000e+00
curr_pts_grp4-6     6.825212e-05 9.721791e-07  70.205296  0.000000e+00
curr_pts_grp7-9     9.522018e-05 2.145488e-06  44.381595  0.000000e+00
curr_pts_grp10-150  1.664582e-04 4.259789e-06  39.076629  0.000000e+00
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)        -5.054489e-06 9.181613e-07  -5.505012 3.691429e-08
policyTRUE          3.814443e-06 3.358473e-07  11.357672 6.793099e-30
age_grp16-19        1.229333e-04 1.515663e-06  81.108593 0.000000e+00
age_grp20-24        1.307627e-04 1.174685e-06 111.317281 0.000000e+00
age_grp25-34        1.170647e-04 1.000340e-06 117.024879 0.000000e+00
age_grp35-44        1.111869e-04 9.836623e-07 113.033608 0.000000e+00
age_grp45-54        8.933593e-05 9.610783e-07  92.953861 0.000000e+00
age_grp55-64        6.444248e-05 9.620489e-07  66.984622 0.000000e+00
age_grp65-199       3.776205e-05 9.520986e-07  39.661914 0.000000e+00
curr_pts_grp1-3     1.970618e-04 8.267986e-07 238.343181 0.000000e+00
curr_pts_grp4-6     3.932082e-04 2.287673e-06 171.881312 0.000000e+00
curr_pts_grp7-9     5.181779e-04 4.948990e-06 104.703772 0.000000e+00
curr_pts_grp10-150  6.376537e-04 8.449962e-06  75.462318 0.000000e+00
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)         4.045867e-05 2.882984e-06  14.0336104  9.708091e-45
policyTRUE         -1.412309e-05 3.234084e-07 -43.6695149  0.000000e+00
age_grp16-19        9.603500e-05 3.139622e-06  30.5880716 1.763790e-205
age_grp20-24        1.019402e-04 2.979239e-06  34.2168523 1.357995e-256
age_grp25-34        6.686379e-05 2.907717e-06  22.9952916 5.195490e-117
age_grp35-44        5.956306e-05 2.902168e-06  20.5236426  1.324113e-93
age_grp45-54        3.519860e-05 2.894411e-06  12.1608853  5.021162e-34
age_grp55-64        1.718228e-05 2.895088e-06   5.9349766  2.938874e-09
age_grp65-199       2.627380e-06 2.894703e-06   0.9076511  3.640626e-01
curr_pts_grp1-3     1.905155e-04 7.998079e-07 238.2015160  0.000000e+00
curr_pts_grp4-6     4.191387e-04 2.318341e-06 180.7925254  0.000000e+00
curr_pts_grp7-9     6.209282e-04 5.298184e-06 117.1964170  0.000000e+00
curr_pts_grp10-150  8.566382e-04 9.551549e-06  89.6857938  0.000000e+00
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)         1.203328e-06 5.062001e-07  2.3771781 1.744566e-02
policyTRUE         -1.011378e-08 3.162031e-08 -0.3198508 7.490814e-01
age_grp16-19        7.897855e-06 5.837943e-07 13.5284891 1.061838e-41
age_grp20-24        1.875789e-06 5.168828e-07  3.6290405 2.844766e-04
age_grp25-34       -1.651295e-07 5.078479e-07 -0.3251555 7.450634e-01
age_grp35-44       -6.824004e-07 5.070916e-07 -1.3457144 1.783947e-01
age_grp45-54       -9.856970e-07 5.066141e-07 -1.9456566 5.169601e-02
age_grp55-64       -1.117490e-06 5.064910e-07 -2.2063368 2.736042e-02
age_grp65-199      -1.045422e-06 5.066195e-07 -2.0635252 3.906276e-02
curr_pts_grp1-3     1.002195e-06 6.886799e-08 14.5524135 5.637848e-48
curr_pts_grp4-6     3.414563e-06 2.180107e-07 15.6623614 2.735499e-55
curr_pts_grp7-9     5.867056e-06 5.271260e-07 11.1302713 8.936322e-29
curr_pts_grp10-150  1.701208e-05 1.328104e-06 12.8092988 1.454431e-37
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
Estimate   Std. Error   t value      Pr(>|t|)
(Intercept)         8.826862e-07 2.704418e-08  32.63867 1.160424e-233
policyTRUE         -2.106535e-06 5.269958e-08 -39.97252  0.000000e+00
age_grp16-19        6.771467e-06 2.679803e-07  25.26853 7.087251e-141
age_grp20-24        6.662758e-06 1.596158e-07  41.74247  0.000000e+00
age_grp25-34        3.304518e-06 7.255292e-08  45.54631  0.000000e+00
age_grp35-44        1.837000e-06 5.631640e-08  32.61927 2.186674e-233
age_grp45-54        9.252263e-07 4.100853e-08  22.56180 1.028466e-112
age_grp55-64        5.302089e-07 3.750599e-08  14.13665  2.257943e-45
age_grp65-199       2.266371e-07 2.879222e-08   7.87147  3.504977e-15
curr_pts_grp1-3     5.428367e-06 1.308848e-07  41.47439  0.000000e+00
curr_pts_grp4-6     1.436081e-05 4.183905e-07  34.32394 3.449063e-258
curr_pts_grp7-9     2.620603e-05 1.061924e-06  24.67788 1.848200e-134
curr_pts_grp10-150  4.911284e-05 2.227920e-06  22.04426 1.084413e-107
```



### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
Estimate   Std. Error     t value     Pr(>|t|)
(Intercept)         8.526591e-08 7.466089e-09  11.4204258 3.306104e-30
policyTRUE         -1.917924e-07 1.466457e-08 -13.0786221 4.362776e-39
age_grp16-19        1.194171e-06 1.077851e-07  11.0791907 1.582971e-28
age_grp20-24        7.474502e-07 5.207856e-08  14.3523586 1.029749e-46
age_grp25-34        2.234973e-07 1.926068e-08  11.6038140 3.941142e-31
age_grp35-44        6.098066e-08 1.327248e-08   4.5945187 4.337493e-06
age_grp45-54        1.937334e-08 9.488296e-09   2.0418148 4.116990e-02
age_grp55-64       -1.243138e-08 6.438260e-09  -1.9308604 5.350032e-02
age_grp65-199      -4.112037e-09 4.881479e-09  -0.8423752 3.995780e-01
curr_pts_grp1-3     3.420442e-07 3.378543e-08  10.1240178 4.322973e-24
curr_pts_grp4-6     1.404020e-06 1.288044e-07  10.9004034 1.147475e-27
curr_pts_grp7-9     2.010006e-06 2.948382e-07   6.8173186 9.275540e-12
curr_pts_grp10-150  7.150022e-06 8.410880e-07   8.5009207 1.880928e-17
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
Estimate   Std. Error    t value     Pr(>|t|)
(Intercept)         1.704712e-06 5.847050e-07  2.9155076 3.551104e-03
policyTRUE         -1.779988e-07 3.292303e-08 -5.4065123 6.426381e-08
age_grp16-19        1.473088e-06 6.098509e-07  2.4154880 1.571414e-02
age_grp20-24        1.416851e-07 5.900850e-07  0.2401096 8.102453e-01
age_grp25-34       -5.222838e-07 5.858548e-07 -0.8914901 3.726663e-01
age_grp35-44       -8.359032e-07 5.853936e-07 -1.4279335 1.533110e-01
age_grp45-54       -1.035844e-06 5.850651e-07 -1.7704762 7.664785e-02
age_grp55-64       -1.036080e-06 5.852545e-07 -1.7703067 7.667606e-02
age_grp65-199      -3.891322e-07 5.866000e-07 -0.6633690 5.070943e-01
curr_pts_grp1-3     1.033071e-06 6.912869e-08 14.9441715 1.699927e-50
curr_pts_grp4-6     3.110816e-06 2.083650e-07 14.9296492 2.113759e-50
curr_pts_grp7-9     4.886398e-06 4.831586e-07 10.1134446 4.816063e-24
curr_pts_grp10-150  9.652769e-06 1.014970e-06  9.5103962 1.899378e-21
```



## Placebo regression Results (Standard Errors with HCCME)


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
Estimate   Std. Error     t value      Pr(>|t|)
(Intercept)                3.242399e-05 6.413448e-06   5.0556250  4.289836e-07
placeboTRUE                7.296109e-06 9.248634e-06   0.7888850  4.301792e-01
age_grp16-19               2.730547e-04 7.543236e-06  36.1986232 6.400587e-287
age_grp20-24               2.691195e-04 6.809042e-06  39.5238421  0.000000e+00
age_grp25-34               2.193516e-04 6.545090e-06  33.5139131 3.023016e-246
age_grp35-44               1.984929e-04 6.514998e-06  30.4670673 7.119611e-204
age_grp45-54               1.448211e-04 6.487760e-06  22.3222100 2.249007e-110
age_grp55-64               9.474596e-05 6.490917e-06  14.5966981  2.947820e-48
age_grp65-199              4.328402e-05 6.481348e-06   6.6782432  2.418236e-11
curr_pts_grp1-3            4.396731e-04 1.816698e-06 242.0176690  0.000000e+00
curr_pts_grp4-6            9.110450e-04 5.274775e-06 172.7173294  0.000000e+00
curr_pts_grp7-9            1.274654e-03 1.184338e-05 107.6258808  0.000000e+00
curr_pts_grp10-150         1.876730e-03 2.365989e-05  79.3211768  0.000000e+00
placeboTRUE:age_grp16-19  -1.164724e-05 1.078868e-05  -1.0795801  2.803292e-01
placeboTRUE:age_grp20-24  -1.142703e-06 9.820541e-06  -0.1163585  9.073684e-01
placeboTRUE:age_grp25-34  -1.059351e-05 9.437107e-06  -1.1225383  2.616336e-01
placeboTRUE:age_grp35-44  -1.510310e-05 9.395652e-06  -1.6074567  1.079542e-01
placeboTRUE:age_grp45-54  -8.679119e-06 9.354616e-06  -0.9277900  3.535165e-01
placeboTRUE:age_grp55-64  -6.707835e-06 9.357229e-06  -0.7168612  4.734597e-01
placeboTRUE:age_grp65-199 -3.472329e-06 9.344187e-06  -0.3716031  7.101884e-01
```


Repeat without the policy-age interaction.

```R
Estimate   Std. Error    t value      Pr(>|t|)
(Intercept)         3.716618e-05 4.653542e-06   7.986643  1.386628e-15
placeboTRUE        -1.733816e-06 7.065351e-07  -2.453970  1.412889e-02
age_grp16-19        2.669572e-04 5.408467e-06  49.359126  0.000000e+00
age_grp20-24        2.683376e-04 4.916364e-06  54.580498  0.000000e+00
age_grp25-34        2.138230e-04 4.728260e-06  45.222347  0.000000e+00
age_grp35-44        1.907323e-04 4.708452e-06  40.508489  0.000000e+00
age_grp45-54        1.402596e-04 4.689802e-06  29.907356 1.578994e-196
age_grp55-64        9.119536e-05 4.692331e-06  19.434979  3.905807e-84
age_grp65-199       4.141808e-05 4.686495e-06   8.837752  9.766419e-19
curr_pts_grp1-3     4.396570e-04 1.816675e-06 242.011887  0.000000e+00
curr_pts_grp4-6     9.109924e-04 5.274715e-06 172.709293  0.000000e+00
curr_pts_grp7-9     1.274598e-03 1.184340e-05 107.620919  0.000000e+00
curr_pts_grp10-150  1.876692e-03 2.366005e-05  79.319007  0.000000e+00
```
