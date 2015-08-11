pro hmi_radiometric_calibration, array, header

;;;[DN] / [texp] = DN/s
texp = header.obs_time???? ; exposure time in seconds
array = array/texp ; = DN/s


;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
area_on_sun =  (0.504*7.25e7)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2


;;;[DN/s.cm^2] / [(DN/e-)*(e-/photon)] = photon/s.cm^2
gain = ;(DN/e-) set by ADC
quantum_efficiency = ;(e-/photon) propertie of the ccd material
array = array/(gain*quantum_efficiency) ; = photon/s.cm^2


;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
h = 6.626e-34 ;planck's constant
c = 2.998e8 ;speed of light m/s
lambda = 6173.e-10 ;wavelength in metres
erg = 1.e-7 ; erg in joules
E_photon = (array*(h*c/lambda))/erg ; = photon/erg
array = array/E_photon ; = erg/s.cm^2


;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
effective_area = ; from instrument paper, includes information about optical path through instrument of captured light
D = 1.49e13 ; 1AU in cm 
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr


;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = 76.e-3 ;76mÅ 
array = array/band_pass ; = erg/s.cm^2.sr.Å

end
