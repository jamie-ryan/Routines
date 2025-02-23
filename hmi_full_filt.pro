pro hmi_full_filt, $
detect_wl = detect_wl, $
process = process, $
restore_sav = restore_sav, $
sav_date, $ 
calc_energy = calc_energy

;make date string for sav files
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date_today = d1+'-'+d2

if keyword_set(process) then begin
;read in fits file names
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
;files2 = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_18*')
;files = [files,files2]

;process sdo hmi data
;aia_prep, files,-1, hmiindex, hmidata, /despike
;process sdo hmi data
read_sdo, files, hmiindex, hmidata

;rotate images 180 degrees
for i = 0, n_elements(files) - 1 do begin
a = hmidata[*,*,i]
b = rotate(a,2)
hmidata[*,*,i] = b
a = 0
b = 0
endfor

;;;kerr & fletcher 2014 data processing
;log unsharp filter (ri) 
nx = n_elements(hmidata[*,0,0])
ny = n_elements(hmidata[0,*,0])
nt = n_elements(hmidata[0,0,*])
smthdat = fltarr(nx, ny, nt)
;logsmthdat = fltarr(nx, ny, nt)
;ri = alog10(rdato) - alog10(SMOOTH(rdato,10))
;bi = alog10(bdato) - alog10(SMOOTH(bdato,10))
;gi = alog10(gdato) - alog10(SMOOTH(gdato,10))
;logsmthdat = alog10(hmidata) - alog10(SMOOTH(hmidata,10))
smthdat = hmidata - SMOOTH(hmidata,10)
index2map, hmiindex, smthdat, hmimap

;;;wider crop, probably better for seeing everything
;xp0 = 2856
;xpf = 2995
;yp0 = 2406
;ypf = 2545

;;;convert pixels to arcsecs
;xa0 = (xp0-hmiindex[0].crpix1+1)*hmiindex[0].cdelt1
;xaf = (xpf-hmiindex[0].crpix1+1)*hmiindex[0].cdelt1
;ya0 = (yp0-hmiindex[0].crpix2+1)*hmiindex[0].cdelt2
;yaf = (ypf-hmiindex[0].crpix2+1)*hmiindex[0].cdelt2

;these coords match sarah's maps
;xa0 = 420.713
;xaf = 603.698
;ya0 = 190.625
;yaf = 372.280

;;;make sub map
;sub_map, hmimap, xr=[xa0,xaf], yr=[ya0,yaf], sbhmimap
sub_map, hmimap, xr=[405,590], yr=[190,372], sbhmimap

;running difference (i-2) applied to unsharp filtered images
rsub = coreg_map(sbhmimap,sbhmimap(40))
hmidiff=diff_map(rsub(1),rsub(0),/rotate)


;;;iterate through each submap and perform differencing
nc = 0
nc = n_elements(sbhmimap)
for i=1, nc-1, 1 do begin
    ;;differencing
    rdiff1=diff_map(rsub(i),rsub(i-2),/rotate)

    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(hmidiff,rdiff1)
endfor

map2index, hmidiff, diffind, diffdat

;use Ca II H as a mask (use thresholding to create a binary array)
;mask = cdato gt 900
;rfilt = riffdat*mask

;make .sav
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date_today = d1+'-'+d2
save, hmidiff, diffind, diffdat, filename = '/unsafe/jsr2/'+date_today+'/hmifullfilt-'+date_today+'.sav'

endif
if keyword_set(restore_sav) then restore, '/unsafe/jsr2/'+date_today+'/hmifullfilt-'+sav_date+'.sav'
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;WL pixel detection from filtered data
if keyword_set(detect_wl) then begin
nx = n_elements(diffdat[*,0,0])
ny = n_elements(diffdat[0,*,0])
nt = n_elements(diffdat[0,0,*])

;;mean
tmp = diffdat
tmp[where(tmp lt 0., /null)] = 0.
av = total(diffdat)/(nx*ny)

;;standard deviation (sigma)
sd = stddev(tmp)

;;detection threshold (2*sigma)
wl = where(tmp gt 2*sd, rd)
ind = array_indices(tmp, wl)

;make .sav
save,hmidiff, hmidat, hmiind , $
filename = '/unsafe/jsr2/'+date_today+'/hmifullfiltWLdetection-'+date_today+'.sav'
endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(calc_energy) then begin

endif
end
