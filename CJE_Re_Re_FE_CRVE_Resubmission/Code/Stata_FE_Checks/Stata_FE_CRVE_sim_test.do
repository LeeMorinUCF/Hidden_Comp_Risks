/*******************************************************************************
 *
 * Stata_FE_CRVE_sim_test.do
 * verifies the calculation of fixed effects regressions
 * with cluster-robust standard errors
 * for a simulated sample of drivers.
 *
 * Lee Morin, Ph.D.
 * Assistant Professor
 * Department of Economics
 * College of Business
 * University of Central Florida
 *
 * August 3, 2021
 *
 *******************************************************************************
*/

/*******************************************************************************
 * Prepare workspace
 *******************************************************************************
*/


* Declare log file and close any open log file.
capture log close
log using Stata_FE_CRVE_sim_test.log, replace

* Clear memory.
clear all

/*******************************************************************************
 * Load Data
 *******************************************************************************
*/


* Import dataset.
import delimited using Stata_FE_CRVE_sim_data.csv , delimiters(",")
* Dataset has the following variables:
* check_var_names <- c('date_stata', 'seq', 'age_grp', 'curr_pts_grp',
*                      'policy_int', 'events_int')


/*******************************************************************************
 * Inspect data
 *******************************************************************************
*/

* Determine variable types.
foreach var of varlist _all {
  display " `var' "  _col(20) "`: type `var''"
}


* Integers.
summarize(seq)

* Binary variables (as integers).
summarize(events_int)
tabulate(events_int)
summarize(policy_int)
tabulate(policy_int)

* Categorical variables.
summarize(curr_pts_grp)
tabulate(curr_pts_grp)
summarize(age_grp)
tabulate(age_grp)

* Generate new categorical variables.
encode curr_pts_grp, generate(curr_pts_grp_cat)
encode age_grp, generate(age_grp_cat)

tabulate(curr_pts_grp_cat)
tabulate(age_grp_cat)


* Verify new variable types.
* For loops look so rudimentary in Stata:
foreach var of varlist _all {
  display " `var' "  _col(20) "`: type `var''"
}


/*******************************************************************************
 * Set variables for panel data
 *******************************************************************************
*/

* Date is in a string format.
* Must be converted to a date format.
generate xtdate = date(date_stata,"DMY")
format xtdate %tCDDmonCCYY

* Declare time and id variables.
xtset seq xtdate


/*******************************************************************************
 * Estimate Model
 * Fixed effect regression with cluster-robust standard errors
 *******************************************************************************
*/

* Run with cluster-robust standard errors, clustered on the driver ID.
xtreg events_int i.curr_pts_grp_cat##policy_int, fe vce(cluster seq)


/*******************************************************************************
 * Closing arguments
 *******************************************************************************
*/

* Closing arguments.
log close

/*******************************************************************************
 * End Stata_FE_CRVE_sim_test.do
 *******************************************************************************
*/
