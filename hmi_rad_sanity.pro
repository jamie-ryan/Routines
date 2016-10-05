;hmi radiometric calibration sanity check
visiblewidth = (7500. - 3800.)/76.e-3 ;in angstroms
sradius = 0.;sdo qk radius [in pixels]
snp = (sradius + 1)*(sradius + 1)
array = out_dat[2000,2000,*]
array = reform(array)
hmi_radiometric_calibration, array*visiblewidth, n_pixels = snp, f, e, pow, f_err , e_err
pix_length = 0.6 ;arcsec
cm_per_arcsec = 725.e7 ;cm

;convert to erg/s.cm^2.sr.Å for 6173 from one HMI pixel... original number is calculated for the sunquake area
center_disc_flux_6173 = ((f/asqk)*((pix_length*cm_per_arcsec)^2))/visiblewidth ;;erg/s.cm^2.sr.Å
print, min(center_disc_flux_6173), max(center_disc_flux_6173)
;  6.14512e+07  7.09709e+07

;Using the Planck's equation for a blackbody with Teff=5777 K, I get that the solar radiance at 6173 A is:
;2.39348x10^6 erg/s/cm^2/sr/A

;Another solution I can think of is to take the value provided in the Neckel & Labs atlas at disk center at 6173 A: 3.15d6 erg/s/cm^2/sr/A (which is close to the blackbody value)
;and compare this to the disk center intensity of HMI in DNs.


;THEREFORE, my calibration code is around an order of magnitude to large.
 



