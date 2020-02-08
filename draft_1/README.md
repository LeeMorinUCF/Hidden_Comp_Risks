
# Draft 1: Second version

Current point groups have been further consolidated in the regressions below.


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
For this reason, both 3- and 6-point violations are included in the sample, after the policy change. That is, the 6-point violations are not included in the sample before the window.

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

The following regression is done including both 7- and 14-point violations in the sample after the policy change but only 7-point violations before.

#### Male drivers:
```R

```

#### Female drivers:
```R

```

### Nine-points and up (speeding 80 or more and 10 other 9- or 12-point offences)

This includes as events all infractions classified as 9 points and up before the policy change.
That is, all the 9-, 12-, 15-, 18- and  21-point violations before the policy change.
Then I include all of the point values that are double those values after the policy change.
That is, in addition to the above, I include all the 24-, 30-, and 36-point violations.
This excludes the 10- and 14-point violations that are the doubled 5- and 7-point violations in the previous regressions.
It does, however, include the 7 different non-speeding 9-point violations
and the 3 different non-speeding 12-point violations,
which are the same before and after the policy change.
Note that 12- and 15- point violations never happen after the policy change (```policy == TRUE```) and 24-points and up are technically possible but never happen before the change.
It appears that the non-speeding 12-point violations never happen after the change.

Points in rows vs. post-policy change TRUE for males:
```R
> table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'],
+       saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

     FALSE TRUE
  9   6140 5020
  12   125    0
  15    17    0
  18     4  549
  24     0   96
  30     0   17
  36     0    4
```
(Units are number of rows, that is date-age-sex-point observations, not necessarily individuals.)

Finally, the 4 crazies who got 18 points before the change are equally matched by 4 others (yes, only 4 individuals, 1 per row in each).


#### Male drivers:
```R

```

#### Female drivers:
```R

```

There is not much going on in the higher point categories for the ladies.

Points in rows vs. post-policy change TRUE for females:
```R
> table(saaq_data[sel_obs & saaq_data[, 'events'], 'points'],
+       saaq_data[sel_obs & saaq_data[, 'events'], 'policy'], useNA = 'ifany')

     FALSE TRUE
  9   2263 2136
  12     1    0
  15     1    0
  18     0   23
  24     0    4
```

All of the incidents above 12 points in the above table are individuals (i.e. one driver per row).
That is, it only happened 6 times that a lady got a ticket for speeding more than 100 km/hr over the speed limit.
Compare this to 263 events for males.
So, for the female drivers, most of the action in this regression is from the 9- point to the 18-point speeding violation,
although most of the 9-point violations relate to the 7 offences other than speeding.
