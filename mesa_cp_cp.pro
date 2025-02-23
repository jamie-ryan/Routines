pro mesa


;tmp = total(map1400.data[sidata[0, 0, npt-1, 0], sidata[0, 1, i, 0]], $
;map1400.data[sidata[0, 0, npt-1, 0], sidata[0, 1, i, 0]]

;time_frames = the number of time frames that ribbon coords have been sampled from.
;nsi, nmg, nbalm, nmgw, nhim are the number of ribbon coords for each data set. I think this is the bast way, as each data set has different sized ribbons, therefore it is unreasonable to assume that one spatial coord could relate to that of another dataset. So instead, I am going to produce high resolution energy distribution plots for each dataset, looking for common features. This approach should help to highlight regions in each dataset-ribbons that are related. i.e, there's a peak here and a trough to the right, there's the same feature in the ribbon above and below (in altitude)

;;;start timer
tic

;;;restore data sav files
restore, '/unsafe/jsr2/iris-16-03-15.sav'
restore, '/unsafe/jsr2/sp2826-Apr28-2015.sav'
restore, '/unsafe/jsr2/hmi-12-05-15.sav'
;restore, '/unsafe/jsr2/HMI-diff-15-Oct-15.sav'

;;;date string
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2

;;;directories
;dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
;datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'

;;;iris spectra fits
;fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
fsp = findfile('/unsafe/jsr2/Data/IRIS/*raster*.fits')

;;;some variables for loops, arrays element definition and header info 
sample = 1 ;use this for spectra
nrb = 20 ; number ribbon coords
time_frames = 2 
time_frame_string = strarr(time_frames)
time_frame_string[0] = '17:45'
time_frame_string[1] = '17:46'
npt = 1 + (nrb/time_frames) ; number of ribbon coords per time_frame + 1 qk coord
columns = 4 ;x,y,E,F
fande = 2 ;columns for error arrays containing f and e
wav1 = sp2826.tag00.wvl[39]
wav2 = sp2826.tag00.wvl[44]

;instrument specific radius (not including central pixel)
iradius = 4.;iris qk radius in pixels
sradius = 1.;sdo qk radius in pixels
inp = (iradius + 1)*(iradius + 1) ;npixels for iris radiometric calibration
snp = (sradius + 1)*(sradius + 1) ;npixels for sdo radiometric calibration

balmwidth = (3600. - 1400.)/0.1  ;in angstroms
visiblewidth = (7500. - 3800.)/76.e-3 ;in angstroms


;;;set time series to run from 17:20 to 17:55 
tsi = map1400.time ;[]
tmg = submg.time ;[]
tbalm = strarr(time_frames, npt, n_elements(tagarr)) ;balmer time array, each column couples with the corresponding e and f columns in balmerdata 
tmgw = diff2832.time ;[]
thmi = diff.time ;[]


;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014


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

dnbkb = fltarr(n_elements(tagarr))
bkb = 100.;630. ;from heinzel and kleint balmer paper



;;;arrays to contain energy values for each coord through the entire time series.
;eg: sidata[time_frame, xcoord, ycoord, time]....have to have seperate arrays due to different cadence
;data = [time_frame, x, y, F, E] = fltarr(2, 4, 10, t)
sidata = fltarr(time_frames, columns, npt, n_elements(tsi))
mgdata = fltarr(time_frames, columns, npt, n_elements(tmg))
balmerdata = fltarr(time_frames, columns, npt, n_elements(tagarr))
mgwdata = fltarr(time_frames, columns, npt, n_elements(tmgw))
hmidata = fltarr(time_frames, columns, npt, n_elements(thmi))

;;;arrays to contain errors associated with corresponding data 
sierr = fltarr(time_frames, fande, npt, n_elements(tsi))
mgerr = fltarr(time_frames, fande, npt, n_elements(tmg))
balmererr = fltarr(time_frames, fande, npt, n_elements(tagarr))
mgwerr = fltarr(time_frames, fande, npt, n_elements(tmgw))
hmierr = fltarr(time_frames, fande, npt, n_elements(thmi))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;calculate pixel location from given arcsec coords
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;read in coord files for each data set
;;;(to change coords ammend file, eg, hmicoords1.txt)
;;;based on naming convention (no zero, always start with 1), eg, hmicoords1, hmicoords2, hmicoords3 etc.
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

;;;;use tmp, e and f arrays to save memory
tmp = 0
c = 0

;sort out balmercoords problems...purge data of dodgy values
for i = 0, n_elements(balmercoords1[0,*]) - 1 do begin
    c = find_iris_slit_pos(balmercoords1[0, i],sp2826) 
    balmerdata[0, 0, i, *] = c
    c = 0
 
    c = find_iris_slit_pos(balmercoords1[1, i],sp2826, /y, /a2p)
    c[where(c eq 1092.00, /null)] = 422.00 
    balmerdata[0, 1, i, *] = c
    c = 0

    c = find_iris_slit_pos(balmercoords2[0, i],sp2826) 
    balmerdata[1, 0, i, *] = c
    c = 0

    c = find_iris_slit_pos(balmercoords2[1, i],sp2826, /y, /a2p)  
    c[where(c eq 1092.00, /null)] = 422.00 
    balmerdata[1, 1, i, *] = c 
    c = 0
endfor
c = find_iris_slit_pos(qkxa,sp2826)
balmerdata[0, 0, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
c[where(c eq 1092.00, /null)] = 422.00 
balmerdata[0, 1, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkxa,sp2826)
balmerdata[1, 0, npt-1, *] = c
c = 0

c = find_iris_slit_pos(qkya,sp2826, /y, /a2p)
c[where(c eq 1092.00, /null)] = 422.00 
balmerdata[1, 1, npt-1, *] = c
c = 0
;;;loop to fill data array coord columns and calculate flux' and energies. 
for i = 0, n_elements(sicoords1[0,*]) - 1 do begin

    ;;;iris 1400 \AA\ section
    dnbksi = total(map1400[495].data[bksip[0,*], bksip[1,*]])/n_elements(bksip[0,*]) ;si
    sidata[0, 0, i, *] = convert_coord_iris(sicoords1[0, i], sji_1400_hdr[495], /x, /a2p)
    sidata[0, 1, i, *] = convert_coord_iris(sicoords1[1, i], sji_1400_hdr[495], /y, /a2p)
    sidata[1, 0, i, *] = convert_coord_iris(sicoords2[0, i], sji_1400_hdr[498], /x, /a2p) 
    sidata[1, 1, i, *] = convert_coord_iris(sicoords2[1, i], sji_1400_hdr[498], /y, /a2p)
;    tmp = map1400.data[sidata[0, 0, i, 0], sidata[0, 1, i, 0]] - dnbksi
    tmp = sumarea(map1400.data - dnbksi, sidata[0, 0, i, 0], sidata[0, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
    sidata[0, 2, i, *] = f
    sidata[0, 3, i, *] = e
    sierr[0,0,i,*] = f_err
    sierr[0,1,i,*] = e_err

;    tmp = map1400.data[sidata[1, 0, i, 0], sidata[1, 1, i, 0]] - dnbksi
    tmp = sumarea(map1400.data - dnbksi, sidata[1, 0, i, 0], sidata[1, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
    sidata[1, 2, i, *] = f
    sidata[1, 3, i, *] = e
    sierr[1,0,i,*] = f_err
    sierr[1,1,i,*] = e_err

    ;;;iris 2796\AA\ section
    dnbkmg = total(submg[661].data[bkmgp[0,*], bkmgp[1,*]])/n_elements(bkmgp[0,*]) ;mg
    mgdata[0, 0, i, *] = convert_coord_iris(mgcoords1[0, i], sji_2796_hdr[661], /x, /a2p)
    mgdata[0, 1, i, *] = convert_coord_iris(mgcoords1[1, i], sji_2796_hdr[661], /y, /a2p) 
    mgdata[1, 0, i, *] = convert_coord_iris(mgcoords2[0, i], sji_2796_hdr[664], /x, /a2p)  
    mgdata[1, 1, i, *] = convert_coord_iris(mgcoords2[1, i], sji_2796_hdr[664], /y, /a2p)
    tmp = sumarea(submg.data - dnbkmg, mgdata[0, 0, i, 0], mgdata[0, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
    mgdata[0, 2, i, *] = f
    mgdata[0, 3, i, *] = e
    mgerr[0,0,i,*] = f_err
    mgerr[0,1,i,*] = e_err
    tmp = sumarea(submg.data - dnbkmg, mgdata[1, 0, i, 0], mgdata[1, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
    mgdata[1, 2, i, *] = f
    mgdata[1, 3, i, *] = e 
    mgerr[1,0,i,*] = f_err
    mgerr[1,1,i,*] = e_err

    ;;;iris 2825.7 to 2825.8 \AA\ section (Balmer continuum)
    tmp = fltarr(20) ;bk array
    for k = 0, 19 do begin ;make bk data
       com = 'tmp[k] = total(sp2826.'+tagarr[129 + k]+'.int[39:44, balmerdata[0, 0, i, 129 + k], bkb])/(44-39)' ;balmer background
       exe = execute(com)
    endfor
    dnbkb = total(tmp)/(20) ;take average for bk

    tmp = 0
    a=0
    balmint = fltarr(8, 1093, n_elements(tagarr))
    for j = 0, n_elements(tagarr)-1 do begin
        com = 'tbalm[0, i, j] = sp2826.'+tagarr[j]+'.time_ccsds[balmerdata[0, 0, i, j]]'
        exe = execute(com)
        com = 'tbalm[1, i, j] = sp2826.'+tagarr[j]+'.time_ccsds[balmerdata[1, 0, i, j]]'
        exe = execute(com)
        for l = 39, 44 do begin
            com = 'a = a + sp2826.'+tagarr[j]+'.int[l, *, *]'
            exe = execute(com)
        endfor
        a = reform(a)
        a = a/(44 - 39)
        balmint[*,*,j] = a - dnbkb
    endfor    
    tmp0 = fltarr(n_elements(tagarr))
    tmp1 = fltarr(n_elements(tagarr))
    for j = 0, n_elements(tagarr) - 1 do begin
        tmp0[j] = sumarea(balmint[*,*,j], balmerdata[0, 0, i, j], balmerdata[0, 1, i, j], iradius, /sg)
        tmp1[j] = sumarea(balmint[*,*,j], balmerdata[1, 0, i, j], balmerdata[1, 1, i, j], iradius, /sg)
    endfor
    iris_radiometric_calibration, tmp0*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[0, 2, i, *] = f
    balmerdata[0, 3, i, *] = e
    balmererr[0,0,i,*] = f_err
    balmererr[0,1,i,*] = e_err
    iris_radiometric_calibration, tmp1*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[1, 2, i, *] = f
    balmerdata[1, 3, i, *] = e
    balmererr[1,0,i,*] = f_err
    balmererr[1,1,i,*] = e_err

    ;;;iris 2832 \AA\ section
    mgwdata[0, 0, i, *] = convert_coord_iris(mgwcoords1[0, i], sji_2832_hdr[166], /x, /a2p)
    mgwdata[0, 1, i, *] = convert_coord_iris(mgwcoords1[1, i], sji_2832_hdr[166], /y, /a2p)
    mgwdata[1, 0, i, *] = convert_coord_iris(mgwcoords2[0, i], sji_2832_hdr[167], /x, /a2p) 
    mgwdata[1, 1, i, *] = convert_coord_iris(mgwcoords2[1, i], sji_2832_hdr[167], /y, /a2p)
    tmp = sumarea(diff2832.data, mgwdata[0, 0, i, 0], mgwdata[0, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
    mgwdata[0, 2, i, *] = f
    mgwdata[0, 3, i, *] = e
    mgwerr[0,0,i,*] = f_err ;*visiblewidth 
    mgwerr[0,1,i,*] = e_err ;*visiblewidth
    tmp = sumarea(diff2832.data, mgwdata[1, 0, i, 0], mgwdata[1, 1, i, 0], iradius)
    iris_radiometric_calibration, tmp, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
    mgwdata[1, 2, i, *] = f
    mgwdata[1, 3, i, *] = e
    mgwerr[1,0,i,*] = f_err ;*visiblewidth 
    mgwerr[1,1,i,*] = e_err ;*visiblewidth

    ;;;SDO HMI continuum section
    hmidata[0, 0, i, *] = convert_coord_hmi(hmicoords1[0, i], diffindex[62],  /x, /a2p)
    hmidata[0, 1, i, *] = convert_coord_hmi(hmicoords1[1, i], diffindex[62],  /y, /a2p)
    hmidata[1, 0, i, *] = convert_coord_hmi(hmicoords2[0, i], diffindex[63],  /x, /a2p)
    hmidata[1, 1, i, *] = convert_coord_hmi(hmicoords2[1, i], diffindex[63],  /y, /a2p)
    tmp = sumarea(diff.data, hmidata[0, 0, i, 0], hmidata[0, 1, i, 0], sradius)
    hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, f_err, e_err
    hmidata[0, 2, i, *] = f
    hmidata[0, 3, i, *] = e
    hmierr[0,0,i,*] = f_err
    hmierr[0,1,i,*] = e_err
    tmp = sumarea(diff.data, hmidata[1, 0, i, 0], hmidata[1, 1, i, 0], sradius)
    hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, f_err, e_err
    hmidata[1, 2, i, *] = f
    hmidata[1, 3, i, *] = e
    hmierr[1,0,i,*] = f_err
    hmierr[1,1,i,*] = e_err

endfor

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Sunquake location fill data array coord columns and calculate flux' and energies.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;iris 1400 \AA\ section
sidata[0, 0, npt-1, *] = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /a2p)
sidata[0, 1, npt-1, *] = convert_coord_iris(qkya, sji_1400_hdr[498], /y, /a2p)
sidata[1, 0, npt-1, *] = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /a2p)
sidata[1, 1, npt-1, *] = convert_coord_iris(qkya, sji_1400_hdr[498], /y, /a2p)
tmp = sumarea(map1400.data - dnbksi, sidata[0, 0, npt-1, 0], sidata[0, 1, i, 0], iradius)
iris_radiometric_calibration, tmp, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
sidata[0, 2, npt-1, *] = f
sidata[0, 3, npt-1, *] = e
sierr[0,0,npt-1,*] = f_err
sierr[0,1,npt-1,*] = e_err
tmp = sumarea(map1400.data - dnbksi, sidata[1, 0, npt-1, 0], sidata[1, 1, i, 0], iradius)
iris_radiometric_calibration, tmp, wave = 1400., n_pixels = inp, f, e, f_err, e_err, /sji
sidata[1, 2, npt-1, *] = f
sidata[1, 3, npt-1, *] = e
sierr[1,0,npt-1,*] = f_err
sierr[1,1,npt-1,*] = e_err

;;;iris 2796 \AA\ section
mgdata[0, 0, npt-1, *] = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /a2p)
mgdata[0, 1, npt-1, *] = convert_coord_iris(qkya, sji_2796_hdr[664], /y, /a2p)
mgdata[1, 0, npt-1, *] = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /a2p)
mgdata[1, 1, npt-1, *] = convert_coord_iris(qkya, sji_2796_hdr[664], /y, /a2p)
tmp = sumarea(submg.data - dnbkmg, mgdata[0, 0, npt-1, 0], mgdata[0, 1, npt-1, 0], iradius)
iris_radiometric_calibration, tmp, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
mgdata[0, 2, npt-1, *] = f
mgdata[0, 3, npt-1, *] = e
mgerr[0,0,npt-1,*] = f_err
mgerr[0,1,npt-1,*] = e_err
tmp = sumarea(submg.data - dnbkmg, mgdata[1, 0, npt-1, 0], mgdata[1, 1, npt-1, 0], iradius)
iris_radiometric_calibration, tmp, wave = 2796., n_pixels = inp, f, e, f_err, e_err, /sji
mgdata[1, 2, npt-1, *] = f
mgdata[1, 3, npt-1, *] = e 
mgerr[1,0,npt-1,*] = f_err
mgerr[1,1,npt-1,*] = e_err

;;;iris 2825.7 to 2825.8 \AA\ (Balmer continuum) section
tmp = fltarr(n_elements(tagarr))
a=0
for i = 0, n_elements(tagarr)-1 do begin
    tmp[i] = sumarea(balmint[*,*,i], balmerdata[0, 0, npt-1, i], balmerdata[0, 1, npt-1, i], iradius, /sg)
    com = 'tbalm[0, npt-1, i] = sp2826.'+tagarr[i]+'.time_ccsds[balmerdata[0, 0, npt-1, i]]'
    exe = execute(com)
    com = 'tbalm[1, npt-1, i] = sp2826.'+tagarr[i]+'.time_ccsds[balmerdata[1, 0, npt-1, i]]'
    exe = execute(com)
endfor
iris_radiometric_calibration, tmp*balmwidth, wave=[wav1,wav2], n_pixels = 1+2*iradius, f, e, f_err, e_err, /sg
balmerdata[0, 2, npt-1, *] = f
balmerdata[0, 3, npt-1, *] = e
balmerdata[1, 2, npt-1, *] = f
balmerdata[1, 3, npt-1, *] = e
balmererr[0,0,npt-1,*] = f_err
balmererr[0,1,npt-1,*] = e_err
balmererr[1,0,npt-1,*] = f_err
balmererr[1,1,npt-1,*] = e_err

;;;iris 2832 \AA\ section
mgwdata[0, 0, npt-1, *] = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /a2p)
mgwdata[0, 1, npt-1, *] = convert_coord_iris(qkya, sji_2832_hdr[167], /y, /a2p)
mgwdata[1, 0, npt-1, *] = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /a2p)
mgwdata[1, 1, npt-1, *] = convert_coord_iris(qkya, sji_2832_hdr[167], /y, /a2p)
tmp = sumarea(diff2832.data, mgwdata[0, 0, npt-1, 0], mgwdata[0, 1, npt-1, 0], iradius)
iris_radiometric_calibration, tmp, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
mgwdata[0, 2, npt-1, *] = f
mgwdata[0, 3, npt-1, *] = e
mgwerr[0,0,npt-1,*] = f_err
mgwerr[0,1,npt-1,*] = e_err
tmp = sumarea(diff2832.data, mgwdata[1, 0, npt-1, 0], mgwdata[1, 1, npt-1, 0], iradius)
iris_radiometric_calibration, tmp, wave = 2832., n_pixels = inp, f, e, f_err, e_err, /sji
mgwdata[1, 2, npt-1, *] = f
mgwdata[1, 3, npt-1, *] = e
mgwerr[1,0,npt-1,*] = f_err
mgwerr[1,1,npt-1,*] = e_err

;;;SDO HMI continuum section
hmidata[0, 0, npt-1, *] = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p) ;npt -1 is last row in coord columns.
hmidata[0, 1, npt-1, *] = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)
hmidata[1, 0, npt-1, *] = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p)
hmidata[1, 1, npt-1, *] = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)
tmp = sumarea(diff.data, hmidata[0, 0, npt-1, 0], hmidata[0, 1, npt-1, 0], sradius)
hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, f_err, e_err
hmidata[0, 2, npt-1, *] = f
hmidata[0, 3, npt-1, *] = e
hmierr[0,0,npt-1,*] = f_err
hmierr[0,1,npt-1,*] = e_err
tmp = sumarea(diff.data, hmidata[1, 0, npt-1, 0], hmidata[1, 1, npt-1, 0], sradius)
hmi_radiometric_calibration, tmp*visiblewidth, n_pixels = snp, f, e, f_err, e_err
hmidata[1, 2, npt-1, *] = f
hmidata[1, 3, npt-1, *] = e
hmierr[1,0,npt-1,*] = f_err
hmierr[1,1,npt-1,*] = e_err

spawn, 'mkdir /unsafe/jsr2/'+date
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
dnbkb, $
mgwdata, $
mgwerr, $
hmidata, $
hmierr, $
tsi, $
tmg, $
tbalm, $
tmgw, $
thmi, $
filename = '/unsafe/jsr2/'+date+'/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'.sav'
toc
end
