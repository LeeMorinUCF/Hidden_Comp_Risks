# Hidden_Comp_Risks
A hidden competing risks model for when competing outcomes are confounded. 


## Empirical Example

The example datset contains traffic violations in the Province of Quebec in the years from 1998 to 2010. 
The dataset is the complete record of demerit points for the Province of Quebec through those years.
Hoever, the dataset contains only the total number of demerit points awarded at a single roadside stop, not the points for a single violation. 
There are no labels for the particular infraction. 

The hidden competing risks model can be used to identify the probabilities of the individual violations, when only the sum of the points from the violations are observed. 


On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revokation of licenses. 


## Preliminary Analysis

### Standard Logistic Regression Results

The following are logistic regression models estimated from adat aggregated by sex and age groups. 
The non-events, denominators for the event probabilities are the total number of licensed drivers in the age and sex categories. 

#### One-ponit violations (only for speeding 11-20 over)

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



### Time Series

