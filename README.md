# Hidden_Comp_Risks
A hidden competing risks model for when competing outcomes are confounded. 
In this model, multiple events can occur but only an aggregate (known) function of the events is observed. 
This model can be used to separate the probabilities of individual events. 


## Empirical Example

The example datset contains traffic violations in the Province of Quebec in the years from 1998 to 2010. 
The dataset is the complete record of demerit points for the Province of Quebec through those years.
Hoever, the dataset contains only the total number of demerit points awarded at a single roadside stop, not the points for a single violation. 
There are no labels for the particular infraction. 
The dataset also contains the age and sex of each driver, along with an individual identifier. 
The data are aggregated by sex, age_group, demerit point value and recorded daily. 
Each aggregate observation for a given point value is weighted by the number of drivers in a particular sex:age_group:point category for a particular day. 
These totals are obtained from the SAAQ website [here](http://www.bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERRUNYAW46-44034787356|@}zb&p_lang=2&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3370). 
It is numerically the same as recording 1 or zero with one observation for each licensed driver every day (except that most would be zeros).


On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revokation of licenses. 
Under this policy change, some violations are associated with different demerit point levels. 

The hidden competing risks model can be used to identify the probabilities of the individual violations, when only the sum of the points from the violations are observed. 
It is important to separate these events because the doubling of speeding violations affects several individual offences and point balances. 
Without separating the individual events, multiple changes affect the incidence of demerit point numbers before and after the policy change, confounding the results of a simple difference-in-difference analysis. 




## Preliminary Analysis

### Standard Logistic Regression Results

The following are logistic regression models estimated from adat aggregated by sex and age groups. 
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the age and sex categories. 

#### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have ocurred. 
The policy change did not affect the penalties for this violation but we see a substitution effect toward these minor offecnces. 
The effect is doubly strong for female drivers. 

```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -12.114162   0.064288 -188.435  < 2e-16 ***
policyTRUE        0.224755   0.002782   80.796  < 2e-16 ***
sexF             -0.784185   0.002613 -300.111  < 2e-16 ***
age_grp16-19      2.694381   0.064447   41.807  < 2e-16 ***
age_grp20-24      2.784258   0.064351   43.267  < 2e-16 ***
age_grp25-34      2.588462   0.064319   40.244  < 2e-16 ***
age_grp35-44      2.419288   0.064317   37.615  < 2e-16 ***
age_grp45-54      2.204263   0.064324   34.268  < 2e-16 ***
age_grp55-64      1.918018   0.064356   29.803  < 2e-16 ***
age_grp65-74      1.431281   0.064489   22.194  < 2e-16 ***
age_grp75-84      0.985103   0.065053   15.143  < 2e-16 ***
age_grp85-89      0.574523   0.075273    7.633  2.3e-14 ***
age_grp90-199     0.196327   0.138050    1.422    0.155    
policyTRUE:sexF   0.224281   0.004844   46.304  < 2e-16 ***

```

The incidence of this offence declines with age, with a peak at age group 20-24. 
The benchmark age group that is dropped is the under 16 age group, with ages ranging from 12 to 15. 

#### Two-point violations (speeding 21-30 over or 7 other violations)

The results are very similar, with this event occurring more often. 

```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -10.713458   0.032161 -333.125  < 2e-16 ***
policyTRUE        0.190260   0.001327  143.419  < 2e-16 ***
sexF             -0.813279   0.001242 -654.904  < 2e-16 ***
age_grp16-19      2.604394   0.032249   80.760  < 2e-16 ***
age_grp20-24      2.913012   0.032188   90.499  < 2e-16 ***
age_grp25-34      2.710019   0.032174   84.230  < 2e-16 ***
age_grp35-44      2.521334   0.032174   78.367  < 2e-16 ***
age_grp45-54      2.316124   0.032176   71.982  < 2e-16 ***
age_grp55-64      2.043452   0.032191   63.479  < 2e-16 ***
age_grp65-74      1.561602   0.032249   48.423  < 2e-16 ***
age_grp75-84      1.104802   0.032502   33.992  < 2e-16 ***
age_grp85-89      0.702861   0.037057   18.967  < 2e-16 ***
age_grp90-199     0.464484   0.062446    7.438 1.02e-13 ***
policyTRUE:sexF   0.203253   0.002342   86.792  < 2e-16 ***
```


#### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is inluenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.

```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -9.078646   0.014528 -624.891  < 2e-16 ***
policyTRUE       0.112614   0.001254   89.786  < 2e-16 ***
sexF            -0.976631   0.001211 -806.223  < 2e-16 ***
age_grp16-19     1.349648   0.014671   91.996  < 2e-16 ***
age_grp20-24     1.618401   0.014575  111.038  < 2e-16 ***
age_grp25-34     1.281524   0.014555   88.046  < 2e-16 ***
age_grp35-44     1.007588   0.014556   69.220  < 2e-16 ***
age_grp45-54     0.748211   0.014565   51.372  < 2e-16 ***
age_grp55-64     0.483218   0.014596   33.106  < 2e-16 ***
age_grp65-74     0.064902   0.014711    4.412 1.03e-05 ***
age_grp75-84    -0.207644   0.015104  -13.747  < 2e-16 ***
age_grp85-89    -0.362045   0.020365  -17.777  < 2e-16 ***
age_grp90-199   -0.415223   0.040392  -10.280  < 2e-16 ***
policyTRUE:sexF  0.112748   0.002399   46.992  < 2e-16 ***
```

Only a small fraction of these very commonly committed offences are actually swapped out to the 6 point penalty. 
The result conforms the situation for the lesser offences above. 
This will be revisited with the 6-point violations below. 


#### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each. 

```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -11.242621   0.045870 -245.098  < 2e-16 ***
policyTRUE       -0.183029   0.007917  -23.119  < 2e-16 ***
sexF             -1.889233   0.010094 -187.171  < 2e-16 ***
age_grp16-19      1.580961   0.046237   34.192  < 2e-16 ***
age_grp20-24      0.891231   0.046200   19.291  < 2e-16 ***
age_grp25-34     -0.108638   0.046260   -2.348   0.0189 *  
age_grp35-44     -0.806933   0.046499  -17.354  < 2e-16 ***
age_grp45-54     -1.311041   0.046916  -27.944  < 2e-16 ***
age_grp55-64     -1.672266   0.047948  -34.877  < 2e-16 ***
age_grp65-74     -2.085937   0.051092  -40.827  < 2e-16 ***
age_grp75-84     -2.193342   0.058588  -37.436  < 2e-16 ***
age_grp85-89     -2.507498   0.142418  -17.607  < 2e-16 ***
age_grp90-199    -2.703218   0.380734   -7.100 1.25e-12 ***
policyTRUE:sexF   0.199447   0.021395    9.322  < 2e-16 ***
```
These events happen less ofthen. 
However, there is a *reduction* in these offences for males, which is not present for females (the female:policy interaction cancels the other out). 

Note that there are no changes to the penalties for these offences and the swapping out of the 3-point speeding 40-45 over in a 100km/hr zone, which was changed to 6 points, is not a possibility, since the driver can only be awarded points for a single speeding infraction. 


#### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points. 
In both cases, the 5 point ticket can be a combination some of the above offences. 


```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -15.330901   0.377952  -40.563  < 2e-16 ***
policyTRUE       -1.051216   0.008176 -128.581  < 2e-16 ***
sexF             -1.649577   0.006269 -263.141  < 2e-16 ***
age_grp16-19      5.353422   0.378026   14.162  < 2e-16 ***
age_grp20-24      5.625060   0.377977   14.882  < 2e-16 ***
age_grp25-34      5.011414   0.377972   13.259  < 2e-16 ***
age_grp35-44      4.310719   0.377983   11.405  < 2e-16 ***
age_grp45-54      3.829388   0.378002   10.131  < 2e-16 ***
age_grp55-64      3.315827   0.378070    8.770  < 2e-16 ***
age_grp65-74      2.457329   0.378428    6.494 8.39e-11 ***
age_grp75-84      1.790517   0.380154    4.710 2.48e-06 ***
age_grp85-89      1.395086   0.410473    3.399 0.000677 ***
age_grp90-199     1.397011   0.556340    2.511 0.012036 *  
policyTRUE:sexF   0.062155   0.020571    3.021 0.002516 ** 
```

Notice the sharp drop as several of the offences are moved to 10 points. 
Repeat the analysis by defining the event as either a 5 or 10 point ticket (both before and after). 
There were only 6 sex:age_group:days in which a driver was awarded 10 points at one roadside stop before the policy change. 
Before then, there was no single offence worth 10 points alone, only a combination of lesser offences. 
In contrast, there were about 7000 instances of 5 or 10 point offences after the policy change (6900 for 10 and 7500 for 5). 
Before the change, there was 36000 sex:age_group:days with 5-point offences. 
In these tables, the first argument (points indicator) is in the rows, the second (post-policy indicator) is in the columns. 

```R
> table(saaq_agg[, 'points'] == 10, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367537 105994
  TRUE       6   6867
> table(saaq_agg[, 'points'] == 5, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 331150 105405
  TRUE   36393   7456
> 
```

To compare this, consider the logistic regression with 5 and 10 points as a combined event. 

```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -15.174742   0.333333  -45.524  < 2e-16 ***
policyTRUE       -0.397884   0.006129  -64.923  < 2e-16 ***
sexF             -1.649042   0.006269 -263.064  < 2e-16 ***
age_grp16-19      5.236348   0.333406   15.706  < 2e-16 ***
age_grp20-24      5.472094   0.333358   16.415  < 2e-16 ***
age_grp25-34      4.847917   0.333353   14.543  < 2e-16 ***
age_grp35-44      4.153338   0.333365   12.459  < 2e-16 ***
age_grp45-54      3.664125   0.333385   10.991  < 2e-16 ***
age_grp55-64      3.149115   0.333456    9.444  < 2e-16 ***
age_grp65-74      2.304442   0.333824    6.903 5.09e-12 ***
age_grp75-84      1.657979   0.335546    4.941 7.77e-07 ***
age_grp85-89      1.242549   0.365838    3.396 0.000683 ***
age_grp90-199     1.408635   0.485912    2.899 0.003744 ** 
policyTRUE:sexF   0.015318   0.015715    0.975 0.329695    
```

Now there is still a decrease of the total number of combined 5 and 10 point offences after the policy change.
The policy effect is the same for both sexes. 


#### Six-point violations (combinations)

The only offence that merits precisely 6 demerit points is speeding 40-45 over in a 100+ zone, only after the policy change. 
Other than that, a driver can only get 6 points for a combination of 1-5 point offences. 
Among these, the above offence (40-45 over in a 100+ zone) can be one of two 3-point offences that add to 6 points. 

Since the 6 point combination with multiple tickets is rare, the former 3 point violation (fairly common) dominates in the post-policy change period. 

```R
> table(saaq_agg[, 'points'] == 6, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 365767 105354
  TRUE    1776   7507
> 
```

Thie regression with only 6 points as the event is as follows.

```R
Coefficients:
                 Estimate Std. Error z value Pr(>|z|)    
(Intercept)     -17.12879    0.33391 -51.298  < 2e-16 ***
policyTRUE        3.06671    0.02222 138.039  < 2e-16 ***
sexF             -3.48373    0.12557 -27.743  < 2e-16 ***
age_grp16-19      3.11675    0.33396   9.333  < 2e-16 ***
age_grp20-24      3.08375    0.33368   9.242  < 2e-16 ***
age_grp25-34      2.27320    0.33365   6.813 9.56e-12 ***
age_grp35-44      1.84645    0.33377   5.532 3.16e-08 ***
age_grp45-54      1.51337    0.33384   4.533 5.81e-06 ***
age_grp55-64      1.10308    0.33430   3.300 0.000968 ***
age_grp65-74      0.45441    0.33650   1.350 0.176891    
age_grp75-84      0.06489    0.34381   0.189 0.850290    
age_grp85-89     -0.23938    0.44096  -0.543 0.587217    
age_grp90-199    -0.86583    1.05409  -0.821 0.411420    
policyTRUE:sexF   2.27115    0.12689  17.898  < 2e-16 ***
```

This is much more likely for males and even more likely for females. 
Consider next the combined event with either 3 or 6 points at a single roadside stop.

```R
> table(saaq_agg[, 'points'] %in% c(3, 6), 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 302718  87460
  TRUE   64825  25401
> 
```

This is a big drop from before the policy change (although the units in the above tables are in sex:age_group:days and don't take into account the number of drivers in each). 
The logistic regression captures the events at the individual level. 

```R
Coefficients:
                 Estimate Std. Error z value Pr(>|z|)    
(Intercept)     -9.081072   0.014515 -625.65  < 2e-16 ***
policyTRUE       0.128407   0.001246  103.04  < 2e-16 ***
sexF            -0.977421   0.001211 -807.00  < 2e-16 ***
age_grp16-19     1.358348   0.014655   92.69  < 2e-16 ***
age_grp20-24     1.624033   0.014561  111.53  < 2e-16 ***
age_grp25-34     1.284751   0.014541   88.35  < 2e-16 ***
age_grp35-44     1.010298   0.014542   69.47  < 2e-16 ***
age_grp45-54     0.750561   0.014551   51.58  < 2e-16 ***
age_grp55-64     0.484979   0.014582   33.26  < 2e-16 ***
age_grp65-74     0.065996   0.014697    4.49 7.11e-06 ***
age_grp75-84    -0.206975   0.015090  -13.72  < 2e-16 ***
age_grp85-89    -0.362222   0.020343  -17.80  < 2e-16 ***
age_grp90-199   -0.416603   0.040361  -10.32  < 2e-16 ***
policyTRUE:sexF  0.108639   0.002387   45.51  < 2e-16 ***
```

It seems as though the substituion effect is still winning out, for females even more than males. 
The next point-level event is concentrated on excessive speeding. 



#### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence. 

The sex:age_group:dates that correspond to these point levels are:

```R
> table(saaq_agg[, 'points'] == 7, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 353153 112833
  TRUE   14390     28
> table(saaq_agg[, 'points'] == 14, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367537 109872
  TRUE       6   2989
> table(saaq_agg[, 'points'] %in% c(7, 14), 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 353147 109844
  TRUE   14396   3017
> 
```

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards. 
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence. 

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation. 
Together, these changes are found in the logistic regression with the event defined as either a 7- or 14-point violation. 

```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -15.94188    0.50001  -31.883  < 2e-16 ***
policyTRUE       -0.48729    0.01537  -31.699  < 2e-16 ***
sexF             -2.42576    0.02152 -112.722  < 2e-16 ***
age_grp16-19      4.74991    0.50019    9.496  < 2e-16 ***
age_grp20-24      4.76844    0.50008    9.535  < 2e-16 ***
age_grp25-34      3.89122    0.50009    7.781 7.19e-15 ***
age_grp35-44      2.79854    0.50020    5.595 2.21e-08 ***
age_grp45-54      2.06235    0.50042    4.121 3.77e-05 ***
age_grp55-64      1.22642    0.50134    2.446   0.0144 *  
age_grp65-74      0.03716    0.50741    0.073   0.9416    
age_grp75-84     -0.48584    0.52859   -0.919   0.3580    
age_grp85-89     -0.61238    0.76376   -0.802   0.4227    
age_grp90-199    -6.65613   18.21589   -0.365   0.7148    
policyTRUE:sexF  -0.06540    0.05766   -1.134   0.2567    
```

There is a sizeable reduction in occurrence of these offences, nearly equal for both sexes. 
The standard errors are bigger for these offences, since the number of drivers is smaller. 
The declining effect by age is still there but excessive speeding really thins out for the 65-and-over age group. 


#### Nine-point violations (speeding 61-80 over or combinations)

One offence that merits 9 demerit points is speeding 80-100 over, only before the policy change, after which it was changed to a 18-point offence. 
Other than that, there 7 other violations that result in 9 demerit points, none of which were changed with the excessive speeding policy. 

The sex:age_group:dates that correspond to these point levels are:

```R
> table(saaq_agg[, 'points'] == 9, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 341056 105951
  TRUE   26487   6910
> table(saaq_agg[, 'points'] == 18, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367534 112220
  TRUE       9    641
> table(saaq_agg[, 'points'] %in% c(9, 18), 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 341047 105310
  TRUE   26496   7551
> 
```

This is a big drop before and after the policy change. 
The combined 9- and 18-point event is analyzed in the following logistic regression: 


```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -12.12566    0.06923 -175.147  < 2e-16 ***
policyTRUE       -0.17585    0.01236  -14.225  < 2e-16 ***
sexF             -0.99979    0.01096  -91.195  < 2e-16 ***
age_grp16-19      0.78173    0.07040   11.104  < 2e-16 ***
age_grp20-24      0.53513    0.06988    7.657 1.90e-14 ***
age_grp25-34     -0.14281    0.06978   -2.047   0.0407 *  
age_grp35-44     -0.55330    0.06988   -7.917 2.43e-15 ***
age_grp45-54     -0.89284    0.07015  -12.727  < 2e-16 ***
age_grp55-64     -1.05761    0.07076  -14.947  < 2e-16 ***
age_grp65-74     -0.90299    0.07150  -12.630  < 2e-16 ***
age_grp75-84     -0.41662    0.07257   -5.741 9.43e-09 ***
age_grp85-89     -0.05774    0.09080   -0.636   0.5248    
age_grp90-199     0.05764    0.15872    0.363   0.7165    
policyTRUE:sexF   0.18079    0.02354    7.679 1.61e-14 ***
```

A drop is recorded for the males that does not appear for the females. 
Also, the young-and-stoopid effect dominates the hump shape by age for the previous regressions. 

#### Twelve-point violations (speeding 100-119 over or 3 other offences)

The 12-point speeding offence was changed to a 24-point offence but the others were unchanged. 

```R
> table(saaq_agg[, 'points'] == 12, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367115 112858
  TRUE     428      3
> table(saaq_agg[, 'points'] == 24, 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367543 112747
  TRUE       0    114
> table(saaq_agg[, 'points'] %in% c(12, 24), 
+       saaq_agg[, 'policy'], useNA = 'ifany')
       
         FALSE   TRUE
  FALSE 367115 112744
  TRUE     428    117
> 
```

```R
Coefficients:
                  Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -15.485985   0.117621 -131.660  < 2e-16 ***
policyTRUE        0.006988   0.103480    0.068  0.94616    
sexF             -4.866661   0.578275   -8.416  < 2e-16 ***
age_grp20-24      0.359296   0.131964    2.723  0.00648 ** 
age_grp25-34     -0.748240   0.136721   -5.473 4.43e-08 ***
age_grp35-44     -2.295187   0.183308  -12.521  < 2e-16 ***
age_grp45-54     -3.367519   0.268299  -12.551  < 2e-16 ***
age_grp55-64     -4.277361   0.461686   -9.265  < 2e-16 ***
policyTRUE:sexF   1.780131   0.736749    2.416  0.01568 *  
```

The observations are very few for these offences, so the young (under 16) and old (65-and-over) age groups were dropped, leaving 16-24 as the benchmark age group. 
For the observations there are, the policy has little effect, except that, post-change, the ladies seem to be embracing the road-racing mentality at this level. 
With millions of observations, I wouldn't get too excited about a t-statistic anywhere near 2. 
Still, this is where, I suspect, the 5- to 10-point excessive speeding violation might be confounded with the 12-point violation. 
The 10-point offences were once the very common 5-point offences, which might often be combined with another 2-point offence for a total of 12 after the policy change. 
This is what got me thinking about the hidden competing risks approach above. 

#### Twelve-points and up (speeding 100 or more and 3 other 12-point offences)

Combining with the more excessive speeding offences, the results are close to the case including only the 12-point offences. 

```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -15.16573    0.07473 -202.944  < 2e-16 ***
policyTRUE        1.83710    0.05678   32.357  < 2e-16 ***
sexF             -4.47263    0.44943   -9.952  < 2e-16 ***
age_grp20-24      0.06916    0.07801    0.886  0.37537    
age_grp25-34     -0.96751    0.08019  -12.066  < 2e-16 ***
age_grp35-44     -2.37122    0.10987  -21.582  < 2e-16 ***
age_grp45-54     -3.40594    0.15530  -21.932  < 2e-16 ***
age_grp55-64     -4.85871    0.33945  -14.313  < 2e-16 ***
policyTRUE:sexF   1.25806    0.48521    2.593  0.00952 ** 
```

Again, the age groups had to be restricted for the likelihood maximization to converge. 

With the possible 5 (now 10) point offences we don't know if the ladies are substituting down to the 50-60 over offence more than the men are or if they are just simply embracing the spirit of excessive speeding just as the penalties are increased. 


#### More than Twelve-points (only speeding 120 or more)

This category includes speeding 120-139 over (15, changed to 30 points after policy change), 
speeding 140-159 over (18, changed to 36 points after policy change), 


```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -17.23243    0.15164 -113.641  < 2e-16 ***
policyTRUE        3.85623    0.13876   27.791  < 2e-16 ***
sexF             -3.21146    0.71958   -4.463 8.08e-06 ***
age_grp20-24     -0.10875    0.09820   -1.107    0.268    
age_grp25-34     -1.08738    0.09980  -10.896  < 2e-16 ***
age_grp35-44     -2.38981    0.13779  -17.344  < 2e-16 ***
age_grp45-54     -3.41749    0.19051  -17.939  < 2e-16 ***
age_grp55-64     -5.29875    0.50595  -10.473  < 2e-16 ***
policyTRUE:sexF  -0.02408    0.74675   -0.032    0.974    
```

Now both males and females are increasing their tendency for excessive speeding in roughly equal numbers after the policy change. 
Strange things can happen when there are such a small number of such events. 

#### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)

This regression predicts the number of 9, 12, 15, and 18-point violations, along with the corresponding 18, 24, 30 and 36-point violations. 

```R
Coefficients:
                 Estimate Std. Error  z value Pr(>|z|)    
(Intercept)     -12.12534    0.06923 -175.144  < 2e-16 ***
policyTRUE       -0.17118    0.01225  -13.969  < 2e-16 ***
sexF             -1.01363    0.01094  -92.631  < 2e-16 ***
age_grp16-19      0.79821    0.07039   11.341  < 2e-16 ***
age_grp20-24      0.56256    0.06987    8.052 8.15e-16 ***
age_grp25-34     -0.12294    0.06977   -1.762    0.078 .  
age_grp35-44     -0.54542    0.06988   -7.805 5.95e-15 ***
age_grp45-54     -0.88769    0.07015  -12.654  < 2e-16 ***
age_grp55-64     -1.05424    0.07076  -14.900  < 2e-16 ***
age_grp65-74     -0.90069    0.07150  -12.598  < 2e-16 ***
age_grp75-84     -0.41520    0.07257   -5.721 1.06e-08 ***
age_grp85-89     -0.05722    0.09080   -0.630    0.529    
age_grp90-199     0.05759    0.15872    0.363    0.717    
policyTRUE:sexF   0.17801    0.02348    7.583 3.39e-14 ***
```

The results are dominated by the 9 vs. 18 point infractions, with a modest reduction for males but no significant change for female drivers. 




```R

```


### Time Series

