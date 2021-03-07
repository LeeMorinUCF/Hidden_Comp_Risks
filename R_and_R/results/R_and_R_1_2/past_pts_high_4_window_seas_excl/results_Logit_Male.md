# Logistic Regression Models - Male Drivers

## Logistic Regression Results 



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.46498         0.0937274         -90.3149                0   
policyTRUE                    -0.370554         0.00209048         -177.257                0   
age_grp16-19                    1.13666         0.093875          12.1082         9.55275e-34   
age_grp20-24                    1.07334         0.0937295          11.4515         2.31186e-30   
age_grp25-34                     1.0976         0.0937099          11.7128         1.09663e-31   
age_grp35-44                    1.03309         0.0937158          11.0236         2.93965e-28   
age_grp45-54                   0.982874         0.0937234           10.487         9.91548e-26   
age_grp55-64                   0.883086         0.0937553          9.41905         4.55191e-21   
age_grp65-199                  0.662353         0.0938641          7.05651         1.70739e-12   
curr_pts_grp1-3                0.622412         0.00318554          195.386                0   
curr_pts_grp4-6                 1.03734         0.00320021          324.146                0   
curr_pts_grp7-9                 1.29977         0.00348799          372.641                0   
curr_pts_grp10-150              1.65833         0.00349172          474.932                0  
```


### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.28426         0.0937332         -88.3813                0   
policyTRUE                       -6.794          3.18217         -2.13502         0.0327593   
age_grp16-19                    1.12563         0.0938998          11.9875         4.13098e-33   
age_grp20-24                   0.976684         0.0937522          10.4177         2.05843e-25   
age_grp25-34                   0.899592         0.0937288          9.59782         8.16554e-22   
age_grp35-44                    0.82383         0.0937395           8.7885         1.51568e-18   
age_grp45-54                   0.773647         0.0937543          8.25185         1.5596e-16   
age_grp55-64                    0.66918         0.0938134           7.1331         9.81335e-13   
age_grp65-199                  0.436707         0.094027          4.64448         3.40935e-06   
curr_pts_grp1-3                0.619239         0.00318609          194.357                0   
curr_pts_grp4-6                 1.03502         0.00320103          323.339                0   
curr_pts_grp7-9                 1.29917         0.00348832          372.433                0   
curr_pts_grp10-150              1.66236         0.00348943          476.399                0   
policyTRUE:age_grp16-19         5.30818          3.18224          1.66806         0.095303   
policyTRUE:age_grp20-24         6.17231          3.18218          1.93965         0.0524223   
policyTRUE:age_grp25-34          6.4656          3.18217          2.03182         0.042172   
policyTRUE:age_grp35-44         6.49326          3.18217          2.04051         0.0412996   
policyTRUE:age_grp45-54         6.49039          3.18218          2.03961         0.0413894   
policyTRUE:age_grp55-64         6.50025          3.18218          2.04271         0.0410816   
policyTRUE:age_grp65-199        6.52161          3.18219          2.04941         0.0404222  
```


### One-point violations (for speeding 11-20 over)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -12.7556         0.700662         -18.2051         4.70085e-74   
policyTRUE                    -0.0712571         0.00761247         -9.36059         7.9296e-21   
age_grp16-19                    2.14498         0.701065           3.0596         0.00221631   
age_grp20-24                    2.16785         0.700678          3.09393         0.00197526   
age_grp25-34                     2.4294         0.700623          3.46748         0.000525357   
age_grp35-44                    2.48921         0.700629          3.55282         0.000381123   
age_grp45-54                      2.484          0.70064          3.54533         0.00039212   
age_grp55-64                    2.40797          0.70069          3.43657         0.000589125   
age_grp65-199                   2.07637           0.7009          2.96243         0.00305225   
curr_pts_grp1-3                0.670257         0.0125138          53.5613                0   
curr_pts_grp4-6                 1.18439         0.0123533          95.8763                0   
curr_pts_grp7-9                 1.56189         0.0130787          119.422                0   
curr_pts_grp10-150              2.02406         0.0128356          157.691                0  
```


### One-point violations (for speeding 11-20 over)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -12.5078          0.70719         -17.6866         5.32238e-70   
policyTRUE                     -5.84095          14.5179        -0.402327         0.687443   
age_grp16-19                    2.12006         0.707658          2.99588         0.00273656   
age_grp20-24                    2.04179         0.707257          2.88692         0.00389035   
age_grp25-34                     2.1812         0.707185          3.08435         0.00203998   
age_grp35-44                    2.20607         0.707199          3.11944         0.00181195   
age_grp45-54                    2.19874         0.707224          3.10897         0.00187744   
age_grp55-64                    2.12088         0.707332          2.99842         0.00271384   
age_grp65-199                   1.69482         0.707867          2.39426         0.0166539   
curr_pts_grp1-3                0.667757         0.0125152          53.3555                0   
curr_pts_grp4-6                 1.18262         0.0123558          95.7134                0   
curr_pts_grp7-9                 1.56108         0.0130805          119.344                0   
curr_pts_grp10-150              2.02724         0.0128283          158.029                0   
policyTRUE:age_grp16-19          4.6655          14.5181         0.321357          0.74794   
policyTRUE:age_grp20-24         5.46488          14.5179         0.376423         0.706603   
policyTRUE:age_grp25-34         5.77104          14.5179         0.397511          0.69099   
policyTRUE:age_grp35-44         5.84165          14.5179         0.402375         0.687408   
policyTRUE:age_grp45-54         5.84311          14.5179         0.402476         0.687334   
policyTRUE:age_grp55-64         5.84622          14.5179         0.402689         0.687177   
policyTRUE:age_grp65-199        6.00925           14.518         0.413918         0.678934  
```


