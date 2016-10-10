pro rhessi_FULLDISC_SPECTRA_fulldisc_energy_calculations_29_mar_14

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;FULL DISC;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;time interval
;timg = 16.0 ;secs
timp = 100. ;secs

;area of non thermal electron beam
abeam = 6.61e16 ;cm^2

p_fulldisc = fltarr(3)
pe_fulldisc = fltarr(3)
pp_fulldisc = fltarr(3)


time_ints = strarr(2,3)

time_ints[0,0] = '29-Mar-2014 17:46:18'
time_ints[0,1] = '29-Mar-2014 17:46:50'
time_ints[0,2] = '29-Mar-2014 17:47:06'

time_ints[1,0] = '17:46:34'
time_ints[1,1] = '17:47:06'
time_ints[1,2] = '17:47:22'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;nth ribbon
fitparams_174618_174634_fulldisc = [89.5691, 9.86309, 41.4275, 3.51006, 18.5561, 32000]
fitparams_174650_174706_fulldisc = [73.1942, 10.6059, 40.613, 3.51786, 19.5572, 32000]
fitparams_174706_174722_fulldisc = [82.8712, 10.6553, 40.8361, 3.60796, 19.3356, 32000]

;non thermal energies
P_174618_174634_fulldisc = nth_power(fitparams_174618_174634_fulldisc)
P_fulldisc[0] = P_174618_174634_fulldisc
P_174650_174706_fulldisc = nth_power(fitparams_174650_174706_fulldisc)
P_fulldisc[1] = P_174650_174706_fulldisc
P_174706_174722_fulldisc = nth_power(fitparams_174706_174722_fulldisc)
P_fulldisc[2] = P_174706_174722_fulldisc

;momentum  e_fulldisc, fitparams, tau, timg, abeam
pe_174618_174634_fulldisc = nth_momentum_e(P_174618_174634_fulldisc,fitparams_174618_174634_fulldisc, timp, abeam)
pe_fulldisc[0] = pe_174618_174634_fulldisc
pp_174618_174634_fulldisc = nth_momentum_p(pe_174618_174634_fulldisc)
pp_fulldisc[0] = pp_174618_174634_fulldisc

pe_174650_174706_fulldisc = nth_momentum_e(P_174650_174706_fulldisc,fitparams_174650_174706_fulldisc, timp, abeam)
pe_fulldisc[1] = pe_174650_174706_fulldisc
pp_174650_174706_fulldisc = nth_momentum_p(pe_174650_174706_fulldisc)
pp_fulldisc[1] = pp_174650_174706_fulldisc

pe_174706_174722_fulldisc = nth_momentum_e(P_174706_174722_fulldisc,fitparams_174706_174722_fulldisc, timp, abeam)
pe_fulldisc[2] = pe_174706_174722_fulldisc
pp_174706_174722_fulldisc = nth_momentum_p(pe_174706_174722_fulldisc)
pp_fulldisc[2] = pp_174706_174722_fulldisc



dir = '/unsafe/jsr2/rhessi-spectra-Sep14-2016/'
savf = dir+'29_mar_14_fulldisc_hxr_energies_momenta.sav'
save, /variables, filename = savf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end