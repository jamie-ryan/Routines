pro balm_data, date
;determine background values based on slit position
;restore, '/unsafe/jsr2/sp2826-Jan15-2016.sav'
restore, '/unsafe/jsr2/sp2826-Jan19-2016.sav'
f = iris_files(path='/unsafe/jsr2/IRIS/old')


;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
iradius = 4.;iris qk radius in pixels


;find x and y slit positions in arcsec and times
;these arrays will be passed to mesa_cp as coordinates for other data
iris_x_pos = fltarr(8, nfiles)
iris_y_pos = fltarr(1093, nfiles)
times = strarr(8, nfiles)
for i = 0, nfiles -1 do begin
    d = iris_obj(f[i])
    iris_x_pos[*, i] = d->getxpos()
    iris_y_pos[*, i] = d->getypos()
    times[*, i] = d->ti2utc()
    obj_destroy, d
endfor

;;;array to contain y locations corresponding to each slit position
iris_y_pix = fltarr(8, nfiles)


;;;read in data
;;;find the numbers needed to create alldata array
d = iris_obj(f[0])
dat = d->getvar(6, /load)
wavelength = d->getlam(6)
fitnum_max = 179 ;specific to event, used in allhdr tag naming
fitnum_min = (fitnum_max - nfiles) + 1
nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
nfiles = n_elements(f)


alldat = fltarr(xpix, ypix, nfiles) ;data array
balmdat = fltarr(8, nfiles)
 
obj_destroy, d
hdr = 0
dat = 0
;fill data and time arrays
for i = 0, nfiles - 1 do begin

    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(6, /load)
    
    ;sum across Balmer continuum range 2825.7 to 2825.8 angstroms
    a = 0
    for l = 39, 44 do begin 
    a = a + dat[l, *, *]
    endfor
    alldat[*,*, i] = a

    ;clean up 
    obj_destroy, d
endfor



;fill array with back 
balmbk = fltarr(xpix,ypix)
bkstart = 0 ;17:40
bkend = 4 ;17:44
for j = 0, xpix - 1 do begin
    for k = 0, ypix - 1 do begin
        balmbk[j, k] = avg(alldat[j, k, bkstart:bkend])
    endfor
endfor

bk = fltarr(8)
for i = 0, 7 do begin 
bk[i] = avg(balmbk[i, *])
endfor

;fill array with bk subtracted data
balmdat_bk_subtracted = fltarr(xpix, ypix, nfiles)
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            balmdat_bk_subtracted[j,k,i] = alldat[j,k,i] - bk[j]
        endfor
    endfor
endfor



;;;fill array with intensity summed over an area equal to sunquake area 
alldat[where(alldat lt 0., /null)] = 0 
for j = 0, 7 do begin 
    for i = 0, nfiles -1 do begin
        balmdat[j, i] = sumarea(balmdat_bk_subtracted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor


d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
filnm = strcompress('/unsafe/jsr2/'+date+'/balmdat-bk subtracted-area-summed-'+date+'.sav', /remove_all)

save,balmdat, times, iris_x_pos, iris_y_pos, iris_y_pix, filename = filnm
end
