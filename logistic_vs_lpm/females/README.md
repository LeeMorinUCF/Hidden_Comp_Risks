
# Logistic Regression Models - Male Drivers


## Logistic Regression Results


### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

```R
                          Estimate Std. Error  z value Pr(>|z|)    
(Intercept)              -9.969223   0.092834 -107.387  < 2e-16 ***
policyTRUE               -0.073893   0.130409   -0.567    0.571    
age_grp16-19              1.765453   0.093103   18.962  < 2e-16 ***
age_grp20-24              1.757549   0.092923   18.914  < 2e-16 ***
age_grp25-34              1.622114   0.092877   17.465  < 2e-16 ***
age_grp35-44              1.552836   0.092874   16.720  < 2e-16 ***
age_grp45-54              1.365959   0.092881   14.706  < 2e-16 ***
age_grp55-64              1.106939   0.092926   11.912  < 2e-16 ***
age_grp65-199             0.684967   0.093050    7.361 1.82e-13 ***
curr_pts_grp1-3           1.153017   0.002235  515.930  < 2e-16 ***
curr_pts_grp4-6           1.677538   0.003318  505.581  < 2e-16 ***
curr_pts_grp7-9           1.951719   0.005299  368.332  < 2e-16 ***
curr_pts_grp10-150        2.197822   0.007108  309.213  < 2e-16 ***
policyTRUE:age_grp16-19   0.062003   0.130755    0.474    0.635    
policyTRUE:age_grp20-24   0.040700   0.130528    0.312    0.755    
policyTRUE:age_grp25-34   0.019430   0.130466    0.149    0.882    
policyTRUE:age_grp35-44   0.050099   0.130463    0.384    0.701    
policyTRUE:age_grp45-54   0.044281   0.130473    0.339    0.734    
policyTRUE:age_grp55-64   0.057741   0.130532    0.442    0.658    
policyTRUE:age_grp65-199  0.132346   0.130685    1.013    0.311    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 21309311  on 588197  degrees of freedom
Residual deviance: 20706235  on 588178  degrees of freedom
AIC: 20706275

Number of Fisher Scoring iterations: 10
```

Repeat without the policy-age interaction.

```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -9.992739   0.065213 -153.23   <2e-16 ***
policyTRUE         -0.027974   0.001867  -14.98   <2e-16 ***
age_grp16-19        1.797802   0.065380   27.50   <2e-16 ***
age_grp20-24        1.778415   0.065269   27.25   <2e-16 ***
age_grp25-34        1.632047   0.065237   25.02   <2e-16 ***
age_grp35-44        1.578492   0.065235   24.20   <2e-16 ***
age_grp45-54        1.388643   0.065239   21.29   <2e-16 ***
age_grp55-64        1.136703   0.065267   17.42   <2e-16 ***
age_grp65-199       0.755681   0.065342   11.56   <2e-16 ***
curr_pts_grp1-3     1.153050   0.002235  515.93   <2e-16 ***
curr_pts_grp4-6     1.677392   0.003318  505.53   <2e-16 ***
curr_pts_grp7-9     1.951398   0.005299  368.28   <2e-16 ***
curr_pts_grp10-150  2.197055   0.007107  309.15   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 21309311  on 588197  degrees of freedom
Residual deviance: 20706396  on 588185  degrees of freedom
AIC: 20706422

Number of Fisher Scoring iterations: 10
```


### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.


```R
                     Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -13.497752   0.352966 -38.241  < 2e-16 ***
policyTRUE           0.214532   0.006194  34.638  < 2e-16 ***
age_grp16-19         3.000015   0.353241   8.493  < 2e-16 ***
age_grp20-24         2.782190   0.353079   7.880 3.28e-15 ***
age_grp25-34         2.671551   0.353010   7.568 3.79e-14 ***
age_grp35-44         2.591429   0.353008   7.341 2.12e-13 ***
age_grp45-54         2.418700   0.353014   6.852 7.30e-12 ***
age_grp55-64         2.185140   0.353067   6.189 6.05e-10 ***
age_grp65-199        1.786043   0.353213   5.057 4.27e-07 ***
curr_pts_grp1-3      1.092946   0.007338 148.945  < 2e-16 ***
curr_pts_grp4-6      1.476876   0.011600 127.316  < 2e-16 ***
curr_pts_grp7-9      1.727803   0.018845  91.687  < 2e-16 ***
curr_pts_grp10-150   2.162565   0.022940  94.271  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 2488062  on 588197  degrees of freedom
Residual deviance: 2438213  on 588185  degrees of freedom
AIC: 2438239

Number of Fisher Scoring iterations: 12
```



