function energy_func, Fluxarray, wave, sji, pixnum
;+
; NAME:
;       energy_func()   
; PURPOSE: 
;       To convert IRIS data in flux units of erg/s/cm^(-2)/angstrom/sr to energy in erg
;
; CALLING SEQUENCE: 
;       E = energy_func( fluxarray, wavelength, sji) 
;
; INPUT PARAMETERS: 
;       fluxarray   the fluxarray returned by the function flux_func
;       wave    the wavelength of the data contained in the array in angstroms
;		eg, 1400 or 2796 or 2832	
;	sji	sji stands for slit-jaw image...set to 1 for yes and 0 for no	
;
; OUTPUT PARAMETERS:
;       E	an energyarray containing intensity data in units of erg
;               
;
; EXAMPLES:
;       
; PROCEDURE:
;       
; NOTES:
;       
; MODIFICATION HISTORY:
;       Written 03/06/15
;-
nnn = n_elements(Fluxarray)

iresp = iris_get_response('2014-03-29T14:10:17.030',version='003')
if (wave eq 1400) then lambda = 1.4e-7 else $

if (wave eq 2796) then lambda = 2.796e-7 else lambda = 2.832e-7 





;spatial pixel in radians
pixxy = 0.16635000*(!pi/(180.*3600.*6. )) 

;spectral scale pixel in angstroms....nuv = 2796, 2832.....fuv = 1330, 1400
pixfuv = 12.8e-3
pixnuv = 25.6e-3
if (wave eq 1400) then pixlambda = pixfuv else pixlambda = pixnuv


;slit width
Wslit = !pi/(180.*3600.*3.)

;exposure time
texp = 8.0000496


if (sji eq 1) then begin
	if (wave eq 1400) then n = 1 else $
	if (wave eq 2796) then n = 2 else n = 3 
	A = iresp.AREA_SJI[n]
	;energy in erg.cm^2
	E = Fluxarray*(A*pixnum*pixxy*pixlambda*texp*wslit)

	
endif

if (sji eq 0) then begin
	if (wave eq 1400) then n = 1 else n = 2 
	A = iresp.AREA_SG[n]
	E = Fluxarray*(A*pixnum*pixxy*pixlambda*texp*wslit)
endif
return, E
end

