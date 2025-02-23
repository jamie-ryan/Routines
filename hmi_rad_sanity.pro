;hmi radiometric calibration sanity check
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')

;read_sdo, files, out_ind, out_dat
aia_prep, files,-1, out_ind, out_dat, /despike

;visiblewidth = (6900. - 4400.)/76.e-3 ;in angstroms
visiblewidth = (7000. - 4800.)*1.0e2 ;in angstroms
array = out_dat[2000,2000,*]
array = reform(array)
hmi_radiometric_calibration, array*visiblewidth, n_pixels = 1, f, e, pow, f_err , e_err
hmi_radiometric_calibration, array, n_pixels = 1, f6173, e6173, pow6173, f_err , e_err
pix_length = 0.6 ;arcsec
cm_per_arcsec = 725.e7 ;cm
asqk = 2.6e16 ;cm^2
;convert to erg/s.cm^2.sr.Å for 6173 from one HMI pixel... original number is calculated for the sunquake area
center_disc_flux_6173 = ((f6173/asqk)*((pix_length*cm_per_arcsec)^2))/visible ;;erg/s.cm^2.sr.Å
print, min(center_disc_flux_6173), max(center_disc_flux_6173)
;5.17215e+06  5.97338e+06 erg/s/cm^2/sr/A


;Using the Planck's equation for a blackbody with Teff=5777 K, I get that the solar radiance at 6173 A is:
;2.39348x10^6 erg/s/cm^2/sr/A

;Another solution I can think of is to take the value provided in the Neckel & Labs atlas at disk center at 6173 A: 
;3.15d6 erg/s/cm^2/sr/A 



 



