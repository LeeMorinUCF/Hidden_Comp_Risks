# Logistic Regression Models - Male Drivers

## Logistic Regression Results 



### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.74707         0.0192947          -453.34                0   
policyTRUE                    -0.110153         0.0011992          -91.855                0   
age_grp16-19                    1.21511         0.0194596          62.4429                0   
age_grp20-24                    1.06801         0.0193654          55.1503                0   
age_grp25-34                   0.885758         0.0193294          45.8244                0   
age_grp35-44                   0.785103         0.0193302          40.6154                0   
age_grp45-54                   0.691257         0.0193318          35.7574         5.07032e-280   
age_grp55-64                   0.539122         0.0193614          27.8452         1.23174e-170   
age_grp65-199                  0.201362         0.019428          10.3645         3.59576e-25   
curr_pts_grp1-3                 1.08258         0.0014745          734.203                0   
curr_pts_grp4-6                 1.53317         0.00183317          836.347                0   
curr_pts_grp7-9                  1.7783         0.00241046          737.744                0   
curr_pts_grp10-150              2.00223         0.00250419          799.551                0  
```


### All violations combined


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -8.79094         0.027023         -325.313                0   
policyTRUE                    -0.0183891         0.0385733        -0.476732         0.633553   
age_grp16-19                    1.26848         0.0272714          46.5131                0   
age_grp20-24                    1.13043         0.0271267          41.6721                0   
age_grp25-34                    0.94845         0.0270811          35.0227         1.0171e-268   
age_grp35-44                    0.82787         0.0270832          30.5677         3.29441e-205   
age_grp45-54                   0.725038         0.0270892          26.7648         8.29589e-158   
age_grp55-64                   0.566736         0.0271347           20.886         7.17708e-97   
age_grp65-199                  0.196847         0.0272431          7.22556         4.99037e-13   
curr_pts_grp1-3                 1.08216         0.0014745          733.919                0   
curr_pts_grp4-6                 1.53281         0.00183311          836.177                0   
curr_pts_grp7-9                 1.77797         0.00241046          737.605                0   
curr_pts_grp10-150              2.00314         0.0025041          799.947                0   
policyTRUE:age_grp16-19       -0.110065         0.0389106         -2.82867         0.00467423   
policyTRUE:age_grp20-24       -0.129894         0.0387188         -3.35482         0.000794181   
policyTRUE:age_grp25-34       -0.130024         0.0386562          -3.3636         0.000769317   
policyTRUE:age_grp35-44       -0.0891778         0.0386614         -2.30664         0.021075   
policyTRUE:age_grp45-54       -0.0713876         0.0386669         -1.84622          0.06486   
policyTRUE:age_grp55-64       -0.0596409         0.0387279            -1.54         0.123561   
policyTRUE:age_grp65-199       0.000689239         0.038864         0.0177346         0.985851  
```


### One-point violations (for speeding 11-20 over)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -11.8573         0.0866168         -136.894                0   
policyTRUE                     0.0966595         0.0042528          22.7284         2.34507e-114   
age_grp16-19                    1.61051         0.0871017            18.49         2.48688e-76   
age_grp20-24                     1.2768         0.0868667          14.6984         6.6014e-49   
age_grp25-34                    1.27731         0.0867173          14.7295         4.16623e-49   
age_grp35-44                    1.30415         0.0867047          15.0412         3.94074e-51   
age_grp45-54                    1.25993         0.0867028          14.5316         7.64283e-48   
age_grp55-64                     1.1357         0.0867719          13.0883         3.84159e-39   
age_grp65-199                  0.745071         0.086955          8.56847         1.04872e-17   
curr_pts_grp1-3                 1.08913         0.00518965          209.865                0   
curr_pts_grp4-6                  1.4972         0.00659626          226.977                0   
curr_pts_grp7-9                 1.79501         0.00857734          209.274                0   
curr_pts_grp10-150              2.12538         0.00861088          246.825                0  
```


### One-point violations (for speeding 11-20 over)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -12.0071         0.134366         -89.3612                0   
policyTRUE                     0.367853          0.17566          2.09412         0.0362494   
age_grp16-19                     1.8058         0.135084           13.368         9.305e-41   
age_grp20-24                    1.48984         0.134719          11.0588         1.98664e-28   
age_grp25-34                    1.45885         0.134539          10.8433         2.14481e-27   
age_grp35-44                    1.45596         0.134526          10.8228         2.68368e-27   
age_grp45-54                    1.39091         0.134536          10.3386         4.71434e-25   
age_grp55-64                    1.24988         0.134649          9.28255         1.65472e-20   
age_grp65-199                  0.782169         0.134981          5.79464         6.84681e-09   
curr_pts_grp1-3                 1.08821         0.00518929          209.703                0   
curr_pts_grp4-6                 1.49637         0.00659545          226.879                0   
curr_pts_grp7-9                 1.79414         0.00857676          209.187                0   
curr_pts_grp10-150              2.12743         0.0086088          247.123                0   
policyTRUE:age_grp16-19       -0.352575         0.176654         -1.99584         0.0459509   
policyTRUE:age_grp20-24       -0.391015         0.176172         -2.21951         0.0264518   
policyTRUE:age_grp25-34       -0.329743         0.175906         -1.87454         0.0608559   
policyTRUE:age_grp35-44       -0.274441         0.175892         -1.56028         0.118693   
policyTRUE:age_grp45-54       -0.236834         0.175897         -1.34644         0.178162   
policyTRUE:age_grp55-64       -0.207772         0.176043         -1.18023         0.237908   
policyTRUE:age_grp65-199      -0.0791152         0.176438        -0.448403         0.653863  
```


