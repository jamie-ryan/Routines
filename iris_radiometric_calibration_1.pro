pro iris_radiometric_calibration_1, wave = wave, sg = sg, sji = sji



if keyword_set(sg) then begin
	
	if then begin
	
	endif

	x = n_elements(wave) ;is data over a single wavelength or a wavelength range?
	switch x of
	1: begin ;single wavelength
	 
	end
	2: begin ;wavelength range
	end
	
endif

if keyword_set(sji) then begin
endif





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
texp = 8.0000496
array = array/texp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
area_on_sun =  (0.16635000*7.25e7)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2   					


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN/s.cm^2] to photon/s.cm^2
array = array*dn2photon; = photon/s.cm^2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
h = !const.h  ; planck's constant
c = !const.c; speed of light m/s
lambda = wave*1.e-10 ;wavelength in metres if wave is in angstroms
erg = 1.e-7 ; erg in joules
E_photon = (h*c)/lambda ; photon energy at 6173 angstroms
n_photon = E_photon/erg ; = photon/erg
array = array/n_photon ; = erg/s.cm^2    


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
A = iresp.AREA_SJI[ind1,n]
effective_area = A[0]
D = 1.49e13 ; 1AU in cm 
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = pixlambda ;equivalent width of 6173Å continuum
fout = array/band_pass ; = erg/s.cm^2.sr.Å					
eout = fout*texp*n_pixels*area_on_sun*effective_solid_angle*band_pass		  				
			




end
