pro balm_data, date, single_pixel = single_pixel, area_pixel = area_pixel
;determine background values based on slit position
;restore, '/unsafe/jsr2/sp2826-Jan15-2016.sav'
restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'

f = iris_files(path='/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(f)
wavecorr = iris_prep_wavecorr_l2(f)

;quake position 
;qkxa = 519.0 ;Matthews et al 2015
;qkya = 262.0 ;Matthews et al 2015
;qkxa = 518.5 ;Donea et al 2014
;qkya = 264.0 ;Donea et al 2014
iradius = 2.;iris qk radius in pixels
spec_line = 6;d->show_lines
d = iris_obj(f[0])
dat = d->getvar(spec_line, /load)
wave = d->getlam(spec_line)
;nwav = n_elements(wave[39:44]) ;wavelength range for balmer
nwav = n_elements(wave)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position

rawdat = fltarr(nfiles, nwav, ypix, xpix) ;raw data array
corrdat = fltarr(nfiles, nwav, ypix, xpix) ;corrected data array
obj_destroy, d
hdr = 0
dat = 0
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
iris_x_pos = fltarr(xpix, nfiles)
iris_y_pos = fltarr(ypix, nfiles)
wrong_times = strarr(xpix, nfiles)
times = strarr(6, nfiles)
texp = dblarr(6, nfiles)
exp1 = dblarr(xpix, nfiles)
for i = 0, nfiles -1 do begin
    d = iris_obj(f[i])
    
    iris_x_pos[*, i] = d->getxpos()
    iris_y_pos[*, i] = d->getypos()

    ;grab wrong times for comparison
    wrong_times[*, i] = d->ti2utc()
    exp1[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
endfor

;common pix will contain the pixel locations of the x coords in balmercoords.txt
;common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)
common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,23])
iris_y_pix = find_iris_slit_pos_new(balmercoords[1, *], iris_y_pos[*,23])
;;;;;;fix raster times based on corrected exposure times;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;function iris_time_correct,new_data = new_data, times_out
f1 = iris_files(path='/unsafe/jsr2/IRIS/preflare/')
f2 = iris_files(path='/unsafe/jsr2/IRIS/old/')
f3 = [f1,f2]
;t0 = sp2826.tag00.time_ccsds[0]
times_correct_all_data = iris_time_correct(f3, 2826)
times_corrected = times_correct_all_data[*,150:179]




;fill raw and wavelength corrected data arrays
for i = 0, nfiles - 1 do begin
    ;load data and put into data array
    d = iris_obj(f[i])
    dat = d->getvar(spec_line, /load)    
    rawdat[i, *,*, *] = dat
    exp1[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
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
;    a = 0
;    for l = 39, 44 do begin 
;    a = a + corrdat[i,l, *, *]
;    endfor
 ;   alldat[*,*, i] = rotate(reform(a), 1)
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            ;Below based on sarah's method bint66_433=total(wd166h.int(41:44,3,438),1)
            alldat[j,k,i] = total(corrdat[i, 41:44, k, j])
        endfor
    endfor
endfor

;;;exposure time: correct dn data
exp_normalised = exp1/max(exp1)
exp_weight = max(exp1)/exp1
alldat_exp_weighted = dblarr(xpix,ypix,nfiles)
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
        alldat_exp_weighted[j, *, i] = exp_weight[j,i]*alldat[j, *, i]
    endfor
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;read in data
;;;find the numbers needed to create alldata array
;d = iris_obj(f[0])
;dat = d->getvar(6, /load)
;wavelength = d->getlam(6)
fitnum_max = 179 ;specific to event, used in allhdr tag naming
fitnum_min = (fitnum_max - nfiles) + 1
;nwav = n_elements(wavelength[39:44]) ;wavelength range for balmer
;ypix =  n_elements(dat[0,*,0]) ;y pixels
;xpix =  n_elements(dat[0,0,*]) ;slit position



;alldat = fltarr(xpix, ypix, nfiles) ;data array

 
;obj_destroy, d
;hdr = 0
;dat = 0
;fill data and time arrays
;for i = 0, nfiles - 1 do begin

    ;load data and put into data array
;    d = iris_obj(f[i])
;    dat = d->getvar(6, /load)
    
    ;sum across Balmer continuum range 2825.7 to 2825.8 angstroms
;    a = 0
;    for l = 39, 44 do begin 
;    a = a + dat[l, *, *]
;    endfor
;    alldat[*,*, i] = a

    ;clean up 
;    obj_destroy, d
;endfor



;fill array with back 
balmbk = fltarr(xpix,ypix)
for j = 0, xpix - 1 do begin
    for k = 0, ypix - 1 do begin
        bkstart = 17 ;17:40
        bkend = 21 ;17:44
        if (j eq 4) then begin ;there's an earlier peak in the usual bk time zone
            
            bkstart = 8 ;17:30
            bkend = 12 ;17:32
        endif
        balmbk[j, k] = avg(alldat_exp_weighted[j, k, bkstart:bkend])
;        balmbk[j, k] = avg(alldat[j, k, bkstart:bkend])
    endfor
endfor

bk = fltarr(8)
for i = 0, 7 do begin 
bk[i] = avg(balmbk[i, *])
endfor

;fill array with bk subtracted data
dat_bk_subtract_exp_weighted = fltarr(xpix, ypix, nfiles)
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            dat_bk_subtract_exp_weighted[j,k,i] = alldat_exp_weighted[j,k,i] - bk[j]
;            dat_bk_subtract_exp_weighted[j,k,i] = alldat[j,k,i] - bk[j]
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
ncoords = n_elements(balmercoords[0,*])
balmdat = fltarr(ncoords, nfiles)
balmerdata = fltarr(4, ncoords, nfiles)
;;;array to contain y pixel locations corresponding to each slit position

;iris_x_pix = fltarr(ncoords, nfiles)
;for i = 0 , nfiles-1 do begin
;a = 0
;a = find_iris_slit_pos_new(iris_x_pos[*,i], iris_x_pos[*,i])
;a = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,i])
;iris_x_pix[*,i] = a
;endfor
;iris_x_pix = [3,4,5,5,6,7]