### Two-point violations (speeding 21-30 over or 7 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.7552         0.0515617         -208.589                0   
policyTRUE                    -0.0183457         0.00190751         -9.61762         6.73732e-22   
age_grp16-19                    2.00373         0.0517682          38.7059                0   
age_grp20-24                    1.96295         0.0516414          38.0111                0   
age_grp25-34                    1.90469         0.0515954          36.9158         2.57942e-298   
age_grp35-44                    1.87581         0.0515931          36.3577         1.98379e-289   
age_grp45-54                    1.83019         0.0515924          35.4741         1.23388e-275   
age_grp55-64                    1.69725         0.0516164          32.8819         3.98469e-237   
age_grp65-199                   1.30909         0.0516785          25.3315         1.43746e-141   
curr_pts_grp1-3                 1.07665         0.00231414          465.247                0   
curr_pts_grp4-6                 1.49373         0.00293161          509.527                0   
curr_pts_grp7-9                 1.70393         0.00394941           431.44                0   
curr_pts_grp10-150              1.82629         0.00432195          422.562                0  
```


### Two-point violations (speeding 21-30 over or 7 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -10.8429         0.0754177         -143.771                0   
policyTRUE                     0.152978         0.103318          1.48064         0.138702   
age_grp16-19                    2.08609         0.0757324          27.5455         5.01294e-167   
age_grp20-24                    2.05339         0.0755361          27.1843         9.96297e-163   
age_grp25-34                    2.00569         0.0754753          26.5742         1.35032e-155   
age_grp35-44                    1.96773         0.0754724          26.0722         7.53708e-150   
age_grp45-54                     1.9148         0.0754747          25.3701         5.38663e-142   
age_grp55-64                    1.77748         0.0755116          23.5392         1.62108e-122   
age_grp65-199                   1.36211         0.0756108          18.0147         1.49375e-72   
curr_pts_grp1-3                 1.07648         0.00231418          465.166                0   
curr_pts_grp4-6                 1.49367         0.00293161          509.504                0   
curr_pts_grp7-9                 1.70395         0.00394948          431.435                0   
curr_pts_grp10-150              1.82677         0.0043222          422.647                0   
policyTRUE:age_grp16-19       -0.161382         0.103742         -1.55561         0.119801   
policyTRUE:age_grp20-24       -0.176783         0.103483         -1.70832         0.0875764   
policyTRUE:age_grp25-34       -0.197329           0.1034          -1.9084         0.0563391   
policyTRUE:age_grp35-44        -0.17971         0.103399         -1.73803         0.082205   
policyTRUE:age_grp45-54       -0.165384           0.1034         -1.59947         0.109717   
policyTRUE:age_grp55-64       -0.157212         0.103449          -1.5197         0.128586   
policyTRUE:age_grp65-199      -0.107466         0.103577         -1.03755         0.299481  
```


