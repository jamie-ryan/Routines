pro make_energy_sav

;;restore data sav files
restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
;restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'

;;date string
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2


;;directories
dir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/plots/'
datdir = '/disk/solar3/jsr2/Data/SDO/DATA-ANALYSIS/Dat/'


;;;;high intensity pixel coordinate files
fmg = findfile(datdir+'*mgii-high*')
fmgw = findfile(datdir+'*mgiiw-high*')
fsi = findfile(datdir+'*siiv-high*')
;fsp = iris_files('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
fsp = findfile('/disk/solar3/jsr2/Data/IRIS/*raster*.fits')
;ffsp = findfile(datdir+'*balmer-high*')
ff = findfile(datdir+'hmi-high*')

sample = 1



nmg = n_elements(submg) ;nmg = n_elements(submg[17:*])
nmgw = n_elements(diff2832[*])
nsi = n_elements(map1400) ;nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)
nnn = n_elements(diff)

qkirxa = 519.
qkirya = 262.

qkmgxp = 588 
qkmgyp = 441 
rbmgxp = 504 
rbmgyp = 487 

qksixp = 588 
qksiyp = 441 
rbsixp = 511 
rbsiyp = 485 

;SDO HMI;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;
;quake position
qkxa = 517.2
qkya = 261.4
qkxp = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p)
qkyp = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)

;south ribbon, from left to right, at 17:45:31 or diff[62]
hmirbxa = 517.8
hmirbya = 260.5
hmirbxp = convert_coord_hmi(hmirbxa, diffindex[62],  /x, /a2p)
hmirbyp = convert_coord_hmi(hmirbya, diffindex[62],  /y, /a2p)

hmirbxa1 = 518.8
hmirbya1 = 261.0
hmirbxp1 = convert_coord_hmi(hmirbxa1, diffindex[62],  /x, /a2p)
hmirbyp1 = convert_coord_hmi(hmirbya1, diffindex[62],  /y, /a2p)

hmirbxa2 = 519.7
hmirbya2 = 261.7
hmirbxp2 = convert_coord_hmi(hmirbxa2, diffindex[62],  /x, /a2p)
hmirbyp2 = convert_coord_hmi(hmirbya2, diffindex[62],  /y, /a2p)


hmirbxa3 = 520.6
hmirbya3 = 262.3
hmirbxp3 = convert_coord_hmi(hmirbxa3, diffindex[62],  /x, /a2p)
hmirbyp3 = convert_coord_hmi(hmirbya3, diffindex[62],  /y, /a2p)

hmirbxa4 = 521.7
hmirbya4 = 262.6
hmirbxp4 = convert_coord_hmi(hmirbxa4, diffindex[62],  /x, /a2p)
hmirbyp4 = convert_coord_hmi(hmirbya4, diffindex[62],  /y, /a2p)

;;;;;;;;;;;;;;;;

;North ribbon from left to right, at 17:45:31 or diff[62]
hmirbxa5 = 500.7
hmirbya5 = 262.7
hmirbxp5 = convert_coord_hmi(hmirbxa5, diffindex[62],  /x, /a2p)
hmirbyp5 = convert_coord_hmi(hmirbya5, diffindex[62],  /y, /a2p)

hmirbxa6 = 503.8
hmirbya6 = 265.0
hmirbxp6 = convert_coord_hmi(hmirbxa6, diffindex[62],  /x, /a2p)
hmirbyp6 = convert_coord_hmi(hmirbya6, diffindex[62],  /y, /a2p)

hmirbxa7 = 506.9
hmirbya7 = 268.1
hmirbxp7 = convert_coord_hmi(hmirbxa7, diffindex[62],  /x, /a2p)
hmirbyp7 = convert_coord_hmi(hmirbya7, diffindex[62],  /y, /a2p)

hmirbxa8 = 509.27680
hmirbya8 = 268.79198
hmirbxp8 = convert_coord_hmi(hmirbxa8, diffindex[62],  /x, /a2p)
hmirbyp8 = convert_coord_hmi(hmirbya8, diffindex[62],  /y, /a2p)


