
# Logistic Regression Models - Male Drivers


## Logistic Regression Results


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                           Estimate Std. Error  z value Pr(>|z|)    
(Intercept)              -8.7909374  0.0270230 -325.313  < 2e-16 ***
policyTRUE               -0.0183891  0.0385733   -0.477 0.633553    
age_grp16-19              1.2684755  0.0272714   46.513  < 2e-16 ***
age_grp20-24              1.1304263  0.0271267   41.672  < 2e-16 ***
age_grp25-34              0.9484504  0.0270811   35.023  < 2e-16 ***
age_grp35-44              0.8278705  0.0270832   30.568  < 2e-16 ***
age_grp45-54              0.7250383  0.0270892   26.765  < 2e-16 ***
age_grp55-64              0.5667364  0.0271347   20.886  < 2e-16 ***
age_grp65-199             0.1968468  0.0272431    7.226 4.99e-13 ***
curr_pts_grp1-3           1.0821603  0.0014745  733.919  < 2e-16 ***
curr_pts_grp4-6           1.5328075  0.0018331  836.177  < 2e-16 ***
curr_pts_grp7-9           1.7779679  0.0024105  737.605  < 2e-16 ***
curr_pts_grp10-150        2.0031433  0.0025041  799.947  < 2e-16 ***
policyTRUE:age_grp16-19  -0.1100653  0.0389106   -2.829 0.004674 **
policyTRUE:age_grp20-24  -0.1298943  0.0387188   -3.355 0.000794 ***
policyTRUE:age_grp25-34  -0.1300243  0.0386562   -3.364 0.000769 ***
policyTRUE:age_grp35-44  -0.0891778  0.0386614   -2.307 0.021075 *  
policyTRUE:age_grp45-54  -0.0713876  0.0386669   -1.846 0.064860 .  
policyTRUE:age_grp55-64  -0.0596409  0.0387279   -1.540 0.123561    
policyTRUE:age_grp65-199  0.0006892  0.0388640    0.018 0.985851    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 47827644  on 921801  degrees of freedom
Residual deviance: 46073621  on 921782  degrees of freedom
AIC: 46073661

Number of Fisher Scoring iterations: 11
```

Repeat without the policy-age interaction.

```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -8.747067   0.019295 -453.34   <2e-16 ***
policyTRUE         -0.110153   0.001199  -91.86   <2e-16 ***
age_grp16-19        1.215115   0.019460   62.44   <2e-16 ***
age_grp20-24        1.068007   0.019365   55.15   <2e-16 ***
age_grp25-34        0.885758   0.019329   45.82   <2e-16 ***
age_grp35-44        0.785103   0.019330   40.62   <2e-16 ***
age_grp45-54        0.691257   0.019332   35.76   <2e-16 ***
age_grp55-64        0.539122   0.019361   27.84   <2e-16 ***
age_grp65-199       0.201362   0.019428   10.37   <2e-16 ***
curr_pts_grp1-3     1.082582   0.001474  734.20   <2e-16 ***
curr_pts_grp4-6     1.533167   0.001833  836.35   <2e-16 ***
curr_pts_grp7-9     1.778305   0.002410  737.74   <2e-16 ***
curr_pts_grp10-150  2.002231   0.002504  799.55   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 47827644  on 921801  degrees of freedom
Residual deviance: 46074522  on 921789  degrees of freedom
AIC: 46074548

Number of Fisher Scoring iterations: 11
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -11.857334   0.086617 -136.894   <2e-16 ***
policyTRUE           0.096660   0.004253   22.728   <2e-16 ***
age_grp16-19         1.610507   0.087102   18.490   <2e-16 ***
age_grp20-24         1.276801   0.086867   14.698   <2e-16 ***
age_grp25-34         1.277305   0.086717   14.730   <2e-16 ***
age_grp35-44         1.304147   0.086705   15.041   <2e-16 ***
age_grp45-54         1.259929   0.086703   14.532   <2e-16 ***
age_grp55-64         1.135696   0.086772   13.088   <2e-16 ***
age_grp65-199        0.745071   0.086955    8.568   <2e-16 ***
curr_pts_grp1-3      1.089125   0.005190  209.865   <2e-16 ***
curr_pts_grp4-6      1.497200   0.006596  226.977   <2e-16 ***
curr_pts_grp7-9      1.795010   0.008577  209.274   <2e-16 ***
curr_pts_grp10-150   2.125383   0.008611  246.825   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 4966977  on 921801  degrees of freedom
Residual deviance: 4834675  on 921789  degrees of freedom
AIC: 4834701

