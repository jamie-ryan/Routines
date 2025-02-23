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
times = d->ti2utc()
plot, wavelength[*],dat[*,630,3]


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
fitnum_max = 179 ;specific to event, used in allhdr tag naming
fitnum_min = (fitnum_max - nfiles) + 1
nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
alldat = fltarr(xpix, ypix, nfiles) ;data array
times = strarr(nfiles, xpix) ;time array for utplot 

hdr = 0
dat = 0
;fill data and time arrays
for i = 0, nfiles - 1 do begin

    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(6, /load)
;    alldat[i, *,*,*] = dat[39:44, *, *]
    a = 0
    for l = 39, 44 do begin 
    a = a + dat[l, *, *]
    endfor
    alldat[*,*, i] = a

    ;load times for each slit position
    ;and put in times array
    time = d->ti2utc()
    times[i,*] = time

    ;make structure containing each header
    hdr = d->gethdr(iext, /struct)
    ii = string(fitnum_min + i, format = '(I0)')
    com = 'hdrtmp = {tag'+ii+' :hdr}'
    exe = execute(com)
    if (i eq 0) then allhdr = hdrtmp else $
    allhdr = create_struct(allhdr, hdrtmp) 

endfor
;plot,wavelength[39:44], alldat[29,*, 620, 3] ;will plot 179.fit spectrum
;utplot,times[*,3], alldat[*,*, 447, 3] ;will plot lightcurve 



restore, '/unsafe/jsr2/sp2826-Jan15-2016.sav'
;restore, '/unsafe/jsr2/sp2826-Apr28-2015.sav'
;;;some variables for loops, arrays element definition and header info 
sample = 1 ;use this for spectra
nrb = 20 ; number ribbon coords
time_frames = 2 
time_frame_string = strarr(time_frames)
time_frame_string[0] = '17:45'
time_frame_string[1] = '17:46'
npt = 1 + (nrb/time_frames) ; number of ribbon coords per time_frame + 1 qk coord
columns = 4 ;x,y,E,F
;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
balmerdata = fltarr(time_frames, columns, npt, nfiles)


dataset = ['balmer']
for i = 1,2 do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'coords'+ii+ '= tmp' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
endfor
;;;;use tmp, e and f arrays to save memory
tmp = 0
c = 0

;sort out balmercoords problems...purge data of dodgy values
for i = 0, n_elements(balmercoords1[0,*]) - 1 do begin
    c = find_iris_slit_pos(balmercoords1[0, i],sp2826) 
    balmerdata[0, 0, i, *] = c
    c = 0
 
    c = find_iris_slit_pos(balmercoords1[1, i],sp2826, /y, /a2p)
;    c[where(c eq 1092.00, /null)] = 422.00 
    balmerdata[0, 1, i, *] = c
    c = 0

    c = find_iris_slit_pos(balmercoords2[0, i],sp2826) 
    balmerdata[1, 0, i, *] = c
    c = 0

    c = find_iris_slit_pos(balmercoords2[1, i],sp2826, /y, /a2p)  
;    c[where(c eq 1092.00, /null)] = 422.00 
    balmerdata[1, 1, i, *] = c 
    c = 0
endfor
c = find_iris_slit_pos(qkxa,sp2826)
balmerdata[0, 0, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
;c[where(c eq 1092.00, /null)] = 422.00 
balmerdata[0, 1, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkxa,sp2826)
balmerdata[1, 0, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
;c[where(c eq 1092.00, /null)] = 422.00 
balmerdata[1, 1, npt-1, *] = c
c = 0
for i = 0, npt-1 do begin
    for j = 0, nfiles-1 do begin
    whereslit = 0
    whereslit = where(balmerdata[0, 0, i, 0:15] eq balmerdata[0, 0, i, j], ind)
    wsind = array_indices(balmerdata[0, 0, i, 0:15], whereslit)
    dnbkb = avg(alldat[balmerdata[0,0,i,wsind[*] ], balmerdata[0,1,i,wsind[*]],0:15])
    alldat[*, *, j] - dnbkb
    ;fill data arrays ready to pass to mesa
    balmerdata[0, 2, i, j] = alldat[balmerdata[0, 0, i, j], balmerdata[0, 1, i, j], j] - dnbkb
    balmerdata[0, 3, i, j] = alldat[balmerdata[0, 0, i, j], balmerdata[0, 1, i, j], j] - dnbkb
    balmerdata[1, 2, i, j] = alldat[balmerdata[0, 0, i, j], balmerdata[0, 1, i, j], j] - dnbkb
    balmerdata[1, 3, i, j] = alldat[balmerdata[0, 0, i, j], balmerdata[0, 1, i, j], j] - dnbkb
    endfor
endfor

;;;preflare subtraction


save, alldat, balmerdata, filename = 'balmerdata.sav'








;heinzel and klient style bk removal and enhancement isolation
avsdbk = fltarr(6,nfiles)
;av = 
;sd = 
;bk removed data = 
;av of bk removed data =
;sd of bk removed data =
;absolute enhancement = 
;
;pf = preflare element number
pf = 160.
;avsdbk[0,*] = avg(alldat[j, 39:44,i,0:5])
;avsdbk[1,*] = stddev(alldat[j, 39:44,i,0:5])
;avsdbk[2,*] = total(alldat[39:44,447,6])/(44.-39.) - 
;avsdbk[3,*] = avg(avsdbk[2,*])
;avsdbk[4,*] = stddev(avsdbk[2,*])
;avsdbk[5,*] = avsdbk[2, i] - avsdbk[2, pf]





end
