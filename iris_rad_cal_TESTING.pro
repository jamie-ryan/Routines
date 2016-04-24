restore, '/unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016.sav'
;IDL> help, balmdat   
;BALMDAT         FLOAT     = Array[6, 30]
;IDL> plot, balmdat[0,*]


iresp = iris_get_response('2014-03-29T14:10:17.030',version='003')
array = balmdat[0,*]
texp = reform(texp[0,*])
balmwidth = (3600. - 1400.)/0.1  ;in angstroms
wav1 = wave[39]
wav2 = wave[44]
wave = [wav1,wav2]
n_pixels = 1


pixel_length = 0.16635000 ;iris pixel length in arcseconds
dacm = 5.0e4 ;uncertainty in arcseconds to cm
arccm = 7.25e7 ;at 1AU, 1" = 7.25e5m...result is in cm
h = 6.63e-27  ; planck's constant erg.s
c = 3.0e10; speed of light cm/s
lambda = (wave*1.e-10)*1.e2 ;wavelength in cm if wave is in angstroms
dlam = 5.0e-11
wav = wave/10.
w = (0.33*pixel_length)*(((725.)^2)/((1.49e8)^2)) ;solid angle=slitwidth*pixel_length*(km/arcsec at 1AU)^2/(1AU in km)^2


pixfuv = 12.8e-3
pixnuv = 25.6e-3
dpxlam = 5.0e-5
if (max(wave) lt 1500.) then pixlambda = pixfuv else pixlambda = pixnuv
;IDL> print, pixlambda
;    0.0256000

if (pixlambda eq pixfuv) then n = 0 else n = 1 
;IDL> print, n
;       1

x = n_elements(wave)
;IDL> print, x
;           2

;;;THIS IS WRONG
;pixlambda = wav[1] - wav[0] ;bandpass equlas wavelength rang
;IDL> print, pixlambda
;     0.012730000
;IDL> print,wave[1] - wave[0] ;bandpass equlas wavelength range                      
;      0.12730000
;FIXED
pixlambda = wave[1] - wave[0] ;bandpass equlas wavelength range
;IDL> print, pixlambda                                                               
;      0.12730000


find1 = min(abs(iresp.lambda[*] - wav[0]),ind1)
find2 = min(abs(iresp.lambda[*] - wav[1]),ind2)
;IDL> ptin, ind1, ind2
;IDL> print, ind1, ind2
;        3251        3252
ind1 = ind1*1.
ind2 = ind2*1.
;IDL> print, ind1, ind2 
;      3251.00      3252.00

A_float = total(iresp.AREA_SG[ind1:ind2,n])/(ind2-ind1+1)
;IDL> print, a_float
;     0.242718

dn2ph = iresp.DN2PHOT_SG[n]
;IDL> print, dn2ph
;      18.0000

dn2photon = dn2ph[0]
;IDL> print, dn2photon
;      18.0000

E_phot = (h*c)/lambda ; photon energy 
;IDL> print, e_phot
;   7.0389817e-12   7.0386646e-12

E_photon = total(E_phot)/n_elements(E_phot)
;IDL> print, e_photon                                
;   7.0388232e-12

n_pixels = 1

for i = 0, n_elements(array) - 1 do begin
    fout[i] = (array[i]*n_pixels*dn2photon*E_photon)/(A_float*texp[i]*pixlambda*w) ;erg/s.cm^2.sr.Å
    eout[i] = fout[i]*asqk*pixlambda*texp[i] ;erg/s.cm^2
;    fout[i] = array[i]*n_pixels*dn2photon*E_photon/A_float*texp[i]*pixlambda*w ;erg/s.cm^2.sr.Å
;    eout[i] = array[i]*n_pixels*dn2photon*E_photon/A_float*texp[i] ;erg/s.cm^2
endfor

;FIXED!






print, max(fout, indf)
;  1.41231e+06
print, max(eout)
;  2.33668e-07
print, indf           
;         24

;testing fout and eout
;fout
alpha = n_pixels*dn2photon*E_photon/A_float*texp[indf]*pixlambda*w 
;IDL> print, alpha
;   2.1063912e-22
;IDL> print, array[indf]*alpha                                          
;   2.2996850e-19

alpha = (n_pixels*dn2photon*E_photon)/(A_float*texp[indf]*pixlambda*w) 
;IDL> print, alpha                                                           
;       1293.6014
;IDL> print, array[indf]*alpha
;       1412309.2

wslit = !pi/(180.*3600.*3.)
;IDL> print, wslit
;  1.61605e-06
alpha = (dn2photon*E_photon)/(A_float*pixel_length*pixlambda*texp[indf]*wslit) 
;IDL> print, alpha      
;    0.0062540930
;IDL> print, array[indf]*alpha                                                       
;       6.8280023

;eout
alpha = n_pixels*dn2photon*E_photon/A_float*texp[indf] 
;IDL> print, alpha                                          
;   1.2731229e-09
;IDL> print, array[indf]*alpha                              
;   1.3899515e-06
;IDL> print, array[indf]*alpha*balmwidth
;     0.030578933
asqk = 1.e16                      
;IDL> print, array[indf]*alpha*balmwidth*asqk
;   3.0578934e+14

alpha = (n_pixels*dn2photon*E_photon)/(A_float*texp[indf])
print, alpha
;   2.1402730e-10
print, array[indf]*alpha                                                                            
;   2.3366760e-07
print, array[indf]*alpha*balmwidth
;    0.0051406872
print, array[indf]*alpha*balmwidth*asqk                                                             
;   5.1406874e+13

alpha = (dn2photon*E_photon)/(A_float*texp[indf]) 
IDL> alpha = (dn2photon*E_photon)/(A_float*texp[indf])
;IDL> print, alpha
;   2.1402730e-10


etest = fout*asqk*0.1*texp[indf]
;FIXED!!!


restore, '/unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016.sav'
for j = 0 , ncoords - 1 do begin 

;convert DN to energy [erg]
;iris_radiometric_calibration_texp, $
iris_radiometric_calibration, $
balmdat[j,*]*balmwidth, $
reform(texp[j,*]), $
wave=[wav1,wav2], $
n_pixels=1, $
fff, eee, f_err, e_err, $
/sg ;, slitpos = j

;fill array with energies
balmerdata[2, j, *] = fff
balmerdata[3, j, *] = eee
endfor
