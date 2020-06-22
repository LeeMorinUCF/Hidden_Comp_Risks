
# Models of Time to Conviction - Female Drivers

The dependent variable is the number of days that pass between the date that
an infraction was committed and the date it was recorded as a conviction.
Convictions are recorded when either the driver pays the fine, thereby admitting
guilt, or is found guilty after challenging the ticket in court.

There are 1,154,069 observations for tickets written between April 1, 2006 and
March 31, 2010.



## Histograms


### Time to conviction before and after policy change

<img src="hist_days2con_F_B4_after.png" width="1000" />

After the increased penalties, there is a slight lift in the number of cases
that settle over 70 to 140 days.
This indicates a slight uptick in the number of cases that are fought in court.
However, there is also a slight increase in the number of tickets that are paid quickly.


## Linear Regression Results (Standard Errors under Homoskedasticity)

No HCCME here, because life is too short. Let's get the answer first.

### Dependent variable: Days to Conviction


```R
Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)        33.0846     6.3929   5.175 2.28e-07 ***
age_grp16-19       34.5519     6.3951   5.403 6.56e-08 ***
age_grp20-24       13.3186     6.3841   2.086  0.03696 *  
age_grp25-34        4.9884     6.3812   0.782  0.43437    
age_grp35-44       -5.3956     6.3811  -0.846  0.39780    
age_grp45-54      -17.2011     6.3816  -2.695  0.00703 **
age_grp55-64      -27.8313     6.3845  -4.359 1.31e-05 ***
age_grp65-199     -39.2925     6.3917  -6.147 7.88e-10 ***
policyTRUE        -10.1838     0.5182 -19.652  < 2e-16 ***
points             15.2369     0.1538  99.045  < 2e-16 ***
policyTRUE:points   1.5511     0.1993   7.783 7.11e-15 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 97.78 on 1154058 degrees of freedom
Multiple R-squared:  0.05203,	Adjusted R-squared:  0.05203
F-statistic:  6335 on 10 and 1154058 DF,  p-value: < 2.2e-16
```



There was no evidence for other interactions with the policy indicator.


### Dependent variable: Logarithm of (1 + ) Days to Conviction


```R
Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)    3.254492   0.074248  43.833  < 2e-16 ***
age_grp16-19   0.166485   0.074352   2.239   0.0251 *  
age_grp20-24   0.064822   0.074225   0.873   0.3825    
age_grp25-34   0.048829   0.074192   0.658   0.5104    
age_grp35-44  -0.107670   0.074190  -1.451   0.1467    
age_grp45-54  -0.364849   0.074196  -4.917 8.77e-07 ***
age_grp55-64  -0.675540   0.074229  -9.101  < 2e-16 ***
age_grp65-199 -1.085454   0.074314 -14.606  < 2e-16 ***
policyTRUE    -0.035779   0.002119 -16.882  < 2e-16 ***
points         0.153164   0.001139 134.485  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.137 on 1154059 degrees of freedom
Multiple R-squared:  0.08581,	Adjusted R-squared:  0.08581
F-statistic: 1.204e+04 on 9 and 1154059 DF,  p-value: < 2.2e-16
```

The interaction with number of points was not significant.



## Logistic Regression Results

### Dependent variable: Days to Conviction = 0

These drivers paid their ticket the same day.


```R
Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept)   -4.49657    0.71085  -6.326 2.52e-10 ***
age_grp16-19  -0.03364    0.71199  -0.047   0.9623    
age_grp20-24   0.03926    0.71075   0.055   0.9559    
age_grp25-34  -0.14044    0.71050  -0.198   0.8433    
age_grp35-44  -0.05703    0.71046  -0.080   0.9360    
age_grp45-54   0.26501    0.71042   0.373   0.7091    
age_grp55-64   0.90278    0.71043   1.271   0.2038    
age_grp65-199  1.61067    0.71046   2.267   0.0234 *  
policyTRUE     0.01156    0.01700   0.680   0.4965    
points        -0.08833    0.01017  -8.683  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 152903  on 1154068  degrees of freedom
Residual deviance: 148265  on 1154059  degrees of freedom
AIC: 148285

```