### Two-point violations (speeding 21-30 over or 7 other violations)




```R
                     Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -12.535815   0.228380  -54.89   <2e-16 ***
policyTRUE           0.031816   0.002751   11.57   <2e-16 ***
age_grp16-19         3.424357   0.228498   14.99   <2e-16 ***
age_grp20-24         3.463300   0.228417   15.16   <2e-16 ***
age_grp25-34         3.389503   0.228394   14.84   <2e-16 ***
age_grp35-44         3.352720   0.228393   14.68   <2e-16 ***
age_grp45-54         3.186961   0.228395   13.95   <2e-16 ***
age_grp55-64         2.919629   0.228412   12.78   <2e-16 ***
age_grp65-199        2.451254   0.228463   10.73   <2e-16 ***
curr_pts_grp1-3      1.128621   0.003286  343.50   <2e-16 ***
curr_pts_grp4-6      1.614574   0.004968  325.00   <2e-16 ***
curr_pts_grp7-9      1.830191   0.008187  223.56   <2e-16 ***
curr_pts_grp10-150   1.980137   0.011524  171.82   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 10661155  on 588197  degrees of freedom
Residual deviance: 10408564  on 588185  degrees of freedom
AIC: 10408590

Number of Fisher Scoring iterations: 11
```


### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.



```R
                     Estimate Std. Error  z value Pr(>|z|)    
(Intercept)        -10.141354   0.071697 -141.447  < 2e-16 ***
policyTRUE          -0.124485   0.002861  -43.512  < 2e-16 ***
age_grp16-19         1.123008   0.072052   15.586  < 2e-16 ***
age_grp20-24         1.138684   0.071812   15.856  < 2e-16 ***
age_grp25-34         0.940058   0.071751   13.102  < 2e-16 ***
age_grp35-44         0.889157   0.071747   12.393  < 2e-16 ***
age_grp45-54         0.675441   0.071757    9.413  < 2e-16 ***
age_grp55-64         0.438984   0.071818    6.112 9.81e-10 ***
age_grp65-199        0.139453   0.071959    1.938   0.0526 .  
curr_pts_grp1-3      1.195612   0.003425  349.072  < 2e-16 ***
curr_pts_grp4-6      1.774645   0.004955  358.126  < 2e-16 ***
curr_pts_grp7-9      2.095507   0.007704  271.988  < 2e-16 ***
curr_pts_grp10-150   2.355274   0.010261  229.543  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 9902479  on 588197  degrees of freedom
Residual deviance: 9615137  on 588185  degrees of freedom
AIC: 9615163

Number of Fisher Scoring iterations: 9
```



### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -13.63804    0.40854 -33.383  < 2e-16 ***
policyTRUE          -0.00837    0.02934  -0.285  0.77542    
age_grp16-19         1.79159    0.40953   4.375 1.22e-05 ***
age_grp20-24         0.73346    0.40953   1.791  0.07330 .  
age_grp25-34        -0.13928    0.40948  -0.340  0.73375    
age_grp35-44        -0.62918    0.40999  -1.535  0.12487    
age_grp45-54        -1.20674    0.41112  -2.935  0.00333 **
age_grp55-64        -1.77774    0.41558  -4.278 1.89e-05 ***
age_grp65-199       -1.67265    0.41801  -4.001 6.30e-05 ***
curr_pts_grp1-3      0.72441    0.03809  19.020  < 2e-16 ***
curr_pts_grp4-6      1.46736    0.05192  28.259  < 2e-16 ***
curr_pts_grp7-9      1.84883    0.07719  23.952  < 2e-16 ***
curr_pts_grp10-150   2.67271    0.07494  35.664  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 138133  on 588197  degrees of freedom
Residual deviance: 130924  on 588185  degrees of freedom
AIC: 130950

