pro heinzel_and_kleint.pro

;f = iris_files(path='/unsafe/jsr2/IRIS/iris/level2/2014/03/29/20140329_140938_3860258481/')
f = iris_files(path='/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(f)

;constants
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
time_frames = 2
columns = 3
npt = 11


;;;read in data
;;;find the numbers needed to create alldata array
d = iris_obj(f[0])
dat = d->getvar(6, /load)
wavelength = d->getlam(6)
nwav = n_elements(wavelength)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
alldat = fltarr(nwav, xpix, ypix, nfiles)
balmdatav = fltarr(xpix, ypix,  nfiles)
times = strarr(nfiles, xpix) ;time array for utplot
hdr = 0
dat = 0


;fill data and time arrays
for i = 0, nfiles - 1 do begin

    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(6, /load)
    alldat[*, *, *, i] = dat

    ;load times for each slit position
    ;and put in times array   
    time = d->ti2utc()
    times[i,*] = time

endfor

;;fill array with intensities summed over balmer continuum
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            balmdatav[j,k,i] =  total(alldat[39:44, j, k, i])
        endfor
    endfor
endfor

;;fill array with background levels
balmbk = fltarr(xpix,ypix)
bkstart = 18
bkend = 22
for j = 0, xpix - 1 do begin
    for k = 0, ypix - 1 do begin
        balmbk[j, k] = avg(balmdatav[j, k, bkstart:bkend])
    endfor
endfor

bk = fltarr(8)
for i = 0, 7 do begin 
bk[i] = avg(balmbk[i, *])
endfor
;;;avg balmbk for y
 ;avg(balmbk[3, *])


;make smaller processed data array
time_start = 10 ;17:30
ntime = n_elements(times[time_start:*,0])
balmdat_bk_subtracted = fltarr(xpix, ypix, ntime)
for i = 0, ntime - 1 do begin
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            balmdat_bk_subtracted[j,k,i] = balmdatav[j,k,time_start + i] - bk[j]
        endfor
    endfor
endfor

;;uncomment for utplot over plots
;utplot, times[time_start:*, 0], balmdat_bk_subtracted[0,423,*]
;for i = 1, xpix - 1 do begin
;outplot, times[time_start:*, 0], balmdat_bk_subtracted[i,423,*]
;endfor

;;fill array with bk subtracted  averaged for all slit positions
balmdat_slitsum = fltarr(ypix, ntime)
for i = 0, ntime - 1 do begin
    for k = 0, ypix - 1 do begin
        balmdat_slitsum[k,i] = avg(balmdat_bk_subtracted[*,k,i])
    endfor
endfor
;utplot, times[time_start:*, 0], balmdat_slitsum[423,*]


;;fill array with bk subtracted slit averaged preflare values
preflare = fltarr(ypix)
bkstart = bkstart - time_start
bkend = bkend - time_start
for k = 0, ypix - 1 do begin
    preflare[k] = avg(balmdat_slitsum[k, bkstart:bkend])
endfor
preflare[where(preflare lt 0, /null)] = 0

;;fill array bk subtracted, slit averaged, preflare subtracted data (finished product)
balm_fini = fltarr(ypix, ntime)
for i = 0, ntime - 1 do begin
    for k = 0, ypix - 1 do begin
        balm_fini[k, i] = balmdat_slitsum[k, i] - preflare[k] 
    endfor
endfor
;utplot, times[time_start:*, 0], balm_fini[423,*]
save, /variables, filename = 'balm_fini.sav'
end
