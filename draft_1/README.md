
# Draft 1: Second version

Current point groups have been further consolidated in the regressions below.

Scroll down to the bottom for regressions with 2-day, 2-week and 4-week performance windows centered on April 1, 2008, the date the new penalties were introduced.

<!---
# UNDER CONSTRUCTION!

Please see the old version in ```README_v1.md```.
--->

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

#### Monthly Series

The 5- and 10-point ticket volumes highlight the strategic choice of pairs of offences.

<img src="num_pts_5_10_all.png" width="1000" />
<img src="num_pts_5_10_M.png" width="1000" />
<img src="num_pts_5_10_F.png" width="1000" />

The 7- and 14- point pair is much cleaner comparison,
since the combinations of other tickets worth 7 points are relatively rare.


<img src="num_pts_7_14_all.png" width="1000" />
<img src="num_pts_7_14_M.png" width="1000" />
<img src="num_pts_7_14_F.png" width="1000" />


#### Daily Series

For a close-up view of the behaviour around the policy change,
the following plots show that there is not much evidence of leniency in the days following the policy change.
If anything, it appears that policy stepped up enforcement to get the message across.
The dotted vertical lines indicate the window of advertising dates for the SAAQ publicity
campaign << Vitesse 2008 >> documented in a marketing report available
[here](https://saaq.gouv.qc.ca/fileadmin/documents/publications/espace-recherche/evaluation-campagne-vitesse-2008.pdf).


<img src="num_pts_daily_5_10_all.png" width="1000" />
<img src="num_pts_daily_7_14_all.png" width="1000" />


### Accumulated Points Balances (Included later)

For each driver, an accumulated demerit point balance
is calculated as the sum of the points awarded to each driver for all violations committed over a two-year rolling window.
A rolling window is used, as opposed to cumulative demerit points, to avoid continually growing balances over the sample period.
The two-year horizon is chosen because that is the time period over which demerit points remain on a driver's record,
potentially counting toward a revocation.

## Tables - Summary Statistics

This table shows the number of individual tickets handed out
for males and females in each two-year window before
and after the policy change.
This is the entire sample used in the regressions below,
along with some totals of the subgroups.


```R
> # Violation frequencies:
> saaq_tab
   points   M_before    M_after   F_before    F_after
1       0 2617459603 2714777888 2109324267 2229733937
2       1     101298     122899      45382      61778
3       2     533167     572194     249669     283108
4       3     701053     627807     247991     239554
5       4      15567      15278       2216       2470
6       5      43006      12368       8172       2272
7       6        496      12000         21       3296
8       7       7688         18        648          6
9       9       7382       5791       2587       2431
10     10          0      12747          0       2137
11     12        127          0          1          0
12     14          0       4145          0        302
13     15         17          0          1          0
14     18          3        560          0         23
15     21          0          0          0          0
16     24          0         98          0          4
17     30          0         17          0          0
18     36          0          4          0          0
>
> # Column totals (frequency of ticket events):
> saaq_tab_sums
M_before  M_after F_before  F_after
 1409804  1385926   556688   597381
>
> # Total for males:
> saaq_tab_sums['M_before'] + saaq_tab_sums['M_after']
M_before
 2795730
>
> # Total for females:
> saaq_tab_sums['F_before'] + saaq_tab_sums['F_after']
F_before
 1154069
>
> # Total before policy:
> saaq_tab_sums['M_before'] + saaq_tab_sums['F_before']
M_before
 1966492
>
> # Total after policy:
> saaq_tab_sums['M_after'] + saaq_tab_sums['F_after']
M_after
1983307
>
> # Grand total number of tickets:
> sum(saaq_tab_sums)
[1] 3949799
>
> # Percent of driver-days with tickets:
>
> # Before policy change:
> sum(saaq_tab_sums['M_before'] + saaq_tab_sums['F_before']) /
+   sum(saaq_tab_denoms['M_before'] + saaq_tab_denoms['F_before'])
[1] 0.0004160317
>
> # After policy change:
> sum(saaq_tab_sums['M_after'] + saaq_tab_sums['F_after']) /
+   sum(saaq_tab_denoms['M_after'] + saaq_tab_denoms['F_after'])
[1] 0.0004011128
>
> # Entire window:
> sum(saaq_tab_sums)/sum(saaq_tab_denoms)
[1] 0.0004084043
>
```

I second-guessed myself when I saw the large numbers of low-point tickets.
They seem like enormous numbers.
Back of envelope: 200 police per 100,000 x 8 million population is about 16000 police officers in Quebec, making about 24 million police-officer-days in which to hand out all of these tickets.
With a total of 3,950,016 tickets in the sample, this is about one ticket per week on average and most police are busy catching the real bad guys.
The numbers make sense.
Still, I double-checked these totals from the raw data and I get exactly the same figures.
The zero-ticket driver-days have higher numbers than I expect for the reasons I explained about the total driving population.

Still, the percentages make sense. An average of 4 tickets in 30 years.
Many people get no tickets. The average driver gets one every several years.
The speeders bring up the average about 10% but the policy reduces it by 4% overall.

## Linear Probability Models

The following are linear probability regression models estimated from data aggregated by age groups and categories of previous demerit points.
The non-events, denominators for the event probabilities, are the total number of licensed drivers in the same sex and age groups and categories of previous demerit points.

### All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.

This regression shows the results without any variables related to the policy change.

#### Pooled regression without policy indicators (male and female drivers):
```R
Coefficients:
                     Estimate Std. Error  t value Pr(>|t|)    
(Intercept)        -2.943e-05  4.647e-06   -6.333  2.4e-10 ***
age_grp16-19        4.708e-04  4.809e-06   97.898  < 2e-16 ***
age_grp20-24        3.852e-04  4.703e-06   81.910  < 2e-16 ***
age_grp25-34        2.651e-04  4.664e-06   56.854  < 2e-16 ***
age_grp35-44        2.229e-04  4.660e-06   47.824  < 2e-16 ***
age_grp45-54        1.749e-04  4.658e-06   37.559  < 2e-16 ***
age_grp55-64        1.219e-04  4.664e-06   26.126  < 2e-16 ***
age_grp65-199       5.125e-05  4.671e-06   10.971  < 2e-16 ***
sexM                1.630e-04  4.174e-07  390.600  < 2e-16 ***
curr_pts_grp1-3     5.461e-04  6.236e-07  875.696  < 2e-16 ***
curr_pts_grp4-6     1.114e-03  1.103e-06 1009.516  < 2e-16 ***
curr_pts_grp7-9     1.588e-03  1.822e-06  871.297  < 2e-16 ***
curr_pts_grp10-150  2.207e-03  2.245e-06  983.003  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245481 degrees of freedom
Multiple R-squared:  0.0004156,	Adjusted R-squared:  0.0004156
F-statistic: 3.352e+05 on 12 and 9675245481 DF,  p-value: < 2.2e-16
```

Now introduce an indicator variable for the period after the policy change was in effect.

#### Pooled regression with policy indicators but without policy interactions (male and female drivers):
```R
Coefficients:
                     Estimate Std. Error  t value Pr(>|t|)    
(Intercept)        -1.116e-05  4.651e-06   -2.399   0.0164 *  
policyTRUE         -3.653e-05  4.112e-07  -88.838   <2e-16 ***
age_grp16-19        4.717e-04  4.809e-06   98.089   <2e-16 ***
age_grp20-24        3.851e-04  4.703e-06   81.876   <2e-16 ***
age_grp25-34        2.652e-04  4.664e-06   56.868   <2e-16 ***
age_grp35-44        2.225e-04  4.660e-06   47.747   <2e-16 ***
age_grp45-54        1.753e-04  4.658e-06   37.633   <2e-16 ***
age_grp55-64        1.226e-04  4.664e-06   26.292   <2e-16 ***
age_grp65-199       5.247e-05  4.672e-06   11.232   <2e-16 ***
sexM                1.626e-04  4.174e-07  389.632   <2e-16 ***
curr_pts_grp1-3     5.474e-04  6.238e-07  877.522   <2e-16 ***
curr_pts_grp4-6     1.116e-03  1.104e-06 1011.226   <2e-16 ***
curr_pts_grp7-9     1.590e-03  1.822e-06  872.451   <2e-16 ***
curr_pts_grp10-150  2.211e-03  2.246e-06  984.599   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245480 degrees of freedom
Multiple R-squared:  0.0004164,	Adjusted R-squared:  0.0004164
F-statistic: 3.1e+05 on 13 and 9675245480 DF,  p-value: < 2.2e-16
```

Now introduce interactions with the indicator variable for the period after the policy change was in effect.


#### Pooled regression with policy indicators and interactions (male and female drivers):
```R
Coefficients:
                                Estimate Std. Error  t value Pr(>|t|)    
(Intercept)                    9.207e-05  6.529e-06   14.101  < 2e-16 ***
age_grp16-19                   4.562e-04  6.790e-06   67.184  < 2e-16 ***
age_grp20-24                   3.656e-04  6.623e-06   55.205  < 2e-16 ***
age_grp25-34                   2.453e-04  6.567e-06   37.350  < 2e-16 ***
age_grp35-44                   1.932e-04  6.561e-06   29.451  < 2e-16 ***
age_grp45-54                   1.456e-04  6.559e-06   22.196  < 2e-16 ***
age_grp55-64                   9.396e-05  6.570e-06   14.302  < 2e-16 ***
age_grp65-199                  2.531e-05  6.581e-06    3.846 0.000120 ***
policyTRUE                    -4.813e-06  9.274e-06   -0.519 0.603790    
curr_pts_grp1-3                5.955e-04  9.076e-07  656.200  < 2e-16 ***
curr_pts_grp4-6                1.214e-03  1.646e-06  737.554  < 2e-16 ***
curr_pts_grp7-9                1.713e-03  2.729e-06  627.723  < 2e-16 ***
curr_pts_grp10-150             2.573e-03  3.553e-06  724.287  < 2e-16 ***
age_grp16-19:policyTRUE       -3.938e-05  9.619e-06   -4.094 4.24e-05 ***
age_grp20-24:policyTRUE       -4.030e-05  9.405e-06   -4.285 1.83e-05 ***
age_grp25-34:policyTRUE       -3.524e-05  9.325e-06   -3.779 0.000158 ***
age_grp35-44:policyTRUE       -1.512e-05  9.319e-06   -1.622 0.104775    
age_grp45-54:policyTRUE       -1.181e-05  9.314e-06   -1.268 0.204882    
age_grp55-64:policyTRUE       -7.917e-06  9.328e-06   -0.849 0.396034    
age_grp65-199:policyTRUE       4.100e-06  9.343e-06    0.439 0.660748    
policyTRUE:curr_pts_grp1-3    -5.372e-05  1.246e-06  -43.122  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -1.127e-04  2.212e-06  -50.941  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.382e-04  3.660e-06  -37.759  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -5.016e-04  4.578e-06 -109.556  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245470 degrees of freedom
Multiple R-squared:  0.0004027,	Adjusted R-squared:  0.0004027
F-statistic: 1.695e+05 on 23 and 9675245470 DF,  p-value: < 2.2e-16
```

To detect any gender differences, male dummies were added, along with a male dummy policy interaction.

#### Pooled regression with policy indicators and interactions (male and female drivers, with male dummies):
```R
Coefficients:
                                Estimate Std. Error  t value Pr(>|t|)    
(Intercept)                   -4.237e-05  6.544e-06   -6.474 9.55e-11 ***
age_grp16-19                   4.971e-04  6.792e-06   73.196  < 2e-16 ***
age_grp20-24                   4.101e-04  6.625e-06   61.903  < 2e-16 ***
age_grp25-34                   2.883e-04  6.568e-06   43.887  < 2e-16 ***
age_grp35-44                   2.356e-04  6.563e-06   35.896  < 2e-16 ***
age_grp45-54                   1.866e-04  6.560e-06   28.445  < 2e-16 ***
age_grp55-64                   1.315e-04  6.571e-06   20.007  < 2e-16 ***
age_grp65-199                  5.374e-05  6.582e-06    8.165 3.22e-16 ***
policyTRUE                     2.523e-05  9.294e-06    2.715  0.00663 **
sexM                           1.805e-04  5.970e-07  302.323  < 2e-16 ***
curr_pts_grp1-3                5.731e-04  9.106e-07  629.352  < 2e-16 ***
curr_pts_grp4-6                1.173e-03  1.651e-06  710.460  < 2e-16 ***
curr_pts_grp7-9                1.660e-03  2.735e-06  606.997  < 2e-16 ***
curr_pts_grp10-150             2.506e-03  3.560e-06  703.874  < 2e-16 ***
policyTRUE:sexM               -3.517e-05  8.350e-07  -42.116  < 2e-16 ***
age_grp16-19:policyTRUE       -4.944e-05  9.620e-06   -5.139 2.77e-07 ***
age_grp20-24:policyTRUE       -5.103e-05  9.407e-06   -5.425 5.80e-08 ***
age_grp25-34:policyTRUE       -4.597e-05  9.327e-06   -4.928 8.29e-07 ***
age_grp35-44:policyTRUE       -2.582e-05  9.321e-06   -2.770  0.00560 **
age_grp45-54:policyTRUE       -2.231e-05  9.316e-06   -2.394  0.01665 *  
age_grp55-64:policyTRUE       -1.785e-05  9.329e-06   -1.913  0.05572 .  
age_grp65-199:policyTRUE      -4.003e-06  9.343e-06   -0.428  0.66835    
policyTRUE:curr_pts_grp1-3    -4.885e-05  1.250e-06  -39.077  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -1.038e-04  2.220e-06  -46.751  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.265e-04  3.668e-06  -34.498  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -4.870e-04  4.588e-06 -106.145  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0202 on 9675245468 degrees of freedom
Multiple R-squared:  0.0004185,	Adjusted R-squared:  0.0004185
F-statistic: 1.62e+05 on 25 and 9675245468 DF,  p-value: < 2.2e-16
```

To detect any further gender differences, the same regression is run on each sample separately.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.058e-04  8.494e-06  12.459  < 2e-16 ***
age_grp16-19                   6.357e-04  8.947e-06  71.058  < 2e-16 ***
age_grp20-24                   4.917e-04  8.664e-06  56.754  < 2e-16 ***
age_grp25-34                   3.177e-04  8.562e-06  37.110  < 2e-16 ***
age_grp35-44                   2.416e-04  8.552e-06  28.248  < 2e-16 ***
age_grp45-54                   1.914e-04  8.548e-06  22.394  < 2e-16 ***
age_grp55-64                   1.307e-04  8.565e-06  15.258  < 2e-16 ***
age_grp65-199                  3.865e-05  8.580e-06   4.505 6.64e-06 ***
policyTRUE                    -6.887e-07  1.218e-05  -0.057  0.95490    
curr_pts_grp1-3                6.517e-04  1.299e-06 501.573  < 2e-16 ***
curr_pts_grp4-6                1.267e-03  2.185e-06 580.057  < 2e-16 ***
curr_pts_grp7-9                1.751e-03  3.454e-06 506.902  < 2e-16 ***
curr_pts_grp10-150             2.580e-03  4.297e-06 600.395  < 2e-16 ***
age_grp16-19:policyTRUE       -7.275e-05  1.277e-05  -5.695 1.24e-08 ***
age_grp20-24:policyTRUE       -7.515e-05  1.241e-05  -6.054 1.41e-09 ***
age_grp25-34:policyTRUE       -6.118e-05  1.227e-05  -4.986 6.16e-07 ***
age_grp35-44:policyTRUE       -3.318e-05  1.226e-05  -2.707  0.00679 **
age_grp45-54:policyTRUE       -2.398e-05  1.225e-05  -1.958  0.05025 .  
age_grp55-64:policyTRUE       -1.828e-05  1.227e-05  -1.489  0.13639    
age_grp65-199:policyTRUE      -2.175e-06  1.229e-05  -0.177  0.85954    
policyTRUE:curr_pts_grp1-3    -6.777e-05  1.794e-06 -37.787  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -1.287e-04  2.954e-06 -43.558  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.460e-04  4.660e-06 -31.342  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -5.112e-04  5.568e-06 -91.808  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02288 on 5335033197 degrees of freedom
Multiple R-squared:  0.0004588,	Adjusted R-squared:  0.0004588
F-statistic: 1.065e+05 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.618e-05  1.069e-05   3.384 0.000715 ***
age_grp16-19                   2.668e-04  1.093e-05  24.401  < 2e-16 ***
age_grp20-24                   2.685e-04  1.077e-05  24.919  < 2e-16 ***
age_grp25-34                   2.140e-04  1.072e-05  19.955  < 2e-16 ***
age_grp35-44                   1.909e-04  1.072e-05  17.806  < 2e-16 ***
age_grp45-54                   1.403e-04  1.072e-05  13.095  < 2e-16 ***
age_grp55-64                   9.135e-05  1.073e-05   8.515  < 2e-16 ***
age_grp65-199                  4.161e-05  1.074e-05   3.873 0.000107 ***
policyTRUE                    -6.225e-06  1.483e-05  -0.420 0.674692    
curr_pts_grp1-3                4.398e-04  1.207e-06 364.263  < 2e-16 ***
curr_pts_grp4-6                9.110e-04  2.584e-06 352.603  < 2e-16 ***
curr_pts_grp7-9                1.275e-03  5.002e-06 254.829  < 2e-16 ***
curr_pts_grp10-150             1.877e-03  8.406e-06 223.265  < 2e-16 ***
age_grp16-19:policyTRUE        1.008e-05  1.516e-05   0.665 0.505973    
age_grp20-24:policyTRUE        1.827e-06  1.495e-05   0.122 0.902720    
age_grp25-34:policyTRUE       -8.017e-06  1.488e-05  -0.539 0.590017    
age_grp35-44:policyTRUE        1.906e-06  1.487e-05   0.128 0.898024    
age_grp45-54:policyTRUE       -9.446e-07  1.487e-05  -0.064 0.949348    
age_grp55-64:policyTRUE        1.580e-06  1.488e-05   0.106 0.915445    
age_grp65-199:policyTRUE       9.430e-06  1.490e-05   0.633 0.526891    
policyTRUE:curr_pts_grp1-3    -1.106e-05  1.645e-06  -6.721 1.80e-11 ***
policyTRUE:curr_pts_grp4-6    -1.427e-05  3.429e-06  -4.162 3.16e-05 ***
policyTRUE:curr_pts_grp7-9    -2.125e-06  6.581e-06  -0.323 0.746759    
policyTRUE:curr_pts_grp10-150 -2.078e-04  1.053e-05 -19.738  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0163 on 4340212249 degrees of freedom
Multiple R-squared:  0.0002095,	Adjusted R-squared:  0.0002095
F-statistic: 3.955e+04 on 23 and 4340212249 DF,  p-value: < 2.2e-16
```

Given the differences in results, the remaining regressions are run separately by gender.

### One-point violations (for speeding 11-20 over)

This is the cleanest point level because there is a single violation that could have occurred.



#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.578e-06  2.407e-06   0.656 0.511938    
age_grp16-19                   4.866e-05  2.535e-06  19.196  < 2e-16 ***
age_grp20-24                   2.725e-05  2.455e-06  11.102  < 2e-16 ***
age_grp25-34                   2.548e-05  2.426e-06  10.506  < 2e-16 ***
age_grp35-44                   2.536e-05  2.423e-06  10.465  < 2e-16 ***
age_grp45-54                   2.277e-05  2.422e-06   9.403  < 2e-16 ***
age_grp55-64                   1.828e-05  2.427e-06   7.532 4.99e-14 ***
age_grp65-199                  8.842e-06  2.431e-06   3.638 0.000275 ***
policyTRUE                     2.147e-06  3.450e-06   0.622 0.533738    
curr_pts_grp1-3                4.772e-05  3.681e-07 129.622  < 2e-16 ***
curr_pts_grp4-6                8.576e-05  6.190e-07 138.539  < 2e-16 ***
curr_pts_grp7-9                1.266e-04  9.786e-07 129.362  < 2e-16 ***
curr_pts_grp10-150             2.075e-04  1.217e-06 170.465  < 2e-16 ***
age_grp16-19:policyTRUE       -1.426e-06  3.619e-06  -0.394 0.693554    
age_grp20-24:policyTRUE       -5.016e-06  3.517e-06  -1.426 0.153758    
age_grp25-34:policyTRUE       -1.554e-06  3.476e-06  -0.447 0.654866    
age_grp35-44:policyTRUE        1.083e-06  3.473e-06   0.312 0.755196    
age_grp45-54:policyTRUE        2.173e-06  3.470e-06   0.626 0.531245    
age_grp55-64:policyTRUE        2.083e-06  3.477e-06   0.599 0.549022    
age_grp65-199:policyTRUE       2.318e-06  3.482e-06   0.666 0.505558    
policyTRUE:curr_pts_grp1-3     4.491e-06  5.081e-07   8.838  < 2e-16 ***
policyTRUE:curr_pts_grp4-6     8.749e-06  8.370e-07  10.452  < 2e-16 ***
policyTRUE:curr_pts_grp7-9     1.118e-05  1.320e-06   8.466  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -1.267e-05  1.578e-06  -8.030 9.72e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.006482 on 5335033197 degrees of freedom
Multiple R-squared:  3.518e-05,	Adjusted R-squared:  3.517e-05
F-statistic:  8160 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.114e-06  3.259e-06   0.342  0.73239    
age_grp16-19                   3.190e-05  3.332e-06   9.575  < 2e-16 ***
age_grp20-24                   2.551e-05  3.284e-06   7.768 7.97e-15 ***
age_grp25-34                   2.050e-05  3.269e-06   6.272 3.57e-10 ***
age_grp35-44                   1.737e-05  3.267e-06   5.316 1.06e-07 ***
age_grp45-54                   1.344e-05  3.266e-06   4.113 3.90e-05 ***
age_grp55-64                   9.335e-06  3.270e-06   2.855  0.00431 **
age_grp65-199                  4.796e-06  3.275e-06   1.465  0.14304    
policyTRUE                    -1.580e-06  4.521e-06  -0.349  0.72675    
curr_pts_grp1-3                3.411e-05  3.680e-07  92.680  < 2e-16 ***
curr_pts_grp4-6                5.969e-05  7.874e-07  75.808  < 2e-16 ***
curr_pts_grp7-9                8.417e-05  1.524e-06  55.212  < 2e-16 ***
curr_pts_grp10-150             1.569e-04  2.562e-06  61.256  < 2e-16 ***
age_grp16-19:policyTRUE        7.269e-06  4.619e-06   1.574  0.11557    
age_grp20-24:policyTRUE        3.317e-06  4.557e-06   0.728  0.46664    
age_grp25-34:policyTRUE        5.087e-06  4.535e-06   1.122  0.26197    
age_grp35-44:policyTRUE        6.432e-06  4.533e-06   1.419  0.15592    
age_grp45-54:policyTRUE        5.665e-06  4.532e-06   1.250  0.21131    
age_grp55-64:policyTRUE        5.469e-06  4.536e-06   1.206  0.22790    
age_grp65-199:policyTRUE       5.169e-06  4.542e-06   1.138  0.25516    
policyTRUE:curr_pts_grp1-3     8.156e-06  5.015e-07  16.262  < 2e-16 ***
policyTRUE:curr_pts_grp4-6     1.518e-05  1.045e-06  14.519  < 2e-16 ***
policyTRUE:curr_pts_grp7-9     1.929e-05  2.006e-06   9.618  < 2e-16 ***
policyTRUE:curr_pts_grp10-150  1.523e-05  3.208e-06   4.746 2.07e-06 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.004969 on 4340212249 degrees of freedom
Multiple R-squared:  1.664e-05,	Adjusted R-squared:  1.664e-05
F-statistic:  3141 on 23 and 4340212249 DF,  p-value: < 2.2e-16
```

### Two-point violations (speeding 21-30 over or 7 other violations)

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -6.756e-06  5.343e-06  -1.265 0.206036    
age_grp16-19                   1.873e-04  5.627e-06  33.284  < 2e-16 ***
age_grp20-24                   1.764e-04  5.450e-06  32.369  < 2e-16 ***
age_grp25-34                   1.601e-04  5.386e-06  29.727  < 2e-16 ***
age_grp35-44                   1.506e-04  5.379e-06  27.989  < 2e-16 ***
age_grp45-54                   1.394e-04  5.376e-06  25.924  < 2e-16 ***
age_grp55-64                   1.158e-04  5.387e-06  21.489  < 2e-16 ***
age_grp65-199                  6.916e-05  5.396e-06  12.815  < 2e-16 ***
policyTRUE                     1.236e-07  7.659e-06   0.016 0.987123    
curr_pts_grp1-3                2.514e-04  8.173e-07 307.635  < 2e-16 ***
curr_pts_grp4-6                4.597e-04  1.374e-06 334.489  < 2e-16 ***
curr_pts_grp7-9                6.028e-04  2.173e-06 277.441  < 2e-16 ***
curr_pts_grp10-150             7.824e-04  2.703e-06 289.493  < 2e-16 ***
age_grp16-19:policyTRUE        3.607e-06  8.035e-06   0.449 0.653488    
age_grp20-24:policyTRUE       -1.689e-07  7.808e-06  -0.022 0.982741    
age_grp25-34:policyTRUE       -7.592e-06  7.718e-06  -0.984 0.325256    
age_grp35-44:policyTRUE       -3.832e-06  7.710e-06  -0.497 0.619157    
age_grp45-54:policyTRUE       -1.427e-06  7.705e-06  -0.185 0.853087    
age_grp55-64:policyTRUE       -1.228e-06  7.719e-06  -0.159 0.873588    
age_grp65-199:policyTRUE       1.817e-06  7.730e-06   0.235 0.814166    
policyTRUE:curr_pts_grp1-3    -4.138e-06  1.128e-06  -3.668 0.000244 ***
policyTRUE:curr_pts_grp4-6    -3.209e-06  1.858e-06  -1.727 0.084162 .  
policyTRUE:curr_pts_grp7-9     5.409e-06  2.931e-06   1.845 0.064969 .  
policyTRUE:curr_pts_grp10-150 -1.069e-04  3.502e-06 -30.524  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01439 on 5335033197 degrees of freedom
Multiple R-squared:  0.0001432,	Adjusted R-squared:  0.0001432
F-statistic: 3.321e+04 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.221e-06  7.265e-06  -0.168    0.866    
age_grp16-19                   1.166e-04  7.429e-06  15.698  < 2e-16 ***
age_grp20-24                   1.262e-04  7.322e-06  17.235  < 2e-16 ***
age_grp25-34                   1.150e-04  7.288e-06  15.781  < 2e-16 ***
age_grp35-44                   1.075e-04  7.284e-06  14.756  < 2e-16 ***
age_grp45-54                   8.623e-05  7.283e-06  11.840  < 2e-16 ***
age_grp55-64                   6.174e-05  7.290e-06   8.469  < 2e-16 ***
age_grp65-199                  3.448e-05  7.301e-06   4.723 2.32e-06 ***
policyTRUE                    -3.580e-06  1.008e-05  -0.355    0.722    
curr_pts_grp1-3                1.937e-04  8.205e-07 236.040  < 2e-16 ***
curr_pts_grp4-6                3.815e-04  1.756e-06 217.318  < 2e-16 ***
curr_pts_grp7-9                4.966e-04  3.399e-06 146.112  < 2e-16 ***
curr_pts_grp10-150             6.562e-04  5.712e-06 114.874  < 2e-16 ***
age_grp16-19:policyTRUE        1.194e-05  1.030e-05   1.160    0.246    
age_grp20-24:policyTRUE        8.879e-06  1.016e-05   0.874    0.382    
age_grp25-34:policyTRUE        3.914e-06  1.011e-05   0.387    0.699    
age_grp35-44:policyTRUE        7.160e-06  1.011e-05   0.708    0.479    
age_grp45-54:policyTRUE        5.950e-06  1.010e-05   0.589    0.556    
age_grp55-64:policyTRUE        5.211e-06  1.011e-05   0.515    0.606    
age_grp65-199:policyTRUE       6.318e-06  1.013e-05   0.624    0.533    
policyTRUE:curr_pts_grp1-3     6.343e-06  1.118e-06   5.673 1.40e-08 ***
policyTRUE:curr_pts_grp4-6     2.063e-05  2.330e-06   8.854  < 2e-16 ***
policyTRUE:curr_pts_grp7-9     3.745e-05  4.472e-06   8.373  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -2.887e-05  7.153e-06  -4.036 5.44e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01108 on 4340212249 degrees of freedom
Multiple R-squared:  8.349e-05,	Adjusted R-squared:  8.348e-05
F-statistic: 1.576e+04 on 23 and 4340212249 DF,  p-value: < 2.2e-16
```

### Three-point violations (speeding 31-60 over or 9 other violations)

This demerit point level is influenced by the policy change in that the penalty for speeding 40-45 over in a 100km/hr zone is doubled to 6 points, with no other changes to the penalties for the other offences.
For this reason, both 3- and 6-point violations are included in the sample, after the policy change. That is, the 6-point violations are not included in the sample before the window.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    9.125e-05  5.884e-06  15.509  < 2e-16 ***
age_grp16-19                   2.764e-04  6.198e-06  44.600  < 2e-16 ***
age_grp20-24                   2.352e-04  6.002e-06  39.195  < 2e-16 ***
age_grp25-34                   1.255e-04  5.931e-06  21.167  < 2e-16 ***
age_grp35-44                   7.701e-05  5.924e-06  13.001  < 2e-16 ***
age_grp45-54                   4.586e-05  5.921e-06   7.745 9.53e-15 ***
age_grp55-64                   1.610e-05  5.933e-06   2.713 0.006662 **
age_grp65-199                 -1.970e-05  5.943e-06  -3.314 0.000919 ***
policyTRUE                     2.764e-06  8.435e-06   0.328 0.743110    
curr_pts_grp1-3                3.234e-04  9.001e-07 359.355  < 2e-16 ***
curr_pts_grp4-6                6.482e-04  1.513e-06 428.270  < 2e-16 ***
curr_pts_grp7-9                8.994e-04  2.393e-06 375.887  < 2e-16 ***
curr_pts_grp10-150             1.330e-03  2.976e-06 446.857  < 2e-16 ***
age_grp16-19:policyTRUE       -5.189e-05  8.849e-06  -5.864 4.51e-09 ***
age_grp20-24:policyTRUE       -5.395e-05  8.599e-06  -6.275 3.50e-10 ***
age_grp25-34:policyTRUE       -4.736e-05  8.500e-06  -5.572 2.52e-08 ***
age_grp35-44:policyTRUE       -3.262e-05  8.491e-06  -3.841 0.000122 ***
age_grp45-54:policyTRUE       -2.847e-05  8.485e-06  -3.355 0.000793 ***
age_grp55-64:policyTRUE       -2.441e-05  8.501e-06  -2.872 0.004078 **
age_grp65-199:policyTRUE      -1.209e-05  8.513e-06  -1.421 0.155406    
policyTRUE:curr_pts_grp1-3    -5.405e-05  1.242e-06 -43.509  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -9.960e-05  2.047e-06 -48.668  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.083e-04  3.228e-06 -33.554  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -2.816e-04  3.857e-06 -73.012  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01585 on 5335033197 degrees of freedom
Multiple R-squared:  0.0002452,	Adjusted R-squared:  0.0002452
F-statistic: 5.689e+04 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    3.406e-05  6.973e-06   4.884 1.04e-06 ***
age_grp16-19                   9.841e-05  7.130e-06  13.802  < 2e-16 ***
age_grp20-24                   1.050e-04  7.027e-06  14.943  < 2e-16 ***
age_grp25-34                   7.402e-05  6.995e-06  10.583  < 2e-16 ***
age_grp35-44                   6.446e-05  6.992e-06   9.220  < 2e-16 ***
age_grp45-54                   4.087e-05  6.990e-06   5.847 5.00e-09 ***
age_grp55-64                   2.129e-05  6.997e-06   3.043  0.00234 **
age_grp65-199                  3.105e-06  7.007e-06   0.443  0.65770    
policyTRUE                    -1.768e-06  9.674e-06  -0.183  0.85498    
curr_pts_grp1-3                2.016e-04  7.875e-07 256.054  < 2e-16 ***
curr_pts_grp4-6                4.399e-04  1.685e-06 261.079  < 2e-16 ***
curr_pts_grp7-9                6.419e-04  3.262e-06 196.756  < 2e-16 ***
curr_pts_grp10-150             9.426e-04  5.483e-06 171.918  < 2e-16 ***
age_grp16-19:policyTRUE       -4.630e-06  9.885e-06  -0.468  0.63955    
age_grp20-24:policyTRUE       -5.857e-06  9.751e-06  -0.601  0.54807    
age_grp25-34:policyTRUE       -1.387e-05  9.705e-06  -1.430  0.15282    
age_grp35-44:policyTRUE       -9.436e-06  9.701e-06  -0.973  0.33070    
age_grp45-54:policyTRUE       -1.089e-05  9.698e-06  -1.123  0.26157    
age_grp55-64:policyTRUE       -7.901e-06  9.707e-06  -0.814  0.41569    
age_grp65-199:policyTRUE      -1.163e-06  9.720e-06  -0.120  0.90474    
policyTRUE:curr_pts_grp1-3    -2.073e-05  1.073e-06 -19.312  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -3.687e-05  2.237e-06 -16.484  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -3.652e-05  4.293e-06  -8.508  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -1.352e-04  6.866e-06 -19.693  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01063 on 4340212249 degrees of freedom
Multiple R-squared:  0.0001051,	Adjusted R-squared:  0.0001051
F-statistic: 1.984e+04 on 23 and 4340212249 DF,  p-value: < 2.2e-16
```


### Four-point violations (speeding 31-45 over or 9 other violations)

Four demerit points can be awarded for any of 10 individual offences or for a one- or two-point speeding violation, combined with a three- or two-point violation for an offence other than speeding, or, finally, for any two non-speeding offences worth two points each.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.715e-05  8.927e-07  19.212  < 2e-16 ***
age_grp16-19                   5.133e-05  9.402e-07  54.593  < 2e-16 ***
age_grp20-24                   1.027e-06  9.105e-07   1.128 0.259402    
age_grp25-34                  -1.330e-05  8.998e-07 -14.784  < 2e-16 ***
age_grp35-44                  -1.638e-05  8.987e-07 -18.230  < 2e-16 ***
age_grp45-54                  -1.718e-05  8.982e-07 -19.129  < 2e-16 ***
age_grp55-64                  -1.722e-05  9.001e-07 -19.127  < 2e-16 ***
age_grp65-199                 -1.704e-05  9.016e-07 -18.897  < 2e-16 ***
policyTRUE                    -5.052e-06  1.280e-06  -3.948 7.88e-05 ***
curr_pts_grp1-3                3.258e-06  1.365e-07  23.858  < 2e-16 ***
curr_pts_grp4-6                1.235e-05  2.296e-07  53.778  < 2e-16 ***
curr_pts_grp7-9                2.305e-05  3.630e-07  63.511  < 2e-16 ***
curr_pts_grp10-150             5.597e-05  4.515e-07 123.959  < 2e-16 ***
age_grp16-19:policyTRUE       -4.963e-07  1.343e-06  -0.370 0.711618    
age_grp20-24:policyTRUE        4.391e-06  1.304e-06   3.366 0.000762 ***
age_grp25-34:policyTRUE        5.040e-06  1.290e-06   3.908 9.30e-05 ***
age_grp35-44:policyTRUE        5.029e-06  1.288e-06   3.904 9.47e-05 ***
age_grp45-54:policyTRUE        5.024e-06  1.287e-06   3.903 9.51e-05 ***
age_grp55-64:policyTRUE        4.920e-06  1.290e-06   3.815 0.000136 ***
age_grp65-199:policyTRUE       4.927e-06  1.291e-06   3.815 0.000136 ***
policyTRUE:curr_pts_grp1-3    -9.158e-07  1.885e-07  -4.859 1.18e-06 ***
policyTRUE:curr_pts_grp4-6    -2.304e-06  3.105e-07  -7.420 1.17e-13 ***
policyTRUE:curr_pts_grp7-9    -4.380e-06  4.897e-07  -8.945  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -1.667e-05  5.852e-07 -28.494  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.002404 on 5335033197 degrees of freedom
Multiple R-squared:  3.131e-05,	Adjusted R-squared:  3.131e-05
F-statistic:  7263 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    8.175e-07  6.814e-07   1.200  0.23024    
age_grp16-19                   8.032e-06  6.968e-07  11.527  < 2e-16 ***
age_grp20-24                   1.922e-06  6.867e-07   2.799  0.00512 **
age_grp25-34                   2.241e-07  6.835e-07   0.328  0.74297    
age_grp35-44                  -3.329e-07  6.832e-07  -0.487  0.62606    
age_grp45-54                  -6.322e-07  6.831e-07  -0.926  0.35468    
age_grp55-64                  -7.365e-07  6.837e-07  -1.077  0.28138    
age_grp65-199                 -5.993e-07  6.848e-07  -0.875  0.38150    
policyTRUE                     7.334e-07  9.454e-07   0.776  0.43785    
curr_pts_grp1-3                1.237e-06  7.696e-08  16.075  < 2e-16 ***
curr_pts_grp4-6                4.006e-06  1.647e-07  24.327  < 2e-16 ***
curr_pts_grp7-9                5.972e-06  3.188e-07  18.735  < 2e-16 ***
curr_pts_grp10-150             1.993e-05  5.358e-07  37.198  < 2e-16 ***
age_grp16-19:policyTRUE       -2.684e-07  9.660e-07  -0.278  0.78110    
age_grp20-24:policyTRUE       -7.458e-08  9.529e-07  -0.078  0.93762    
age_grp25-34:policyTRUE       -7.501e-07  9.483e-07  -0.791  0.42897    
age_grp35-44:policyTRUE       -6.718e-07  9.480e-07  -0.709  0.47854    
age_grp45-54:policyTRUE       -6.786e-07  9.477e-07  -0.716  0.47395    
age_grp55-64:policyTRUE       -7.320e-07  9.486e-07  -0.772  0.44027    
age_grp65-199:policyTRUE      -8.538e-07  9.499e-07  -0.899  0.36872    
policyTRUE:curr_pts_grp1-3    -4.389e-07  1.049e-07  -4.185 2.85e-05 ***
policyTRUE:curr_pts_grp4-6    -1.051e-06  2.186e-07  -4.811 1.50e-06 ***
policyTRUE:curr_pts_grp7-9    -1.989e-07  4.195e-07  -0.474  0.63543    
policyTRUE:curr_pts_grp10-150 -4.609e-06  6.709e-07  -6.869 6.45e-12 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001039 on 4340212249 degrees of freedom
Multiple R-squared:  3.461e-06,	Adjusted R-squared:  3.456e-06
F-statistic: 653.1 on 23 and 4340212249 DF,  p-value: < 2.2e-16
```
### Five-point violations (speeding 46-60 over or a handheld device violation)

This captures a variety of speeding violations, based on the speed zone, some of which are changed to 10 points.
In both cases, the 5 point ticket can be a combination of some of the above offences.
For this reason, both 5- and 10-point violations are included in the sample after the policy change.


#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.451e-06  1.326e-06  -1.848   0.0646 .  
age_grp16-19                   4.752e-05  1.397e-06  34.015  < 2e-16 ***
age_grp20-24                   3.989e-05  1.353e-06  29.488  < 2e-16 ***
age_grp25-34                   1.938e-05  1.337e-06  14.497  < 2e-16 ***
age_grp35-44                   8.736e-06  1.335e-06   6.542 6.06e-11 ***
age_grp45-54                   5.213e-06  1.335e-06   3.905 9.41e-05 ***
age_grp55-64                   2.808e-06  1.337e-06   2.099   0.0358 *  
age_grp65-199                  1.609e-06  1.340e-06   1.201   0.2298    
policyTRUE                     9.810e-07  1.901e-06   0.516   0.6059    
curr_pts_grp1-3                2.023e-05  2.029e-07  99.690  < 2e-16 ***
curr_pts_grp4-6                4.704e-05  3.412e-07 137.867  < 2e-16 ***
curr_pts_grp7-9                7.446e-05  5.394e-07 138.046  < 2e-16 ***
curr_pts_grp10-150             1.400e-04  6.709e-07 208.739  < 2e-16 ***
age_grp16-19:policyTRUE       -1.364e-05  1.995e-06  -6.840 7.91e-12 ***
age_grp20-24:policyTRUE       -1.596e-05  1.938e-06  -8.232  < 2e-16 ***
age_grp25-34:policyTRUE       -8.913e-06  1.916e-06  -4.652 3.29e-06 ***
age_grp35-44:policyTRUE       -4.188e-06  1.914e-06  -2.188   0.0287 *  
age_grp45-54:policyTRUE       -2.903e-06  1.913e-06  -1.517   0.1291    
age_grp55-64:policyTRUE       -1.516e-06  1.916e-06  -0.791   0.4289    
age_grp65-199:policyTRUE      -8.500e-07  1.919e-06  -0.443   0.6578    
policyTRUE:curr_pts_grp1-3    -1.045e-05  2.801e-07 -37.313  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -2.480e-05  4.613e-07 -53.746  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -3.842e-05  7.276e-07 -52.804  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -6.388e-05  8.695e-07 -73.469  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.003573 on 5335033197 degrees of freedom
Multiple R-squared:  3.41e-05,	Adjusted R-squared:  3.409e-05
F-statistic:  7909 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -2.518e-07  1.116e-06  -0.226  0.82156    
age_grp16-19                   8.156e-06  1.142e-06   7.144 9.06e-13 ***
age_grp20-24                   8.726e-06  1.125e-06   7.756 8.80e-15 ***
age_grp25-34                   4.486e-06  1.120e-06   4.006 6.19e-05 ***
age_grp35-44                   2.641e-06  1.119e-06   2.360  0.01829 *  
age_grp45-54                   1.422e-06  1.119e-06   1.270  0.20401    
age_grp55-64                   7.811e-07  1.120e-06   0.697  0.48566    
age_grp65-199                  2.840e-07  1.122e-06   0.253  0.80014    
policyTRUE                     8.653e-08  1.549e-06   0.056  0.95545    
curr_pts_grp1-3                7.418e-06  1.261e-07  58.835  < 2e-16 ***
curr_pts_grp4-6                1.958e-05  2.698e-07  72.585  < 2e-16 ***
curr_pts_grp7-9                3.744e-05  5.223e-07  71.673  < 2e-16 ***
curr_pts_grp10-150             7.586e-05  8.778e-07  86.419  < 2e-16 ***
age_grp16-19:policyTRUE       -2.607e-06  1.583e-06  -1.647  0.09957 .  
age_grp20-24:policyTRUE       -4.036e-06  1.561e-06  -2.585  0.00973 **
age_grp25-34:policyTRUE       -2.290e-06  1.554e-06  -1.474  0.14048    
age_grp35-44:policyTRUE       -1.550e-06  1.553e-06  -0.998  0.31833    
age_grp45-54:policyTRUE       -9.367e-07  1.553e-06  -0.603  0.54636    
age_grp55-64:policyTRUE       -4.890e-07  1.554e-06  -0.315  0.75305    
age_grp65-199:policyTRUE      -1.550e-07  1.556e-06  -0.100  0.92065    
policyTRUE:curr_pts_grp1-3    -3.715e-06  1.718e-07 -21.622  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -9.226e-06  3.581e-07 -25.762  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.946e-05  6.873e-07 -28.318  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -4.192e-05  1.099e-06 -38.137  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001702 on 4340212249 degrees of freedom
Multiple R-squared:  8.368e-06,	Adjusted R-squared:  8.363e-06
F-statistic:  1579 on 23 and 4340212249 DF,  p-value: < 2.2e-16
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
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -3.538e-07  5.532e-07  -0.640   0.5224    
age_grp16-19                   1.518e-05  5.826e-07  26.059  < 2e-16 ***
age_grp20-24                   9.826e-06  5.642e-07  17.415  < 2e-16 ***
age_grp25-34                   3.561e-06  5.576e-07   6.387 1.69e-10 ***
age_grp35-44                   6.582e-07  5.569e-07   1.182   0.2372    
age_grp45-54                   9.076e-10  5.566e-07   0.002   0.9987    
age_grp55-64                  -2.009e-07  5.578e-07  -0.360   0.7186    
age_grp65-199                 -3.963e-08  5.587e-07  -0.071   0.9435    
policyTRUE                     1.279e-07  7.929e-07   0.161   0.8718    
curr_pts_grp1-3                3.139e-06  8.461e-08  37.094  < 2e-16 ***
curr_pts_grp4-6                8.331e-06  1.423e-07  58.552  < 2e-16 ***
curr_pts_grp7-9                1.397e-05  2.249e-07  62.102  < 2e-16 ***
curr_pts_grp10-150             3.820e-05  2.798e-07 136.527  < 2e-16 ***
age_grp16-19:policyTRUE       -6.171e-06  8.319e-07  -7.418 1.19e-13 ***
age_grp20-24:policyTRUE       -4.107e-06  8.083e-07  -5.081 3.75e-07 ***
age_grp25-34:policyTRUE       -1.959e-06  7.990e-07  -2.451   0.0142 *  
age_grp35-44:policyTRUE       -3.008e-07  7.983e-07  -0.377   0.7064    
age_grp45-54:policyTRUE        1.725e-08  7.977e-07   0.022   0.9827    
age_grp55-64:policyTRUE        1.580e-07  7.991e-07   0.198   0.8432    
age_grp65-199:policyTRUE       1.969e-08  8.003e-07   0.025   0.9804    
policyTRUE:curr_pts_grp1-3    -1.994e-06  1.168e-07 -17.072  < 2e-16 ***
policyTRUE:curr_pts_grp4-6    -5.329e-06  1.924e-07 -27.697  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -7.087e-06  3.034e-07 -23.355  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -1.916e-05  3.626e-07 -52.842  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00149 on 5335033197 degrees of freedom
Multiple R-squared:  1.15e-05,	Adjusted R-squared:  1.149e-05
F-statistic:  2667 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.925e-08  3.076e-07  -0.063  0.95011    
age_grp16-19                   1.766e-06  3.146e-07   5.616 1.96e-08 ***
age_grp20-24                   9.441e-07  3.100e-07   3.045  0.00232 **
age_grp25-34                   3.384e-07  3.086e-07   1.097  0.27283    
age_grp35-44                   1.036e-07  3.084e-07   0.336  0.73688    
age_grp45-54                   3.211e-08  3.084e-07   0.104  0.91707    
age_grp55-64                  -2.461e-08  3.087e-07  -0.080  0.93644    
age_grp65-199                 -3.936e-09  3.091e-07  -0.013  0.98984    
policyTRUE                     1.008e-08  4.268e-07   0.024  0.98116    
curr_pts_grp1-3                5.374e-07  3.474e-08  15.468  < 2e-16 ***
curr_pts_grp4-6                2.280e-06  7.434e-08  30.672  < 2e-16 ***
curr_pts_grp7-9                2.696e-06  1.439e-07  18.730  < 2e-16 ***
curr_pts_grp10-150             1.026e-05  2.419e-07  42.405  < 2e-16 ***
age_grp16-19:policyTRUE       -1.066e-06  4.361e-07  -2.446  0.01446 *  
age_grp20-24:policyTRUE       -3.843e-07  4.302e-07  -0.893  0.37166    
age_grp25-34:policyTRUE       -2.230e-07  4.281e-07  -0.521  0.60252    
age_grp35-44:policyTRUE       -7.966e-08  4.280e-07  -0.186  0.85233    
age_grp45-54:policyTRUE       -2.349e-08  4.278e-07  -0.055  0.95621    
age_grp55-64:policyTRUE        2.287e-08  4.282e-07   0.053  0.95741    
age_grp65-199:policyTRUE      -4.092e-09  4.288e-07  -0.010  0.99239    
policyTRUE:curr_pts_grp1-3    -3.646e-07  4.734e-08  -7.702 1.34e-14 ***
policyTRUE:curr_pts_grp4-6    -1.544e-06  9.867e-08 -15.650  < 2e-16 ***
policyTRUE:curr_pts_grp7-9    -1.191e-06  1.894e-07  -6.287 3.23e-10 ***
policyTRUE:curr_pts_grp10-150 -4.866e-06  3.029e-07 -16.065  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.0004691 on 4340212249 degrees of freedom
Multiple R-squared:  1.456e-06,	Adjusted R-squared:  1.45e-06
F-statistic: 274.7 on 23 and 4340212249 DF,  p-value: < 2.2e-16
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
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    5.309e-06  6.014e-07   8.828  < 2e-16 ***
age_grp16-19                   7.485e-06  6.334e-07  11.816  < 2e-16 ***
age_grp20-24                   1.193e-06  6.134e-07   1.945   0.0517 .  
age_grp25-34                  -2.989e-06  6.062e-07  -4.932 8.16e-07 ***
age_grp35-44                  -4.206e-06  6.054e-07  -6.947 3.72e-12 ***
age_grp45-54                  -4.457e-06  6.051e-07  -7.365 1.77e-13 ***
age_grp55-64                  -4.686e-06  6.064e-07  -7.727 1.10e-14 ***
age_grp65-199                 -4.046e-06  6.074e-07  -6.661 2.72e-11 ***
policyTRUE                    -1.678e-06  8.621e-07  -1.947   0.0516 .  
curr_pts_grp1-3                2.327e-06  9.199e-08  25.294  < 2e-16 ***
curr_pts_grp4-6                5.319e-06  1.547e-07  34.385  < 2e-16 ***
curr_pts_grp7-9                9.505e-06  2.446e-07  38.867  < 2e-16 ***
curr_pts_grp10-150             2.257e-05  3.042e-07  74.197  < 2e-16 ***
age_grp16-19:policyTRUE       -8.627e-07  9.044e-07  -0.954   0.3401    
age_grp20-24:policyTRUE        5.573e-07  8.788e-07   0.634   0.5260    
age_grp25-34:policyTRUE        1.129e-06  8.687e-07   1.299   0.1938    
age_grp35-44:policyTRUE        1.491e-06  8.678e-07   1.718   0.0857 .  
age_grp45-54:policyTRUE        1.439e-06  8.672e-07   1.659   0.0972 .  
age_grp55-64:policyTRUE        1.555e-06  8.688e-07   1.790   0.0735 .  
age_grp65-199:policyTRUE       1.550e-06  8.700e-07   1.781   0.0749 .  
policyTRUE:curr_pts_grp1-3    -5.196e-07  1.270e-07  -4.092 4.27e-05 ***
policyTRUE:curr_pts_grp4-6    -1.483e-06  2.092e-07  -7.090 1.34e-12 ***
policyTRUE:curr_pts_grp7-9    -3.254e-06  3.299e-07  -9.863  < 2e-16 ***
policyTRUE:curr_pts_grp10-150 -7.255e-06  3.942e-07 -18.404  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.00162 on 5335033197 degrees of freedom
Multiple R-squared:  4.774e-06,	Adjusted R-squared:  4.77e-06
F-statistic:  1107 on 23 and 5335033197 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    1.679e-06  7.072e-07   2.374  0.01757 *  
age_grp16-19                   1.674e-06  7.231e-07   2.316  0.02058 *  
age_grp20-24                   1.164e-07  7.127e-07   0.163  0.87026    
age_grp25-34                  -5.844e-07  7.094e-07  -0.824  0.41004    
age_grp35-44                  -8.605e-07  7.090e-07  -1.214  0.22489    
age_grp45-54                  -1.020e-06  7.089e-07  -1.438  0.15036    
age_grp55-64                  -1.034e-06  7.096e-07  -1.457  0.14510    
age_grp65-199                 -4.525e-07  7.106e-07  -0.637  0.52433    
policyTRUE                    -1.282e-07  9.811e-07  -0.131  0.89606    
curr_pts_grp1-3                1.199e-06  7.986e-08  15.008  < 2e-16 ***
curr_pts_grp4-6                3.849e-06  1.709e-07  22.520  < 2e-16 ***
curr_pts_grp7-9                5.642e-06  3.308e-07  17.053  < 2e-16 ***
curr_pts_grp10-150             1.344e-05  5.560e-07  24.170  < 2e-16 ***
age_grp16-19:policyTRUE       -3.710e-07  1.002e-06  -0.370  0.71134    
age_grp20-24:policyTRUE        5.028e-08  9.889e-07   0.051  0.95945    
age_grp25-34:policyTRUE        1.220e-07  9.842e-07   0.124  0.90131    
age_grp35-44:policyTRUE        4.936e-08  9.838e-07   0.050  0.95999    
age_grp45-54:policyTRUE       -3.022e-08  9.835e-07  -0.031  0.97549    
age_grp55-64:policyTRUE       -3.426e-09  9.844e-07  -0.003  0.99722    
age_grp65-199:policyTRUE       1.187e-07  9.858e-07   0.120  0.90412    
policyTRUE:curr_pts_grp1-3    -3.105e-07  1.088e-07  -2.853  0.00433 **
policyTRUE:curr_pts_grp4-6    -1.305e-06  2.268e-07  -5.753 8.77e-09 ***
policyTRUE:curr_pts_grp7-9    -1.318e-06  4.353e-07  -3.028  0.00246 **
policyTRUE:curr_pts_grp10-150 -5.951e-06  6.963e-07  -8.547  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.001078 on 4340212249 degrees of freedom
Multiple R-squared:  8.064e-07,	Adjusted R-squared:  8.011e-07
F-statistic: 152.2 on 23 and 4340212249 DF,  p-value: < 2.2e-16
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





### Two-day Window: All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.
Observations are restricted to the day immediately before the change, March 31, 2008, and the first day of the new policy, April 1, 2008.

It looks as though some drivers were caught by surprise that day:

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -9.708e-05  2.447e-04  -0.397  0.69151    
age_grp16-19                   5.911e-04  2.567e-04   2.303  0.02127 *  
age_grp20-24                   5.835e-04  2.495e-04   2.338  0.01936 *  
age_grp25-34                   5.679e-04  2.466e-04   2.303  0.02128 *  
age_grp35-44                   4.571e-04  2.463e-04   1.856  0.06348 .  
age_grp45-54                   4.131e-04  2.461e-04   1.679  0.09324 .  
age_grp55-64                   3.288e-04  2.466e-04   1.334  0.18236    
age_grp65-199                  2.247e-04  2.469e-04   0.910  0.36278    
policyTRUE                     9.537e-05  3.460e-04   0.276  0.78283    
curr_pts_grp1-3                6.768e-04  3.554e-05  19.043  < 2e-16 ***
curr_pts_grp4-6                1.196e-03  5.671e-05  21.090  < 2e-16 ***
curr_pts_grp7-9                1.716e-03  8.703e-05  19.714  < 2e-16 ***
curr_pts_grp10-150             2.530e-03  1.028e-04  24.613  < 2e-16 ***
age_grp16-19:policyTRUE       -1.501e-04  3.630e-04  -0.414  0.67919    
age_grp20-24:policyTRUE       -1.745e-04  3.529e-04  -0.495  0.62094    
age_grp25-34:policyTRUE       -1.809e-04  3.487e-04  -0.519  0.60401    
age_grp35-44:policyTRUE       -1.213e-04  3.484e-04  -0.348  0.72777    
age_grp45-54:policyTRUE       -8.411e-05  3.481e-04  -0.242  0.80907    
age_grp55-64:policyTRUE       -6.421e-05  3.487e-04  -0.184  0.85392    
age_grp65-199:policyTRUE      -4.774e-05  3.492e-04  -0.137  0.89126    
policyTRUE:curr_pts_grp1-3     4.610e-05  5.026e-05   0.917  0.35905    
policyTRUE:curr_pts_grp4-6     5.845e-05  8.019e-05   0.729  0.46603    
policyTRUE:curr_pts_grp7-9     3.346e-04  1.230e-04   2.720  0.00653 **
policyTRUE:curr_pts_grp10-150  4.115e-04  1.453e-04   2.832  0.00463 **
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02406 on 7210895 degrees of freedom
Multiple R-squared:  0.000544,	Adjusted R-squared:  0.0005408
F-statistic: 170.7 on 23 and 7210895 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.938e-05  2.969e-04  -0.065 0.947938    
age_grp16-19                   1.153e-04  3.034e-04   0.380 0.704065    
age_grp20-24                   2.639e-04  2.993e-04   0.882 0.377926    
age_grp25-34                   2.718e-04  2.978e-04   0.913 0.361376    
age_grp35-44                   2.636e-04  2.977e-04   0.886 0.375849    
age_grp45-54                   2.101e-04  2.976e-04   0.706 0.480135    
age_grp55-64                   1.469e-04  2.979e-04   0.493 0.621987    
age_grp65-199                  1.038e-04  2.983e-04   0.348 0.727762    
policyTRUE                    -1.474e-06  4.198e-04  -0.004 0.997200    
curr_pts_grp1-3                5.090e-04  3.236e-05  15.727  < 2e-16 ***
curr_pts_grp4-6                1.060e-03  6.515e-05  16.276  < 2e-16 ***
curr_pts_grp7-9                2.003e-03  1.229e-04  16.297  < 2e-16 ***
curr_pts_grp10-150             2.038e-03  1.934e-04  10.537  < 2e-16 ***
age_grp16-19:policyTRUE       -1.116e-06  4.291e-04  -0.003 0.997924    
age_grp20-24:policyTRUE        6.694e-05  4.233e-04   0.158 0.874349    
age_grp25-34:policyTRUE        3.310e-05  4.212e-04   0.079 0.937355    
age_grp35-44:policyTRUE       -1.887e-05  4.210e-04  -0.045 0.964256    
age_grp45-54:policyTRUE       -3.865e-05  4.209e-04  -0.092 0.926825    
age_grp55-64:policyTRUE        2.966e-05  4.213e-04   0.070 0.943868    
age_grp65-199:policyTRUE       6.028e-05  4.219e-04   0.143 0.886381    
policyTRUE:curr_pts_grp1-3     7.118e-05  4.577e-05   1.555 0.119860    
policyTRUE:curr_pts_grp4-6    -9.125e-05  9.210e-05  -0.991 0.321832    
policyTRUE:curr_pts_grp7-9    -6.657e-04  1.738e-04  -3.831 0.000128 ***
policyTRUE:curr_pts_grp10-150 -1.926e-05  2.734e-04  -0.070 0.943844    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01722 on 5894541 degrees of freedom
Multiple R-squared:  0.0002889,	Adjusted R-squared:  0.000285
F-statistic: 74.07 on 23 and 5894541 DF,  p-value: < 2.2e-16
```

These are a little messy so I also include the two-week window.

### Two-week Window: All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.
Observations are restricted to the week immediately before the change, from March 25, 2008, and the first week that the new policy was in effect, up to April 7, 2008.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.036e-04  9.899e-05  -1.047  0.29503    
age_grp16-19                   5.981e-04  1.039e-04   5.759 8.48e-09 ***
age_grp20-24                   7.251e-04  1.010e-04   7.181 6.91e-13 ***
age_grp25-34                   6.226e-04  9.977e-05   6.241 4.35e-10 ***
age_grp35-44                   5.416e-04  9.966e-05   5.435 5.49e-08 ***
age_grp45-54                   4.586e-04  9.959e-05   4.605 4.12e-06 ***
age_grp55-64                   4.152e-04  9.977e-05   4.162 3.16e-05 ***
age_grp65-199                  2.945e-04  9.991e-05   2.947  0.00320 **
policyTRUE                     2.645e-05  1.400e-04   0.189  0.85017    
curr_pts_grp1-3                7.992e-04  1.439e-05  55.549  < 2e-16 ***
curr_pts_grp4-6                1.519e-03  2.297e-05  66.149  < 2e-16 ***
curr_pts_grp7-9                2.276e-03  3.525e-05  64.575  < 2e-16 ***
curr_pts_grp10-150             3.102e-03  4.166e-05  74.458  < 2e-16 ***
age_grp16-19:policyTRUE       -1.661e-05  1.469e-04  -0.113  0.90996    
age_grp20-24:policyTRUE       -9.093e-05  1.428e-04  -0.637  0.52436    
age_grp25-34:policyTRUE       -6.852e-05  1.411e-04  -0.486  0.62728    
age_grp35-44:policyTRUE       -8.898e-05  1.410e-04  -0.631  0.52793    
age_grp45-54:policyTRUE       -3.836e-05  1.409e-04  -0.272  0.78540    
age_grp55-64:policyTRUE       -6.649e-05  1.411e-04  -0.471  0.63756    
age_grp65-199:policyTRUE      -3.944e-05  1.413e-04  -0.279  0.78022    
policyTRUE:curr_pts_grp1-3    -8.558e-05  2.034e-05  -4.208 2.58e-05 ***
policyTRUE:curr_pts_grp4-6    -8.746e-05  3.245e-05  -2.695  0.00703 **
policyTRUE:curr_pts_grp7-9    -2.813e-04  4.978e-05  -5.651 1.59e-08 ***
policyTRUE:curr_pts_grp10-150 -1.647e-04  5.878e-05  -2.802  0.00509 **
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02576 on 50480141 degrees of freedom
Multiple R-squared:  0.0006131,	Adjusted R-squared:  0.0006126
F-statistic:  1346 on 23 and 50480141 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    6.430e-05  1.196e-04   0.538  0.59080    
age_grp16-19                   2.002e-04  1.222e-04   1.638  0.10146    
age_grp20-24                   2.843e-04  1.206e-04   2.357  0.01840 *  
age_grp25-34                   2.419e-04  1.200e-04   2.016  0.04380 *  
age_grp35-44                   2.061e-04  1.199e-04   1.718  0.08574 .  
age_grp45-54                   1.691e-04  1.199e-04   1.410  0.15851    
age_grp55-64                   9.576e-05  1.200e-04   0.798  0.42491    
age_grp65-199                  3.229e-05  1.202e-04   0.269  0.78816    
policyTRUE                    -4.210e-05  1.691e-04  -0.249  0.80342    
curr_pts_grp1-3                5.522e-04  1.304e-05  42.334  < 2e-16 ***
curr_pts_grp4-6                1.131e-03  2.627e-05  43.075  < 2e-16 ***
curr_pts_grp7-9                1.917e-03  4.953e-05  38.702  < 2e-16 ***
curr_pts_grp10-150             2.569e-03  7.809e-05  32.893  < 2e-16 ***
age_grp16-19:policyTRUE       -3.099e-05  1.729e-04  -0.179  0.85770    
age_grp20-24:policyTRUE        3.265e-05  1.705e-04   0.191  0.84816    
age_grp25-34:policyTRUE        4.952e-05  1.697e-04   0.292  0.77037    
age_grp35-44:policyTRUE        3.856e-05  1.696e-04   0.227  0.82014    
age_grp45-54:policyTRUE        1.924e-05  1.695e-04   0.113  0.90964    
age_grp55-64:policyTRUE        3.817e-05  1.697e-04   0.225  0.82202    
age_grp65-199:policyTRUE       4.316e-05  1.699e-04   0.254  0.79953    
policyTRUE:curr_pts_grp1-3    -2.396e-07  1.844e-05  -0.013  0.98963    
policyTRUE:curr_pts_grp4-6    -3.864e-05  3.709e-05  -1.042  0.29756    
policyTRUE:curr_pts_grp7-9    -3.033e-04  6.998e-05  -4.334 1.47e-05 ***
policyTRUE:curr_pts_grp10-150 -3.554e-04  1.100e-04  -3.230  0.00124 **
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01835 on 41262169 degrees of freedom
Multiple R-squared:  0.0002963,	Adjusted R-squared:  0.0002958
F-statistic: 531.8 on 23 and 41262169 DF,  p-value: < 2.2e-16
```

## 28-day window: All violations combined

This includes all infractions, regardless of the relation to speeding or the policy change.
Observations are restricted to the two weeks immediately before the change, from March 18, 2008, and the first two weeks that the new policy was in effect, up to April 14, 2008.

#### Male drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                   -1.033e-04  6.906e-05  -1.496 0.134699    
age_grp16-19                   6.138e-04  7.246e-05   8.472  < 2e-16 ***
age_grp20-24                   7.103e-04  7.044e-05  10.083  < 2e-16 ***
age_grp25-34                   6.026e-04  6.960e-05   8.658  < 2e-16 ***
age_grp35-44                   5.412e-04  6.953e-05   7.784 7.03e-15 ***
age_grp45-54                   4.594e-04  6.948e-05   6.612 3.79e-11 ***
age_grp55-64                   3.908e-04  6.961e-05   5.615 1.97e-08 ***
age_grp65-199                  2.765e-04  6.970e-05   3.967 7.29e-05 ***
policyTRUE                     5.043e-05  9.771e-05   0.516 0.605808    
curr_pts_grp1-3                7.474e-04  1.004e-05  74.418  < 2e-16 ***
curr_pts_grp4-6                1.427e-03  1.604e-05  88.942  < 2e-16 ***
curr_pts_grp7-9                2.041e-03  2.463e-05  82.864  < 2e-16 ***
curr_pts_grp10-150             2.952e-03  2.913e-05 101.334  < 2e-16 ***
age_grp16-19:policyTRUE       -6.547e-05  1.025e-04  -0.639 0.523032    
age_grp20-24:policyTRUE       -1.110e-04  9.966e-05  -1.114 0.265485    
age_grp25-34:policyTRUE       -9.235e-05  9.848e-05  -0.938 0.348367    
age_grp35-44:policyTRUE       -1.035e-04  9.838e-05  -1.052 0.292655    
age_grp45-54:policyTRUE       -5.740e-05  9.830e-05  -0.584 0.559306    
age_grp55-64:policyTRUE       -5.774e-05  9.848e-05  -0.586 0.557702    
age_grp65-199:policyTRUE      -2.567e-05  9.862e-05  -0.260 0.794619    
policyTRUE:curr_pts_grp1-3    -4.058e-05  1.419e-05  -2.859 0.004253 **
policyTRUE:curr_pts_grp4-6    -4.689e-05  2.265e-05  -2.070 0.038432 *  
policyTRUE:curr_pts_grp7-9    -9.395e-05  3.474e-05  -2.704 0.006852 **
policyTRUE:curr_pts_grp10-150 -1.490e-04  4.101e-05  -3.634 0.000279 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.02543 on 100961499 degrees of freedom
Multiple R-squared:  0.0005668,	Adjusted R-squared:  0.0005666
F-statistic:  2490 on 23 and 100961499 DF,  p-value: < 2.2e-16
```

#### Female drivers:
```R
Coefficients:
                                Estimate Std. Error t value Pr(>|t|)    
(Intercept)                    4.518e-05  8.278e-05   0.546 0.585249    
age_grp16-19                   1.954e-04  8.462e-05   2.310 0.020899 *  
age_grp20-24                   2.762e-04  8.346e-05   3.309 0.000936 ***
age_grp25-34                   2.356e-04  8.305e-05   2.837 0.004558 **
age_grp35-44                   2.066e-04  8.301e-05   2.489 0.012814 *  
age_grp45-54                   1.648e-04  8.299e-05   1.985 0.047100 *  
age_grp55-64                   1.031e-04  8.307e-05   1.241 0.214633    
age_grp65-199                  3.612e-05  8.318e-05   0.434 0.664150    
policyTRUE                    -4.385e-05  1.171e-04  -0.375 0.707925    
curr_pts_grp1-3                4.985e-04  9.033e-06  55.184  < 2e-16 ***
curr_pts_grp4-6                1.079e-03  1.820e-05  59.314  < 2e-16 ***
curr_pts_grp7-9                1.673e-03  3.432e-05  48.739  < 2e-16 ***
curr_pts_grp10-150             2.492e-03  5.414e-05  46.037  < 2e-16 ***
age_grp16-19:policyTRUE        1.706e-05  1.196e-04   0.143 0.886635    
age_grp20-24:policyTRUE        6.964e-05  1.180e-04   0.590 0.555096    
age_grp25-34:policyTRUE        6.881e-05  1.174e-04   0.586 0.557899    
age_grp35-44:policyTRUE        5.686e-05  1.174e-04   0.484 0.628103    
age_grp45-54:policyTRUE        4.795e-05  1.173e-04   0.409 0.682820    
age_grp55-64:policyTRUE        5.369e-05  1.175e-04   0.457 0.647582    
age_grp65-199:policyTRUE       6.855e-05  1.176e-04   0.583 0.560034    
policyTRUE:curr_pts_grp1-3     4.121e-05  1.276e-05   3.229 0.001241 **
policyTRUE:curr_pts_grp4-6     3.448e-05  2.567e-05   1.343 0.179233    
policyTRUE:curr_pts_grp7-9    -5.675e-05  4.843e-05  -1.172 0.241346    
policyTRUE:curr_pts_grp10-150 -1.765e-04  7.606e-05  -2.321 0.020289 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.01796 on 82522700 degrees of freedom
Multiple R-squared:  0.0002866,	Adjusted R-squared:  0.0002863
F-statistic:  1029 on 23 and 82522700 DF,  p-value: < 2.2e-16
```



### Two-week Window: All violations combined, restricted to ```curr_pts_grp == '1-3'```


#### Male drivers:
```R
Coefficients:
                           Estimate Std. Error t value Pr(>|t|)    
(Intercept)               1.690e-16  4.323e-04   0.000 1.000000    
age_grp16-19              9.995e-04  4.406e-04   2.268 0.023304 *  
age_grp20-24              1.513e-03  4.363e-04   3.467 0.000526 ***
age_grp25-34              1.480e-03  4.340e-04   3.411 0.000648 ***
age_grp35-44              1.245e-03  4.338e-04   2.870 0.004107 **
age_grp45-54              1.159e-03  4.338e-04   2.671 0.007554 **
age_grp55-64              1.022e-03  4.345e-04   2.352 0.018671 *  
age_grp65-199             8.104e-04  4.360e-04   1.859 0.063048 .  
policyTRUE               -4.616e-17  6.120e-04   0.000 1.000000    
age_grp16-19:policyTRUE  -1.153e-04  6.238e-04  -0.185 0.853374    
age_grp20-24:policyTRUE  -1.901e-04  6.176e-04  -0.308 0.758196    
age_grp25-34:policyTRUE  -1.931e-04  6.144e-04  -0.314 0.753249    
age_grp35-44:policyTRUE  -1.041e-04  6.142e-04  -0.170 0.865361    
age_grp45-54:policyTRUE  -1.139e-04  6.141e-04  -0.186 0.852814    
age_grp55-64:policyTRUE  -5.317e-05  6.152e-04  -0.086 0.931122    
age_grp65-199:policyTRUE -8.498e-05  6.172e-04  -0.138 0.890493    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.03388 on 7822109 degrees of freedom
Multiple R-squared:  3.715e-05,	Adjusted R-squared:  3.523e-05
F-statistic: 19.37 on 15 and 7822109 DF,  p-value: < 2.2e-16
```

A small but insignificant decrease for all age groups.

#### Female drivers:
```R
Coefficients:
                           Estimate Std. Error t value Pr(>|t|)
(Intercept)               2.076e-15  1.050e-03   0.000    1.000
age_grp16-19              5.935e-04  1.055e-03   0.563    0.574
age_grp20-24              1.001e-03  1.052e-03   0.951    0.342
age_grp25-34              8.897e-04  1.051e-03   0.847    0.397
age_grp35-44              7.950e-04  1.051e-03   0.756    0.449
age_grp45-54              8.296e-04  1.051e-03   0.789    0.430
age_grp55-64              6.692e-04  1.052e-03   0.636    0.525
age_grp65-199             5.479e-04  1.053e-03   0.520    0.603
policyTRUE               -2.652e-15  1.480e-03   0.000    1.000
age_grp16-19:policyTRUE  -2.150e-04  1.486e-03  -0.145    0.885
age_grp20-24:policyTRUE   3.220e-06  1.482e-03   0.002    0.998
age_grp25-34:policyTRUE   7.503e-05  1.481e-03   0.051    0.960
age_grp35-44:policyTRUE   2.905e-05  1.481e-03   0.020    0.984
age_grp45-54:policyTRUE  -8.238e-05  1.481e-03  -0.056    0.956
age_grp55-64:policyTRUE  -7.336e-05  1.482e-03  -0.050    0.961
age_grp65-199:policyTRUE  4.390e-05  1.484e-03   0.030    0.976

Residual standard error: 0.0283 on 4510010 degrees of freedom
Multiple R-squared:  2.375e-05,	Adjusted R-squared:  2.042e-05
F-statistic:  7.14 on 15 and 4510010 DF,  p-value: 5.804e-16
```

The results were similar for ```curr_pts_grp == '4-6'``` except that fewer statistics were significant given the smaller sample sizes.
In an attempt to enlarge the sample sizes, I also ran these with the one-month window
(two weeks on each side, from March 18, 2008 to April 14, 2008)
but the results were qualitatively similar.
