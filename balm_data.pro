pro balm_data, date
;determine background values based on slit position
;restore, '/unsafe/jsr2/sp2826-Jan15-2016.sav'
restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'
f = iris_files(path='/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(f)

;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
iradius = 4.;iris qk radius in pixels

dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor

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

common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)


;;read in data
;;;find the numbers needed to create alldata array
d = iris_obj(f[0])
dat = d->getvar(6, /load)
wavelength = d->getlam(6)
fitnum_max = 179 ;specific to event, used in allhdr tag naming
fitnum_min = (fitnum_max - nfiles) + 1
nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position



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

;y0 = 415 ;259" 
;yf = 499 ;273"
;ny = 499 - 415
;iris_y_pix = fltarr(8,)

;;enhanced pixel detector
;;;y coordinates based on impulsive phase 17:44 to 17:48  
;times[*,8]  ;17:44
;times[*,12]  ;17:48
;times[*,8:12] 
;for j = 0, 7 do begin
;    imp_start = 8
;    imp_end = 12
;    for i = 0, 
;        rwl = 0
;        rind = 0
;        tmpav = 0
;        tmpsd = 0
;        tmp = 0
;        tmp = alldat[j, *, i]
;        tmp[where(tmp lt 0, /null)] = 0
;        tmpav = avg(tmp)
        ;;standard deviation (sigma)
;        tmpsd = stddev(tmp)
        ;;detection threshold (2*sigma)
;        rwl = where(tmp gt 2*tmpsd, rd)
;        rind = array_indices(tmp, rwl)
;        iris_y_pix[j, *, i] = rind[1,y0:yf]            
;    endfor
;endfor


balmerdata = fltarr(4, 8, nfiles)
;;;array to contain y pixel locations corresponding to each slit position
iris_x_pix = fltarr(8, nfiles)
for i = 0 , nfiles-1 do begin
a = 0
a = find_iris_slit_pos_new(iris_x_pos[*,i], iris_x_pos[*,i])
iris_x_pix[*,i] = a
endfor

coords = balmercoords[1, *]
;coords = [270, 271.6, 261., 264., 262.25, 263.9, 264, 262.9]
iris_y_pix = find_iris_slit_pos_new(coords, iris_y_pos)

balmerdata[0, *, *] = iris_x_pix[*, *]
balmerdata[1, *, *] = iris_y_pix[*, *]


;;;fill array with intensity summed over an area equal to sunquake area 
alldat[where(alldat lt 0., /null)] = 0 
for j = 0, 7 do begin 
    for i = 0, nfiles -1 do begin
        ;fill array with intensity summed over an area equal to sunquake area
        balmdat[j, i] = sumarea(balmdat_bk_subtracted[*,*,i], common_x_pix[i], iris_y_pix[j, i], iradius, /sg)        
        ;balmdat[j, i] = sumarea(balmdat_bk_subtracted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor

;calculate energy
balmwidth = (3600. - 1400.)/0.1  ;in angstroms
wav1 = wavelength[39]
wav2 = wavelength[44]
for j = 0 , 7 do begin 

;convert DN to energy [erg]
iris_radiometric_calibration, $
balmdat[j,*]*balmwidth, $
sp2826, $
wave=[wav1,wav2], $
n_pixels=1, $
f, e, f_err, e_err, $
/sg, slitpos = j

;fill array with energies
balmerdata[2, j, *] = f
balmerdata[3, j, *] = e
endfor

filnm = strcompress('/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav', /remove_all)

;save,balmdat, times, iris_x_pos, iris_y_pos, iris_y_pix, filename = filnm
save, /variables, filename = filnm
end