### Two-point violations (speeding 21-30 over or 7 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -11.1777         0.352672         -31.6944         1.85439e-220   
policyTRUE                    -0.210343         0.00347436         -60.5414                0   
age_grp16-19                     2.2818         0.352867          6.46646         1.00327e-10   
age_grp20-24                    2.46779         0.352681          6.99723         2.61069e-12   
age_grp25-34                    2.67011          0.35266          7.57135         3.69367e-14   
age_grp35-44                     2.6757         0.352663          7.58714         3.27055e-14   
age_grp45-54                    2.66301         0.352667          7.55105         4.31755e-14   
age_grp55-64                    2.57944         0.352689          7.31366         2.59965e-13   
age_grp65-199                   2.30295         0.352768          6.52822         6.65542e-11   
curr_pts_grp1-3                0.599577         0.00537194          111.613                0   
curr_pts_grp4-6                 1.09489         0.00531766          205.897                0   
curr_pts_grp7-9                 1.35524         0.0058098          233.268                0   
curr_pts_grp10-150              1.62017         0.00597461          271.176                0  
```


### Two-point violations (speeding 21-30 over or 7 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                     -10.967         0.353592         -31.0159         3.29459e-211   
policyTRUE                     -5.16792          5.30355        -0.974427         0.329844   
age_grp16-19                     2.2593         0.353813          6.38556         1.70768e-10   
age_grp20-24                    2.34196         0.353619          6.62284         3.52371e-11   
age_grp25-34                    2.44217         0.353591          6.90678         4.95776e-12   
age_grp35-44                    2.44839         0.353597          6.92423         4.38339e-12   
age_grp45-54                    2.43317         0.353606          6.88101         5.94316e-12   
age_grp55-64                    2.34443         0.353648          6.62928         3.37334e-11   
age_grp65-199                   2.04326         0.353818          5.77489         7.70057e-09   
curr_pts_grp1-3                0.597394         0.00537257          111.193                0   
curr_pts_grp4-6                 1.09327         0.00531867          205.553                0   
curr_pts_grp7-9                  1.3548         0.0058103          233.173                0   
curr_pts_grp10-150              1.62319         0.00597177          271.811                0   
policyTRUE:age_grp16-19         3.87891           5.3037         0.731359          0.46456   
policyTRUE:age_grp20-24         4.72936          5.30356         0.891734         0.372536   
policyTRUE:age_grp25-34         4.99549          5.30355         0.941914         0.346237   
policyTRUE:age_grp35-44         4.99512          5.30355         0.941845         0.346272   
policyTRUE:age_grp45-54         4.99899          5.30355         0.942573         0.345899   
policyTRUE:age_grp55-64         5.00935          5.30356         0.944527         0.344901   
policyTRUE:age_grp65-199         5.0553          5.30358         0.953186         0.340496  
```


