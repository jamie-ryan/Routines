restore, '/unsafe/jsr2/sp2826-Apr28-2015.sav'

fsp = findfile('/unsafe/jsr2/Data/IRIS/*raster*.fits')

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


tbalm = strarr(time_frames, npt, n_elements(tagarr))
dnbkb = fltarr(n_elements(tagarr))
bkb = 100.;630. ;from heinzel and kleint balmer paper
balmerdata = fltarr(time_frames, columns, npt, n_elements(tagarr))

;quake position 
qkxa = 518.5 ;Donea et al 2014
qkya = 264.0 ;Donea et al 2014
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


for i = 0, n_elements(balmercoords1[0,*]) - 1 do begin
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
    ;iris_radiometric_calibration, tmp0*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[0, 2, i, *] = tmp0 ;f
;    balmerdata[0, 3, i, *] = e

    ;iris_radiometric_calibration, tmp1*balmwidth, wave=[wav1,wav2], n_pixels=1, f, e, f_err, e_err, /sg
    balmerdata[1, 2, i, *] = tmp1 ;f
;    balmerdata[1, 3, i, *] = e

endfor

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
balmerdata[0, 2, npt-1, *] = tmp ;f
;balmerdata[0, 3, npt-1, *] = e
balmerdata[1, 2, npt-1, *] = tmp ;f
;balmerdata[1, 3, npt-1, *] = e

