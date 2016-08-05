files = findfile('/unsafe/jsr2/project2/HMI/ic/*')
aia_prep, files,-1, hmiindex, hmidata, /despike
nx = n_elements(hmidata[*,0,0])
ny = n_elements(hmidata[0,*,0])
nt = n_elements(hmidata[0,0,*])
smthdat = fltarr(nx, ny, nt)
;ri = alog10(rdato) - alog10(SMOOTH(rdato,10))
;bi = alog10(bdato) - alog10(SMOOTH(bdato,10))
;gi = alog10(gdato) - alog10(SMOOTH(gdato,10))
smthdat = hmidata - SMOOTH(hmidata,10)
index2map, hmiindex, smthdat, hmimap
sub_map, hmimap, xr=[-300,-350], yr=[-150,-200], sbhmimap
