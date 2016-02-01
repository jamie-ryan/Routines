

;;;try newly downloaded iris data
f = iris_files(path='/unsafe/jsr2/IRIS/iris/level2/2014/03/30/20140330_140236_3860258481/')
nfiles = n_elements(f)
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
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
alldat = fltarr(xpix, ypix, nfiles) ;data array
balmdat = fltarr(time_frames, npt, nfiles)
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
endfor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
restore, 'sp2826-Feb1-2016.sav'
dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
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

tmp = fltarr(n_elements(tagarr))
balmerdata = fltarr(time_frames, columns, npt, n_elements(tagarr))

;;;quake
balmerdata[0, 0, npt-1, *] = find_iris_slit_pos(qkxa,sp2826)
balmerdata[0, 1, npt-1, *] = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
balmerdata[1, 0, npt-1, *] = find_iris_slit_pos(qkxa,sp2826)
balmerdata[1, 1, npt-1, *] = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
for j = 0, n_elements(tagarr)-1 do begin
    com = 'tmp[j] = total(sp2826.'+tagarr[j]+'.int[39:44, balmerdata[0, 0, npt-1, j], balmerdata[0, 1, npt-1, j]])/(44-39)' 
    exe = execute(com)
endfor
balmerdata[0,2,npt-1, *] = tmp
;;;ribbons
for i = 0, npt - 2 do begin
    balmerdata[0, 0, i, *] = find_iris_slit_pos(balmercoords1[0, i],sp2826) 
    balmerdata[0, 1, i, *] = find_iris_slit_pos(balmercoords1[1, i],sp2826, /y, /a2p) 
    balmerdata[1, 0, i, *] = find_iris_slit_pos(balmercoords2[0, i],sp2826) 
    balmerdata[1, 1, i, *] = find_iris_slit_pos(balmercoords2[1, i],sp2826, /y, /a2p) 
    for j = 0, n_elements(tagarr)-1 do begin
        com = 'tmp[j] = total(sp2826.'+tagarr[j]+'.int[39:44, balmerdata[0, 0, i, j], balmerdata[0, 1, i, j]])/(44-39)' 
        exe = execute(com)
    endfor
    balmerdata[0,2,i, *] = tmp
    balmerdata[1,2,i, *] = tmp
endfor


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

f = iris_files(path='/unsafe/jsr2/IRIS/iris/level2/2014/03/29/20140329_140938_3860258481/')
nfiles = n_elements(f)
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
;alldat = fltarr(xpix, ypix, nfiles) ;data array
alldat = fltarr(nwav, xpix, ypix, nfiles)
balmdat = fltarr(time_frames, npt, nfiles)
times = strarr(nfiles, xpix) ;time array for utplot 

hdr = 0
dat = 0
;fill data and time arrays
for i = 0, nfiles - 1 do begin

    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(6, /load)
    alldat[*, *, *, i] = dat
;    a = 0
;    for l = 39, 44 do begin 
;    a = a + dat[l, *, *]
;    endfor
;    alldat[*,*, i] = a

    ;load times for each slit position
    ;and put in times array
    time = d->ti2utc()
    times[i,*] = time
endfor