hmirbxa9 = 514.4
hmirbya9 = 270.1
hmirbxp9 = convert_coord_hmi(hmirbxa9, diffindex[62],  /x, /a2p)
hmirbyp9 = convert_coord_hmi(hmirbya9, diffindex[62],  /y, /a2p)



;south ribbon, from left to right, at 17:46:16 or diff[63]
hmirbxa10 = 518.6
hmirbya10 = 259.1
hmirbxp10 = convert_coord_hmi(hmirbxa10, diffindex[63],  /x, /a2p)
hmirbyp10 = convert_coord_hmi(hmirbya10, diffindex[63],  /y, /a2p)

hmirbxa11 = 519.6
hmirbya11 = 259.3
hmirbxp11 = convert_coord_hmi(hmirbxa11, diffindex[63],  /x, /a2p)
hmirbyp11 = convert_coord_hmi(hmirbya11, diffindex[63],  /y, /a2p)

hmirbxa12 = 520.6
hmirbya12 = 259.5
hmirbxp12 = convert_coord_hmi(hmirbxa12, diffindex[63],  /x, /a2p)
hmirbyp12 = convert_coord_hmi(hmirbya12, diffindex[63],  /y, /a2p)

hmirbxa13 = 521.6
hmirbya13 = 259.9
hmirbxp13 = convert_coord_hmi(hmirbxa13, diffindex[63],  /x, /a2p)
hmirbyp13 = convert_coord_hmi(hmirbya13, diffindex[63],  /y, /a2p)

hmirbxa14 = 524.1
hmirbya14 = 259.7
hmirbxp14 = convert_coord_hmi(hmirbxa14, diffindex[63],  /x, /a2p)
hmirbyp14 = convert_coord_hmi(hmirbya14, diffindex[63],  /y, /a2p)

;North ribbon, from left to right, at 17:46:16 or diff[63]
hmirbxa15 = 499.1
hmirbya15 = 264.7
hmirbxp15 = convert_coord_hmi(hmirbxa15, diffindex[63],  /x, /a2p)
hmirbyp15 = convert_coord_hmi(hmirbya15, diffindex[63],  /y, /a2p)

hmirbxa16 = 502.1
hmirbya16 = 263.8
hmirbxp16 = convert_coord_hmi(hmirbxa16, diffindex[63],  /x, /a2p)
hmirbyp16 = convert_coord_hmi(hmirbya16, diffindex[63],  /y, /a2p)

hmirbxa17 = 504.6
hmirbya17 = 267.0
hmirbxp17 = convert_coord_hmi(hmirbxa17, diffindex[63],  /x, /a2p)
hmirbyp17 = convert_coord_hmi(hmirbya17, diffindex[63],  /y, /a2p)

hmirbxa18 = 508.4
hmirbya18 = 269.8
hmirbxp18 = convert_coord_hmi(hmirbxa18, diffindex[63],  /x, /a2p)
hmirbyp18 = convert_coord_hmi(hmirbya18, diffindex[63],  /y, /a2p)

hmirbxa14 = 511. ;rbxa,rbxpcorr = 39
hmirbya14 = 272. ;rbya,rbypcorr = 90
hmirbxp14 = convert_coord_hmi(hmirbxa14, diffindex[63],  /x, /a2p)
hmirbyp14 = convert_coord_hmi(hmirbya14, diffindex[63],  /y, /a2p)




for j = 0, n_elements(fmg) - 1 do begin
;;;;;;;open files 

openr,lun,fmg[j],/get_lun

;;;count lines in file
nlinesmg = file_lines(fmg[j])

;;;make array to fill with values from the file
hmg=intarr(2,nlinesmg)

;;;read file contents into array
readf,lun,hmg

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fmgw[j],/get_lun

;;;count lines in file
nlinesmgw = file_lines(fmgw[j])

;;;make array to fill with values from the file
hmgw=intarr(2,nlinesmgw)

;;;read file contents into array
readf,lun,hmgw

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,fsi[j],/get_lun

;;;count lines in file
nlinessi = file_lines(fsi[j])

;;;make array to fill with values from the file
hsi=intarr(2,nlinessi)

