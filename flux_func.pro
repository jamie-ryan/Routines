function flux_func, array, wave, sji 
;+
; NAME:
;       flux_func()   
; PURPOSE: 
;       To convert IRIS observations from DN/pixel to erg/s/cm^(-2)/angstrom/sr
;
; CALLING SEQUENCE: 
;       F = flux_func( array, wavelength, sji) 
;
; INPUT PARAMETERS: 
;       array   the IRIS data array, slit-jaw or or spectrograph
;       wave    the wavelength of the data contained in the array in angstroms
;		eg, 1400 or 2796 or 2832	
;	sji	sji stands for slit-jaw image...set to 1 for yes and 0 for no	
;
; OUTPUT PARAMETERS:
;       F	a fluxarray containing intensity data in units of erg/s/cm^(-2)/angstrom/sr
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
nnn = n_elements(array)
F= fltarr(nnn)

if (wave eq 1400) then lambda = 1.4e-7 else $

if (wave eq 2796) then lambda = 2.796e-7 else lambda = 2.832e-7 


iresp = iris_get_response('2014-03-29T14:10:17.030',version='003')
h = 6.626e-34 ;planck's constant
c = 2.998e8;speed of light

;photon energies
Ejou = (h*c)/lambda
Ephot = Ejou/1e-7 ;convert to erg...1 erg = 1e-7 J

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
	F = array*((Ephot*iresp.DN2PHOT_SJI[n])/(A*pixxy*pixlambda*texp*wslit))
	
endif

if (sji eq 0) then begin
	if (wave eq 1400) then n = 1 else n = 2 
	A = iresp.AREA_SG[n]
	F = array*((Ephot*iresp.DN2PHOT_SG[n])/(A*pixxy*pixlambda*texp*wslit))
endif

return, F
end