There were no other policy interactions worth reporting.


### Dependent variable: Days to Conviction > 30

These drivers did not pay their ticket within 30 days.
They might have fought the ticket in court but they might have paid late.


```R
Coefficients:
               Estimate Std. Error z value Pr(>|z|)    
(Intercept)   -0.512852   0.131652  -3.896 9.80e-05 ***
age_grp16-19   0.088821   0.131810   0.674 0.500405    
age_grp20-24   0.203814   0.131586   1.549 0.121405    
age_grp25-34   0.306489   0.131526   2.330 0.019793 *  
age_grp35-44   0.022483   0.131522   0.171 0.864266    
age_grp45-54  -0.437639   0.131535  -3.327 0.000877 ***
age_grp55-64  -0.958592   0.131621  -7.283 3.27e-13 ***
age_grp65-199 -1.580208   0.131944 -11.976  < 2e-16 ***
policyTRUE     0.001168   0.003861   0.302 0.762377    
points         0.204015   0.002237  91.199  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1592047  on 1154068  degrees of freedom
Residual deviance: 1518154  on 1154059  degrees of freedom
AIC: 1518174
```

There were no other policy interactions worth reporting.


### Dependent variable: Days to Conviction > 42

These drivers did not pay their ticket within 42 days.
They probably fought the ticket in court but those who did not might have paid late,
so this allows a grace period for the stragglers.
The number 42 was not only chosen because it is the answer to life, the universe and
everything but because it is a quantile that defines the end of the highest mode of the distribution.


A policy interaction with the number of points was significant here.

```R
Coefficients:
                   Estimate Std. Error z value Pr(>|z|)    
(Intercept)       -1.294683   0.136534  -9.482  < 2e-16 ***
age_grp16-19       0.238390   0.136529   1.746 0.080799 .  
age_grp20-24       0.259035   0.136301   1.900 0.057373 .  
age_grp25-34       0.311866   0.136241   2.289 0.022075 *  
age_grp35-44       0.031124   0.136241   0.228 0.819298    
age_grp45-54      -0.441444   0.136266  -3.240 0.001197 **
age_grp55-64      -0.946877   0.136396  -6.942 3.86e-12 ***
age_grp65-199     -1.534257   0.136896 -11.207  < 2e-16 ***
policyTRUE         0.059520   0.012030   4.947 7.52e-07 ***
points             0.251916   0.003475  72.486  < 2e-16 ***
policyTRUE:points -0.017581   0.004574  -3.844 0.000121 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 1441918  on 1154068  degrees of freedom
Residual deviance: 1377085  on 1154058  degrees of freedom
AIC: 1377107
```


## Generalized Linear Model (Gamma Distribution) Results

The exponential distribution is a special case of the gamma distribution.
In any case, it is a model well-specified for a dependent variable with positive support.

### Dependent variable: Days to Conviction



```R
Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)    3.834964   0.104910  36.555  < 2e-16 ***
age_grp16-19   0.388028   0.105058   3.693 0.000221 ***
age_grp20-24   0.156086   0.104878   1.488 0.136682    
age_grp25-34   0.054631   0.104830   0.521 0.602269    
age_grp35-44  -0.097225   0.104828  -0.927 0.353684    
age_grp45-54  -0.313326   0.104837  -2.989 0.002802 **
age_grp55-64  -0.557070   0.104884  -5.311 1.09e-07 ***
age_grp65-199 -0.885333   0.105003  -8.432  < 2e-16 ***
policyTRUE    -0.108768   0.002994 -36.323  < 2e-16 ***
points         0.178941   0.001609 111.198  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for Gamma family taken to be 2.58001)

    Null deviance: 1665126  on 1154068  degrees of freedom
Residual deviance: 1526946  on 1154059  degrees of freedom
AIC: 11697656
```

There were no other interactions worth reporting.