### Three-point violations (speeding 31-60 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -9.07048         0.0230078         -394.236                0   
policyTRUE                    -0.185901         0.00173271         -107.289                0   
age_grp16-19                   0.838445         0.0232907          35.9991         8.63848e-284   
age_grp20-24                   0.749961         0.0231222          32.4347         8.91122e-231   
age_grp25-34                   0.522777         0.0230671          22.6633         1.03087e-113   
age_grp35-44                   0.385245         0.0230713           16.698         1.35421e-62   
age_grp45-54                   0.255592         0.0230775          11.0754         1.65204e-28   
age_grp55-64                   0.0893347         0.0231342          3.86159         0.000112653   
age_grp65-199                 -0.191199         0.0232444         -8.22559         1.94232e-16   
curr_pts_grp1-3                 1.09462         0.00214085          511.301                0   
curr_pts_grp4-6                  1.5705         0.00262864          597.457                0   
curr_pts_grp7-9                 1.82368         0.00342635           532.25                0   
curr_pts_grp10-150              2.05767         0.00353429          582.204                0  
```


### Three-point violations (speeding 31-60 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -9.14738         0.0321938         -284.135                0   
policyTRUE                    -0.0220393         0.0459867        -0.479253         0.631759   
age_grp16-19                   0.909151          0.03261          27.8795         4.73092e-171   
age_grp20-24                   0.829768         0.0323582          25.6432         5.02913e-145   
age_grp25-34                   0.613105         0.0322893          18.9879         2.14875e-80   
age_grp35-44                   0.461481         0.0322962           14.289         2.56105e-46   
age_grp45-54                   0.330057         0.0323099          10.2154         1.69256e-24   
age_grp55-64                   0.163452         0.0323919          5.04608         4.50956e-07   
age_grp65-199                 -0.150312         0.0325638         -4.61594         3.91329e-06   
curr_pts_grp1-3                 1.09443         0.00214089          511.204                0   
curr_pts_grp4-6                 1.57042         0.00262867          597.418                0   
curr_pts_grp7-9                 1.82366         0.00342646          532.229                0   
curr_pts_grp10-150              2.05808         0.00353443          582.294                0   
policyTRUE:age_grp16-19       -0.151356         0.0465637         -3.25052         0.00115195   
policyTRUE:age_grp20-24       -0.170051         0.0462212         -3.67906         0.000234093   
policyTRUE:age_grp25-34       -0.192273         0.0461276          -4.1683         3.06884e-05   
policyTRUE:age_grp35-44       -0.162343         0.0461425         -3.51829         0.000434334   
policyTRUE:age_grp45-54       -0.158716         0.0461584         -3.43852         0.000584912   
policyTRUE:age_grp55-64       -0.158073         0.0462748         -3.41595         0.000635595   
policyTRUE:age_grp65-199      -0.0922457         0.046498         -1.98386         0.0472709  
```


### Four-point violations (speeding 31-45 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -11.1547         0.0682933         -163.336                0   
policyTRUE                    -0.122444         0.0114136         -10.7279         7.52592e-27   
age_grp16-19                    1.09927         0.0689731          15.9376         3.47249e-57   
age_grp20-24                  -0.0856398         0.0691408         -1.23863         0.215483   
age_grp25-34                   -1.12989         0.0693249         -16.2985         1.01126e-59   
age_grp35-44                   -1.90793         0.0705329         -27.0502         3.79913e-161   
age_grp45-54                   -2.45592         0.0720585         -34.0823         1.34717e-254   
age_grp55-64                   -2.79183         0.0756327          -36.913         2.85457e-298   
age_grp65-199                   -3.0653         0.0804462         -38.1037                0   
curr_pts_grp1-3                0.573648         0.015495          37.0216         5.14849e-300   
curr_pts_grp4-6                 1.20146         0.0173791          69.1329                0   
curr_pts_grp7-9                 1.54808         0.0209126           74.026                0   
curr_pts_grp10-150               2.0102         0.018366          109.452                0  
```


### Four-point violations (speeding 31-45 over or 9 other violations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                     -11.052         0.0880826         -125.473                0   
policyTRUE                    -0.360259         0.138732         -2.59679         0.00940994   
age_grp16-19                    1.00567         0.0893485          11.2556         2.17234e-29   
age_grp20-24                  -0.188892         0.0895268          -2.1099         0.0348672   
age_grp25-34                   -1.24566         0.0899212         -13.8528         1.22333e-43   
age_grp35-44                   -2.02485         0.0917141         -22.0779         5.15762e-108   
age_grp45-54                   -2.57793         0.0942207         -27.3605         8.09136e-165   
age_grp55-64                   -2.85811         0.0992494         -28.7972         2.32316e-182   
age_grp65-199                  -3.12934         0.106472         -29.3912         7.1171e-190   
curr_pts_grp1-3                0.573597         0.0154958          37.0163         6.26053e-300   
curr_pts_grp4-6                  1.2012         0.0173802          69.1132                0   
curr_pts_grp7-9                 1.54766         0.0209145          73.9994                0   
curr_pts_grp10-150              2.01007         0.0183663          109.443                0   
policyTRUE:age_grp16-19        0.220163         0.140188          1.57049         0.116302   
policyTRUE:age_grp20-24        0.239192         0.140454          1.70299         0.0885698   
policyTRUE:age_grp25-34        0.264523         0.141041          1.87551         0.0607225   
policyTRUE:age_grp35-44        0.267589         0.143504          1.86468         0.0622257   
policyTRUE:age_grp45-54        0.276708         0.146549          1.88816         0.0590041   
policyTRUE:age_grp55-64        0.163603         0.153641          1.06484         0.286948   
policyTRUE:age_grp65-199       0.159925         0.163151         0.980223         0.326976  
```


