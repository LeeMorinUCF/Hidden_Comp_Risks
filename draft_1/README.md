
# Draft 1


## Data

The example dataset contains traffic violations in the Province of Quebec in the years from 1998 to 2010.
The dataset is the complete record of demerit points for the Province of Quebec through those years.
However, the dataset contains only the total number of demerit points awarded at a single roadside stop, not the points for a single violation.
There are no labels for the particular infraction.
The dataset also contains the age and sex of each driver, along with an individual identifier.
The data are aggregated by sex, age_group, demerit point value and recorded daily.
Each aggregate observation for a given point value is weighted by the number of drivers in a particular sex:age_group:point category for a particular day.
These totals are obtained from the SAAQ website [here](http://www.bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERRUNYAW46-44034787356|@}zb&p_lang=2&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3370).
It is numerically the same as recording 1 or zero with one observation for each licensed driver every day (except that most would be zeros).

### Drivers' History

A new categorical variable ```curr_pts_grp``` was added to capture the number of demerit points that a driver has accumulated over the past two years.
This was simple to calculate for the violation events.
For the non-events, an aggregate calculation was performed to take an inventory of the population of drivers with different point histories for each sex and age category.
To reduce the computational burden, the violation history was aggregated into the number of points for point levels 0-10, and in categories 11-20, 21-30 and 30-150, 150 being the highest observed.
In roughly 35% of the driver-days, drivers have no point history.
A further 45% have up to 10 demerit points in the last two years.
The 11-20 category accounts for the next decile.
The remaining decile  is split 7-3% between the next two categories, 21-30 and 30-150, respectively.
The last three categories were consolidated into a 10-150 point category.


### Policy Change: Excessive Speeding

On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revocation of licenses.
Under this policy change, some violations are associated with different demerit point levels.

### Sample selection

The sample was limited to an equal window of two years before and after the date of the policy change,
from April 1, 2006 to March 31, 2010.
The summer months account for a large fraction of the infractions, so it is important to either impose symmetry over the calendar year or explicitly model the seasonality.




## Time Series Plots



### Pairs of Point Values for Related Speeding violations

Plots of the number of instances of tickets with selected pairs of point values.
Coloring should be clear from the context: original point value occurs before the
date of the policy change, the double-point tickets occur afterward.

The 5- and 10-point ticket volumes highlight the strategic choice of pairs of offences.

<img src="num_pts_5_10_all.png" width="1000" />
<img src="num_pts_5_10_M.png" width="1000" />
<img src="num_pts_5_10_F.png" width="1000" />

The 7- and 14- point pair is much cleaner comparison,
since the combinations of other tickets worth 7 points are relatively rare.


<img src="num_pts_7_14_all.png" width="1000" />
<img src="num_pts_7_14_M.png" width="1000" />
<img src="num_pts_7_14_F.png" width="1000" />

### Accumulated Points Balances (Included later)

For each driver, an accumulated demerit point balance
is calculated as the sum of the points awarded to each driver for all violations committed over a two-year rolling window.
A rolling window is used, as opposed to cumulative demerit points, to avoid continually growing balances over the sample period.
The two-year horizon is chosen because that is the time period over which demerit points remain on a driver's record,
potentially counting toward a revocation.

## Tables - Summary Statistics (Included later)


## Linear Probability Models

The following are linear probability regression models estimated from data aggregated by age groups and categories of previous demerit points.
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the same sex and age groups and categories of previous demerit points.

### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.046e-04  8.495e-06  12.318  < 2e-16 ***
age_grp16-19                   6.376e-04  8.947e-06  71.270  < 2e-16 ***
age_grp20-24                   4.915e-04  8.664e-06  56.723  < 2e-16 ***
age_grp25-34                   3.183e-04  8.562e-06  37.178  < 2e-16 ***
age_grp35-44                   2.428e-04  8.552e-06  28.388  < 2e-16 ***
age_grp45-54                   1.930e-04  8.548e-06  22.582  < 2e-16 ***
age_grp55-64                   1.323e-04  8.565e-06  15.446  < 2e-16 ***
age_grp65-199                  3.985e-05  8.580e-06   4.645 3.40e-06 ***
policyTRUE                    -1.077e-06  1.218e-05  -0.088  0.92954    
curr_pts_grp1                  5.763e-04  4.279e-06 134.690  < 2e-16 ***
curr_pts_grp2                  6.163e-04  1.982e-06 310.879  < 2e-16 ***
curr_pts_grp3                  6.886e-04  1.711e-06 402.465  < 2e-16 ***
curr_pts_grp4                  1.117e-03  4.373e-06 255.557  < 2e-16 ***
curr_pts_grp5                  1.241e-03  3.274e-06 378.934  < 2e-16 ***
curr_pts_grp6                  1.409e-03  3.702e-06 380.661  < 2e-16 ***
curr_pts_grp7                  1.682e-03  6.003e-06 280.189  < 2e-16 ***
curr_pts_grp8                  1.853e-03  5.617e-06 329.871  < 2e-16 ***
curr_pts_grp9                  1.701e-03  6.198e-06 274.484  < 2e-16 ***
curr_pts_grp10-150             2.580e-03  4.297e-06 600.495  < 2e-16 ***
age_grp16-19:policyTRUE       -7.350e-05  1.278e-05  -5.753 8.75e-09 ***
age_grp20-24:policyTRUE       -7.503e-05  1.241e-05  -6.045 1.50e-09 ***
age_grp25-34:policyTRUE       -6.085e-05  1.227e-05  -4.959 7.08e-07 ***
age_grp35-44:policyTRUE       -3.281e-05  1.226e-05  -2.677  0.00743 **
age_grp45-54:policyTRUE       -2.358e-05  1.225e-05  -1.925  0.05420 .  
age_grp55-64:policyTRUE       -1.774e-05  1.227e-05  -1.445  0.14835    
age_grp65-199:policyTRUE      -1.696e-06  1.229e-05  -0.138  0.89022    
policyTRUE:curr_pts_grp1      -5.501e-05  5.843e-06  -9.414  < 2e-16 ***
policyTRUE:curr_pts_grp2      -6.344e-05  2.669e-06 -23.773  < 2e-16 ***
policyTRUE:curr_pts_grp3      -6.667e-05  2.404e-06 -27.738  < 2e-16 ***
policyTRUE:curr_pts_grp4      -9.246e-05  5.754e-06 -16.071  < 2e-16 ***
policyTRUE:curr_pts_grp5      -1.203e-04  4.445e-06 -27.071  < 2e-16 ***
policyTRUE:curr_pts_grp6      -1.487e-04  5.063e-06 -29.381  < 2e-16 ***
policyTRUE:curr_pts_grp7      -1.226e-04  8.019e-06 -15.287  < 2e-16 ***
policyTRUE:curr_pts_grp8      -1.946e-04  7.574e-06 -25.688  < 2e-16 ***
policyTRUE:curr_pts_grp9      -1.103e-04  8.440e-06 -13.066  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -5.111e-04  5.568e-06 -91.792  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033185 degrees of freedom
Multiple R-squared:  0.0004603,	Adjusted R-squared:  0.0004603
F-statistic: 7.02e+04 on 35 and 5335033185 DF,  p-value: < 2.2e-16
```
#### Female drivers:
```R

```

### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.



#### Male drivers:
```R

```
#### Female drivers:
```R

```

### Two-point violations (speeding 21-30 over or 7 other violations)

#### Male drivers:
```R

```
#### Female drivers:
```R

```

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change.

#### Male drivers:
```R

```
#### Female drivers:
```R

```


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

#### Male drivers:
```R

```
#### Female drivers:
```R

```
### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.


#### Male drivers:
```R

```
#### Female drivers:
```R

```

### Seven-point violations (speeding 61-80 over or combinations)

The only offence that merits precisely 7 demerit points is speeding 61-80 over, only before the policy change, after which it was changed to a 14-point offence.

There are plenty of 7-point offences before the change but not many 7-point combinations of offences afterwards.
Likewise, there were hardly any 14-point events before the change, because it would involve combining a number of unusually-paired offences, which might include, say, one 12 point offence plus 2 points for a minor offence.

Still, there is some confounding with the policy change effect from other offences, since 14 points can be earned from the 10-point speeding (which was once 5 points) combined with a four-point violation.
Together, these changes are found in the regression with the event defined as either a 7- or 14-point violation.

The following regression is done including both 7- and 14-point violations in the sample after the policy change.

#### Male drivers:
```R

```
#### Female drivers:
```R

```

### X-points and up (speeding 100 or more and 3 other 12-point offences)

I'm not sure that 9 is the best number here. With 9 as the threshold,
it would include 10 but not 5, 14 but not 7, etc. after the policy change.
Let me think about this in the morning.

Combining with the more excessive speeding offences, the number of events is larger.


#### Male drivers:
```R

```
#### Female drivers:
```R

```
