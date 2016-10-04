pro rhessi_IMAGING_SPECTRA_nth_power_calculations_29_mar_14

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;IMAGING SPECTROSCOPY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;time interval
;timg = 16.0 ;secs
timp = 100. ;secs

;area of non thermal electron beam
abeam = 6.61e16

P_north = fltarr(3) ;power
pe_north = fltarr(3) ;electron momentum
pp_north = fltarr(3) ;proton momentum


P_south = fltarr(3)
pe_south = fltarr(3)
pp_south = fltarr(3)
time_ints = strarr(2,3)

time_ints[0,0] = '29-Mar-2014 17:46:18'
time_ints[0,1] = '29-Mar-2014 17:46:50'
time_ints[0,2] = '29-Mar-2014 17:47:06'

time_ints[1,0] = '17:46:34'
time_ints[1,1] = '17:47:06'
time_ints[1,2] = '17:47:22'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nth ribbon
fitparams_174618_174634_nth = [0.434686, 3.55041, 345.374, 12.8685, 22.1739, 32000.0]
fitparams_174650_174706_nth = [0.375598, 3.58079, 1080.85, 14.9101, 23.9414, 32000.0]
fitparams_174706_174722_nth = [0.221209, 3.06198, 275.558, 18.8356, 21.2422, 32000.0]

;non thermal energies
P_174618_174634_nth = nth_power(fitparams_174618_174634_nth)
P_north[0] = P_174618_174634_nth
P_174650_174706_nth = nth_power(fitparams_174650_174706_nth)
P_north[1] = P_174650_174706_nth
P_174706_174722_nth = nth_power(fitparams_174706_174722_nth)
P_north[2] = P_174706_174722_nth

;momentum  e_nth, fitparams, tau, abeam
pe_174618_174634_nth = nth_momentum_e(P_174618_174634_nth,fitparams_174618_174634_nth, timp, abeam)
pe_north[0] = pe_174618_174634_nth
pp_174618_174634_nth = nth_momentum_p(pe_174618_174634_nth)
pp_north[0] = pp_174618_174634_nth

pe_174650_174706_nth = nth_momentum_e(P_174650_174706_nth,fitparams_174650_174706_nth, timp, abeam)
pe_north[1] = pe_174650_174706_nth
pp_174650_174706_nth = nth_momentum_p(pe_174650_174706_nth)
pp_north[1] = pp_174650_174706_nth

pe_174706_174722_nth = nth_momentum_e(P_174706_174722_nth,fitparams_174706_174722_nth, timp, abeam)
pe_north[2] = pe_174706_174722_nth
pp_174706_174722_nth = nth_momentum_p(pe_174706_174722_nth)
pp_north[2] = pp_174706_174722_nth

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sth ribbon
fitparams_174618_174634_sth = [1.6461, 3.71534, 35323.7, 11.5112, 17.8858, 32000]
fitparams_174650_174706_sth = [1.72857, 3.84761, 35323.7, 8.46896, 15.6627, 32000]
fitparams_174706_174722_sth = [2.69522, 4.11943, 35323.7, 7.66625, 16.8909, 32000]

;non thermal energies
P_174618_174634_sth = nth_power(fitparams_174618_174634_sth)
P_south[0] = P_174618_174634_sth
P_174650_174706_sth = nth_power(fitparams_174650_174706_sth)
P_south[1] = P_174650_174706_sth
P_174706_174722_sth = nth_power(fitparams_174706_174722_sth)
P_south[2] = P_174706_174722_sth

;momentum
pe_174618_174634_sth = nth_momentum_e(P_174618_174634_sth,fitparams_174618_174634_sth, timp, abeam)
pe_south[0] = pe_174618_174634_sth
pp_174618_174634_sth = nth_momentum_p(pe_174618_174634_sth)
pp_south[0] = pp_174618_174634_sth

pe_174650_174706_sth = nth_momentum_e(P_174650_174706_sth, fitparams_174650_174706_sth,timp, abeam)
pe_south[1] = pe_174650_174706_sth
pp_174650_174706_sth = nth_momentum_p(pe_174650_174706_sth)
pp_south[1] = pp_174650_174706_sth

pe_174706_174722_sth = nth_momentum_e(P_174706_174722_sth,fitparams_174706_174722_sth, timp, abeam)
pe_south[2] = pe_174706_174722_sth
pp_174706_174722_sth = nth_momentum_p(pe_174706_174722_sth)
pp_south[2] = pp_174706_174722_sth

dir = '/unsafe/jsr2/rhessi-spectra-Sep14-2016/'
savf = dir+'29_mar_14_imaging_hxr_energies_momenta.sav'
save, /variables, filename = savf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end
