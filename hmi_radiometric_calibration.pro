pro hmi_radiometric_calibration, array, header

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
texp = header.obs_time???? ; exposure time in seconds
array = array/texp ; = DN/s


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
area_on_sun =  (0.504*7.25e7)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN/s.cm^2] / [(DN/e-)*(e-/photon)] = photon/s.cm^2
aia_gain =  1./17.7. ;(DN/e-) set by ADC....see pg 19, table 6 Initial Calibration of the Atmospheric Imaging 
		     ;Assembly(AIA) on the Solar Dynamics Observatory (SDO)

hmi_gain_front_cam = [16.27,15.45,15.91,15.91] ;from top left to bottom right, shows the gain of each quadrant of the front camera ccd

hmi_gain_side_cam = [16.10,16.93,15.83,16.27] ;from top left to bottom right, shows the gain of each quadrant of the side camera ccd

quantum_efficiency = 0.75;(e-/photon) property of the ccd material taken from ccd product data sheet

gain = avg(hmi_gain_front_cam)

array = array/(gain*quantum_efficiency) ; = photon/s.cm^2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
h = 6.626e-34 ;planck's constant
c = 2.998e8 ;speed of light m/s
lambda = 6173.e-10 ;wavelength in metres
erg = 1.e-7 ; erg in joules
E_photon = (array*(h*c/lambda))/erg ; = photon/erg
array = array/E_photon ; = erg/s.cm^2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
transmittance_low = 1.15 ; low estimate from couvidat instrument paper
transmittance_med = 1.35 ; med estimate from couvidat instrument paper
transmittance_high = 2. ;high estimate from couvidat instrument paper
transmittance_avg = (transmittance_low + transmittance_med + transmittance_high)/3 ;average transmittance
area = !pi*14.^2 ; pi.r^2...r = radius of aperture
effective_area = area*(transmittance_avg/100.) ;area multiplied by relative transmittance gives effective area???
D = 1.49e13 ; 1AU in cm 
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = 76.e-3 ;76mÅ pg 11 hmi instrument paper
array = array/band_pass ; = erg/s.cm^2.sr.Å

end






