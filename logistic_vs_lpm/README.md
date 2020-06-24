
# Logistic Regression Models - All Drivers


## Logistic Regression Results


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                          Estimate Std. Error  z value Pr(>|z|)    
(Intercept)              -8.974804   0.025946 -345.909  < 2e-16 ***
policyTRUE               -0.042077   0.036989   -1.138   0.2553    
age_grp16-19              1.208796   0.026149   46.228  < 2e-16 ***
age_grp20-24              1.086805   0.026025   41.759  < 2e-16 ***
age_grp25-34              0.915377   0.025988   35.223  < 2e-16 ***
age_grp35-44              0.809706   0.025989   31.156  < 2e-16 ***
age_grp45-54              0.686585   0.025994   26.413  < 2e-16 ***
age_grp55-64              0.511176   0.026031   19.637  < 2e-16 ***
age_grp65-199             0.154903   0.026122    5.930 3.03e-09 ***
curr_pts_grp1-3           1.159480   0.001226  945.940  < 2e-16 ***
curr_pts_grp4-6           1.663881   0.001589 1047.433  < 2e-16 ***
curr_pts_grp7-9           1.934558   0.002170  891.670  < 2e-16 ***
curr_pts_grp10-150        2.182777   0.002318  941.696  < 2e-16 ***
policyTRUE:age_grp16-19  -0.067996   0.037262   -1.825   0.0680 .  
policyTRUE:age_grp20-24  -0.082310   0.037100   -2.219   0.0265 *  
policyTRUE:age_grp25-34  -0.083451   0.037049   -2.252   0.0243 *  
policyTRUE:age_grp35-44  -0.043197   0.037051   -1.166   0.2437    
policyTRUE:age_grp45-54  -0.033893   0.037057   -0.915   0.3604    
policyTRUE:age_grp55-64  -0.022918   0.037106   -0.618   0.5368    
policyTRUE:age_grp65-199  0.037871   0.037220    1.017   0.3089    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 69543772  on 1509999  degrees of freedom
Residual deviance: 66957172  on 1509980  degrees of freedom
AIC: 66957212

Number of Fisher Scoring iterations: 11
```

Repeat without the policy-age interaction.

```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -8.950908   0.018500 -483.825   <2e-16 ***
policyTRUE         -0.091382   0.001009  -90.598   <2e-16 ***
age_grp16-19        1.175123   0.018633   63.068   <2e-16 ***
age_grp20-24        1.046598   0.018553   56.411   <2e-16 ***
age_grp25-34        0.874484   0.018525   47.205   <2e-16 ***
age_grp35-44        0.788728   0.018525   42.577   <2e-16 ***
age_grp45-54        0.670436   0.018527   36.187   <2e-16 ***
age_grp55-64        0.500803   0.018551   26.996   <2e-16 ***
age_grp65-199       0.177169   0.018607    9.522   <2e-16 ***
curr_pts_grp1-3     1.159748   0.001226  946.143   <2e-16 ***
curr_pts_grp4-6     1.664063   0.001589 1047.510   <2e-16 ***
curr_pts_grp7-9     1.934707   0.002170  891.732   <2e-16 ***
curr_pts_grp10-150  2.181887   0.002318  941.320   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 69543772  on 1509999  degrees of freedom
Residual deviance: 66958164  on 1509987  degrees of freedom
AIC: 66958190

Number of Fisher Scoring iterations: 11
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -12.084218   0.083844 -144.127   <2e-16 ***
policyTRUE           0.131540   0.003504   37.538   <2e-16 ***
age_grp16-19         1.724868   0.084192   20.487   <2e-16 ***
age_grp20-24         1.422870   0.084010   16.937   <2e-16 ***
age_grp25-34         1.387920   0.083909   16.541   <2e-16 ***
age_grp35-44         1.376957   0.083903   16.411   <2e-16 ***
age_grp45-54         1.294583   0.083905   15.429   <2e-16 ***
age_grp55-64         1.146326   0.083960   13.653   <2e-16 ***
age_grp65-199        0.772728   0.084106    9.188   <2e-16 ***
curr_pts_grp1-3      1.128980   0.004216  267.788   <2e-16 ***
curr_pts_grp4-6      1.555185   0.005663  274.621   <2e-16 ***
curr_pts_grp7-9      1.859475   0.007699  241.514   <2e-16 ***
curr_pts_grp10-150   2.212476   0.007888  280.483   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 7476652  on 1509999  degrees of freedom
Residual deviance: 7281650  on 1509987  degrees of freedom
AIC: 7281676

