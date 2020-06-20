# Exact linear regression model. 

library(elrm)

data("diabDat")



simDiab.elrm <- elrm(IA2A/n ~ gender + age + nDQ2 + nDQ8 + nDQ6.2 +
                       age:nDQ2 + age:nDQ8 + age:nDQ6.2, interest = ~age:nDQ6.2 + nDQ6.2,
                     iter = 100000, burnIn = 500, dataset = diabDat)






