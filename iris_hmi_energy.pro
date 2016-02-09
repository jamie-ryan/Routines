pro iris_hmi_energy, date


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
;restore, '/unsafe/jsr2/'+date+'/hmifullfilt-'+date+'.sav'
restore, '/unsafe/jsr2/Feb7-2016/hmifullfilt-Feb7-2016.sav'
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'
;restore, '/unsafe/jsr2/sp2826-Jan19-2016.sav'
restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'
;;;iris spectra fits
;fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
fsp = findfile('/unsafe/jsr2/IRIS/old/')
nfiles = n_elements(fsp)

;;;some variables for loops, arrays element definition and header info 
slitpos = 8
columns = 4 ;x,y,E,F
fande = 2 ;columns for error arrays containing f and e

;instrument specific radius (not including central pixel)
iradius = 4.;iris qk radius in pixels
sradius = 1.;sdo qk radius in pixels
inp = (iradius + 1)*(iradius + 1) ;npixels for iris radiometric calibration
snp = (sradius + 1)*(sradius + 1) ;npixels for sdo radiometric calibration

balmwidth = (3600. - 1400.)/0.1  ;in angstroms
visiblewidth = (7500. - 3800.)/76.e-3 ;in angstroms


;;;set time series to run from 17:30 to 17:55 
tsi = map1400.time ;[]
tmg = submg.time ;[]
;times = balmer
tmgw = diff2832.time ;[]
thmi = hmidiff.time ;[]


;quake position 
hmiqkxa = 518.5 ;Donea et al 2014
hmiqkya = 264.0 ;Donea et al 2014
qkxa = 517.5 
qkya = 265.0 

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
;balmerdata = fltarr(columns, slitpos, nfiles)
mgwdata = fltarr(columns, slitpos, n_elements(tmgw))
hmidata = fltarr(columns, slitpos, n_elements(thmi))

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
dataset = ['si', 'mg', 'mgw', 'hmi']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor



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
    tmp = sumarea(map1400.data - dnbksi, sidata[0, i, 0], sidata[1, i, 0], iradius)
;    iris_radiometric_calibration, tmp, sji_1400_hdr, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
    iris_radiometric_calibration, tmp, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
    sidata[2, i, *] = f
    sidata[3, i, *] = e
    sierr[0,i,*] = f_err
    sierr[1,i,*] = e_err
    tmp = 0
    ;;;iris 2796\AA\ section
    dnbkmg = total(submg[661].data[bkmgp[0,*], bkmgp[1,*]])/n_elements(bkmgp[0,*]) ;mg
    mgdata[0, i, *] = convert_coord_iris(mgcoords[0, i], sji_2796_hdr[666], /x, /a2p)
    mgdata[1, i, *] = convert_coord_iris(mgcoords[1, i], sji_2796_hdr[666], /y, /a2p) 
    tmp = sumarea(submg.data - dnbkmg, mgdata[0, i, 0], mgdata[1, i, 0], iradius)
;    iris_radiometric_calibration, tmp, sji_2796_hdr, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
    iris_radiometric_calibration, tmp, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
    mgdata[2, i, *] = f
    mgdata[3, i, *] = e
    mgerr[0,i,*] = f_err
    mgerr[1,i,*] = e_err
    tmp = 0
    ;;;iris 2832 \AA\ section
    mgwdata[0, i, *] = convert_coord_iris(mgwcoords[0, i], sji_2832_hdr[167], /x, /a2p)
    mgwdata[1, i, *] = convert_coord_iris(mgwcoords[1, i], sji_2832_hdr[167], /y, /a2p)
    tmp = sumarea(diff2832.data, mgwdata[0, i, 0], mgwdata[1, i, 0], iradius)
;    iris_radiometric_calibration, tmp, sji_2832_hdr, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
    iris_radiometric_calibration, tmp, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
    mgwdata[2, i, *] = f
    mgwdata[3, i, *] = e
    mgwerr[0,i,*] = f_err ;*visiblewidth 
    mgwerr[1,i,*] = e_err ;*visiblewidth
    tmp = 0
    ;;;SDO HMI continuum section
    hmidata[0, i, *] = convert_coord_hmi(hmicoords[0, i], diffind[64],  /x, /a2p)
    hmidata[1, i, *] = convert_coord_hmi(hmicoords[1, i], diffind[64],  /y, /a2p)
    tmp = sumarea(hmidiff.data, hmidata[0, i, 0], hmidata[1, i, 0], sradius)
    hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, f_err, e_err
    hmidata[2, i, *] = f
    hmidata[3, i, *] = e
    hmierr[0,i,*] = f_err
    hmierr[1,i,*] = e_err
    tmp = 0
endfor

;spawn, 'mkdir /unsafe/jsr2/'+date......this is now done in master.pro
;;;or maybe write individual sav files for each dataset?
save, $
;quake area
sidata, $
sierr, $
dnbksi, $
mgdata, $
mgerr, $
dnbkmg, $
balmerdata, $
balmererr, $
mgwdata, $
mgwerr, $
hmidata, $
hmierr, $
tsi, $
tmg, $
times, $
tmgw, $
thmi, $
filename = '/unsafe/jsr2/'+date+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'.sav'
toc
end
