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
pro sot_power, array, n_pixels = n_pixels, p, e, r=r, g=g, b=b
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
;texp = exposure time in seconds, dn2pix is the conversion factor provided in kerr and fletcher 2014
if keyword_set(r) then begin
texp = 0.05120
dn2pix = 7.6122e-6
endif 
if keyword_set(g) then begin
texp = 0.07680
dn2pix = 1.4610e-5
endif
if keyword_set(b) then begin
texp = 0.06144
dn2pix = 1.9133e-5
endif
;dt = 0.005 ;uncertainty in t



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
pixel_length = 0.109
arccm = 7.25e7 ;arcseconds to cm (1" = arccm at 1AU)
area_on_sun =  (n_pixels*pixel_length*arccm)^2 ;at 1AU, 1" = 7.25e5m...result is in cm^2


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[photon/s.cm^2] / [photon/erg] = erg/s.cm^2
;h = !const.h  ; planck's constant
;c = !const.c; speed of light m/s
pi = !const.pi
;lambda = 6173.e-10 ;wavelength in metres
;dlam = 5.0e-11 ;uncertainty in pixel lambda
;erg = 1.e-7 ; erg in joules
;E_photon = (h*c)/lambda ; photon energy at 6173 angstroms
;n_photon = E_photon/erg ; = photon/erg
;array = array/n_photon ; = erg/s.cm^2    					



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2] / [effective_solid_angle] = erg/s.cm^2.sr
;transmittance_low = 1.15 ;% low estimate from couvidat instrument paper
;transmittance_med = 1.35 ;% med estimate from couvidat instrument paper...this is the figure quoted in the conclusion
;transmittance_high = 2. ;% high estimate from couvidat instrument paper
;transmittance_avg = (transmittance_low + transmittance_med + transmittance_high)/3 ;average transmittance
;dtrans = 0.005 ;uncertainty in transmittance_med
;area = !pi*14.^2 ;cm^2...14cm = r = telescope aperture radius
;effective_area = area*(transmittance_med/100.) ;area multiplied by relative transmittance gives effective area???
;D = 1.49e13 ; 1AU in cm 
;effective_solid_angle = effective_area/D^2 ; steradians
;array = array/effective_solid_angle ; erg/s.cm^2.sr   				


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[erg/s.cm^2.sr] / [band pass of instrument] = erg/s.cm^2.sr.Å
band_pass = 4.0 ;equivalent width [in Å]  of 6173Å continuum
I = array*dn2pix
p = pi*I*area_on_sun*band_pass
e = p*texp


end






