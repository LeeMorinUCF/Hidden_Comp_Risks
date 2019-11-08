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


On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revokation of licenses. 
Under this policy change, some violations are associated with different demerit point levels. 

The hidden competing risks model can be used to identify the probabilities of the individual violations, when only the sum of the points from the violations are observed. 
It is important to separate these events because the doubling of speeding violations affects several individual offences and point balances. 
Without separating the individual events, multiple changes affect the incidence of demerit point numbers before and after the policy change, confounding the results of a simple difference-in-difference analysis. 




## Preliminary Analysis

### Standard Logistic Regression Results

The following are logistic regression models estimated from adat aggregated by sex and age groups. 
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the age and sex categories. 

#### One-ponit violations (for speeding 11-20 over)

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

The incidence of this offfence declines with age, with a peak at age group 20-24. 
The benchmark age group that is dropped is the under 16 age group, with ages ranging from 12 to 15. 

#### Two-ponit violations (speeding 21-30 over or 7 other violations)

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


#### Three-ponit violations (speeding 31-45 over or 9 other violations)

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


#### Four-ponit violations (speeding 31-45 over or 9 other violations)

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

### Time Series

