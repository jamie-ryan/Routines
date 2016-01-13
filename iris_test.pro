iris_test
;;/unsafe/jsr2/iris_check

f = iris_files(path='/unsafe/jsr2/iris_check')
;IDL> print, f
;iris_l2_20140329_140938_3860258481_raster_t000_r00174.fits

;;;general reading in of info and a quick plot to check
d = iris_obj(f[0])
d->show_lines
dat = d->getvar(6, /load)
wavelength = d->getlam(6)
plot, wavelength[*],dat[*,630,3]
times = d->ti2utc()

;;;Balmer 2825.7 to 2825.8
plot, wavelength[39:44], dat[39:44,620,3]
av = avg(dat[39:44,620,*])
;IDL> print, av
;      121.536

sd = stddev(dat[39:44, 620, *])
;IDL> print, sd
;      19.4927

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;attempting to copy Heinzel & Kleint
av = avg(dat[39:44,620,0:5])
;IDL> print, av
;      112.924

;y1 (620) bk removal for "quiet sun"
qs =  total(dat[39:44,620,6])/(44.-39.) - av
;print, intensity
;      74.9264

;qs vs flare, i.e, y1 = 620 vs y2 = 447
;----y----|---preflare---------|-------flare--------|
;---------|--------------------|--------------------|
;y2 vs y1 |  ~20 DN/s more     | ~80 DN/s more      |
;---y1----| average = 50 DN/s* | average = 55 DN/s* |
;*y1 has bk removed as above
;*y2 has bk removed, then preflare value is also removed from enhancement to find absolute increase.

;y2 (447) bk removal for "flaring sun"
fs = total(dat[39:44,447,6])/(44.-39.) - avg(dat[39:44,447,0:5])


;need more data to test..try a new method of reading in all fits into one array
f = iris_files(path='/unsafe/jsr2/IRIS')

;;;find the numbers needed to create alldata array
d = iris_obj(f[0])
dat = d->getvar(6, /load)
wavelength = d->getlam(6)

nfiles = n_elements(f) ;number of rasters
nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
alldat = fltarr(nfiles, nwav, ypix, xpix)
times = strarr(nfiles, xpix)

dat = 0
for i = 0, nfiles - 1 do begin
d = iris_obj(f[i])
dat = d->getvar(6, /load)
time = d->ti2utc()
times[i,*] = time
alldat[i, *,*,*] = dat[39:44, *, *]
endfor



;;;check my data
restore, '/unsafe/jsr2/sp2826-Apr28-2015.sav'


end
