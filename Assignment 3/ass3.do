clear all
cap log close
log using "122090407.log", replace
cd "/Users/30706/Desktop"
use aghousehold.dta, clear

// Assignment 3
use Rainfall.dta, clear
sort vl_id
drop if missing(av_rain)
tostring vl_id, replace
save Rainfall.dta, replace

use aghousehold.dta, clear
sort vl_id
drop if missing(rental_out_share) | missing(ln_yield)
merge m:1 vl_id using Rainfall.dta
save aghousehold.dta, replace

reg rental_out_share av_rain
predict hat_rental_out_share, xb
outreg2 using first_stage_result.doc, replace

reg ln_yield hat_rental_out_share
outreg2 using second_stage_result.doc, replace

ivregress 2sls ln_yield (rental_out_share = av_rain)
outreg2 using ivregress_result.doc, replace
save aghousehold.dta, replace

use landlaw.dta
sort vl_id2
save landlaw.dta, replace
use aghousehold.dta
gen vl_id2 = substr(vl_id, 1, 2)
sort vl_id2
drop _merge
merge m:1 vl_id2 using landlaw.dta
ivregress 2sls ln_yield (rental_out_share = av_rain implemented)

// relevance test
reg rental_out_share av_rain implemented

// exogenous test
reg ln_yield rental_out_share
predict res, residuals
reg res av_rain implemented

save aghousehold.dta, replace
log close