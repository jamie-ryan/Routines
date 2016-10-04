;calculates non-thermal electron energy
;fitparams = array containing fit params from either results or setup summary txt files
;spectral_index = power law index
;N_e = number of accelerated electrons
;E_c = energy cut off, i.e., all electrons with energy higher than E_c are considered non-thermal (accelerated out of the maxwellian distribution) in erg
;delta_t = time interval in seconds

;fitparams should follow this order...
;thick2
;a[0] - total integrated elctron flux 10^35 electrons per sec
;a[1] - Low delta, index of electron distribution function below break
;a[2] - Break energy (keV) For single power-law electron distr. 
;a[3] - High delta, index of electron distr. function above break
;a[4] - low energy cutoff (keV)
;a[5] - high energy cut off (keV)
function nth_power, fitparams

spectral_index = fitparams[1]
N_e = 1.0e35 * fitparams[0]
E_c = fitparams[4]

P_nth  = (1.6e-9 * ( (spectral_index - 1)  / (spectral_index - 2)) * N_e * E_c ) 


return, P_nth
end