Number of Fisher Scoring iterations: 10
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -10.985634   0.050084 -219.343  < 2e-16 ***
policyTRUE          -0.005339   0.001567   -3.407 0.000657 ***
age_grp16-19         2.082017   0.050236   41.445  < 2e-16 ***
age_grp20-24         2.058502   0.050139   41.056  < 2e-16 ***
age_grp25-34         1.996719   0.050106   39.850  < 2e-16 ***
age_grp35-44         1.965506   0.050105   39.228  < 2e-16 ***
age_grp45-54         1.882618   0.050105   37.573  < 2e-16 ***
age_grp55-64         1.716988   0.050125   34.254  < 2e-16 ***
age_grp65-199        1.328970   0.050176   26.486  < 2e-16 ***
curr_pts_grp1-3      1.134865   0.001884  602.359  < 2e-16 ***
curr_pts_grp4-6      1.592541   0.002500  637.026  < 2e-16 ***
curr_pts_grp7-9      1.814700   0.003519  515.741  < 2e-16 ***
curr_pts_grp10-150   1.949739   0.003980  489.836  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 31726412  on 1509999  degrees of freedom
Residual deviance: 30832888  on 1509987  degrees of freedom
AIC: 30832914

Number of Fisher Scoring iterations: 9
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -9.261670   0.021900 -422.915   <2e-16 ***
policyTRUE         -0.175917   0.001482 -118.718   <2e-16 ***
age_grp16-19        0.747309   0.022135   33.762   <2e-16 ***
age_grp20-24        0.666172   0.021989   30.296   <2e-16 ***
age_grp25-34        0.445560   0.021944   20.304   <2e-16 ***
age_grp35-44        0.332678   0.021946   15.159   <2e-16 ***
age_grp45-54        0.185525   0.021952    8.451   <2e-16 ***
age_grp55-64        0.013656   0.021999    0.621    0.535    
age_grp65-199      -0.242783   0.022092  -10.989   <2e-16 ***
curr_pts_grp1-3     1.190644   0.001809  658.157   <2e-16 ***
curr_pts_grp4-6     1.734054   0.002302  753.443   <2e-16 ***
curr_pts_grp7-9     2.023286   0.003099  652.844   <2e-16 ***
curr_pts_grp10-150  2.284966   0.003283  696.060   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 35066033  on 1509999  degrees of freedom
Residual deviance: 33725680  on 1509987  degrees of freedom
AIC: 33725706

Number of Fisher Scoring iterations: 8
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -11.44306    0.06734 -169.927  < 2e-16 ***
policyTRUE          -0.12466    0.01063  -11.723  < 2e-16 ***
age_grp16-19         0.88546    0.06793   13.035  < 2e-16 ***
age_grp20-24        -0.31660    0.06807   -4.651  3.3e-06 ***
age_grp25-34        -1.33512    0.06821  -19.572  < 2e-16 ***
age_grp35-44        -2.06066    0.06915  -29.802  < 2e-16 ***
age_grp45-54        -2.59906    0.07041  -36.912  < 2e-16 ***
age_grp55-64        -2.94903    0.07367  -40.028  < 2e-16 ***
age_grp65-199       -3.10547    0.07748  -40.079  < 2e-16 ***
curr_pts_grp1-3      0.75350    0.01430   52.681  < 2e-16 ***
curr_pts_grp4-6      1.50710    0.01635   92.174  < 2e-16 ***
curr_pts_grp7-9      1.91640    0.02000   95.800  < 2e-16 ***
curr_pts_grp10-150   2.45384    0.01758  139.584  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 960380  on 1509999  degrees of freedom
Residual deviance: 874225  on 1509987  degrees of freedom
AIC: 874251

