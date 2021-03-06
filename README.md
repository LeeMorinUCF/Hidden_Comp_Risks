# Hidden_Comp_Risks
A hidden competing risks model for when competing outcomes are partially observed.
In this model, multiple events can occur but only an aggregate (known) function of the events is observed.
This model can be used to separately estimate the probabilities of individual events when particular identification conditions are satisfied.

## Empirical Example

The example dataset contains traffic violations in the Province of Quebec in the years from 1998 to 2010.
The dataset is the complete record of demerit points for the Province of Quebec through those years.
However, the dataset contains only the total number of demerit points awarded at a single roadside stop, not the points for a single violation.
There are no labels for the particular infraction.
The dataset also contains the age and sex of each driver, along with an individual identifier.
The data are aggregated by sex, age_group, demerit point value and recorded daily.
Each aggregate observation for a given point value is weighted by the number of drivers in a particular sex:age_group:point category for a particular day.
These totals are obtained from the SAAQ website [here](http://www.bdso.gouv.qc.ca/pls/ken/ken213_afich_tabl.page_tabl?p_iden_tran=REPERRUNYAW46-44034787356|@}zb&p_lang=2&p_m_o=SAAQ&p_id_ss_domn=718&p_id_raprt=3370).
It is numerically the same as recording 1 or zero with one observation for each licensed driver every day (except that most would be zeros).


On April 1, 2008 (no joke) the SAAQ implemented stiffer penalties on speeding violations, which involved doubling of the demerit points awarded for excessive speeding violations, higher fines and revocation of licenses.
Under this policy change, some violations are associated with different demerit point levels.

The hidden competing risks model can be used to identify the probabilities of the individual violations, when only the sum of the points from the violations are observed.
It is important to separate these events because the doubling of speeding violations affects several individual offences and point balances.
Without separating the individual events, multiple changes affect the incidence of demerit point numbers before and after the policy change, confounding the results of a simple difference-in-difference analysis.
