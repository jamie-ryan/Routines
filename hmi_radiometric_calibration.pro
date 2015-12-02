;+
; NAME:
;       hmi_radiometric_calibration   
; PURPOSE: 
;       To convert hmi continuum data from DN/pixel to erg/s/cm^(-2)/angstrom/sr and ergs
;
; CALLING SEQUENCE: 
;       hmi_radiometric_calibration, array, n_pixels = npixels, fout, eout
;
; INPUT PARAMETERS: 
;       array   	the hmi continuum data array
;	n_pixels	= number of pixels 
;
; OUTPUT PARAMETERS:
;       Fout		a fluxarray containing intensity data in units of erg/s.cm^2.sr.Å
;       Eout		a energy array containing data in units of erg        
;
; EXAMPLES:
;       
; PROCEDURE:
;       
; NOTES:
;       
; MODIFICATION HISTORY:
;       Written 13/08/15 by Jamie Ryan
;-
pro hmi_radiometric_calibration, array, n_pixels = n_pixels, fout, eout, f_err, e_err

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
texp = 0.12 ; exposure time in seconds
array = array/texp ; = DN/s   							;;;;2e4


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
area_on_sun =  (0.505*7.25e7)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2
array = array/area_on_sun ; = DN/s.cm^2   					;;;;;;1.5e-11


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN/s.cm^2] / [(DN/e-)*(e-/photon)] = photon/s.cm^2
;aia_gain =  1./17.7. ;(DN/e-) set by ADC....see pg 19, table 6 Initial Calibration of the Atmospheric Imaging 
		     ;Assembly(AIA) on the Solar Dynamics Observatory (SDO)
;hmi_gain_side_cam = [16.10,16.93,15.83,16.27] ;from top left to bottom right, shows the gain of each quadrant of the side camera ccd

hmi_gain_front_cam = [16.27,15.45,15.91,15.91] ;from top left to bottom right, shows the gain of each quadrant of the front camera ccd

quantum_efficiency = 0.75;(e-/photon) property of the ccd material taken from ccd product data sheet

gain = avg(hmi_gain_front_cam)

array = array/(gain*quantum_efficiency) ; = photon/s.cm^2     			


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
h = !const.h  ; planck's constant
c = !const.c; speed of light m/s
lambda = 6173.e-10 ;wavelength in metres
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
area = !pi*14.^2 ;cm^2...14cm = r = telescope aperture radius
effective_area = area*(transmittance_med/100.) ;area multiplied by relative transmittance gives effective area???
D = 1.49e13 ; 1AU in cm 
effective_solid_angle = effective_area/D^2 ; steradians
array = array/effective_solid_angle ; erg/s.cm^2.sr   				


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = 76.e-3 ;equivalent width of 6173Å continuum
fout = array/band_pass ; = erg/s.cm^2.sr.Å					
eout = fout*texp*n_pixels*area_on_sun*effective_solid_angle*band_pass
;hmi_err = fltarr(see list of variables)		  				
f_err = errcalc(hmi_err,fout)
e_err = errcalc(hmi_err,eout)		
end






