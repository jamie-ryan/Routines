;+
; NAME:
;       hmi_radiometric_calibration   
; PURPOSE: 
;       To convert hmi continuum data from DN/pixel to erg/s.cm^2.sr.Å and ergs
;
; CALLING SEQUENCE: 
;       hmi_radiometric_calibration, array, n_pixels = npixels, fout, eout
;
; INPUT PARAMETERS: 
;       array   a 1d array containing hmi continuum data in units of DN 
;	n_pixels	= number of pixels 
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
;       Written 13/08/15 by Jamie Ryan
;-
pro hmi_radiometric_calibration, array, n_pixels = n_pixels, fout, eout, f_err, e_err

dDN = 1.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN] / [texp] = DN/s
texp = 0.12 ; exposure time in seconds
dt = 0.005 ;uncertainty in t



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;[DN.s^-1] / [area_on_sun] = DN/s.cm^2
pixel_length = 0.505
dpl = 0.0005 ;uncertainty in pixel length
dacm = 5.0e4 ;uncertainty in arcseconds to cm
h = 6.63e-27  ; planck's constant erg.s
c = 3.e10; speed of light cm/s
lambda = 6173.e-10*1.e2 ;wavelength in cm if wave is in angstroms
dlam = 5.0e-11
pixlambda = 76.e-3 ;equivalent width [in Å]  of 6173Å continuum
ap_radius = 14. ;telescope aperture radius in cm
aperture_width = 2.*ap_radius 
w = (aperture_width*pixel_length)*(((725.)^2)/(1.49e8)^2) ;solid angle=slitwidth*pixel_length*(km/arcsec at 1AU)^2/(1AU in km)^2
E_photon = (h*c)/lambda ; photon energy at 6173 angstroms
asqk = 2.6e16 ;cm^2


;;;;;;;;;;;;;;;;;DN2PHOTONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
dn2photon = gain*quantum_efficiency      			



;;;;;;;;;;;;;;EFFECTIVE AREA;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
transmittance_low = 1.15 ;% low estimate from couvidat instrument paper
transmittance_med = 1.35 ;% med estimate from couvidat instrument paper...this is the figure quoted in the conclusion
transmittance_high = 2. ;% high estimate from couvidat instrument paper
transmittance_avg = (transmittance_low + transmittance_med + transmittance_high)/3 ;average transmittance
dtrans = 0.005 ;uncertainty in transmittance_med
area = !pi*ap_radius^2 ;cm^2...14cm = r = telescope aperture radius
A_eff = area*(transmittance_med/100.) ;area multiplied by relative transmittance gives effective area

;;;;;;;;;;;;;;DNs to erg/s.cm^2.sr.Å....;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fout = (array*dn2photon*E_photon)/(A_eff*texp*pixlambda*w) ;erg/s.cm^2.sr.Å
;eout = (array*dn2photon*E_photon)/(A_eff*texp) ;erg/s.cm^2
eout = fout*asqk*pixlambda*texp ;erg
;fout = array*dn2photon*E_photon/A_eff*texp*pixlambda*w ;erg/s.cm^2.sr.Å
;eout = array*dn2photon*E_photon/A_eff*texp ;erg/s.cm^2



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
hmi_err[1,3] = 0 ;arccm
hmi_err[0,4] = dgain
hmi_err[1,4] = gain
hmi_err[0,5] = dqe
hmi_err[1,5] = quantum_efficiency
hmi_err[0,6] = dlam
hmi_err[1,6] = lambda
hmi_err[0,7] = dtrans
hmi_err[1,7] = transmittance_med
hmi_err[0,8] = 0;dbp
hmi_err[1,8] = 0;;band_pass

f_err[i] = errcalc(hmi_err,fout[i])
e_err[i] = errcalc(hmi_err,eout[i])		
endfor
end