Number of Fisher Scoring iterations: 12
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                     Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -15.378978   0.492218 -31.244  < 2e-16 ***
policyTRUE          -0.672595   0.007323 -91.845  < 2e-16 ***
age_grp16-19         4.427276   0.492343   8.992  < 2e-16 ***
age_grp20-24         4.201433   0.492273   8.535  < 2e-16 ***
age_grp25-34         3.722006   0.492256   7.561 4.00e-14 ***
age_grp35-44         3.210957   0.492279   6.523 6.91e-11 ***
age_grp45-54         2.834756   0.492311   5.758 8.51e-09 ***
age_grp55-64         2.420803   0.492439   4.916 8.84e-07 ***
age_grp65-199        1.719883   0.492894   3.489 0.000484 ***
curr_pts_grp1-3      1.336656   0.008986 148.753  < 2e-16 ***
curr_pts_grp4-6      1.983184   0.010615 186.835  < 2e-16 ***
curr_pts_grp7-9      2.361889   0.013201 178.923  < 2e-16 ***
curr_pts_grp10-150   2.876767   0.012315 233.598  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 2048913  on 1509999  degrees of freedom
Residual deviance: 1910673  on 1509987  degrees of freedom
AIC: 1910699

Number of Fisher Scoring iterations: 13
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                     Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -1.674e+01  9.988e-01 -16.758  < 2e-16 ***
policyTRUE         -7.653e-01  1.858e-02 -41.192  < 2e-16 ***
age_grp16-19        4.424e+00  9.990e-01   4.428 9.49e-06 ***
age_grp20-24        3.976e+00  9.989e-01   3.981 6.87e-05 ***
age_grp25-34        3.257e+00  9.989e-01   3.261  0.00111 **
age_grp35-44        2.371e+00  9.991e-01   2.373  0.01765 *  
age_grp45-54        1.708e+00  9.994e-01   1.709  0.08747 .  
age_grp55-64        9.607e-01  1.001e+00   0.960  0.33707    
age_grp65-199       5.619e-04  1.006e+00   0.001  0.99955    
curr_pts_grp1-3     1.289e+00  2.396e-02  53.802  < 2e-16 ***
curr_pts_grp4-6     2.013e+00  2.707e-02  74.363  < 2e-16 ***
curr_pts_grp7-9     2.469e+00  3.192e-02  77.342  < 2e-16 ***
curr_pts_grp10-150  3.254e+00  2.676e-02 121.590  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 372302  on 1509999  degrees of freedom
Residual deviance: 337027  on 1509987  degrees of freedom
AIC: 337053

Number of Fisher Scoring iterations: 15
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -12.47224    0.11490 -108.545  < 2e-16 ***
policyTRUE          -0.23209    0.01455  -15.952  < 2e-16 ***
age_grp16-19         0.39871    0.11675    3.415 0.000638 ***
age_grp20-24        -0.17789    0.11607   -1.533 0.125385    
age_grp25-34        -0.80028    0.11581   -6.910 4.83e-12 ***
age_grp35-44        -1.17976    0.11616  -10.156  < 2e-16 ***
age_grp45-54        -1.39238    0.11642  -11.960  < 2e-16 ***
age_grp55-64        -1.52575    0.11750  -12.985  < 2e-16 ***
age_grp65-199       -1.01799    0.11703   -8.698  < 2e-16 ***
curr_pts_grp1-3      0.85533    0.01879   45.509  < 2e-16 ***
curr_pts_grp4-6      1.40219    0.02407   58.245  < 2e-16 ***
curr_pts_grp7-9      1.77051    0.03111   56.919  < 2e-16 ***
curr_pts_grp10-150   2.40627    0.02729   88.164  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 538553  on 1509999  degrees of freedom
Residual deviance: 521069  on 1509987  degrees of freedom
AIC: 521095

Number of Fisher Scoring iterations: 11
```