### Five-point violations (speeding 46-60 over or a handheld device violation)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -15.0859         0.497096         -30.3481         2.66195e-202   
policyTRUE                    -0.643135         0.00795813         -80.8148                0   
age_grp16-19                    4.56523         0.497237           9.1812         4.26319e-20   
age_grp20-24                    4.35155         0.497161          8.75279         2.08147e-18   
age_grp25-34                    3.87815         0.497141          7.80091         6.14642e-15   
age_grp35-44                    3.34426         0.497171          6.72658         1.737e-11   
age_grp45-54                    2.96437         0.497208          5.96205         2.49098e-09   
age_grp55-64                     2.5234         0.497359           5.0736         3.90354e-07   
age_grp65-199                   1.77815         0.497879          3.57145         0.000355014   
curr_pts_grp1-3                 1.18271         0.00992734          119.137                0   
curr_pts_grp4-6                 1.70901         0.0115353          148.154                0   
curr_pts_grp7-9                 2.01774         0.0141287          142.812                0   
curr_pts_grp10-150              2.48111         0.0130278          190.447                0  
```


### Five-point violations (speeding 46-60 over or a handheld device violation)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -14.9563         0.576685         -25.9349         2.69226e-148   
policyTRUE                     -1.08189          1.12106        -0.965057         0.334516   
age_grp16-19                    4.35605         0.576907           7.5507         4.32921e-14   
age_grp20-24                    4.20633          0.57678          7.29278         3.03613e-13   
age_grp25-34                    3.75892         0.576754          6.51737         7.15522e-11   
age_grp35-44                    3.22624         0.576795          5.59338         2.22685e-08   
age_grp45-54                    2.86826         0.576845          4.97233         6.61541e-07   
age_grp55-64                    2.41642         0.577054          4.18752         2.82023e-05   
age_grp65-199                   1.66873         0.577772          2.88821         0.00387443   
curr_pts_grp1-3                 1.18356         0.0099285          119.208                0   
curr_pts_grp4-6                 1.71031         0.0115375          148.239                0   
curr_pts_grp7-9                 2.01955         0.0141312          142.914                0   
curr_pts_grp10-150              2.48049         0.0130321          190.336                0   
policyTRUE:age_grp16-19        0.631164          1.12132         0.562878         0.573518   
policyTRUE:age_grp20-24         0.47947          1.12118         0.427648         0.668908   
policyTRUE:age_grp25-34        0.408643          1.12116         0.364483         0.715497   
policyTRUE:age_grp35-44         0.40429          1.12122         0.360579         0.718414   
policyTRUE:age_grp45-54        0.344859           1.1213         0.307553         0.758422   
policyTRUE:age_grp55-64        0.376521          1.12159         0.335704         0.737094   
policyTRUE:age_grp65-199       0.384355          1.12257         0.342388         0.732059  
```


