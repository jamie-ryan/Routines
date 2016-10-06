pro balm_simple, date

;;read in fits file locations
f = findfile('/unsafe/jsr2/IRIS/Oct6/iris_l2_20140329_140938_3860258481_raster_t000*')

;;count fits files
nfiles = n_elements(f)

;;
wavecorr = iris_prep_wavecorr_l2(f)
;help, wavecorr
;** Structure <1f67e98>, 14 tags, length=2129888, data length=2129884, refs=1:              
;   NOTE            STRING    'corrs[file, rasterstep, line] gives target_wave - measured_wave in angstroms'
;   FILES           STRING    Array[30]
;   LNAME           STRING    Array[5]
;   WAVE0S          FLOAT     Array[5]
;   TIMES           STRING    Array[30, 8]
;   TAIS            DOUBLE    Array[30, 8]
;   NX              LONG                 8
;   NY              LONG              1093
;   COORD           FLOAT     Array[30, 8, 1093, 2]
;   CORRS           DOUBLE    Array[30, 8, 5]
;   CHISQ           DOUBLE    Array[30, 8, 5]
;   CORR_TAI        DOUBLE    Array[240]
;   CORR_NUV        DOUBLE    Array[240]
;   CORR_FUV        DOUBLE    Array[240]





restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'

;read in a raster to get dimensions for various arrays
spec_line = 6;d->show_lines
;d = iris_obj(f[0])
;dat = d->getvar(spec_line, /load)
;wave = d->getlam(spec_line)
;obj_destroy, d


;nwav = n_elements(wave)
;ypix =  n_elements(dat[0,*,0]) ;y pixels
;xpix =  n_elements(dat[0,0,*]) ;slit position


;rawdat = fltarr(nfiles, nwav, ypix, xpix) ;raw data array
;corrdat = fltarr(nfiles, nwav, ypix, xpix) ;corrected data array
;iris_x_pos = fltarr(xpix, nfiles)
;iris_y_pos = fltarr(ypix, nfiles)
;wrong_times = strarr(xpix, nfiles)
;times = strarr(6, nfiles)
;texp = dblarr(6, nfiles)
;exp1 = dblarr(xpix, nfiles)
;alldat_exp_weighted = dblarr(xpix,ypix,nfiles)
;bk = fltarr(8)
;dat_bk_subtract_exp_weighted = fltarr(xpix, ypix, nfiles)

for i = 0, nfiles -1 do begin
    d = iris_obj(f[i])

    ;;make arrays on the fly with concentation method 
    if (i eq 0) then begin 
    ;get raster positions
    iris_x_pos = d->getxpos()
    iris_y_pos = d->getypos()

    rawdat = d->getvar(spec_line, /load)

    endif
 
   if (i gt 0) then begin
    ;get raster positions 
    x_pos = d->getxpos()
    y_pos = d->getypos()
    iris_x_pos = [iris_x_pos, x_pos]
    iris_y_pos = [iris_y_pos, y_pos]

    ;get data
    dat = d->getvar(spec_line, /load)
    rawdat = [rawdat, dat]

    endif


    ;grab wrong times for comparison
    wrong_times[*, i] = d->ti2utc()
    exp1[*,i] = d->getexp(iexp,iwin=spec_line)

;    dat = d->getvar(spec_line, /load)    
;    rawdat[i, *,*, *] = dat
    exp1[*,i] = d->getexp(iexp,iwin=spec_line)
    obj_destroy, d
    for j = 0, xpix - 1 do begin
        for k = 0, ypix -1 do begin
            ;;;corrected for fuv wavelengths 
            ;corrdat[*, j, i] = interpol(rawdat[*, j, i], wave + wavecorr.corr_fuv[i], wave)
            
            ;;;corrected for nuv wavelengths
            corrdat[i, *, k, j] = interpol(rawdat[t, *, k, j], wave + wavecorr.corr_nuv[i], wave)
            alldat[j,k,i] = total(corrdat[i, 41:44, k, j])

            bkstart = 17 ;17:40
            bkend = 21 ;17:44
            if (j eq 4) then begin ;there's an earlier peak in the usual bk time zone
                
                bkstart = 8 ;17:30
                bkend = 12 ;17:32
            endif
            balmbk[j, k] = avg(alldat_exp_weighted[j, k, bkstart:bkend])
            alldat_exp_weighted[j, *, i] = exp_weight[j,i]*alldat[j, *, i]
            bk[i] = avg(balmbk[i, *])
            dat_bk_subtract_exp_weighted[j,k,i] = alldat_exp_weighted[j,k,i] - bk[j]
        endfor
    endfor
endfor


dat_bk_subtract_exp_weighted = fltarr(xpix, ypix, nfiles)
for i = 0, nfiles - 1 do begin
    for j = 0, xpix - 1 do begin
        for k = 0, ypix - 1 do begin
            dat_bk_subtract_exp_weighted[j,k,i] = alldat_exp_weighted[j,k,i] - bk[j]
;            dat_bk_subtract_exp_weighted[j,k,i] = alldat[j,k,i] - bk[j]
        endfor
    endfor
endfor


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

;common pix will contain the pixel locations of the x coords in balmercoords.txt
;common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)
common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,23])
iris_y_pix = find_iris_slit_pos_new(balmercoords[1, *], iris_y_pos[*,23])

;;;;;;fix raster times based on corrected exposure times;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;function iris_time_correct,new_data = new_data, times_out
f1 = findfile('/unsafe/jsr2/IRIS/Oct6/preflare')
f3 = [f1,f]
;t0 = sp2826.tag00.time_ccsds[0]
times_correct_all_data = iris_time_correct(f3, 2826)
times_corrected = times_correct_all_data[*,150:179]



end
