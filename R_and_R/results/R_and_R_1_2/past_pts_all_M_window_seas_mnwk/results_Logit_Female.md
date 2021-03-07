# Logistic Regression Models - Female Drivers

## Logistic Regression Results 

## Regressions with Monthly Policy Dummies 



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.6978         0.0653677         -163.656                0   
policyTRUE                     0.0310293         0.00222034           13.975         2.21497e-44   
policy_monthpolicy01           0.106254         0.00703428          15.1052         1.49726e-51   
policy_monthpolicy02           0.0632156         0.00693251          9.11871         7.60222e-20   
policy_monthpolicy03          -0.0156975         0.00738841         -2.12462         0.0336186   
policy_monthpolicy04          -0.152662         0.00775873         -19.6761         3.45509e-86   
policy_monthpolicy05          -0.165357         0.0082587         -20.0222         3.53027e-89   
policy_monthpolicy06          -0.165356         0.00714546         -23.1415         1.77137e-118   
policy_monthpolicy07          -0.139045         0.00707185         -19.6618         4.58609e-86   
policy_monthpolicy08           -0.18416         0.00743821         -24.7587         2.49965e-135   
policy_monthpolicy09          -0.358364         0.0116883           -30.66         1.9455e-206   
policy_monthpolicy10          -0.526841         0.00945001         -55.7504                0   
policy_monthpolicy11          -0.197813         0.00801029         -24.6949         1.21292e-134   
policy_monthpolicy12          -0.077163         0.0071688         -10.7637         5.1056e-27   
age_grp16-19                    1.79775         0.0653528          27.5084         1.39456e-166   
age_grp20-24                     1.7775         0.0652419          27.2447         1.92065e-163   
age_grp25-34                    1.63126         0.0652101          25.0154         4.15378e-138   
age_grp35-44                    1.57767         0.0652081          24.1944         2.54781e-129   
age_grp45-54                    1.38791         0.0652118          21.2831         1.62735e-100   
age_grp55-64                    1.13597         0.0652402           17.412         6.68621e-68   
age_grp65-199                  0.755007         0.0653146          11.5595         6.60544e-31   
curr_pts_grp1-3                 1.15417         0.0022351          516.385                0   
curr_pts_grp4-6                  1.6792         0.00331857              506                0   
curr_pts_grp7-9                  1.9541         0.00529947          368.735                0   
curr_pts_grp10-150              2.20049         0.00710797          309.581                0   
month02                        0.171721         0.00536232          32.0237         5.10786e-225   
month03                         0.21149         0.00520133          40.6608                0   
month04                        0.162895         0.00536633          30.3549         2.16181e-202   
month05                        0.200506         0.00526094          38.1123                0   
month06                        0.158837         0.00535101          29.6836         1.25176e-193   
month07                        0.0982063         0.00538814          18.2264         3.18826e-74   
month08                        0.0132494         0.00548734          2.41454         0.0157553   
month09                        0.317336         0.00515482          61.5611                0   
month10                        0.276424         0.00514791          53.6965                0   
month11                        0.269676         0.00518681          51.9926                0   
month12                       -0.587911         0.00650444          -90.386                0   
weekdayMonday                  0.635478         0.00406437          156.354                0   
weekdayTuesday                 0.777621         0.003971          195.825                0   
weekdayWednesday               0.825365         0.00394189          209.383                0   
weekdayThursday                0.764805         0.00398201          192.065                0   
weekdayFriday                   0.60641         0.0040885          148.321                0   
weekdaySaturday                0.134471         0.00450044          29.8796         3.62308e-196  
```



```
policy_month          pred_prob
policyTRUE          0.837378
policy01          2.442150
policy02          1.778422
policy03          -0.464979
policy04          -4.365074
policy05          -4.896179
policy06          -4.635424
policy07          -3.629269
policy08          -4.385491
policy09          -11.588971
policy10          -16.578278
policy11          -6.098475
policy12          -0.995761