### Three-point violations (speeding 31-60 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.79126         0.112596         -78.0779                0   
policyTRUE                    -0.464541         0.00293696         -158.171                0   
age_grp16-19                   0.880477         0.112827          7.80381         6.00668e-15   
age_grp20-24                    0.86204         0.112596          7.65603         1.91775e-14   
age_grp25-34                   0.824582         0.112568          7.32516         2.38606e-13   
age_grp35-44                   0.736012         0.112579          6.53775         6.24513e-11   
age_grp45-54                   0.667472         0.112592          5.92823         3.06218e-09   
age_grp55-64                   0.564622         0.112646          5.01237         5.37627e-07   
age_grp65-199                   0.40624          0.11281           3.6011         0.00031688   
curr_pts_grp1-3                0.643148         0.00438312          146.733                0   
curr_pts_grp4-6                 1.00492         0.00444954          225.848                0   
curr_pts_grp7-9                 1.24819         0.00487421          256.081                0   
curr_pts_grp10-150              1.61456         0.00486604          331.802                0  
```


### Three-point violations (speeding 31-60 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.62812           0.1126         -76.6263                0   
policyTRUE                     -7.43489          5.31258         -1.39949         0.161667   
age_grp16-19                   0.871461         0.112858          7.72176         1.14733e-14   
age_grp20-24                   0.765145         0.112624          6.79378         1.09235e-11   
age_grp25-34                   0.638488         0.112592          5.67083         1.42106e-08   
age_grp35-44                   0.546472         0.112609          4.85282         1.21719e-06   
age_grp45-54                   0.487647         0.112633          4.32951         1.4944e-05   
age_grp55-64                   0.383885         0.112726          3.40546         0.00066053   
age_grp65-199                  0.223933         0.113027          1.98123         0.0475655   
curr_pts_grp1-3                0.640139         0.00438391           146.02                0   
curr_pts_grp4-6                  1.0027         0.00445062          225.295                0   
curr_pts_grp7-9                 1.24777         0.00487457          255.975                0   
curr_pts_grp10-150              1.61831         0.00486309          332.773                0   
policyTRUE:age_grp16-19          5.8722          5.31266          1.10532          0.26902   
policyTRUE:age_grp20-24         6.76243          5.31259          1.27291         0.203051   
policyTRUE:age_grp25-34         7.02873          5.31258          1.32303         0.185824   
policyTRUE:age_grp35-44         7.03882          5.31259          1.32493         0.185194   
policyTRUE:age_grp45-54           7.013          5.31259          1.32007         0.186811   
policyTRUE:age_grp55-64         7.01496          5.31259          1.32044         0.186688   
policyTRUE:age_grp65-199         7.0165          5.31261          1.32073         0.186592  
```


### Four-point violations (speeding 31-45 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                     -9.9945         0.231208         -43.2272                0   
policyTRUE                    -0.878459         0.0228263         -38.4844                0   
age_grp16-19                   0.331492         0.230465          1.43836         0.150331   
age_grp20-24                  -0.954195         0.230268         -4.14385         3.41527e-05   
age_grp25-34                   -1.72645         0.230374          -7.4941         6.67548e-14   
age_grp35-44                   -2.37244         0.231479         -10.2491         1.19497e-24   
age_grp45-54                   -2.83515         0.233365          -12.149         5.80932e-34   
age_grp55-64                    -3.1023         0.238436         -13.0111         1.05854e-38   
age_grp65-199                  -3.27404         0.251768         -13.0042         1.15751e-38   
curr_pts_grp1-3                0.431865         0.0341299          12.6536         1.06904e-36   
curr_pts_grp4-6                0.727655         0.0343302          21.1958         1.04419e-99   
curr_pts_grp7-9                 1.08587         0.0352937          30.7667         7.31369e-208   
curr_pts_grp10-150               1.7756         0.0323909           54.818                0  
```


### Four-point violations (speeding 31-45 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -9.87641         0.231193         -42.7193                0   
policyTRUE                     -9.05546          23.9164         -0.37863         0.704963   
age_grp16-19                   0.303441         0.230545          1.31619          0.18811   
age_grp20-24                    -1.0424         0.230463         -4.52307         6.09498e-06   
age_grp25-34                    -1.9128         0.230759         -8.28918         1.1403e-16   
age_grp35-44                   -2.55143         0.232431         -10.9772         4.92089e-28   
age_grp45-54                   -3.05274         0.235654         -12.9543         2.22102e-38   
age_grp55-64                    -3.3531         0.244307          -13.725         7.19726e-43   
age_grp65-199                  -3.47242         0.265064         -13.1003         3.27773e-39   
curr_pts_grp1-3                0.420018         0.0341601          12.2956         9.56857e-35   
curr_pts_grp4-6                0.720187         0.0343589          20.9607         1.49769e-97   
curr_pts_grp7-9                 1.08524         0.0353033          30.7405         1.63899e-207   
curr_pts_grp10-150              1.78316         0.0323542          55.1136                0   
policyTRUE:age_grp16-19          7.4321          23.9165         0.310752         0.755989   
policyTRUE:age_grp20-24         8.05947          23.9164         0.336985         0.736128   
policyTRUE:age_grp25-34         8.39101          23.9164         0.350847         0.725703   
policyTRUE:age_grp35-44         8.37565          23.9165         0.350204         0.726186   
policyTRUE:age_grp45-54         8.47045          23.9166         0.354167         0.723214   
policyTRUE:age_grp55-64         8.55151          23.9168         0.357553         0.720678   
policyTRUE:age_grp65-199        8.40673          23.9173         0.351491          0.72522  
```


