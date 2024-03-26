clear all

//check which directory
cd 

//import raw data and store as input
import delimited "0_raw\gen_ai_earnings.csv"
save "1_input\gen_ai_earnings.dta", replace

//data management
clear all
use "1_input\gen_ai_earnings.dta", replace

gen earnings_scaled = earnings / 10
drop if earnings_scaled<0

save "2_process\gen_ai_earnings.dta", replace

//analysis
clear all
use "2_process\gen_ai_earnings.dta"

eststo: regress earnings_scaled gen_ai, r

esttab using "3_output\Table 1.rtf", ///
replace stats(r2 F p df_m N) b(3) aux(se 3) star(* 0.10 ** 0.05 *** 0.01) obslast onecell nogaps ///
compress title(TABLE 1 - REGRESSIONS OF SCALED EARNINGS ON GENERATIVE AI) addnotes(p-levels are two-tailed, * p < 0.10, ** p < 0.05, *** p < 0.01; the numbers within the round parentheses are robust standard errors.) nonotes
eststo clear

exit, STATA clear