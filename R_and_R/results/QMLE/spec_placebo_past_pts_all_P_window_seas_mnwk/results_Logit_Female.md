# Logistic Regression Models - Female Drivers

## Logistic Regression Results 

## Placebo Regressions 

## Regressions for Full Sample 



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.6442         0.0929933         -114.462                0   
policyTRUE                    -0.00585193         0.00268681         -2.17802         0.0294045   
age_grp16-19                    1.76872         0.0930303          19.0123         1.348e-80   
age_grp20-24                    1.75944         0.0928473          18.9498         4.43051e-80   
age_grp25-34                    1.62392         0.0928002          17.4991         1.45443e-68   
age_grp35-44                    1.55439         0.0927968          16.7504         5.6207e-63   
age_grp45-54                    1.36736         0.092803           14.734         3.9015e-49   
age_grp55-64                    1.10794         0.0928469           11.933         7.96886e-33   
age_grp65-199                  0.685505         0.0929712           7.3733         1.6645e-13   
curr_pts_grp1-3                 1.14592         0.00326234          351.257                0   
curr_pts_grp4-6                 1.66601         0.00500243           333.04                0   
curr_pts_grp7-9                  1.9346         0.00812588          238.079                0   
curr_pts_grp10-150              2.24527         0.0113998          196.957                0   
month02                        0.149439         0.00669444          22.3229         2.21646e-110   
month03                         0.17268         0.00654444          26.3858         1.99553e-153   
month04                        0.137629         0.00675493          20.3746         2.80959e-92   
month05                        0.185992         0.00654923           28.399         2.07968e-177   
month06                         0.15607         0.0066814          23.3589         1.11974e-120   
month07                        0.102179         0.00672547          15.1929         3.94197e-52   
month08                        0.0266128         0.00678568           3.9219         8.78541e-05   
month09                        0.313755         0.00644555          48.6778                0   
month10                        0.259039         0.00642104          40.3423                0   
month11                        0.268272         0.00644238          41.6417                0   
month12                       -0.544727         0.00803894         -67.7611                0   
weekdayMonday                  0.622194         0.00580948            107.1                0   
weekdayTuesday                 0.750779         0.0056967          131.792                0   
weekdayWednesday               0.803243         0.00564926          142.185                0   
weekdayThursday                0.758139         0.00568698          133.311                0   
weekdayFriday                  0.574996         0.00586582          98.0248                0   
weekdaySaturday                0.113467         0.00644722          17.5994         2.48823e-69  
```



```
AME          MER
-0.154338196247359          -0.879545
32.8473577664048          126.352716
34.3649802284322          124.946730
27.4696379140017          105.839162
24.6270849063333          96.992483
17.898161903167          76.030206
11.6150561299826          52.730133
5.24635476201367          25.610704

```



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.7402         0.141337         -75.9904                0   
policyTRUE                     0.169625         0.187263         0.905812         0.365036   
age_grp16-19                    1.87453         0.141566          13.2414         5.05948e-40   
age_grp20-24                    1.85188         0.141311           13.105         3.08324e-39   
age_grp25-34                    1.72475         0.141248          12.2108         2.72227e-34   
age_grp35-44                    1.66132         0.141243          11.7622         6.11527e-32   
age_grp45-54                    1.45952         0.141254          10.3326         5.01784e-25   
age_grp55-64                    1.19041         0.141316          8.42373         3.64679e-17   
age_grp65-199                   0.74295         0.141498          5.25061         1.51598e-07   
curr_pts_grp1-3                 1.14594         0.00326216          351.283                0   
curr_pts_grp4-6                 1.66624         0.00500243          333.087                0   
curr_pts_grp7-9                 1.93498         0.00812605           238.12                0   
curr_pts_grp10-150              2.24579         0.0114003          196.994                0   
month02                        0.149436         0.00669443          22.3224         2.23719e-110   
month03                        0.172675         0.00654444           26.385         2.03875e-153   
month04                         0.13762         0.00675496          20.3731         2.8979e-92   
month05                        0.185986         0.00654926           28.398         2.14093e-177   
month06                        0.156066         0.00668142          23.3582         1.13731e-120   
month07                        0.102178         0.00672547          15.1927         3.95555e-52   
month08                        0.0266118         0.00678568          3.92176         8.79034e-05   
month09                        0.313755         0.00644555          48.6778                0   
month10                        0.259043         0.00642104          40.3428                0   
month11                        0.268277         0.00644238          41.6425                0   
month12                       -0.544725         0.00803894         -67.7609                0   
weekdayMonday                  0.622194         0.00580948            107.1                0   
weekdayTuesday                  0.75078         0.0056967          131.792                0   
weekdayWednesday               0.803243         0.00564926          142.186                0   
weekdayThursday                0.758139         0.00568698          133.311                0   
weekdayFriday                  0.574996         0.00586582           98.025                0   
weekdaySaturday                0.113467         0.00644722          17.5994         2.48801e-69   
policyTRUE:age_grp16-19       -0.193978         0.187793         -1.03293         0.301635   
policyTRUE:age_grp20-24       -0.168631         0.187433        -0.899688         0.368287   
policyTRUE:age_grp25-34       -0.184831         0.187344         -0.98659         0.323844   
policyTRUE:age_grp35-44       -0.197029         0.187338         -1.05173         0.292925   
policyTRUE:age_grp45-54       -0.168071         0.187355        -0.897075         0.369679   
policyTRUE:age_grp55-64       -0.149554         0.187444        -0.797858         0.424953   
policyTRUE:age_grp65-199      -0.102791         0.187693        -0.547656         0.583928  
```



```
AME          MER
0.841541740076807          4.369504
-6.87885727593188          -26.451865
-6.42188676954983          -23.341698
-5.71205154027792          -22.002740
-5.49120073315546          -21.622330
-3.70626210799588          -15.741381
-2.42436222348685          -11.005370
-1.0624221873926          -5.186624
33.8561162415358          130.258277
34.8727302186378          126.816064
28.2528669928435          108.877816
25.5744502209907          100.743183
18.3664212013442          78.036354
11.9061722476837          54.064409
5.33400321011901          26.045119

```