Number of Fisher Scoring iterations: 13
```


### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
Conduct the analysis by defining the event as either a 5 or 10 point ticket (both before and after).


```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -22.44457   23.02561  -0.975    0.330    
policyTRUE          -0.74609    0.01874 -39.822   <2e-16 ***
age_grp16-19        10.50093   23.02564   0.456    0.648    
age_grp20-24        10.42396   23.02562   0.453    0.651    
age_grp25-34         9.92845   23.02562   0.431    0.666    
age_grp35-44         9.54070   23.02562   0.414    0.679    
age_grp45-54         9.10104   23.02563   0.395    0.693    
age_grp55-64         8.67451   23.02564   0.377    0.706    
age_grp65-199        7.90434   23.02571   0.343    0.731    
curr_pts_grp1-3      1.34363    0.02144  62.655   <2e-16 ***
curr_pts_grp4-6      2.08480    0.02830  73.663   <2e-16 ***
curr_pts_grp7-9      2.58766    0.03936  65.745   <2e-16 ***
curr_pts_grp10-150   3.13282    0.04516  69.378   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 346009  on 588197  degrees of freedom
Residual deviance: 328126  on 588185  degrees of freedom
AIC: 328152

Number of Fisher Scoring iterations: 18
```




### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.



```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -25.43259  105.72839  -0.241    0.810    
policyTRUE          -0.90627    0.06946 -13.048   <2e-16 ***
age_grp16-19        11.69749  105.72843   0.111    0.912    
age_grp20-24        11.17593  105.72841   0.106    0.916    
age_grp25-34        10.31745  105.72841   0.098    0.922    
age_grp35-44         9.63640  105.72843   0.091    0.927    
age_grp45-54         9.14070  105.72845   0.086    0.931    
age_grp55-64         8.10870  105.72863   0.077    0.939    
age_grp65-199        7.36932  105.72918   0.070    0.944    
curr_pts_grp1-3      1.23320    0.08203  15.034   <2e-16 ***
curr_pts_grp4-6      2.31684    0.09479  24.442   <2e-16 ***
curr_pts_grp7-9      2.58484    0.14223  18.173   <2e-16 ***
curr_pts_grp10-150   3.71161    0.12461  29.786   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 31220  on 588197  degrees of freedom
Residual deviance: 28920  on 588185  degrees of freedom
AIC: 28946

Number of Fisher Scoring iterations: 21
```



### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations.

```R
                    Estimate Std. Error z value Pr(>|z|)    
(Intercept)        -13.27751    0.35366 -37.543  < 2e-16 ***
policyTRUE          -0.15309    0.02822  -5.425  5.8e-08 ***
age_grp16-19         0.49486    0.35727   1.385  0.16601    
age_grp20-24        -0.02964    0.35571  -0.083  0.93359    
age_grp25-34        -0.39925    0.35479  -1.125  0.26046    
age_grp35-44        -0.65857    0.35498  -1.855  0.06356 .  
age_grp45-54        -0.89994    0.35526  -2.533  0.01130 *  
age_grp55-64        -0.93012    0.35615  -2.612  0.00901 **
age_grp65-199       -0.27655    0.35551  -0.778  0.43663    
curr_pts_grp1-3      0.73553    0.03780  19.457  < 2e-16 ***
curr_pts_grp4-6      1.43768    0.05393  26.660  < 2e-16 ***
curr_pts_grp7-9      1.77426    0.08378  21.177  < 2e-16 ***
curr_pts_grp10-150   2.32885    0.09663  24.101  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

Null deviance: 148025  on 588197  degrees of freedom
Residual deviance: 145904  on 588185  degrees of freedom
AIC: 145930

Number of Fisher Scoring iterations: 12
```