;;;read file contents into array
readf,lun,hsi

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
openr,lun,ff[j],/get_lun

;;;count lines in file
nlines = file_lines(ff[j])

;;;make array to fill with values from the file
h=intarr(2,nlines)

;;;read file contents into array
readf,lun,h

;;close file and free up file unit number
free_lun, lun
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;rhessi;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;mgii;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

com = 'boxarrmg'+string(j,format = '(I0)')+' = fltarr(nmg)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmg-1, 1 do begin
;com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[17 + i].data[hmg[0,*],hmg[1,*]]) '
com = 'boxarrmg'+string(j,format = '(I0)')+'[i] = total(submg[i].data[hmg[0,*],hmg[1,*]]) '
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration,boxarrmg'+string(j,format = '(I0)')+ $
', wave = 2796, n_pixels = nlinesmg ,F_area_mgii'+string(j,format = '(I0)')+ $
', E_area_mgii'+string(j,format = '(I0)')+' ,/sji'
exe = execute(com)

;;;balmer;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	for i = 0, nn-1, 1 do begin
;		comt = 'timearr[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
;		exet1 = execute(comt)
;		comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
;		exet = execute(comi)
;	endfor


;;;mgiiw;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

com = 'boxarrmgw'+string(j,format = '(I0)')+' = fltarr(nmgw)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nmgw-1, 1 do begin
com = 'boxarrmgw'+string(j,format = '(I0)')+'[i] = total(diff2832[i].data[hmgw[0,*],hmgw[1,*]])
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration,boxarrmgw'+string(j,format = '(I0)')+ $
', wave = 2832, n_pixels = nlinesmgw ,F_area_mgiiw'+string(j,format = '(I0)')+ $
', E_area_mgiiw'+string(j,format = '(I0)')+' ,/sji'
exe = execute(com)


;;siiv;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;501?

com = 'boxarrsi'+string(j,format = '(I0)')+' = fltarr(nsi)'
exe = execute(com)
;loop to fill arrays with summed pixel intensity values
for i = 0, nsi-1, 1 do begin
;com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[387 + i].data[hsi[0,*],hsi[1,*]]) '
com = 'boxarrsi'+string(j,format = '(I0)')+'[i] = total(map1400[i].data[hsi[0,*],hsi[1,*]]) '
exe = execute(com)
endfor
;;;flux and energy of flare area
com = 'iris_radiometric_calibration, boxarrsi'+string(j,format = '(I0)')+ $
', wave = 1400, n_pixels = nlinessi , F_area_siiv'+string(j,format = '(I0)')+ $
', E_area_siiv'+string(j,format = '(I0)')+' ,/sji'

exe = execute(com)

;;hmi continuum;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
com = 'boxarr'+string(j,format = '(I0)')+' = fltarr(nnn)'
exe = execute(com)
;bgarr = fltarr(nnn)
for i = 0, nnn-1, 1 do begin
com = 'boxarr'+string(j,format = '(I0)')+'[i] = total(diff[i].data[h[0,*],h[1,*]])'
exe = execute(com) 
endfor
;;;;;intensity of flare area in erg/s.cm^2.sr
com = 'hmi_radiometric_calibration, boxarr'+string(j,format = '(I0)')+ $
', n_pixels = nlines, F_area_hmi'+string(j,format = '(I0)')+ $
', E_area_hmi'+string(j,format = '(I0)')+''
exe = execute(com)
endfor

;;;set up single pixel arrays
qkmgmax = fltarr(nmg)
rbmgmax = fltarr(nmg)
qkmgcontrast = fltarr(nmg)
rbmgcontrast = fltarr(nmg)

qkmgwmax = fltarr(nmgw)
rbmgwmax = fltarr(nmgw)
qkmgwcontrast = fltarr(nmgw)
rbmgwcontrast = fltarr(nmgw)

qksimax = fltarr(nsi)
rbsimax = fltarr(nsi)
qksicontrast = fltarr(nsi)
rbsicontrast = fltarr(nsi)

spboxarr = fltarr(sample*nn)
timearr = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)

qkimax = fltarr(nnn)
rbimax = fltarr(nnn)


;;;;;;;;;FILL ARRAYS