### Five-point violations (speeding 46-60 over or a handheld device violation)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -20.0612          19.7472          -1.0159         0.309676   
policyTRUE                    -0.993126         0.0124316         -79.8873                0   
age_grp16-19                     10.236          19.7472         0.518353         0.604212   
age_grp20-24                    9.98337          19.7472         0.505559         0.613166   
age_grp25-34                     9.7022          19.7472          0.49132           0.6232   
age_grp35-44                    9.28057          19.7472         0.469969         0.638377   
age_grp45-54                    9.03436          19.7472         0.457501         0.647311   
age_grp55-64                    8.66347          19.7472         0.438719         0.660866   
age_grp65-199                   8.20698          19.7473         0.415601         0.677702   
curr_pts_grp1-3                0.680708         0.0173443          39.2468                0   
curr_pts_grp4-6                0.944959         0.0178231          53.0187                0   
curr_pts_grp7-9                 1.20209         0.0192056          62.5907                0   
curr_pts_grp10-150              1.78178         0.0180535          98.6946                0  
```


### Five-point violations (speeding 46-60 over or a handheld device violation)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -20.3544          24.0209        -0.847359         0.396795   
policyTRUE                      0.28669          46.2639         0.00619685         0.995056   
age_grp16-19                    10.5941          24.0209         0.441035         0.659188   
age_grp20-24                    10.2957          24.0209         0.428614         0.668204   
age_grp25-34                    9.97014          24.0209          0.41506         0.678098   
age_grp35-44                    9.56574          24.0209         0.398225         0.690464   
age_grp45-54                    9.32774          24.0209         0.388317         0.697781   
age_grp55-64                    8.98098          24.0209         0.373881         0.708493   
age_grp65-199                   8.47681           24.021         0.352892          0.72417   
curr_pts_grp1-3                0.678237         0.0173479          39.0961                0   
curr_pts_grp4-6                0.943167         0.0178269           52.907                0   
curr_pts_grp7-9                 1.20199         0.019207          62.5811                0   
curr_pts_grp10-150              1.78414         0.0180473           98.859                0   
policyTRUE:age_grp16-19        -1.86475          46.2639        -0.0403068         0.967849   
policyTRUE:age_grp20-24         -1.3635          46.2639        -0.0294721         0.976488   
policyTRUE:age_grp25-34        -1.19116          46.2639        -0.0257471         0.979459   
policyTRUE:age_grp35-44         -1.2486          46.2639        -0.0269886         0.978469   
policyTRUE:age_grp45-54        -1.27781          46.2639        -0.0276201         0.977965   
policyTRUE:age_grp55-64        -1.36134          46.2639        -0.0294255         0.976525   
policyTRUE:age_grp65-199       -1.20435           46.264        -0.0260321         0.979232  
```