```



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.6745         0.0929468         -114.845                0   
policyTRUE                    -0.0146122         0.130351        -0.112099         0.910745   
policy_monthpolicy01           0.106436         0.00703436          15.1308         1.01439e-51   
policy_monthpolicy02           0.0633925         0.00693258          9.14414         6.01039e-20   
policy_monthpolicy03          -0.0155306         0.00738847           -2.102         0.0355531   
policy_monthpolicy04          -0.152502         0.00775878         -19.6554         5.194e-86   
policy_monthpolicy05          -0.165205         0.00825873         -20.0037         5.11745e-89   
policy_monthpolicy06          -0.165213         0.00714549         -23.1214         2.82414e-118   
policy_monthpolicy07          -0.138911         0.00707187         -19.6428         6.66411e-86   
policy_monthpolicy08          -0.184036         0.00743823         -24.7419         3.78989e-135   
policy_monthpolicy09          -0.358248         0.0116883           -30.65         2.6399e-206   
policy_monthpolicy10          -0.526739         0.00945001         -55.7395                0   
policy_monthpolicy11          -0.197722         0.00801029         -24.6835         1.60928e-134   
policy_monthpolicy12          -0.077078         0.00716879         -10.7519         5.80688e-27   
age_grp16-19                    1.76604         0.0930874          18.9719         2.9129e-80   
age_grp20-24                    1.75687         0.0929076          18.9099         9.46091e-80   
age_grp25-34                    1.62145         0.0928618          17.4609         2.84421e-68   
age_grp35-44                    1.55197         0.0928588          16.7132         1.05063e-62   
age_grp45-54                    1.36544         0.0928663          14.7032         6.14451e-49   
age_grp55-64                    1.10658         0.0929104          11.9102         1.04722e-32   
age_grp65-199                  0.684845         0.0930345           7.3612         1.82266e-13   
curr_pts_grp1-3                 1.15414         0.00223504          516.383                0   
curr_pts_grp4-6                 1.67934         0.00331854          506.047                0   
curr_pts_grp7-9                 1.95442         0.00529955          368.789                0   
curr_pts_grp10-150              2.20126         0.00710894          309.646                0   
month02                        0.171718         0.00536231          32.0231         5.20612e-225   
month03                        0.211483         0.00520132          40.6594                0   
month04                        0.162905         0.00536632          30.3569         2.03647e-202   
month05                        0.200515         0.00526093           38.114                0   
month06                        0.158847         0.00535101          29.6854         1.18455e-193   
month07                        0.0982156         0.00538814          18.2281         3.08829e-74   
month08                        0.0132578         0.00548733          2.41607         0.0156891   
month09                        0.317343         0.00515481          61.5625                0   
month10                        0.276429         0.0051479          53.6974                0   
month11                        0.269678         0.00518681          51.9931                0   
month12                       -0.587911         0.00650444         -90.3862                0   
weekdayMonday                  0.635478         0.00406436          156.354                0   
weekdayTuesday                 0.777621         0.003971          195.825                0   
weekdayWednesday               0.825365         0.00394188          209.383                0   
weekdayThursday                0.764806         0.003982          192.066                0   
weekdayFriday                  0.606411         0.0040885          148.321                0   
weekdaySaturday                0.134471         0.00450044          29.8796         3.61984e-196   
policyTRUE:age_grp16-19        0.0608043         0.130691         0.465252         0.641751   
policyTRUE:age_grp20-24        0.0402393         0.130464         0.308433         0.757753   
policyTRUE:age_grp25-34        0.0191887         0.130403          0.14715         0.883014   
policyTRUE:age_grp35-44        0.0502056         0.130399         0.385014         0.700227   
policyTRUE:age_grp45-54        0.0438754         0.130409         0.336444         0.736536   
policyTRUE:age_grp55-64        0.0570101         0.130468         0.436965         0.662137   
policyTRUE:age_grp65-199       0.131304         0.130621          1.00523         0.314786  
```



```
age_grp          pred_prob
0-15          -0.070959
16-19          2.455843
20-24          1.696283
25-34          0.655624
35-44          1.590613
45-54          1.061559
55-64          0.995228
65-199          1.448054

```
