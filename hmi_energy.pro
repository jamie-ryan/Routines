pro hmi_energy, array, lambda, temp

;Such a conversion factor depends on the CCD gains, the CCD quantum efficiency, the filter transmission profile widths, the transmittance of the various optical filter elements etc... I can do a quick back of the envelope calculation: If the intensity on a hmi.lev1 pixel is, say 10000 DNs, then using the CCD average reverse gain of 15.885 and the exposure time of 0.12s means that the number of photo-electrons produced  at that pixel on the CCD during the exposure time is: 10000/0.12/15.882=5247 photo-electrons. I believe the quantum efficiency of HMI CCDs (which depends on the temperature) is roughly 0.75. Therefore, that means that the specific pixel we are looking at received roughly 5247/0.75=6996 photons during exposure. So, 6996 photons hit the CCD pixel to result in 10000 DN. Assuming a HMI throughput of 2% (i.e. only 2% of photons hitting the front window reach the CCD, that's only a guess based on the exposure time required and may be widely off mark), that means that 6995/0.02=349802 photons entered HMI on the path to that specific pixel. Since a HMI pixel represents 0.504", and the photons are at the 6173 A wavelength, you can deduce the energy corresponding to the 10000 DN measured on hmi.lev1. However, as you can see, it is really just a back of the envelope calculation.

;A more precise conversion factor can be obtained by computing the energy/second expected from a blackbody with effective temperature Teff set to the solar surface temperature and at a wavelength of 6173 A, and then use the Sun-SDO distance and HMI CCD pixel size to see how this energy relates to the DNs. Using the Planck's equation for a blackbody with Teff=5777 K, I get that the solar radiance at 6173 A is: 2.39348x10^6 erg/s/cm^2/sr/A The FWHM of the HMI filter transmission profiles is about 76 mA, the HMI aperture is 14 cm (each pixel on the CCD receives light rays that come from this 14 cm front window), and a HMI pixel corresponds to a solid angle of 0.504*0.504 arcsecond^2, so 5.97x10^-12 steradian. Therefore, a HMI pixel should receive (for the 76 mA passband outside the instrument): 2.3948x10^6 * 5.97x10^-12 *0.076 * 3.14159*14.^2 = 0.00066874155 erg/s If you take the intensity per pixel on a pixel at disk center of a  hmi.lev1 record, you can convert from DNs to erg/s. Does that make sense? Sorry, I'm bad with these radiance calculations... Also, I'm not sure whether using the FWHM of the filter transmission profile is the right thing to do, or if I'm supposed to compute some equivalent width?

;Another solution I can think of is to take the value provided in the Neckel & Labs atlas at disk center at 6173 A: 3.15d6 erg/s/cm^2/sr/A (which is close to the blackbody value) and compare this to the disk center intensity of HMI in DNs. 


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
h = 6.626e-34 ;planck's constant
c = 2.998e8;speed of light
radius = 7.0e10 ;cm
erg = 10.e-7 ;joules
m2cm = 10000. ;m^2 to cm^2
mic2ang = 10.e-4;micrometers e-6 to angstroms e-10
sterad = 4*!pi ;solid angle of sphere in steradians
instr = pixxy*fwhm*!pi*aperture^2

;planck1
bbflux = planck(lambda,temp) ;erg/s.cm^2.A
radiance1 = bbflux/sterad ;erg/s.cm^2.A.sr 
energy1 = radiance1*instr ;erg/s
;radiance1 = bbflux*radius^2/pixxy*sun_sdo^2 ;erg/s/cm^2/sr/A 

;planck2
result = Planck_Radiance(( lambda, temp, radiance, /wavelength )); W/(m2.sr.um)
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
disc_centre = ;dn/s
rel1 = radiance1/disc_centre
rel2 = radiance2/disc_centre
rel3 = radiance3/disc_centre
limb_dark = 

;flux conversion
F1 = array*limb_dark*rel1
F2 = array*limb_dark*rel2
F3 = array*limb_dark*rel3




end