Number of Fisher Scoring iterations: 10
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -10.755209   0.051562 -208.589   <2e-16 ***
policyTRUE          -0.018346   0.001908   -9.618   <2e-16 ***
age_grp16-19         2.003732   0.051768   38.706   <2e-16 ***
age_grp20-24         1.962946   0.051641   38.011   <2e-16 ***
age_grp25-34         1.904686   0.051595   36.916   <2e-16 ***
age_grp35-44         1.875808   0.051593   36.358   <2e-16 ***
age_grp45-54         1.830193   0.051592   35.474   <2e-16 ***
age_grp55-64         1.697247   0.051616   32.882   <2e-16 ***
age_grp65-199        1.309093   0.051678   25.331   <2e-16 ***
curr_pts_grp1-3      1.076649   0.002314  465.247   <2e-16 ***
curr_pts_grp4-6      1.493733   0.002932  509.527   <2e-16 ***
curr_pts_grp7-9      1.703934   0.003949  431.440   <2e-16 ***
curr_pts_grp10-150   1.826293   0.004322  422.562   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 20961568  on 921801  degrees of freedom
Residual deviance: 20382255  on 921789  degrees of freedom
AIC: 20382281

Number of Fisher Scoring iterations: 9
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -9.070480   0.023008 -394.236  < 2e-16 ***
policyTRUE         -0.185901   0.001733 -107.289  < 2e-16 ***
age_grp16-19        0.838445   0.023291   35.999  < 2e-16 ***
age_grp20-24        0.749961   0.023122   32.435  < 2e-16 ***
age_grp25-34        0.522777   0.023067   22.663  < 2e-16 ***
age_grp35-44        0.385245   0.023071   16.698  < 2e-16 ***
age_grp45-54        0.255592   0.023078   11.075  < 2e-16 ***
age_grp55-64        0.089335   0.023134    3.862 0.000113 ***
age_grp65-199      -0.191199   0.023244   -8.226  < 2e-16 ***
curr_pts_grp1-3     1.094618   0.002141  511.301  < 2e-16 ***
curr_pts_grp4-6     1.570502   0.002629  597.457  < 2e-16 ***
curr_pts_grp7-9     1.823676   0.003426  532.250  < 2e-16 ***
curr_pts_grp10-150  2.057674   0.003534  582.204  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 24909461  on 921801  degrees of freedom
Residual deviance: 23991021  on 921789  degrees of freedom
AIC: 23991047

Number of Fisher Scoring iterations: 8
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                    Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -11.15473    0.06829 -163.336   <2e-16 ***
policyTRUE          -0.12244    0.01141  -10.728   <2e-16 ***
age_grp16-19         1.09927    0.06897   15.938   <2e-16 ***
age_grp20-24        -0.08564    0.06914   -1.239    0.215    
age_grp25-34        -1.12989    0.06932  -16.299   <2e-16 ***
age_grp35-44        -1.90793    0.07053  -27.050   <2e-16 ***
age_grp45-54        -2.45592    0.07206  -34.082   <2e-16 ***
age_grp55-64        -2.79183    0.07563  -36.913   <2e-16 ***
age_grp65-199       -3.06530    0.08045  -38.104   <2e-16 ***
curr_pts_grp1-3      0.57365    0.01549   37.022   <2e-16 ***
curr_pts_grp4-6      1.20146    0.01738   69.133   <2e-16 ***
curr_pts_grp7-9      1.54808    0.02091   74.026   <2e-16 ***
curr_pts_grp10-150   2.01020    0.01837  109.452   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 805722  on 921801  degrees of freedom
Residual deviance: 732927  on 921789  degrees of freedom
AIC: 732953