### Seven-point violations (speeding 61-80 over or combinations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -20.6099          32.7117        -0.630045         0.528665   
policyTRUE                     -1.13475         0.029101         -38.9936                0   
age_grp16-19                    10.1449          32.7118         0.310131         0.756462   
age_grp20-24                    9.55282          32.7117          0.29203         0.770263   
age_grp25-34                     9.0068          32.7117         0.275338         0.783056   
age_grp35-44                    8.30259          32.7118         0.253811         0.799642   
age_grp45-54                    7.67508          32.7118         0.234627         0.814498   
age_grp55-64                    7.03173          32.7119          0.21496         0.829799   
age_grp65-199                   6.61308          32.7122          0.20216         0.839792   
curr_pts_grp1-3                 0.23608         0.0380614          6.20262         5.55307e-10   
curr_pts_grp4-6                0.342311         0.0406331          8.42444         3.6247e-17   
curr_pts_grp7-9                0.757506         0.0418193          18.1138         2.48036e-73   
curr_pts_grp10-150              1.61398         0.0360818           44.731                0  
```


### Seven-point violations (speeding 61-80 over or combinations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -20.9041          39.6181        -0.527641         0.597749   
policyTRUE                     0.271391          76.0646         0.0035679         0.997153   
age_grp16-19                    10.5063          39.6181         0.265189         0.790864   
age_grp20-24                    9.84307          39.6181         0.248449         0.803787   
age_grp25-34                    9.29136          39.6181         0.234523         0.814579   
age_grp35-44                    8.55757          39.6181         0.216002         0.828986   
age_grp45-54                     7.9742          39.6181         0.201277         0.840482   
age_grp55-64                    7.28879          39.6182         0.183976         0.854032   
age_grp65-199                   7.21933          39.6184         0.182222         0.855409   
curr_pts_grp1-3                0.231913         0.0380786          6.09038         1.12643e-09   
curr_pts_grp4-6                0.339519         0.0406481          8.35265         6.67477e-17   
curr_pts_grp7-9                0.757317         0.0418238          18.1073         2.78965e-73   
curr_pts_grp10-150              1.61677         0.0360607          44.8346                0   
policyTRUE:age_grp16-19        -2.07176          76.0647        -0.0272368         0.978271   
policyTRUE:age_grp20-24        -1.38757          76.0646        -0.018242         0.985446   
policyTRUE:age_grp25-34        -1.36608          76.0646        -0.0179595         0.985671   
policyTRUE:age_grp35-44        -1.25473          76.0646        -0.0164955         0.986839   
policyTRUE:age_grp45-54        -1.42011          76.0647        -0.0186697         0.985105   
policyTRUE:age_grp55-64        -1.27077          76.0649        -0.0167064         0.986671   
policyTRUE:age_grp65-199       -4.02751          76.0714        -0.0529439         0.957777  
```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.6207         0.409736         -25.9209         3.86887e-148   
policyTRUE                    -0.756107         0.0319179         -23.6892         4.66299e-124   
age_grp16-19                  -0.218666         0.411115        -0.531885         0.594806   
age_grp20-24                  -0.898911         0.409481         -2.19524         0.0281462   
age_grp25-34                   -1.39086         0.409355         -3.39768         0.000679601   
age_grp35-44                   -1.88127         0.410266          -4.5855         4.52905e-06   
age_grp45-54                    -2.0937         0.411258         -5.09097         3.5624e-07   
age_grp55-64                   -2.12006         0.413589         -5.12599         2.95972e-07   
age_grp65-199                  -1.84439         0.416607         -4.42716         9.54825e-06   
curr_pts_grp1-3               -0.301127         0.0473306         -6.36222         1.98862e-10   
curr_pts_grp4-6                0.128266         0.0465717          2.75415         0.0058845   
curr_pts_grp7-9                0.657583         0.0469242          14.0137         1.28487e-44   
curr_pts_grp10-150              1.39172         0.0416579          33.4084         1.03546e-244  
```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                     -10.481         0.409708         -25.5817         2.43796e-144   
policyTRUE                     -8.97368          39.3321        -0.228152         0.819528   
age_grp16-19                  -0.232604         0.411338         -0.56548         0.571747   
age_grp20-24                   -1.02308         0.409834         -2.49634         0.0125483   
age_grp25-34                    -1.6019         0.409815         -3.90884         9.27386e-05   
age_grp35-44                   -2.02736           0.4111         -4.93155         8.15802e-07   
age_grp45-54                   -2.22795         0.412638         -5.39927         6.69108e-08   
age_grp55-64                   -2.23245         0.416049         -5.36584         8.05743e-08   
age_grp65-199                  -1.93423           0.4206         -4.59873         4.2507e-06   
curr_pts_grp1-3               -0.308371         0.0473586         -6.51139         7.44563e-11   
curr_pts_grp4-6                 0.12283         0.0466027          2.63569         0.00839674   
curr_pts_grp7-9                0.656558         0.0469369          13.9881         1.8433e-44   
curr_pts_grp10-150              1.39588         0.0416115          33.5456         1.04439e-246   
policyTRUE:age_grp16-19         7.24234          39.3324         0.184131          0.85391   
policyTRUE:age_grp20-24         8.16377          39.3321          0.20756         0.835573   
policyTRUE:age_grp25-34         8.41978          39.3321         0.214069         0.830493   
policyTRUE:age_grp35-44         8.24152          39.3321         0.209536         0.834029   
policyTRUE:age_grp45-54         8.20708          39.3322         0.208661         0.834713   
policyTRUE:age_grp55-64         8.14409          39.3323         0.207059         0.835964   
policyTRUE:age_grp65-199        8.08338          39.3324         0.205514          0.83717  
```