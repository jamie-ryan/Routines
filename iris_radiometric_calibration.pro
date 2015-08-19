;+
; NAME:
;       iris_flux_energy   
; PURPOSE: 
;       To convert IRIS observations from DN/pixel to erg/s/cm^(-2)/angstrom/sr
;
; CALLING SEQUENCE: 
;       iris_flux_energy, array, wave = [wave], n_pixels = n_pixels, fout, eout, /sji or /sg 
;
; INPUT PARAMETERS: 
;       array   	the IRIS data array, slit-jaw or or spectrograph
;       wave		= [lambda1, lambda2] or = lambda the wavelength range of the data contained 
;			in the array in angstroms. If there is a wavelength range, function calculates
;			average based on each iresp.wav increment  
;	n_pixels	= the number of pixels....used to calculate area on sun	
;	/sji		for slit-jaw data
;	/sg		for spectrograph data
;
; OUTPUT PARAMETERS:
;       Fout		a fluxarray containing intensity data in units of erg/s/cm^(-2)/angstrom/sr
;       Eout		a fluxarray containing intensity data in units of erg/s        
;
; EXAMPLES:
;       
; PROCEDURE:
;       
; NOTES:
;       
; MODIFICATION HISTORY:
;       Written 03/06/15 by Jamie Ryan
pro iris_radiometric_calibration, array, wave = wave, n_pixels = n_pixels, fout, eout, sg = sg, sji = sji




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Grab iris response
iresp = iris_get_response('2014-03-29T14:10:17.030',version='003')

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
texp = 8.0000496
array = array/texp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
area_on_sun =  (0.16635000*7.25e7)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2   		


;spectral scale pixel in angstroms....nuv = 2796, 2832.....fuv = 1330, 1400
pixfuv = 12.8e-3
pixnuv = 25.6e-3
if (max(wave) lt 1500.) then pixlambda = pixfuv else pixlambda = pixnuv



h = !const.h  ; planck's constant
c = !const.c; speed of light m/s
lambda = wave*1.e-10 ;wavelength in metres if wave is in angstroms
erg = 1.e-7 ; erg in joules
wav = wave/10.


;spectrograph
if keyword_set(sg) then begin
	if (pixlambda eq pixfuv) then n = 0 else n = 1	

		;switch to set single wavelength or range
		x = n_elements(wave)
		switch x of
			1: begin ;single wavelength
				find =  min(abs(iresp.lambda[*] - wav[0]), ind1)
				A = iresp.AREA_SG[ind1,n]
				A_float = A[0]
				dn2ph = iresp.DN2PHOT_SG[n]
				dn2photon = dn2ph[0]
				E_photon = (h*c)/lambda ; photon energy 
				n_photon = E_photon/erg ; = photon/erg
			end
			2: begin ;wavelength range
				find1 = min(abs(iresp.lambda[*] - wav[0]),ind1)
				find2 = min(abs(iresp.lambda[*] - wav[1]),ind2)
				ind1 = ind1*1.
				ind2 = ind2*1.
				A_float = total(iresp.AREA_SG[ind1:ind2,n])/(ind2-ind1+1)
				dn2ph = iresp.DN2PHOT_SG[n]
				dn2photon = dn2ph[0]
				E_phot = (h*c)/lambda ; photon energy 
				E_photon = total(E_phot)/n_elements(E_phot)
				n_photon = E_photon/erg ; = photon/erg
			end
		endswitch
	
endif


;slit jaw
if keyword_set(sji) then begin
	find =  min(abs(iresp.lambda[*] - wav[0]), ind1)
	wavint = wave/10
	wavstr = string(wavint, format = "(I0)")
	n = where(iresp.name_sji eq wavstr)
	A = iresp.AREA_SJI[ind1,n]
	A_float = A[0]
	E_photon = (h*c)/lambda ; photon energy
	n_photon = E_photon/erg ; = photon/erg
	dn2ph = iresp.DN2PHOT_SJI[n]
	dn2photon = dn2ph[0]
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
array = array/n_photon ; = erg/s.cm^2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN/s.cm^2] to photon/s.cm^2
array = array*dn2photon; = photon/s.cm^2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
D = 1.49e13 ; 1AU in cm 
Wslit = !pi/(180.*3600.*3.) ;slit width
effective_area = A_float*wslit*1d
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
fout = array/pixlambda ; = erg/s.cm^2.sr.Å					
eout = fout*texp*n_pixels*area_on_sun*effective_solid_angle*pixlambda		  				

end