;coords = [270, 271.6, 261., 264., 262.25, 263.9, 264, 262.9]
;iris_y_pix = find_iris_slit_pos_new(coords, iris_y_pos)

;balmerdata[0, *, *] = iris_x_pix[*, *]
;balmerdata[1, *, *] = iris_y_pix[*, *]
for i = 0, n_elements(balmerdata[0,0,*]) - 1 do begin 
balmerdata[0, *, i] = common_x_pix[*] ;think this will give a constant x y pix? check
balmerdata[1, *, i] = iris_y_pix[*]
endfor



;;;;;;;;;;;;;;;;;area pix;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(area_pixel) then begin
;;;fill array with intensity summed over an area equal to sunquake area 
;alldat[where(alldat lt 0., /null)] = 0 
for j = 0, ncoords - 1 do begin 
    for i = 0, nfiles -1 do begin
;	    times[j,i] =  t_x_pos[common_x_pix[i], i]
        times[j,i] = times_corrected[common_x_pix[j], i]
        ;fill array with intensity summed over an area equal to sunquake area
        texp[j,i]  = exp1[common_x_pix[j], i] 
        balmdat[j, i] = sumarea(dat_bk_subtract_exp_weighted[*,*,i], common_x_pix[j], iris_y_pix[j], iradius, /sg)        
        ;balmdat[j, i] = sumarea(dat_bk_subtract_exp_weighted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor
endif

;;;;;;;;;;;;;;;;;single pix;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(single_pixel) then begin
for j = 0,  ncoords - 1 do begin 
    for i = 0, nfiles -1 do begin
;	    times[j,i] =  t_x_pos[common_x_pix[i], i]
	    times[j,i] =  times_corrected[common_x_pix[j], i]
        texp[j,i]  = exp1[common_x_pix[j], i]

        ;fill array with intensity summed over an area equal to sunquake area
        balmdat[j, i] = dat_bk_subtract_exp_weighted[common_x_pix[j], iris_y_pix[j] ,i]
        ;balmdat[j, i] = sumarea(dat_bk_subtract_exp_weighted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor
endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;calculate energy;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
balmwidth = (3600. - 1400.)/0.1  ;in angstroms
wav1 = wave[39]
wav2 = wave[44]
for j = 0 , ncoords - 1 do begin 

;convert DN to energy [erg]
;iris_radiometric_calibration_texp, $
iris_radiometric_calibration, $
balmdat[j,*]*balmwidth, $
reform(texp[j,*]), $
wave=[wav1,wav2], $
n_pixels=1, $
fout, eout, f_err, e_err, $
/sg ;, slitpos = j

;fill array with energies
balmerdata[2, j, *] = fout
balmerdata[3, j, *] = eout
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





filnm = strcompress('/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav', /remove_all)

;save,balmdat, times, t_x_pos, iris_x_pos, iris_y_pos, iris_y_pix, filename = filnm
save, /variables, filename = filnm
end
