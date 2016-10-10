pro balm_simple, date

;;read in fits file locations
f = findfile('/unsafe/jsr2/IRIS/Oct6/iris_l2_20140329_140938_3860258481_raster_t000*')
f1 = findfile('/unsafe/jsr2/IRIS/preflare/')
;;count fits files
nfiles = n_elements(f)

;read in a raster to get dimensions for various arrays
spec_line = 6;d->show_lines
d = iris_obj(f[0])
dat = d->getvar(spec_line, /load)
wave = d->getlam(spec_line)



;define arrays
nwav = n_elements(wave)
ypix =  n_elements(dat[0,*,0]) ;y pixels
xpix =  n_elements(dat[0,0,*]) ;slit position
rawdat = fltarr(nfiles, nwav, ypix, xpix) ;raw data array
corrdat = fltarr(nfiles, nwav, ypix, xpix) ;corrected data array
alldat = fltarr(xpix,ypix,nfiles)
alldat_exp_weighted = dblarr(xpix,ypix,nfiles)
;balmbk = fltarr(xpix, ypix) ;currently redundant
;bk = fltarr(xpix) ;currently redundant
dat_bk_subtract_exp_weighted = fltarr(xpix, ypix, nfiles)    
iris_x_pos = fltarr(xpix, nfiles)
iris_y_pos = fltarr(ypix, nfiles)
obs_times = strarr(xpix, nfiles)
exp1 = dblarr(xpix, nfiles)

obj_destroy, d

;;;;BK DATA
bk = 170. ; from visual inspection

;read in wavelength correction strucrure
wavecorr = iris_prep_wavecorr_l2(f)
for i = 0, nfiles -1 do begin
    ;;;;RAW DATA
    d = iris_obj(f[i]) ;define fits object
    dat = d->getvar(spec_line, /load) ;get data for individual fits    
    rawdat[i, *,*, *] = dat ;put into array to contain all data from all fits


    ;;;;SPACECRAFT FOV
    iris_x_pos[*, i] = d->getxpos() ;get y pixel locations in heliocentric coords
    iris_y_pos[*, i] = d->getypos() ;get x pixel locations (slit position) in heliocentric coords

    ;;;;OBS TIMES
;    obs_times = d->gettime() ;get relative obs times
    obs_times[*,i] = d->ti2utc() ;get UT obs times
    exp1[*,i] = d->getexp(iexp,iwin=spec_line) ;get exposure times

    obj_destroy, d ;clean up

    for j = 0, xpix - 1 do begin
        for k = 0, ypix -1 do begin

            ;;;;WAVELENGTH ORBITAL CORRECTIONS
            ;;;corrected for fuv wavelengths 
            ;corrdat[*, j, i] = interpol(rawdat[*, j, i], wave + wavecorr.corr_fuv[i], wave)            

            ;;;corrected for nuv wavelengths
;            corrdat[i, *, k, j] = interpol(rawdat[i, *, k, j], wave + wavecorr.corr_nuv[j], wave) 
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            
            ;;;SUM BALMER WAVELENGTH SELECTION
            alldat[j,k,i] = total(corrdat[i, 41:44, k, j])
            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

            ;;;EXPOSURE NORMALISATION
            alldat_exp_weighted[*, k, i] = alldat[*, k, i]/exp1[*,i] ;exposure corrected            

            ;;;;BK SUBTRACTION
            dat_bk_subtract_exp_weighted[j,k,i] = alldat_exp_weighted[j,k,i] - bk ;subtract bk
        endfor
    endfor
endfor


;;;;Save all raw variables
fsav = '/unsafe/jsr2/'+date+'/balm_simple_'+date+'_raw_variables.sav'
save, /variables, filename = fsav

;;;;CREATE DATA ARRAYS TO PASS TO IRIS_HMI_ENERGY.PRO
;get sampling coords
dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coordsfinal.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor


;;;Sampling coords specific arrays for iris_hmi_energy.pro
ncoords = n_elements(balmercoords[0,*])
balmdat = fltarr(ncoords, nfiles)
slitpos = 6
columns = 5 ;x,y,F,E,P
balmerdata = fltarr(columns, ncoords, nfiles)
times = strarr(ncoords, nfiles)
texp = dblarr(ncoords, nfiles)

;common pix will contain the pixel locations of the x coords in balmercoords.txt
;common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)
common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,23])
iris_y_pix = find_iris_slit_pos_new(balmercoords[1, *], iris_y_pos[*,23])
for i = 0, n_elements(balmerdata[0,0,*]) - 1 do begin 
balmerdata[0, *, i] = common_x_pix[*] ;think this will give a constant x y pix? check
balmerdata[1, *, i] = iris_y_pix[*]
endfor

for j = 0,  ncoords - 1 do begin 
    for i = 0, nfiles -1 do begin
        ;fill arrays with corrected times and exposure times for selected sampling coords
	    times[j,i] =  obs_times[common_x_pix[j], i]
        texp[j,i]  = exp1[common_x_pix[j], i]

        ;fill array with intensity values from selected sampling coords
        balmdat[j, i] = dat_bk_subtract_exp_weighted[common_x_pix[j], iris_y_pix[j] ,i]
        ;balmdat[j, i] = sumarea(dat_bk_subtract_exp_weighted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor

;;;;Save variables for iris_hmi_energy.pro
fsav = '/unsafe/jsr2/'+date+'/balmerdata'+date+'.sav'
save, balmerdata, balmdat, times, texp, wave, filename = fsav

end
