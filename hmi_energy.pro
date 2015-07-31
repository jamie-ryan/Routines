function hmi_energy, array, lambda, temp, obs_angle, f1 = f1, f2 = f2, f3=f3

;f1 = planck 
;f2 = Planck_Radiance.pro
;f3 = based on Neckel & Labs atlas at disk center at 6173 A: 3.15e6 erg/s/cm^2/sr/A  = default

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Energy per second from blackbody  erg/s/cm^2/sr/A 
;Effective Temp = T = 5777 K
;sun-SDO distance = sun_sdo = = 36.0e6m = 36.0e8cm
;spectral resolution (fwhm of the transmission profile)= fwhm = 76 mA
;hmi aperture = 14cm
;pixel solid angle = 0.504*0.504 arcseconds^2 = pixxy = 5.97x10^-12 steradian
;photon energy = Ephot = provided by planck function ergs/s/cm2/A 
;relative intensity [DN/s] = provided by SDO data 

;constants
pixxy = 5.97e-12 ;steradian
fwhm = 76.e-3 ;A
aperture = 14. ;cm
sun_sdo = 36.e8  ;cm
radius = 7.0e10 ;cm
erg = 10.e-7 ;joules
m2cm = 10000. ;m^2 to cm^2
mic2ang = 10.e-4 ;micrometers e-6 to angstroms e-10
sterad = 4*!pi ;solid angle of sphere in steradians
instr = pixxy*fwhm*!pi*aperture^2
rad = 4.84813681e-6 ;1 arcsecond = 4.84813681e-6 radians

;planck1
bbflux = planck(lambda,temp) ;erg/s.cm^2.A
radiance1 = bbflux/sterad ;erg/s.cm^2.A.sr 
energy1 = radiance1*instr ;erg/s
;radiance1 = bbflux*radius^2/pixxy*sun_sdo^2 ;erg/s/cm^2/sr/A 

;planck2
result = Planck_Radiance(lambda, temp, radiance, /wavelength); W/(m2.sr.um)
radiance2 = radiance*((erg)/(m2cm*mic2ang)) ;convert W/(m2.sr.um) to erg/s/cm^2/sr/A 
energy2 = radiance2*instr ;erg/s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Neckel & Labs atlas at disk center at 6173 A: 3.15e6 erg/s/cm^2/sr/A 
;(which is close to the blackbody value)
;compare to disk centre value

;;planck3
radiance3 = 3.15e6 ;erg/s/cm^2/sr/A 
energy2 = radiance3*instr ;erg/s 

;relationship between dn/s and radiance
;dn/s at disc center based on:
;IDL> nnn = n_elements(hmidata[0,0,*])
;IDL> print, nnn
;         160
;IDL> a = total(hmidata[2048.5,2048.5,*])/nnn
;IDL> print, a
;      60245.5
disc_centre_int = 60245.5 
rel1 = radiance1/disc_centre_int 
rel2 = radiance2/disc_centre_int
rel3 = radiance3/disc_centre_int
disc_centre = 0.
theta = disc_centre + obs_angle ;arcseconds
theta = theta*rad ;radians
limb_dark = cos(theta) ;brightest at zero, dimmest at 90

;flux conversion
F1 = array*limb_dark*rel1
F2 = array*limb_dark*rel2
F3 = array*limb_dark*rel3

if keyword_set(f1) then begin
return, F1
endif

if keyword_set(f2) then begin
return, F2
endif

if keyword_set(f3) then begin
return, F3
endif

end
