pro rhessi_IMAGING_SPECTRA_nth_energy_calculations_29_mar_14

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;IMAGING SPECTROSCOPY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;time interval
timg = 16.0 ;secs
timp = 100. ;secs

;area of non thermal electron beam
abeam = 6.61e16

e_north = fltarr(3)
pe_north = fltarr(3)
pp_north = fltarr(3)


e_south = fltarr(3)
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
E_174618_174634_nth = nth_energy(fitparams_174618_174634_nth, timg)
e_north[0] = E_174618_174634_nth
E_174650_174706_nth = nth_energy(fitparams_174650_174706_nth, timg)
e_north[1] = E_174650_174706_nth
E_174706_174722_nth = nth_energy(fitparams_174706_174722_nth, timg)
e_north[2] = E_174706_174722_nth

;momentum  e_nth, fitparams, tau, timg, abeam
pe_174618_174634_nth = nth_momentum_e(E_174618_174634_nth,fitparams_174618_174634_nth, timp, timg, abeam)
pe_north[0] = pe_174618_174634_nth
pp_174618_174634_nth = nth_momentum_p(pe_174618_174634_nth)
pp_north[0] = pp_174618_174634_nth

pe_174650_174706_nth = nth_momentum_e(E_174650_174706_nth,fitparams_174650_174706_nth, timp, timg, abeam)
pe_north[1] = pe_174650_174706_nth
pp_174650_174706_nth = nth_momentum_p(pe_174650_174706_nth)
pp_north[1] = pp_174650_174706_nth

pe_174706_174722_nth = nth_momentum_e(E_174706_174722_nth,fitparams_174706_174722_nth, timp, timg, abeam)
pe_north[2] = pe_174706_174722_nth
pp_174706_174722_nth = nth_momentum_p(pe_174706_174722_nth)
pp_north[2] = pp_174706_174722_nth

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;sth ribbon
fitparams_174618_174634_sth = [1.6461, 3.71534, 35323.7, 11.5112, 17.8858, 32000]
fitparams_174650_174706_sth = [1.72857, 3.84761, 35323.7, 8.46896, 15.6627, 32000]
fitparams_174706_174722_sth = [2.69522, 4.11943, 35323.7, 7.66625, 16.8909, 32000]

;non thermal energies
E_174618_174634_sth = nth_energy(fitparams_174618_174634_sth, timg)
e_south[0] = E_174618_174634_sth
E_174650_174706_sth = nth_energy(fitparams_174650_174706_sth, timg)
e_south[1] = E_174650_174706_sth
E_174706_174722_sth = nth_energy(fitparams_174706_174722_sth, timg)
e_south[2] = E_174706_174722_sth

;momentum
pe_174618_174634_sth = nth_momentum_e(E_174618_174634_sth,fitparams_174618_174634_sth, timp, timg, abeam)
pe_south[0] = pe_174618_174634_sth
pp_174618_174634_sth = nth_momentum_p(pe_174618_174634_sth)
pp_south[0] = pp_174618_174634_sth

pe_174650_174706_sth = nth_momentum_e(E_174650_174706_sth, fitparams_174650_174706_sth,timp, timg, abeam)
pe_south[1] = pe_174650_174706_sth
pp_174650_174706_sth = nth_momentum_p(pe_174650_174706_sth)
pp_south[1] = pp_174650_174706_sth

pe_174706_174722_sth = nth_momentum_e(E_174706_174722_sth,fitparams_174706_174722_sth, timp, timg, abeam)
pe_south[2] = pe_174706_174722_sth
pp_174706_174722_sth = nth_momentum_p(pe_174706_174722_sth)
pp_south[2] = pp_174706_174722_sth

dir = '/unsafe/jsr2/rhessi-spectra-Sep14-2016/'
savf = dir+'29_mar_14_hxr_energies_momenta.sav'
save, /variables, filename = savf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end
