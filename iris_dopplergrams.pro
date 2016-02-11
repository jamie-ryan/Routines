pro iris_dopplergrams
f = iris_files(path='/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(f)
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'
;calculate wavelength shifts from the orbital velocity and thermal drifts
wavecorr = iris_prep_wavecorr_l2(f)


;d->show_lines     
;Spectral regions(windows)
; 0   1335.71   C II 1336
; 1   1343.37   1343    
; 2   1349.43   Fe XII 1349
; 3   1355.60   O I 1356
; 4   1402.77   Si IV 1403
; 5   2832.69   2832    
; 6   2826.61   2826    
; 7   2814.41   2814    
; 8   2796.20   Mg II k 2796
spec_line = 8;d->show_lines
d = iris_obj(f[0])
dat = d->getvar(spec_line, /load)
wave = d->getlam(spec_line)
;nwav = n_elements(wave[39:44]) ;wavelength range for balmer
nwav = n_elements(wave)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position

rawdat = fltarr(nfiles, nwav, ypix, xpix) ;raw data array
corrdat = fltarr(nfiles, nwav,  ypix, xpix) ;corrected data array
obj_destroy, d
hdr = 0
dat = 0

;fill raw and wavelength corrected data arrays
for i = 0, nfiles - 1 do begin
    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(spec_line, /load)    
    rawdat[i, *,*, *] = dat
endfor

for t = 0, nfiles - 1 do begin
    for i = 0, xpix - 1 do begin
        for j = 0, ypix -1 do begin
            ;;;corrected for fuv wavelengths 
            ;corrdat[*, j, i] = interpol(rawdat[*, j, i], wave + wavecorr.corr_fuv[i], wave)
            
            ;;;corrected for nuv wavelengths
            corrdat[t, *, j, i] = interpol(rawdat[t, *, j, i], wave + wavecorr.corr_nuv[i], wave)
        endfor
        ;clean up 
        obj_destroy, d
        dat = 0
    endfor
endfor
alldat = fltarr(xpix, ypix, nfiles)
for i = 0, nfiles - 1 do begin
    ;sum across Balmer continuum range 2825.7 to 2825.8 angstroms
    a = 0
    for l = 39, 44 do begin 
    a = a + corrdat[i,l, *, *]
    endfor
    alldat[*,*, i] = rotate(reform(a), 1)

    ;clean up 
    obj_destroy, d
endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;DOPPLERGRAMS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;We can use this calibrated data for example to calculate dopplergrams. 
;A dopplergram is the difference between the intensities at two wavelength positions, 
;at the same (and opposite) distance from the line core. 
;For example, at +/- 50 km/s from the Mg II k3 core... 
;To do this,
;#1)let us first calculate a velocity scale for the h line
;#2) then find the indices of the -50 and +50 km/s velocity positions
;;setup line centre selection based on spec_line choice.
k3_centre = 2796.32 ;mean Mg II k3 position
velocity = (k3_centre - wave) * 3e5 / k3_centre
;;find index of -50 and 50 km/s
tmp = min(abs(velocity - 100), i50p)  
tmp = min(abs(velocity + 100), i50m)

doppgr = fltarr(nfiles, xpix, ypix)
for t = 0, nfiles - 1 do begin
    ;;get the dopplergram using indices from above
    doppgr[t, *, *] = rotate(reform(corrdat[t, i50m, *, *] - corrdat[t, i50p, *, *]), 1)
endfor
;plot, doppgr[*,4,440]
;pih, doppgr[27,*,*], min=-100, max=100, scale=[0.35, 0.1667]  

;;make a magnified array for imaging spcetra and dopplergrams
;basically stretching the x axis
;xmag = 240 ;a multiple of number of slit positions, i.e, 8                                                      
;magdopp = fltarr(nfiles, xmag,1093)
;magraw = fltarr(2, nfiles, xmag,1093)
;magcorr = fltarr(2, nfiles, xmag,1093)
;for i = 0, nfiles - 1 do begin
;    ;magnified spectra images
;    magraw[0,i, *, *] = congrid(rotate(reform(rawdat[i, i50p, *,*]),1), 240, 1093, /interp)
;    magcorr[0,i, *, *] = congrid(rotate(reform(corrdat[i, i50p, *,*]),1), 240, 1093, /interp)
;    magraw[1,i, *, *] = congrid(rotate(reform(rawdat[i, i50m, *,*]),1), 240, 1093, /interp)
;    magcorr[1,i, *, *] = congrid(rotate(reform(corrdat[i, i50m, *,*]),1), 240, 1093, /interp)

    ;magnified dopplergrams
;    magdopp[i, *, *] = congrid(reform(doppgr[i,*,*]), 240, 1093, /interp)
;endfor                                                           
          
;pih, magdopp[27,*,*], min=-100, max=100, scale=[0.35, 0.1667] 
;pih, magraw[0, 27,*,*], min=-100, max=100, scale=[0.35, 0.1667] 
;pih, magcorr[0, 27,*,*], min=-100, max=100, scale=[0.35, 0.1667] 

;oplot line across a y location
;pih,doppgr[27,*,*], scale=[100, 1.0] 
;oplot, [-50,800], [400,400], linestyle = 2

;;;;;;;;;;;;;;SPECTRA PLOTS;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;pih, magdopp[27,*,*], min=-100, max=100, scale=[100, 1.0] 
;pih, magraw[0, 27,*,*], min=-100, max=100, scale=[100, 1.0] 
;pih, magcorr[0, 27,*,*], min=-100, max=100, scale=[100, 1.0] 

;oplot line across a y location
;pih,doppgr[27,*,*], scale=[100, 1.0] 
;oplot, [-50,800], [400,400], linestyle = 2
date = 'Feb9-2016'
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'

for t = 0, nfiles - 1 do begin
    loadct, 0
    pih,doppgr[t,*,*], scale=[100, 1.0] 
    nlines = n_elements(balmerdata[0,*,t])
    linecolors
    for i = 0, nlines - 1 do begin
        ;oplot, [-50,800], [balmerdata[1, i, 0],balmerdata[1, i, 29]], linestyle = i, color = 2*i
        oplot, [balmerdata[0, i, 0]*100,balmerdata[0, i, 29]*100], $
        [balmerdata[1, i, 0],balmerdata[1, i, 29]], linestyle = i, color = 1*i
    endfor
endfor

plot, doppgr[*, balmerdata[0,3,*], balmerdata[1,3,*]


end
