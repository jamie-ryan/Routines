pro iris_hmi_energy, datestring, single_pixel = single_pixel


;tmp = total(map1400.data[sidata[0, 0, npt-1, 0], sidata[0, 1, i, 0]], $
;map1400.data[sidata[0, 0, npt-1, 0], sidata[0, 1, i, 0]]

;time_frames = the number of time frames that ribbon coords have been sampled from.

;TO dO
;take out the time_frmaes dimension.
;produce data comparing iris_x_pos, probably only the tail end of the bright north ribbon
;look into iris_y_pos coords and ammend to cater for possible change in sj and hmi y coord
;produce sj and hmi data comparing north ribbon comparison use existing coords ammended to 
;reprocess hmi with the sot process


;;;start timer
tic

;;;restore data sav files
restore, '/unsafe/jsr2/iris-16-03-15.sav'
;restore, '/unsafe/jsr2/'+datestring+'/hmifullfilt-'+datestring+'.sav'
;restore, '/unsafe/jsr2/Feb12-2016/hmifullfilt-Feb12-2016.sav'
;restore, '/unsafe/jsr2/Sep21-2016/hmi_smth_diff.sav'

;;;;;;HMI filters....choose one
restore, '/unsafe/jsr2/Oct10-2016/hmihmi-smth-diff.sav'
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-smth.sav
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-bksub-log-smth.sav
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-bksub-smth.sav
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-log-smth-diff.sav
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-log-smth.sav
;restore, '/unsafe/jsr2/Oct5-2016/hmihmi-smth-diff.sav' ;can use various processing...see above

;restore, '/unsafe/jsr2/Feb15-2016/balm_data-Feb15-2016.sav'
;restore, '/unsafe/jsr2/'+datestring+'/balm_data-'+datestring+'.sav'
;restore, '/unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016.sav'
;restore, '/unsafe/jsr2/Mar18-2016/balm-dat-final-coords.sav'
;restore, '/unsafe/jsr2/Oct7-2016/balmerdataOct7-2016.sav'
;times = 0
;restore, '/unsafe/jsr2/Oct10-2016/balm_times.sav' ;read in corrected time array
restore, '/unsafe/jsr2/Oct10-2016/balmerdata-sarah-Oct10-2016.sav
;restore, '/unsafe/jsr2/sp2826-Jan19-2016.sav'
restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'
;;;iris spectra fits
;fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
fsp = findfile('/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(fsp)

fsji = findfile('/unsafe/jsr2/IRIS/sji/*')
nsji = n_elements(fsji)

;;;some variables for loops, arrays element definition and header info 
slitpos = 6
columns = 5 ;x,y,F,E,P
fande = 2 ;columns for error arrays containing f and e

;instrument specific radius (not including central pixel)
iradius = 2.;iris qk radius relating to sdo pixel size [in pixels]
sradius = 0.;sdo qk radius [in pixels]
inp = (iradius + 1)*(iradius + 1) ;npixels for iris radiometric calibration
snp = (sradius + 1)*(sradius + 1) ;npixels for sdo radiometric calibration

;continuum scaling factors
;balmwidth = (3600. - 1400.)/0.1  ;in angstroms
balmwidth = (6563. - 3646.)/0.1  ;in angstroms
visiblewidth = (7000. - 4800.)*1.0e2 ;in cm

;;;set time series to run from 17:30 to 17:55 
tsi = map1400.time ;[]
tmg = submg.time ;[]
;times = balmer
tmgw = diff2832.time ;[]
thmi = hmidiff.time ;[]


;quake position 
hmiqkxa = 518.5 ;Donea et al 2014
hmiqkya = 264.0 ;Donea et al 2014
qkxa = 519.0 
qkya = 262.0 

;;;background pixel locations for si and mg and balmer
bksia = fltarr(2,3)
bksip = fltarr(2,3)
bkmgp = fltarr(2,3)
bksia[0,0] = 472.74468 ;x
bksia[1,0] = 215.48495 ;y
bksia[0,1] = 517.20386    
bksia[1,1] = 213.44085
bksia[0,2] = 574.43865     
bksia[1,2] = 217.01802
;bksia[0,3] = 580.57095    
;bksia[1,3] = 327.91044
;bksia[0,4] = 522.82513      
;bksia[1,4] = 327.39942
;bksia[0,5] = 471.72263      
;bksia[1,5] = 329.95454
for i = 0, n_elements(bksip[0,*]) - 1 do begin
bksip[0, i] = convert_coord_iris(bksia[0,i], sji_1400_hdr[495], /x, /a2p)
bksip[1, i] = convert_coord_iris(bksia[1,i], sji_1400_hdr[495], /y, /a2p)
bkmgp[0, i] = convert_coord_iris(bksia[0,i], sji_2796_hdr[661], /x, /a2p)
bkmgp[1, i] = convert_coord_iris(bksia[1,i], sji_2796_hdr[661], /y, /a2p)
endfor


;;;arrays to contain energy values for each coord through the entire time series.
;eg: sidata[time_frame, xcoord, ycoord, time]....have to have seperate arrays due to different cadence
sidata = fltarr(columns, slitpos, n_elements(tsi))
mgdata = fltarr(columns, slitpos, n_elements(tmg))
;bdtmp0 = balmerdata[0,*,*]
;bdtmp1 = balmerdata[1,*,*]
;balmerdata = fltarr(columns, slitpos, n_elements(times[0,*]))
;balmerdata = fltarr(columns, slitpos, nfiles)
mgwdata = fltarr(columns, slitpos, n_elements(tmgw))
hmidata = fltarr(columns, slitpos, n_elements(thmi))

si_tmp = fltarr(slitpos, n_elements(tsi))
mg_tmp = fltarr(slitpos, n_elements(tmg))
mgw_tmp = fltarr(slitpos, n_elements(tmgw))
hmi_tmp = fltarr(slitpos, n_elements(thmi))

;;;arrays to contain errors associated with corresponding data 
sierr = fltarr(fande, slitpos, n_elements(tsi))
mgerr = fltarr(fande, slitpos, n_elements(tmg))
balmererr = fltarr(fande, slitpos, n_elements(tagarr))
mgwerr = fltarr(fande, slitpos, n_elements(tmgw))
hmierr = fltarr(fande, slitpos, n_elements(thmi))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;calculate pixel location from given arcsec coords
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;read in coord files for each data set
;;;(to change coords ammend file, eg, hmicoords.txt)
;;;based on naming convention (no zero, always start with 1), eg, hmicoords, hmicoords2, hmicoords3 etc.
dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coordsfinal.txt' ;eg, flnm=hmicoords.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor


exp_time = dblarr(nsji)
exp_time[*] = 8.000
;for i = 0, nsji - 1 do begin

;    d = iris_obj(fsji[i])
;    if (i eq 0) then spec_line = 4 else $ ;1400
;    if (i eq 1) then spec_line = 8 else spec_line = 5 ;2796 else 2832
;    exp_time[i] = avg(d->getexp(iexp,iwin=spec_line))
;endfor

;;;;use tmp, e and f arrays to save memory
tmp = 0
c = 0
;;;loop to fill data array coord columns and calculate flux' and energies. 
for i = 0, n_elements(sicoords[0,*]) - 1 do begin

    ;;;iris 1400 \AA\ section
    dnbksi = total(map1400[495].data[bksip[0,*], bksip[1,*]])/n_elements(bksip[0,*]) ;si
    sidata[0, i, *] = convert_coord_iris(sicoords[0, i], sji_1400_hdr[500], /x, /a2p)
    sidata[1, i, *] = convert_coord_iris(sicoords[1, i], sji_1400_hdr[500], /y, /a2p)
;    tmp = map1400.data[sidata[0, 0, i, 0], sidata[0, 1, i, 0]] - dnbksi
    if keyword_set(single_pixel) then tmp = map1400.data[sidata[0, i, 0], sidata[1, i, 0]] - dnbksi else $
    tmp = sumarea(map1400.data - dnbksi, sidata[0, i, 0], sidata[1, i, 0], iradius)


;    iris_radiometric_calibration, tmp, exp_time, sji_1400_hdr, wave = 1400., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    iris_radiometric_calibration, tmp, exp_time[0], wave = 1400., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    si_tmp[i,*] = tmp
    sidata[2, i, *] = f
    sidata[3, i, *] = e
    sidata[4, i, *] = pow
    sierr[0,i,*] = f_err
    sierr[1,i,*] = e_err
    tmp = 0
    ;;;iris 2796\AA\ section
    dnbkmg = total(submg[661].data[bkmgp[0,*], bkmgp[1,*]])/n_elements(bkmgp[0,*]) ;mg
    mgdata[0, i, *] = convert_coord_iris(mgcoords[0, i], sji_2796_hdr[666], /x, /a2p)
    mgdata[1, i, *] = convert_coord_iris(mgcoords[1, i], sji_2796_hdr[666], /y, /a2p) 
    if keyword_set(single_pixel) then tmp = submg.data[mgdata[0, i, 0], mgdata[1, i, 0]]- dnbkmg else $ 
    tmp = sumarea(submg.data - dnbkmg, mgdata[0, i, 0], mgdata[1, i, 0], iradius)
;    iris_radiometric_calibration, tmp, exp_time, sji_2796_hdr, wave = 2796., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    iris_radiometric_calibration, tmp, exp_time[1], wave = 2796., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    mg_tmp[i,*] = tmp
    mgdata[2, i, *] = f
    mgdata[3, i, *] = e
    mgdata[4, i, *] = pow
    mgerr[0,i,*] = f_err
    mgerr[1,i,*] = e_err
    tmp = 0
    ;;;iris 2832 \AA\ section
    mgwdata[0, i, *] = convert_coord_iris(mgwcoords[0, i], sji_2832_hdr[167], /x, /a2p)
    mgwdata[1, i, *] = convert_coord_iris(mgwcoords[1, i], sji_2832_hdr[167], /y, /a2p)
    if keyword_set(single_pixel) then tmp = map2832.data[mgwdata[0, i, 0], mgwdata[1, i, 0]] else $
;    tmp = sumarea(diff2832.data, mgwdata[0, i, 0], mgwdata[1, i, 0], iradius)
    tmp = sumarea(map2832.data, mgwdata[0, i, 0], mgwdata[1, i, 0], iradius)
;    iris_radiometric_calibration, tmp, exp_time, sji_2832_hdr, wave = 2832., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    iris_radiometric_calibration, tmp, exp_time[2], wave = 2832., n_pixels = inp, f, e, pow, f_err , e_err, /sji
    mgw_tmp[i,*] = tmp
    mgwdata[2, i, *] = f
    mgwdata[3, i, *] = e
    mgwdata[4, i, *] = pow
    mgwerr[0,i,*] = f_err ;*visiblewidth 
    mgwerr[1,i,*] = e_err ;*visiblewidth
    tmp = 0
    ;;;SDO HMI continuum section
    hmidata[0, i, *] = convert_coord_hmi(hmicoords[0, i], diffind[64],  /x, /a2p)
    hmidata[1, i, *] = convert_coord_hmi(hmicoords[1, i], diffind[64],  /y, /a2p)
    if keyword_set(single_pixel) then tmp = hmidiff.data[hmidata[0, i, 0], hmidata[1, i, 0]] else $
    tmp = sumarea(hmidiff.data, hmidata[0, i, 0], hmidata[1, i, 0], sradius)
    hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, pow, f_err , e_err
    hmi_tmp[i,*] = tmp
    hmidata[2, i, *] = f
    hmidata[3, i, *] = e
    hmidata[4, i, *] = pow
    hmierr[0,i,*] = f_err
    hmierr[1,i,*] = e_err
    tmp = 0
endfor


wav1 = wave[39]
wav2 = wave[44]
for j = 0 , n_elements(balmercoords[0,*]) - 1 do begin 

    ;convert DN to energy [erg]
    ;iris_radiometric_calibration_texp, $
    iris_radiometric_calibration, $
    balmdat[j,*]*balmwidth, $
    reform(texp[j,*]), $
    wave=[wav1,wav2], $
    n_pixels=1, $
    f, e, pow, f_err , e_err, $
    /sg ;, slitpos = j

    ;fill array with energies
    balmerdata[2, j, *] = f
    balmerdata[3, j, *] = e
    balmerdata[4, j, *] = pow
endfor


;spawn, 'mkdir /unsafe/jsr2/'+datestring......this is now done in master.pro
;;;or maybe write individual sav files for each dataset?
savfile = '/unsafe/jsr2/'+datestring+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+datestring+'.sav'
save, $
;quake area
sidata, $
sierr, $
si_tmp, $
dnbksi, $
mgdata, $
mgerr, $
mg_tmp, $
dnbkmg, $
balmerdata, $
balmererr, $
balmdat, $
mgwdata, $
mgwerr, $
mgw_tmp, $
hmidata, $
hmierr, $
hmi_tmp, $
tsi, $
tmg, $
times, $
tmgw, $
thmi, $
filename = savfile
toc
end