Number of Fisher Scoring iterations: 12
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                     Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -15.085933   0.497096 -30.348  < 2e-16 ***
policyTRUE          -0.643135   0.007958 -80.815  < 2e-16 ***
age_grp16-19         4.565235   0.497237   9.181  < 2e-16 ***
age_grp20-24         4.351547   0.497161   8.753  < 2e-16 ***
age_grp25-34         3.878149   0.497141   7.801 6.15e-15 ***
age_grp35-44         3.344262   0.497171   6.727 1.74e-11 ***
age_grp45-54         2.964375   0.497208   5.962 2.49e-09 ***
age_grp55-64         2.523401   0.497359   5.074 3.90e-07 ***
age_grp65-199        1.778147   0.497879   3.571 0.000355 ***
curr_pts_grp1-3      1.182709   0.009927 119.137  < 2e-16 ***
curr_pts_grp4-6      1.709011   0.011535 148.154  < 2e-16 ***
curr_pts_grp7-9      2.017743   0.014129 142.812  < 2e-16 ***
curr_pts_grp10-150   2.481114   0.013028 190.447  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 1671487  on 921801  degrees of freedom
Residual deviance: 1565208  on 921789  degrees of freedom
AIC: 1565234

Number of Fisher Scoring iterations: 13
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -16.42667    0.98516 -16.674  < 2e-16 ***
policyTRUE          -0.73237    0.01929 -37.974  < 2e-16 ***
age_grp16-19         4.63770    0.98542   4.706 2.52e-06 ***
age_grp20-24         4.23535    0.98531   4.298 1.72e-05 ***
age_grp25-34         3.53184    0.98529   3.585 0.000338 ***
age_grp35-44         2.63273    0.98548   2.672 0.007551 **
age_grp45-54         1.92855    0.98583   1.956 0.050433 .  
age_grp55-64         1.17278    0.98728   1.188 0.234875    
age_grp65-199        0.12119    0.99355   0.122 0.902917    
curr_pts_grp1-3      1.09955    0.02512  43.778  < 2e-16 ***
curr_pts_grp4-6      1.65704    0.02833  58.483  < 2e-16 ***
curr_pts_grp7-9      2.04936    0.03295  62.190  < 2e-16 ***
curr_pts_grp10-150   2.75223    0.02770  99.364  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 332240  on 921801  degrees of freedom
Residual deviance: 302898  on 921789  degrees of freedom
AIC: 302924

Number of Fisher Scoring iterations: 14
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -12.291585   0.121555 -101.120  < 2e-16 ***
policyTRUE          -0.248993   0.016988  -14.657  < 2e-16 ***
age_grp16-19         0.554105   0.123688    4.480 7.47e-06 ***
age_grp20-24        -0.008557   0.122956   -0.070    0.945    
age_grp25-34        -0.700062   0.122733   -5.704 1.17e-08 ***
age_grp35-44        -1.130632   0.123303   -9.170  < 2e-16 ***
age_grp45-54        -1.342539   0.123642  -10.858  < 2e-16 ***
age_grp55-64        -1.543012   0.125261  -12.318  < 2e-16 ***
age_grp65-199       -1.140266   0.124742   -9.141  < 2e-16 ***
curr_pts_grp1-3      0.799254   0.021913   36.474  < 2e-16 ***
curr_pts_grp4-6      1.229565   0.027275   45.080  < 2e-16 ***
curr_pts_grp7-9      1.563083   0.033999   45.974  < 2e-16 ***
curr_pts_grp10-150   2.159889   0.029346   73.601  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 387795  on 921801  degrees of freedom
Residual deviance: 373652  on 921789  degrees of freedom
AIC: 373678

Number of Fisher Scoring iterations: 11
```
