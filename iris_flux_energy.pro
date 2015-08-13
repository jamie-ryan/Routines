pro iris_flux_energy, array, wave = wave, Fout, Eout, sji = sji, sg = sg
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
;       array   	the IRIS data array, slit-jaw or or spectrograph
;       wave		= [lambda1, lambda2] or = lambda the wavelength range of the data contained 
;			in the array in angstroms. If there is a wavelength range, function calculates
;			average based on each iresp.wav increment  
;			
;	/sji		for slit-jaw data
;	/sg		for spectrograph data
;	/wavrange	for a wavelength range in angstroms, e.g, wave + wavrange
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
;-
nnn = n_elements(array)
F= fltarr(nnn)
lam =  wave*1.e-10 ;angstroms to m
;if (wave lt 1400) then lam = 1.4e-7 else $

;if (wave eq 2796) then lam = 2.796e-7 else lam = 2.832e-7 


iresp = iris_get_response('2014-03-29T14:10:17.030',version='003')
h = 6.626e-34 ;planck's constant
c = 2.998e8;speed of light

;photon energies
Ejou = (h*c)/lam
Ephot = Ejou/1e-7 ;convert to erg...1 erg = 1e-7 J

;spatial pixel in radians
pixxy = 0.16635000*(!pi/(180.*3600.*6. )) 

;spectral scale pixel in angstroms....nuv = 2796, 2832.....fuv = 1330, 1400
pixfuv = 12.8e-3
pixnuv = 25.6e-3

if (max(wave) lt 1500) then begin 
	pixlambda = pixfuv 
endif

if (min(wave) gt 1500) then begin
	pixlambda = pixnuv
endif

;slit width
Wslit = !pi/(180.*3600.*3.)

;exposure time
texp = 8.0000496

;convert to form contained in iresp.lambda
wav = wave/10. 
nwav = n_elements(wav)

;;;;single wavelength
if (nwav eq 1) then begin
find =  min(abs(iresp.lambda - wav),ind1)

	if keyword_set(sji) then begin
		wavint = wave/10
		wavstr = string(wavint, format = "(I0)")
		n = where(iresp.name_sji eq wavstr)
		A = iresp.AREA_SJI[ind1,n]
		Fout = array*((Ephot*iresp.DN2PHOT_SJI[n])/(A*pixxy*pixlambda*texp*wslit))
		Eout = Fout*(A*pixxy*pixlambda*texp*wslit)
	endif

	if keyword_set(sg) then begin
		if (pixlambda eq pixfuv) then n = 0 else n = 1		
		A = iresp.AREA_SG[ind1,n]
		Fout = array*((Ephot*iresp.DN2PHOT_SG[n])/(A*pixxy*pixlambda*texp*wslit))
		Eout = Fout*(A*pixxy*pixlambda*texp*wslit)
	endif
endif

;;;wavelength range...only relevent for sg
if (nwav gt 1) then begin
find1 = min(abs(iresp.lambda - wav[0]),ind1)
find2 = min(abs(iresp.lambda - wav[1]),ind2)


	if keyword_set(sg) then begin
		if (pixlambda eq pixfuv) then n = 0 else n = 1				
		A = total(iresp.AREA_SG[ind1:ind2,n])/(ind2-ind1+1)
		Fout = array*(((total(Ephot)/n_elements(Ephot))*iresp.DN2PHOT_SG[n])/(A*pixxy*pixlambda*texp*wslit))
		Eout = Fout*(A*pixxy*pixlambda*texp*wslit)
	endif
endif


end
