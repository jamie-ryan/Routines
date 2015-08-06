function energy_func, Fluxarray, wave = wave, sji = sji, sg = sg,  pixnum = pixnum
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
;       wave		= [lambda1, lambda2] or = lambda the wavelength range of the data contained 
;			in the array in angstroms. If there is a wavelength range, function calculates
;			average based on each iresp.wav increment  
;			
;	/sji		for slit-jaw data
;	/sg		for spectrograph data
;	/wavrange	for a wavelength range in angstroms, e.g, wave + wavrange
;	pixnum      	= npixels that are summed to make fluxarray  
; OUTPUT PARAMETERS:
;       E		an energyarray containing intensity data in units of erg
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
lam =  wave*1.e-10

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

if not keyword_set(pixnum) then pixnum = 1

;slit width
Wslit = !pi/(180.*3600.*3.)

;exposure time
texp = 8.0000496

;convert to form contained in iresp.lambda
wav = wave/10. 
nwav = n_elements(wav)

if (nwav eq 1) then begin
find =  min(abs(iresp.lambda - wav),ind1)

	if keyword_set(sji) then begin
		wavint = wave/10
		wavstr = string(wavint, format = "(I0)")
		n = where(iresp.name_sji eq wavstr)
		A = iresp.AREA_SJI[ind1,n]
		E = Fluxarray*(A*pixnum*pixxy*pixlambda*texp*wslit)
	endif

	if keyword_set(sg) then begin
		if (pixlambda eq pixfuv) then n = 0 else n = 1		
		A = iresp.AREA_SG[ind1,n]
		E = Fluxarray*(A*pixnum*pixxy*pixlambda*texp*wslit)
	endif
endif

;;;wavelength range...only relevent for sg
if (nwav gt 1) then begin
find1 = min(abs(iresp.lambda - wav[0]),ind1)
find2 = min(abs(iresp.lambda - wav[1]),ind2)


	if keyword_set(sg) then begin
		if (pixlambda eq pixfuv) then n = 0 else n = 1				
		A = total(iresp.AREA_SG[ind1:ind2,n])/(ind2-ind1+1)
		E = Fluxarray*(A*pixxy*pixlambda*texp*wslit)
	endif
endif

return, E
end




