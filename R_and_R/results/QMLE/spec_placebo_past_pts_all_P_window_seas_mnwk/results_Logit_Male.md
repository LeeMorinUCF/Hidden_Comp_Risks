# Logistic Regression Models - Male Drivers

## Logistic Regression Results 

## Placebo Regressions 

## Regressions for Full Sample 



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -9.13893         0.0272809         -334.994                0   
policyTRUE                    -0.00242793         0.00169008         -1.43658         0.150838   
age_grp16-19                     1.2702         0.0272842          46.5543                0   
age_grp20-24                    1.12945         0.0271331          41.6262                0   
age_grp25-34                   0.948756         0.0270819          35.0329         7.10863e-269   
age_grp35-44                    0.82877         0.0270829          30.6012         1.17821e-205   
age_grp45-54                   0.725913         0.0270884          26.7979         3.41784e-158   
age_grp55-64                   0.567382         0.0271341          20.9103         4.31377e-97   
age_grp65-199                  0.196745         0.027244          7.22157         5.13889e-13   
curr_pts_grp1-3                 1.07647         0.00208145          517.172                0   
curr_pts_grp4-6                 1.52179         0.00264879          574.521                0   
curr_pts_grp7-9                 1.75436         0.00351133          499.627                0   
curr_pts_grp10-150              2.04024         0.00372205           548.15                0   
month02                        0.127355         0.00408814          31.1522         4.73616e-213   
month03                        0.123705         0.00401558          30.8062         2.16228e-208   
month04                        0.0103016         0.00423068          2.43498         0.0148927   
month05                        0.0465393         0.00412563          11.2805         1.63756e-29   
month06                        0.0633516         0.00415318          15.2537         1.55457e-52   
month07                        0.0767474         0.00410959          18.6752         7.87749e-78   
month08                       -0.018013         0.00417932         -4.31002         1.63241e-05   
month09                        0.208923         0.00400486          52.1674                0   
month10                        0.160142         0.00399519          40.0837                0   
month11                        0.156783         0.00402021          38.9988                0   
month12                       -0.546276         0.00486682         -112.245                0   
weekdayMonday                  0.322707         0.00340284          94.8344                0   
weekdayTuesday                 0.401044         0.00335617          119.495                0   
weekdayWednesday               0.457171         0.00331924          137.734                0   
weekdayThursday                0.430701         0.00333505          129.144                0   
weekdayFriday                  0.343848         0.00339343          101.328                0   
weekdaySaturday                0.0766258         0.00359725          21.3012         1.10604e-100  
```



```
AME          MER
-0.130566589238914          -0.547840
80.9236946388813          187.262160
67.9824738088008          153.130083
42.906589890984          115.771191
32.0147758999285          94.429767
24.5873122841237          78.060390
16.405452282847          55.899682
4.16823837660749          15.922758

```



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -9.11149         0.0381393           -238.9                0   
policyTRUE                    -0.0572004         0.0540489         -1.05831         0.289915   
age_grp16-19                    1.27715         0.0383407          33.3105         2.72286e-243   
age_grp20-24                    1.11956         0.0381181          29.3707         1.30173e-189   
age_grp25-34                   0.925981         0.0380523          24.3345         8.4697e-131   
age_grp35-44                   0.803993         0.0380545          21.1274         4.45146e-99   
age_grp45-54                   0.690677         0.0380663          18.1441         1.43057e-73   
age_grp55-64                   0.522587         0.0381371          13.7029         9.75953e-43   
age_grp65-199                  0.128422         0.0383115          3.35206         0.000802133   
curr_pts_grp1-3                 1.07625         0.00208132            517.1                0   
curr_pts_grp4-6                 1.52169         0.00264846          574.558                0   
curr_pts_grp7-9                 1.75455         0.00351095          499.736                0   
curr_pts_grp10-150              2.04115         0.00372173          548.441                0   
month02                        0.127351         0.00408814          31.1514         4.85765e-213   
month03                        0.123693         0.00401558          30.8032         2.37124e-208   
month04                        0.0102459         0.0042307          2.42179         0.0154443   
month05                        0.0465018         0.00412565          11.2714         1.81731e-29   
month06                        0.063331         0.00415319          15.2488         1.67775e-52   
month07                        0.0767373         0.00410959          18.6727         8.25126e-78   
month08                       -0.0180152         0.00417933         -4.31055         1.62851e-05   
month09                        0.208929         0.00400486          52.1688                0   
month10                        0.160156         0.00399519          40.0871                0   
month11                        0.156798         0.00402021          39.0024                0   
month12                       -0.546271         0.00486682         -112.244                0   
weekdayMonday                  0.322706         0.00340284          94.8343                0   
weekdayTuesday                 0.401044         0.00335617          119.495                0   
weekdayWednesday               0.457172         0.00331924          137.734                0   
weekdayThursday                0.430701         0.00333505          129.144                0   
weekdayFriday                  0.343849         0.00339343          101.328                0   
weekdaySaturday                0.0766261         0.00359725          21.3013         1.10375e-100   
policyTRUE:age_grp16-19       -0.0105874         0.0545407        -0.194119         0.846083   
policyTRUE:age_grp20-24        0.020382         0.0542484         0.375717         0.707127   
policyTRUE:age_grp25-34        0.0457285         0.0541636         0.844266         0.398521   
policyTRUE:age_grp35-44        0.0495962         0.0541702         0.915562         0.359897   
policyTRUE:age_grp45-54        0.0697788         0.054184          1.28781         0.197812   
policyTRUE:age_grp55-64        0.0878608         0.0542768          1.61876           0.1055   
policyTRUE:age_grp65-199       0.131609         0.0544968          2.41499         0.0157355  
```



```
AME          MER
-1.08119161314712          -4.184778
-1.14463612345711          -2.647283
2.02661973836141          4.562762
3.25144108037464          8.768417
2.87326376618051          8.470595
3.45766389930777          10.971991
3.52482333114556          12.005151
3.39418581417875          12.962262
83.9768225406855          194.296975
68.8597597608379          155.076115
42.4794527295462          114.604429
31.4750599770642          92.829390
23.5751477318701          74.841662
15.1552980318025          51.636907
2.69994203534037          10.313287

```