### Seven-point violations (speeding 61-80 over or combinations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -16.4267         0.985164          -16.674         2.0241e-62   
policyTRUE                    -0.732372         0.0192861         -37.9741                0   
age_grp16-19                     4.6377         0.985425          4.70629         2.52265e-06   
age_grp20-24                    4.23535          0.98531          4.29849         1.71964e-05   
age_grp25-34                    3.53184         0.985291          3.58457         0.000337638   
age_grp35-44                    2.63273         0.985482          2.67151         0.00755107   
age_grp45-54                    1.92855         0.985828          1.95628         0.0504326   
age_grp55-64                    1.17278         0.987277          1.18789         0.234875   
age_grp65-199                   0.12119         0.993546         0.121977         0.902917   
curr_pts_grp1-3                 1.09955         0.0251162          43.7784                0   
curr_pts_grp4-6                 1.65704         0.0283338          58.4827                0   
curr_pts_grp7-9                 2.04936         0.0329532          62.1898                0   
curr_pts_grp10-150              2.75223         0.0276986          99.3636                0  
```


### Seven-point violations (speeding 61-80 over or combinations)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -16.0398          1.00002         -16.0395         6.76776e-58   
policyTRUE                     -7.22603           22.686        -0.318524         0.750088   
age_grp16-19                    4.20999          1.00046          4.20805         2.5759e-05   
age_grp20-24                     3.8228          1.00026          3.82181         0.000132477   
age_grp25-34                    3.18365          1.00023          3.18291         0.00145801   
age_grp35-44                    2.25188          1.00052           2.2507         0.0244043   
age_grp45-54                     1.5494          1.00106          1.54777         0.121679   
age_grp55-64                   0.749736          1.00342         0.747178         0.454956   
age_grp65-199                 -0.0166286          1.01015        -0.0164615         0.986866   
curr_pts_grp1-3                 1.10032         0.025119          43.8045                0   
curr_pts_grp4-6                 1.65817         0.0283385          58.5131                0   
curr_pts_grp7-9                 2.05098         0.032959          62.2282                0   
curr_pts_grp10-150              2.75207         0.0277082          99.3233                0   
policyTRUE:age_grp16-19         6.59921          22.6861         0.290893         0.771133   
policyTRUE:age_grp20-24         6.56468           22.686         0.289371         0.772297   
policyTRUE:age_grp25-34         6.37746           22.686         0.281118          0.77862   
policyTRUE:age_grp35-44         6.47443          22.6861         0.285392         0.775343   
policyTRUE:age_grp45-54         6.47052          22.6861         0.285219         0.775476   
policyTRUE:age_grp55-64         6.59045          22.6864         0.290502         0.771432   
policyTRUE:age_grp65-199        5.55979          22.6885         0.245049         0.806418  
```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -12.2916         0.121555          -101.12                0   
policyTRUE                    -0.248993         0.0169881         -14.6569         1.21751e-48   
age_grp16-19                   0.554105         0.123688          4.47986         7.46917e-06   
age_grp20-24                  -0.00855651         0.122956        -0.0695899          0.94452   
age_grp25-34                  -0.700062         0.122733         -5.70393         1.17078e-08   
age_grp35-44                   -1.13063         0.123303         -9.16953         4.75082e-20   
age_grp45-54                   -1.34254         0.123642         -10.8582         1.82213e-27   
age_grp55-64                   -1.54301         0.125261         -12.3183         7.21633e-35   
age_grp65-199                  -1.14027         0.124742         -9.14098         6.18894e-20   
curr_pts_grp1-3                0.799254         0.0219129          36.4742         2.8418e-291   
curr_pts_grp4-6                 1.22956         0.0272755          45.0795                0   
curr_pts_grp7-9                 1.56308         0.0339993           45.974                0   
curr_pts_grp10-150              2.15989         0.0293458          73.6013                0  
```


### All pairs of infractions 9 or over (speeding 81 or more and 10 other offences)


``` 
Variable                      Estimate         Std. Error         z value         Pr(>|z|)     
(Intercept)                    -12.2331         0.156228         -78.3029                0   
policyTRUE                    -0.390033         0.247809         -1.57393         0.115505   
age_grp16-19                   0.509351         0.159573          3.19196         0.00141309   
age_grp20-24                  -0.0626123         0.158372        -0.395351         0.692584   
age_grp25-34                  -0.738127         0.158142         -4.66749         3.04898e-06   
age_grp35-44                   -1.20307         0.159013         -7.56582         3.85429e-14   
age_grp45-54                   -1.39109         0.159541          -8.7193         2.79927e-18   
age_grp55-64                   -1.62905         0.162155         -10.0462         9.54469e-24   
age_grp65-199                  -1.25845         0.161624         -7.78629         6.90035e-15   
curr_pts_grp1-3                0.798862         0.0219123          36.4572         5.28497e-291   
curr_pts_grp4-6                 1.22928         0.0272745          45.0708                0   
curr_pts_grp7-9                 1.56279         0.0339997          45.9647                0   
curr_pts_grp10-150               2.1608         0.0293455          73.6329                0   
policyTRUE:age_grp16-19        0.112411          0.25209         0.445916         0.655658   
policyTRUE:age_grp20-24        0.131265         0.250559         0.523889         0.600356   
policyTRUE:age_grp25-34         0.09613         0.250441         0.383842         0.701095   
policyTRUE:age_grp35-44        0.172221         0.251677         0.684292         0.493791   
policyTRUE:age_grp45-54        0.119666         0.252409         0.474095         0.635432   
policyTRUE:age_grp55-64        0.199067          0.25561         0.778793         0.436102   
policyTRUE:age_grp65-199       0.262857         0.254625          1.03233         0.301916  
```