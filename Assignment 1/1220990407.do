clear all

cap log close
log using "122090407.log", replace
cd "/Users/30706/Desktop/GPA/ECO3121/Assignments/1"

use aghousehold, clear

//Assignment 1
keep if year == 2010

gen yield = d32/d31
gen rental_in = c10
gen rental_out = c13

//sum yield
//sum rental_in
//sum rental_out

reg yield rental_in
predict hat_yield_1
predict res_yield_1, residuals
//sum res_yield_1

reg yield rental_out
predict hat_yield_2
predict res_yield_2, residuals
//sum res_yield_2

gen rental_in_share = 100*rental_in/d31
gen rental_out_share = 100*rental_out/d31
reg yield rental_in_share
reg yield rental_out_share

gen ln_yield = log(yield+1)
reg ln_yield rental_in_share
reg ln_yield rental_out_share


log close