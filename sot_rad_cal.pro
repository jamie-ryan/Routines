;+
; NAME:
;       sot_rad_cal   
; PURPOSE: 
;       To convert hmi continuum data from DN/pixel to erg/s.cm^2.sr.Å and ergs
;
; CALLING SEQUENCE: 
;       sot_rad_cal, array, n_pixels = npixels, fout, eout
;
; INPUT PARAMETERS: 
;       array       = a 1d array containing hmi continuum data in units of DN 
;	    n_pixels	= number of pixels 
;       r           = red
;       g           = green
;       b           = blue
;
; OUTPUT PARAMETERS:
;       Fout		a fluxarray containing intensity data in units of erg/s.cm^2.sr.Å
;       Eout		a energy array containing data in units of erg    
;       f_err       array containing the errors for Fout in units of erg/s.cm^2.sr.Å
;       e_err       array containing the errors for Eout in units of erg
;
; EXAMPLES:
;       
; PROCEDURE:
;       
; NOTES:
;       
; MODIFICATION HISTORY:
;       Written 11/01/16 by Jamie Ryan
;-
pro sot_rad_cal, array, n_pixels = n_pixels, fout, eout, f_err, e_err, r=r, g=g, b=b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
;texp = exposure time in seconds
if keyword_set(r) then texp = 0.05120
if keyword_set(g) then texp = 0.07680
if keyword_set(b) then texp = 0.06144
dt = 0.005 ;uncertainty in t
array = array/texp ; = DN/s   							;;;;2e4

;uncertainty in DN
nmx = max(array)
dDN = 1./sqrt(nmx)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
pixel_length = 0.109
dpl = 0.0005 ;uncertainty in pixel length
arccm = 7.25e7 ;arcseconds to cm (1" = arccm at 1AU)
dacm = 5.0e4 ;uncertainty in arcseconds to cm
area_on_sun =  (pixel_length*arccm)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2   					;;;;;;1.5e-11


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN/s.cm^2] / [(DN/e-)*(e-/photon)] = photon/s.cm^2
;aia_gain =  1./17.7. ;(DN/e-) set by ADC....see pg 19, table 6 Initial Calibration of the Atmospheric Imaging 
		     ;Assembly(AIA) on the Solar Dynamics Observatory (SDO)
;hmi_gain_side_cam = [16.10,16.93,15.83,16.27] ;from top left to bottom right, shows the gain of each quadrant of the side camera ccd

hmi_gain_front_cam = [16.27,15.45,15.91,15.91] ;from top left to bottom right, shows the gain of each quadrant of the front camera ccd

quantum_efficiency = 0.75;(e-/photon) property of the ccd material taken from ccd product data sheet
dqe = 0.005 ;uncertainty in quantum_efficiency

gain = avg(hmi_gain_front_cam)
dgain = 0.005 ;uncertainty in gain
array = array/(gain*quantum_efficiency) ; = photon/s.cm^2     			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
h = !const.h  ; planck's constant
c = !const.c; speed of light m/s
lambda = 6173.e-10 ;wavelength in metres
dlam = 5.0e-11 ;uncertainty in pixel lambda
erg = 1.e-7 ; erg in joules
E_photon = (h*c)/lambda ; photon energy at 6173 angstroms
n_photon = E_photon/erg ; = photon/erg
array = array/n_photon ; = erg/s.cm^2    					



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
transmittance_low = 1.15 ;% low estimate from couvidat instrument paper
transmittance_med = 1.35 ;% med estimate from couvidat instrument paper...this is the figure quoted in the conclusion
transmittance_high = 2. ;% high estimate from couvidat instrument paper
transmittance_avg = (transmittance_low + transmittance_med + transmittance_high)/3 ;average transmittance
dtrans = 0.005 ;uncertainty in transmittance_med
area = !pi*14.^2 ;cm^2...14cm = r = telescope aperture radius
effective_area = area*(transmittance_med/100.) ;area multiplied by relative transmittance gives effective area???
D = 1.49e13 ; 1AU in cm 
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr   				


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = 76.e-3 ;equivalent width [in Å]  of 6173Å continuum
dbp = 5.0e-4 ;uncertainty in band_pass [in Å]
fout = array/band_pass ; = erg/s.cm^2.sr.Å					
eout = fout*texp*n_pixels*area_on_sun*effective_solid_angle*band_pass

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;ERRORS;;;;;;;;;;;;;;;;;;;;;;;;;;;
nerr = 9
hmi_err = fltarr(2,nerr)
f_err = fltarr(n_elements(array))
e_err = fltarr(n_elements(array))
for i = 0, n_elements(array) - 1 do begin
;hmi_err = fltarr(see list of variables)	
;hmi_err[1,0] = physical value	  				
;hmi_err[0,0] = associated uncertainty 
hmi_err = 0
hmi_err = fltarr(2,nerr)
hmi_err[0,0] = dDN
hmi_err[1,0] = array[i]
hmi_err[0,1] = dt
hmi_err[1,1] = texp
hmi_err[0,2] = dpl
hmi_err[1,2] = pixel_length
hmi_err[0,3] = dacm
hmi_err[1,3] = arccm
hmi_err[0,4] = dgain
hmi_err[1,4] = gain
hmi_err[0,5] = dqe
hmi_err[1,5] = quantum_efficiency
hmi_err[0,6] = dlam
hmi_err[1,6] = lambda
hmi_err[0,7] = dtrans
hmi_err[1,7] = transmittance_med
hmi_err[0,8] = dbp
hmi_err[1,8] = band_pass

f_err[i] = errcalc(hmi_err,fout[i])
e_err[i] = errcalc(hmi_err,eout[i])		
endfor
end