;;SI IV 1400
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[i].data[qksixp, qksiyp] ;qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
;;calculate contrast value for ribbon pixels on all frames to save time
rbsimax[i] = map1400[i].data[rbsixp, rbsiyp] ;rbsimax[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax1[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax2[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax3[i] = map1400[387 + i].data[rbsixp, rbsiyp]
;	rbsimax4[i] = map1400[387 + i].data[rbsixp, rbsiyp]
endfor
;calculate flux and energy
iris_radiometric_calibration, qksimax, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji
iris_radiometric_calibration, rbsimax, wave = 1400., n_pixels = 1,Fsirb, Esirb, /sji
;	iris_radiometric_calibration, rbsimax1, wave = 1400., n_pixels = 1,Fsirb1, Esirb1, /sji
;	iris_radiometric_calibration, rbsimax2, wave = 1400., n_pixels = 1,Fsirb2, Esirb2, /sji
;	iris_radiometric_calibration, rbsimax3, wave = 1400., n_pixels = 1,Fsirb3, Esirb3, /sji
;	iris_radiometric_calibration, rbsimax4, wave = 1400., n_pixels = 1,Fsirb4, Esirb4, /sji

;;MG II 2796
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[i].data[qkmgxp, qkmgyp] ;qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[i].data[rbmgxp, rbmgyp] ;rbmgmax[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax1[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax2[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax3[i] = submg[17 + i].data[rbmgxp, rbmgyp]
;	rbmgmax4[i] = submg[17 + i].data[rbmgxp, rbmgyp]
endfor
;calculate flux and energy
iris_radiometric_calibration, qkmgmax, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji
iris_radiometric_calibration, rbmgmax, wave = 2976., n_pixels = 1,Fmgrb, Emgrb, /sji
;	iris_radiometric_calibration, rbmgmax1, wave = 2976., n_pixels = 1,Fmgrb1, Emgrb1, /sji
;	iris_radiometric_calibration, rbmgmax2, wave = 2976., n_pixels = 1,Fmgrb2, Emgrb2, /sji
;	iris_radiometric_calibration, rbmgmax3, wave = 2976., n_pixels = 1,Fmgrb3, Emgrb3, /sji
;	iris_radiometric_calibration, rbmgmax4, wave = 2976., n_pixels = 1,Fmgrb4, Emgrb4, /sji


;;BALMER
;sp quake
for i = 0, nn-1, 1 do begin
comt = 'tslit3[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
exet1 = execute(comt)

comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
exet = execute(comi)

comt = 'tslit0[0] = sp2826.'+tagarr[i]+'.time_ccsds[0]'
exet1 = execute(comt)

comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
exet = execute(comi)

;		comi = 'rbboxarr1[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr2[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr3[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

;		comi = 'rbboxarr4[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;		exet = execute(comi)

endfor

tsp = timearr

;calculate flux and energy
w1 = sp2826.tag00.wvl[39]
w2 = sp2826.tag00.wvl[44]
iris_radiometric_calibration, spboxarr, wave = [w1, w2], n_pixels = 10,Fspqk, Espqk ,/sg
iris_radiometric_calibration, rbboxarr, wave = [w1, w2], n_pixels = 5,Fsprb, Esprb ,/sg
;	iris_radiometric_calibration, rbboxarr1, wave = [w1, w2], n_pixels = 5,Fsprb1, Esprb1 ,/sg
;	iris_radiometric_calibration, rbboxarr2, wave = [w1, w2], n_pixels = 5,Fsprb2, Esprb2 ,/sg
;	iris_radiometric_calibration, rbboxarr3, wave = [w1, w2], n_pixels = 5,Fsprb3, Esprb3 ,/sg
;	iris_radiometric_calibration, rbboxarr4, wave = [w1, w2], n_pixels = 5,Fsprb4, Esprb4 ,/sg


;;MGW 2832
for i = 0, nmgw-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgwmax[i] = map2832[i].data[588,441 ]  ;559, 441
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgwmax[i] = map2832[i].data[483, 475]
;	rbmgwmax1[i] = map2832[i].data[483, 475]
;	rbmgwmax2[i] = map2832[i].data[483, 475]
;	rbmgwmax3[i] = map2832[i].data[483, 475]
;	rbmgwmax4[i] = map2832[i].data[483, 475]
endfor   
;calculate flux and energy
iris_radiometric_calibration, qkmgwmax, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji
iris_radiometric_calibration, rbmgwmax, wave = 2832., n_pixels = 1,Fmgwrb, Emgwrb, /sji
;	iris_radiometric_calibration, rbmgwmax1, wave = 2832., n_pixels = 1,Fmgwrb1, Emgwrb1, /sji
;	iris_radiometric_calibration, rbmgwmax2, wave = 2832., n_pixels = 1,Fmgwrb2, Emgwrb2, /sji
;	iris_radiometric_calibration, rbmgwmax3, wave = 2832., n_pixels = 1,Fmgwrb3, Emgwrb3, /sji
;	iris_radiometric_calibration, rbmgwmax4, wave = 2832., n_pixels = 1,Fmgwrb4, Emgwrb4, /sji

;HMI single pixel
for i = 0, nnn-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkimax[i] = diff[i].data[qkxp, qkyp]
rbimax[i] = diff[i].data[hmirbxp, hmirbyp]
rbimax1[i] = diff[i].data[hmirbxp1, hmirbyp1]
rbimax2[i] = diff[i].data[hmirbxp2, hmirbyp2]
rbimax3[i] = diff[i].data[hmirbxp3, hmirbyp3]
rbimax4[i] = diff[i].data[hmirbxp4, hmirbyp4]
rbimax5[i] = diff[i].data[hmirbxp5, hmirbyp5]
rbimax6[i] = diff[i].data[hmirbxp6, hmirbyp6]
rbimax7[i] = diff[i].data[hmirbxp7, hmirbyp7]
rbimax8[i] = diff[i].data[hmirbxp8, hmirbyp8]
rbimax9[i] = diff[i].data[hmirbxp9, hmirbyp9]
rbimax10[i] = diff[i].data[hmirbxp10, hmirbyp10]
rbimax11[i] = diff[i].data[hmirbxp11, hmirbyp11]
rbimax12[i] = diff[i].data[hmirbxp12, hmirbyp12]
rbimax13[i] = diff[i].data[hmirbxp13, hmirbyp13]
rbimax14[i] = diff[i].data[hmirbxp14, hmirbyp14]
endfor

;calculate flux and energy
hmi_radiometric_calibration, qkimax, n_pixels = 1, Fhmiqk, Ehmiqk
hmi_radiometric_calibration, rbimax, n_pixels = 1, Fhmirb, Ehmirb
hmi_radiometric_calibration, rbimax1, n_pixels = 1, Fhmirb1, Ehmirb1
hmi_radiometric_calibration, rbimax2, n_pixels = 1, Fhmirb2, Ehmirb2
hmi_radiometric_calibration, rbimax3, n_pixels = 1, Fhmirb3, Ehmirb3
hmi_radiometric_calibration, rbimax4, n_pixels = 1, Fhmirb4, Ehmirb4
hmi_radiometric_calibration, rbimax5, n_pixels = 1, Fhmirb5, Ehmirb5
hmi_radiometric_calibration, rbimax6, n_pixels = 1, Fhmirb6, Ehmirb6
hmi_radiometric_calibration, rbimax7, n_pixels = 1, Fhmirb7, Ehmirb7
hmi_radiometric_calibration, rbimax8, n_pixels = 1, Fhmirb8, Ehmirb8
hmi_radiometric_calibration, rbimax9, n_pixels = 1, Fhmirb9, Ehmirb9
hmi_radiometric_calibration, rbimax10, n_pixels = 1, Fhmirb10, Ehmirb10
hmi_radiometric_calibration, rbimax11, n_pixels = 1, Fhmirb11, Ehmirb11
hmi_radiometric_calibration, rbimax12, n_pixels = 1, Fhmirb12, Ehmirb12
hmi_radiometric_calibration, rbimax13, n_pixels = 1, Fhmirb13, Ehmirb13
hmi_radiometric_calibration, rbimax14, n_pixels = 1, Fhmirb14, Ehmirb14



;HMI quake area array...eventually calculate iris quake energy based on solid angle relationship found by trumpet.pro
qkarea = fltarr(nnn)
;based on the four iris pixels (4*0.1667") flagged by quake_area.pro.....more detailed version needed
;assuming 2 iris pixels relate to the radius of a circular quake impact, 
;but 0.505/0.1667 = 3 therefore 3 iris pixels equal one hmi pixel, which sets minimum resolution
;iris_quake_radius = 2*(0.1667*7.5e5)  
;iris_quake_area = !pi*quake_radius^2 
for i= 0, nnn-1 do begin
qkarea[i] = diff[i].data[qkxp, qkyp] + $
diff[i].data[qkxp, qkyp + 1] + $
diff[i].data[qkxp - 1, qkyp + 1] + $
diff[i].data[qkxp - 1, qkyp] + $
diff[i].data[qkxp - 1, qkyp - 1] + $
diff[i].data[qkxp, qkyp - 1] + $
diff[i].data[qkxp + 1, qkyp - 1] + $
diff[i].data[qkxp + 1, qkyp] + $
diff[i].data[qkxp + 1, qkyp + 1]
endfor
hmi_radiometric_calibration, qkarea, n_pixels = 9, Fqk_9px_area, Eqk_9px_area


;;;make time arrays
tsi = map1400.time
tmgii = submg.time
tmgw = map2832.time
thmi = diff.time

;;;make .sav file
save, $
;iris flare area siiv
F_area_siiv0, E_area_siiv0, $
F_area_siiv1, E_area_siiv1, $
F_area_siiv2, E_area_siiv2, $
F_area_siiv3, E_area_siiv3, $
tsi, $

;iris flare area mgii
F_area_mgii0, E_area_mgii0, $
F_area_mgii1, E_area_mgii1, $
F_area_mgii2, E_area_mgii2, $
F_area_mgii3, E_area_mgii3, $
tmgii, $

;iris flare area mgw
F_area_mgiiw0, E_area_mgiiw0, $
F_area_mgiiw1, E_area_mgiiw1, $
F_area_mgiiw2, E_area_mgiiw2, $
F_area_mgiiw3, E_area_mgiiw3, $
tmgw, $

;hmi flare area
F_area_hmi0, E_area_hmi0, $
F_area_hmi1, E_area_hmi1, $
F_area_hmi2, E_area_hmi2, $
F_area_hmi3, E_area_hmi3, $
thmi, $

;siiv; for time use tsi
Fsiqk, Esiqk, $
Fsirb, Esirb, $
;Fsirb1, Esirb1, $
;Fsirb2, Esirb2, $
;Fsirb3, Esirb3, $
;Fsirb4, Esirb4, $

;mgii; for time use tmgii
Fmgqk, Emgqk, $
Fmgrb, Emgrb, $
;Fmgrb1, Emgrb1, $
;Fmgrb2, Emgrb2, $
;Fmgrb3, Emgrb3, $
;Fmgrb4, Emgrb4, $

;balmer; for time use timearr
Fspqk, Espqk, $
Fsprb, Esprb, $
;Fsprb1, Esprb1, $
;Fsprb2, Esprb2, $
;Fsprb3, Esprb3, $
;Fsprb4, Esprb4, $
tslit0, $
tslit3, $

;mgw; for time use tmgw
Fmgwqk, Emgwqk, $
Fmgwrb, Emgwrb, $
;Fmgwrb1, Emgwrb1, $
;Fmgwrb2, Emgwrb2, $
;Fmgwrb3, Emgwrb3, $
;Fmgwrb4, Emgwrb4, $

;hmi; for time use thmi
Fhmiqk, Ehmiqk, $
Fhmirb, Ehmirb, $
;Fhmirb1, Ehmirb1, $
;Fhmirb2, Ehmirb2, $
;Fhmirb3, Ehmirb3, $
;Fhmirb4, Ehmirb4, $
Fqk_9px_area, Eqk_9px_area, $
filename = '29-Mar-2014-energies-for-python-'+date+'.sav'


end
