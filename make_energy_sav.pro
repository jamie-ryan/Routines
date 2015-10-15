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
nmgw = n_elements(diff2832)
nsi = n_elements(map1400) ;nsi = n_elements(map1400[387:*])
nn = n_elements(fsp)
nnn = n_elements(diff)

;qkirxa = 519.
;qkirya = 262.

;qkmgxp = 588 
;qkmgyp = 441 
;rbmgxp = 504 
;rbmgyp = 487 

;qksixp = 588 
;qksiyp = 441 
;rbsixp = 511 
;rbsiyp = 485 

;SDO HMI;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;
;quake position
qkxa = 517.2
qkya = 261.4
qkxp = convert_coord_hmi(qkxa, diffindex[63],  /x, /a2p)
qkyp = convert_coord_hmi(qkya, diffindex[63],  /y, /a2p)
qksixp = convert_coord_iris(qkxa, sji_1400_hdr[498], /x, /a2p)
qksiyp = convert_coord_iris(qkya, sji_1400_hdr[498], /y, /a2p)
qkmgxp = convert_coord_iris(qkxa, sji_2796_hdr[664], /x, /a2p)
qkmgyp = convert_coord_iris(qkya, sji_2796_hdr[664], /y, /a2p)
qkmgwxp = convert_coord_iris(qkxa, sji_2832_hdr[167], /x, /a2p)
qkmgwyp = convert_coord_iris(qkya, sji_2832_hdr[167], /y, /a2p)

;south ribbon, from left to right, at 17:45:31 or diff[62]
hmirbxa = 517.8
hmirbya = 260.5
hmirbxp = convert_coord_hmi(hmirbxa, diffindex[62],  /x, /a2p)
hmirbyp = convert_coord_hmi(hmirbya, diffindex[62],  /y, /a2p)
sirbxp = convert_coord_iris(hmirbxa, sji_1400_hdr[495], /x, /a2p)
sirbyp = convert_coord_iris(hmirbya, sji_1400_hdr[495], /y, /a2p)
mgrbxp = convert_coord_iris(hmirbxa, sji_2796_hdr[661], /x, /a2p)
mgrbyp = convert_coord_iris(hmirbya, sji_2796_hdr[661], /y, /a2p)
mgwrbxp = convert_coord_iris(hmirbxa, sji_2832_hdr[166], /x, /a2p)
mgwrbyp = convert_coord_iris(hmirbya, sji_2832_hdr[166], /y, /a2p)

hmirbxa1 = 518.8
hmirbya1 = 261.0
hmirbxp1 = convert_coord_hmi(hmirbxa1, diffindex[62],  /x, /a2p)
hmirbyp1 = convert_coord_hmi(hmirbya1, diffindex[62],  /y, /a2p)
sirbxp1 = convert_coord_iris(hmirbxa1, sji_1400_hdr[495], /x, /a2p)
sirbyp1= convert_coord_iris(hmirbya1, sji_1400_hdr[495], /y, /a2p)
mgrbxp1 = convert_coord_iris(hmirbxa1, sji_2796_hdr[661], /x, /a2p)
mgrbyp1 = convert_coord_iris(hmirbya1, sji_2796_hdr[661], /y, /a2p)
mgwrbxp1 = convert_coord_iris(hmirbxa1, sji_2832_hdr[166], /x, /a2p)
mgwrbyp1 = convert_coord_iris(hmirbya1, sji_2832_hdr[166], /y, /a2p)

hmirbxa2 = 519.7
hmirbya2 = 261.7
hmirbxp2 = convert_coord_hmi(hmirbxa2, diffindex[62],  /x, /a2p)
hmirbyp2 = convert_coord_hmi(hmirbya2, diffindex[62],  /y, /a2p)
sirbxp2 = convert_coord_iris(hmirbxa2, sji_1400_hdr[495], /x, /a2p)
sirbyp2 = convert_coord_iris(hmirbya2, sji_1400_hdr[495], /y, /a2p)
mgrbxp2 = convert_coord_iris(hmirbxa2, sji_2796_hdr[661], /x, /a2p)
mgrbyp2 = convert_coord_iris(hmirbya2, sji_2796_hdr[661], /y, /a2p)
mgwrbxp2 = convert_coord_iris(hmirbxa2, sji_2832_hdr[166], /x, /a2p)
mgwrbyp2= convert_coord_iris(hmirbya2, sji_2832_hdr[166], /y, /a2p)

hmirbxa3 = 520.6
hmirbya3 = 262.3
hmirbxp3 = convert_coord_hmi(hmirbxa3, diffindex[62],  /x, /a2p)
hmirbyp3 = convert_coord_hmi(hmirbya3, diffindex[62],  /y, /a2p)
sirbxp3 = convert_coord_iris(hmirbxa3, sji_1400_hdr[495], /x, /a2p)
sirbyp3 = convert_coord_iris(hmirbya3, sji_1400_hdr[495], /y, /a2p)
mgrbxp3 = convert_coord_iris(hmirbxa3, sji_2796_hdr[661], /x, /a2p)
mgrbyp3 = convert_coord_iris(hmirbya3, sji_2796_hdr[661], /y, /a2p)
mgwrbxp3 = convert_coord_iris(hmirbxa3, sji_2832_hdr[166], /x, /a2p)
mgwrbyp3 = convert_coord_iris(hmirbya3, sji_2832_hdr[166], /y, /a2p)

hmirbxa4 = 521.7
hmirbya4 = 262.6
hmirbxp4 = convert_coord_hmi(hmirbxa4, diffindex[62],  /x, /a2p)
hmirbyp4 = convert_coord_hmi(hmirbya4, diffindex[62],  /y, /a2p)
sirbxp4 = convert_coord_iris(hmirbxa4, sji_1400_hdr[495], /x, /a2p)
sirbyp4 = convert_coord_iris(hmirbya4, sji_1400_hdr[495], /y, /a2p)
mgrbxp4 = convert_coord_iris(hmirbxa4, sji_2796_hdr[661], /x, /a2p)
mgrbyp4 = convert_coord_iris(hmirbya4, sji_2796_hdr[661], /y, /a2p)
mgwrbxp4 = convert_coord_iris(hmirbxa4, sji_2832_hdr[166], /x, /a2p)
mgwrbyp4 = convert_coord_iris(hmirbya4, sji_2832_hdr[166], /y, /a2p)
;;;;;;;;;;;;;;;;

;North ribbon from left to right, at 17:45:31 or diff[62]
hmirbxa5 = 500.7 
hmirbya5 = 262.7
hmirbxp5 = convert_coord_hmi(hmirbxa5, diffindex[62],  /x, /a2p)
hmirbyp5 = convert_coord_hmi(hmirbya5, diffindex[62],  /y, /a2p)
sirbxp5 = convert_coord_iris(hmirbxa5, sji_1400_hdr[495], /x, /a2p)
sirbyp5 = convert_coord_iris(hmirbya5, sji_1400_hdr[495], /y, /a2p)
mgrbxp5 = convert_coord_iris(hmirbxa5, sji_2796_hdr[661], /x, /a2p)
mgrbyp5 = convert_coord_iris(hmirbya5, sji_2796_hdr[661], /y, /a2p)
mgwrbxp5 = convert_coord_iris(hmirbxa5, sji_2832_hdr[166], /x, /a2p)
mgwrbyp5 = convert_coord_iris(hmirbya5, sji_2832_hdr[166], /y, /a2p)

hmirbxa6 = 503.8 tag
hmirbya6 = 265.0
hmirbxp6 = convert_coord_hmi(hmirbxa6, diffindex[62],  /x, /a2p)
hmirbyp6 = convert_coord_hmi(hmirbya6, diffindex[62],  /y, /a2p)
sirbxp6 = convert_coord_iris(hmirbxa6, sji_1400_hdr[495], /x, /a2p)
sirbyp6 = convert_coord_iris(hmirbya6, sji_1400_hdr[495], /y, /a2p)
mgrbxp6 = convert_coord_iris(hmirbxa6, sji_2796_hdr[661], /x, /a2p)
mgrbyp6 = convert_coord_iris(hmirbya6, sji_2796_hdr[661], /y, /a2p)
mgwrbxp6 = convert_coord_iris(hmirbxa6, sji_2832_hdr[166], /x, /a2p)
mgwrbyp6 = convert_coord_iris(hmirbya6, sji_2832_hdr[166], /y, /a2p)

hmirbxa7 = 506.9
hmirbya7 = 268.1
hmirbxp7 = convert_coord_hmi(hmirbxa7, diffindex[62],  /x, /a2p)
hmirbyp7 = convert_coord_hmi(hmirbya7, diffindex[62],  /y, /a2p)
sirbxp7 = convert_coord_iris(hmirbxa7, sji_1400_hdr[495], /x, /a2p)
sirbyp7 = convert_coord_iris(hmirbya7, sji_1400_hdr[495], /y, /a2p)
mgrbxp7 = convert_coord_iris(hmirbxa7, sji_2796_hdr[661], /x, /a2p)
mgrbyp7 = convert_coord_iris(hmirbya7, sji_2796_hdr[661], /y, /a2p)
mgwrbxp7 = convert_coord_iris(hmirbxa7, sji_2832_hdr[166], /x, /a2p)
mgwrbyp7 = convert_coord_iris(hmirbya7, sji_2832_hdr[166], /y, /a2p)

hmirbxa8 = 509.27680
hmirbya8 = 268.79198
hmirbxp8 = convert_coord_hmi(hmirbxa8, diffindex[62],  /x, /a2p)
hmirbyp8 = convert_coord_hmi(hmirbya8, diffindex[62],  /y, /a2p)
sirbxp8 = convert_coord_iris(hmirbxa8, sji_1400_hdr[495], /x, /a2p)
sirbyp8 = convert_coord_iris(hmirbya8, sji_1400_hdr[495], /y, /a2p)
mgrbxp8 = convert_coord_iris(hmirbxa8, sji_2796_hdr[661], /x, /a2p)
mgrbyp8 = convert_coord_iris(hmirbya8, sji_2796_hdr[661], /y, /a2p)
mgwrbxp8 = convert_coord_iris(hmirbxa8, sji_2832_hdr[166], /x, /a2p)
mgwrbyp8 = convert_coord_iris(hmirbya8, sji_2832_hdr[166], /y, /a2p)

hmirbxa9 = 514.4
hmirbya9 = 270.1
hmirbxp9 = convert_coord_hmi(hmirbxa9, diffindex[62],  /x, /a2p)
hmirbyp9 = convert_coord_hmi(hmirbya9, diffindex[62],  /y, /a2p)
sirbxp9 = convert_coord_iris(hmirbxa9, sji_1400_hdr[495], /x, /a2p)
sirbyp9 = convert_coord_iris(hmirbya9, sji_1400_hdr[495], /y, /a2p)
mgrbxp9 = convert_coord_iris(hmirbxa9, sji_2796_hdr[661], /x, /a2p)
mgrbyp9 = convert_coord_iris(hmirbya9, sji_2796_hdr[661], /y, /a2p)
mgwrbxp9 = convert_coord_iris(hmirbxa9, sji_2832_hdr[166], /x, /a2p)
mgwrbyp9 = convert_coord_iris(hmirbya9, sji_2832_hdr[166], /y, /a2p)
;;;;;;;;;;;;;;;;;;

;south ribbon, from left to right, at 17:46:16 or diff[63]
hmirbxa10 = 518.6
hmirbya10 = 259.1
hmirbxp10 = convert_coord_hmi(hmirbxa10, diffindex[63],  /x, /a2p)
hmirbyp10 = convert_coord_hmi(hmirbya10, diffindex[63],  /y, /a2p)
sirbxp10 = convert_coord_iris(hmirbxa10, sji_1400_hdr[498], /x, /a2p)
sirbyp10 = convert_coord_iris(hmirbya10, sji_1400_hdr[498], /y, /a2p)
mgrbxp10 = convert_coord_iris(hmirbxa10, sji_2796_hdr[664], /x, /a2p)
mgrbyp10 = convert_coord_iris(hmirbya10, sji_2796_hdr[664], /y, /a2p)
mgwrbxp10 = convert_coord_iris(hmirbxa10, sji_2832_hdr[167], /x, /a2p)
mgwrbyp10 = convert_coord_iris(hmirbya10, sji_2832_hdr[167], /y, /a2p)

hmirbxa11 = 519.6
hmirbya11 = 259.3
hmirbxp11 = convert_coord_hmi(hmirbxa11, diffindex[63],  /x, /a2p)
hmirbyp11 = convert_coord_hmi(hmirbya11, diffindex[63],  /y, /a2p)
sirbxp11 = convert_coord_iris(hmirbxa11, sji_1400_hdr[498], /x, /a2p)
sirbyp11 = convert_coord_iris(hmirbya11, sji_1400_hdr[498], /y, /a2p)
mgrbxp11 = convert_coord_iris(hmirbxa11, sji_2796_hdr[664], /x, /a2p)
mgrbyp11 = convert_coord_iris(hmirbya11, sji_2796_hdr[664], /y, /a2p)
mgwrbxp11 = convert_coord_iris(hmirbxa11, sji_2832_hdr[167], /x, /a2p)
mgwrbyp11 = convert_coord_iris(hmirbya11, sji_2832_hdr[167], /y, /a2p)

hmirbxa12 = 520.6
hmirbya12 = 259.5
hmirbxp12 = convert_coord_hmi(hmirbxa12, diffindex[63],  /x, /a2p)
hmirbyp12 = convert_coord_hmi(hmirbya12, diffindex[63],  /y, /a2p)
sirbxp12 = convert_coord_iris(hmirbxa12, sji_1400_hdr[498], /x, /a2p)
sirbyp12 = convert_coord_iris(hmirbya12, sji_1400_hdr[498], /y, /a2p)
mgrbxp12 = convert_coord_iris(hmirbxa12, sji_2796_hdr[664], /x, /a2p)
mgrbyp12 = convert_coord_iris(hmirbya12, sji_2796_hdr[664], /y, /a2p)
mgwrbxp12 = convert_coord_iris(hmirbxa12, sji_2832_hdr[167], /x, /a2p)
mgwrbyp12 = convert_coord_iris(hmirbya12, sji_2832_hdr[167], /y, /a2p)

hmirbxa13 = 521.6
hmirbya13 = 259.9
hmirbxp13 = convert_coord_hmi(hmirbxa13, diffindex[63],  /x, /a2p)
hmirbyp13 = convert_coord_hmi(hmirbya13, diffindex[63],  /y, /a2p)
sirbxp13 = convert_coord_iris(hmirbxa13, sji_1400_hdr[498], /x, /a2p)
sirbyp13 = convert_coord_iris(hmirbya13, sji_1400_hdr[498], /y, /a2p)
mgrbxp13 = convert_coord_iris(hmirbxa13, sji_2796_hdr[664], /x, /a2p)
mgrbyp13 = convert_coord_iris(hmirbya13, sji_2796_hdr[664], /y, /a2p)
mgwrbxp13 = convert_coord_iris(hmirbxa13, sji_2832_hdr[167], /x, /a2p)
mgwrbyp13 = convert_coord_iris(hmirbya13, sji_2832_hdr[167], /y, /a2p)

hmirbxa14 = 524.1
hmirbya14 = 259.7
hmirbxp14 = convert_coord_hmi(hmirbxa14, diffindex[63],  /x, /a2p)
hmirbyp14 = convert_coord_hmi(hmirbya14, diffindex[63],  /y, /a2p)
sirbxp14 = convert_coord_iris(hmirbxa14, sji_1400_hdr[498], /x, /a2p)
sirbyp14 = convert_coord_iris(hmirbya14, sji_1400_hdr[498], /y, /a2p)
mgrbxp14 = convert_coord_iris(hmirbxa14, sji_2796_hdr[664], /x, /a2p)
mgrbyp14 = convert_coord_iris(hmirbya14, sji_2796_hdr[664], /y, /a2p)
mgwrbxp14 = convert_coord_iris(hmirbxa14, sji_2832_hdr[167], /x, /a2p)
mgwrbyp14 = convert_coord_iris(hmirbya14, sji_2832_hdr[167], /y, /a2p)

;North ribbon, from left to right, at 17:46:16 or diff[63]
hmirbxa15 = 499.1
hmirbya15 = 264.7
hmirbxp15 = convert_coord_hmi(hmirbxa15, diffindex[63],  /x, /a2p)
hmirbyp15 = convert_coord_hmi(hmirbya15, diffindex[63],  /y, /a2p)
sirbxp15 = convert_coord_iris(hmirbxa15, sji_1400_hdr[498], /x, /a2p)
sirbyp15 = convert_coord_iris(hmirbya15, sji_1400_hdr[498], /y, /a2p)
mgrbxp15 = convert_coord_iris(hmirbxa15, sji_2796_hdr[664], /x, /a2p)
mgrbyp15 = convert_coord_iris(hmirbya15, sji_2796_hdr[664], /y, /a2p)
mgwrbxp15 = convert_coord_iris(hmirbxa15, sji_2832_hdr[167], /x, /a2p)
mgwrbyp15 = convert_coord_iris(hmirbya15, sji_2832_hdr[167], /y, /a2p)

hmirbxa16 = 502.1
hmirbya16 = 263.8
hmirbxp16 = convert_coord_hmi(hmirbxa16, diffindex[63],  /x, /a2p)
hmirbyp16 = convert_coord_hmi(hmirbya16, diffindex[63],  /y, /a2p)
sirbxp16 = convert_coord_iris(hmirbxa16, sji_1400_hdr[498], /x, /a2p)
sirbyp16 = convert_coord_iris(hmirbya16, sji_1400_hdr[498], /y, /a2p)
mgrbxp16 = convert_coord_iris(hmirbxa16, sji_2796_hdr[664], /x, /a2p)
mgrbyp16 = convert_coord_iris(hmirbya16, sji_2796_hdr[664], /y, /a2p)
mgwrbxp16 = convert_coord_iris(hmirbxa16, sji_2832_hdr[167], /x, /a2p)
mgwrbyp16 = convert_coord_iris(hmirbya16, sji_2832_hdr[167], /y, /a2p)

hmirbxa17 = 504.6
hmirbya17 = 267.0
hmirbxp17 = convert_coord_hmi(hmirbxa17, diffindex[63],  /x, /a2p)
hmirbyp17 = convert_coord_hmi(hmirbya17, diffindex[63],  /y, /a2p)
sirbxp17 = convert_coord_iris(hmirbxa17, sji_1400_hdr[498], /x, /a2p)
sirbyp17 = convert_coord_iris(hmirbya17, sji_1400_hdr[498], /y, /a2p)
mgrbxp17 = convert_coord_iris(hmirbxa17, sji_2796_hdr[664], /x, /a2p)
mgrbyp17 = convert_coord_iris(hmirbya17, sji_2796_hdr[664], /y, /a2p)
mgwrbxp17 = convert_coord_iris(hmirbxa17, sji_2832_hdr[167], /x, /a2p)
mgwrbyp17 = convert_coord_iris(hmirbya17, sji_2832_hdr[167], /y, /a2p)

hmirbxa18 = 508.4
hmirbya18 = 269.8
hmirbxp18 = convert_coord_hmi(hmirbxa18, diffindex[63],  /x, /a2p)
hmirbyp18 = convert_coord_hmi(hmirbya18, diffindex[63],  /y, /a2p)
sirbxp18 = convert_coord_iris(hmirbxa18, sji_1400_hdr[498], /x, /a2p)
sirbyp18 = convert_coord_iris(hmirbya18, sji_1400_hdr[498], /y, /a2p)
mgrbxp18 = convert_coord_iris(hmirbxa18, sji_2796_hdr[664], /x, /a2p)
mgrbyp18 = convert_coord_iris(hmirbya18, sji_2796_hdr[664], /y, /a2p)
mgwrbxp18 = convert_coord_iris(hmirbxa18, sji_2832_hdr[167], /x, /a2p)
mgwrbyp18 = convert_coord_iris(hmirbya18, sji_2832_hdr[167], /y, /a2p)

hmirbxa19 = 511. ;rbxa,rbxpcorr = 39
hmirbya19 = 272. ;rbya,rbypcorr = 90
hmirbxp19 = convert_coord_hmi(hmirbxa19, diffindex[63],  /x, /a2p)
hmirbyp19 = convert_coord_hmi(hmirbya19, diffindex[63],  /y, /a2p)
sirbxp19 = convert_coord_iris(hmirbxa19, sji_1400_hdr[498], /x, /a2p)
sirbyp19 = convert_coord_iris(hmirbya19, sji_1400_hdr[498], /y, /a2p)
mgrbxp19 = convert_coord_iris(hmirbxa19, sji_2796_hdr[664], /x, /a2p)
mgrbyp19 = convert_coord_iris(hmirbya19, sji_2796_hdr[664], /y, /a2p)
mgwrbxp19 = convert_coord_iris(hmirbxa19, sji_2832_hdr[167], /x, /a2p)
mgwrbyp19 = convert_coord_iris(hmirbya19, sji_2832_hdr[167], /y, /a2p)




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
tsprb = strarr(sample*nn)
tspqk = strarr(sample*nn)
rbboxarr = fltarr(sample*nn)

qkimax = fltarr(nnn)
rbimax = fltarr(nnn)


;;;;;;;;;FILL ARRAYS
sirbxp 
sirbyp 
mgrbxp 
mgrbyp 
mgwrbxp
mgwrbyp
;;SI IV 1400
for i = 0, nsi-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qksimax[i] = map1400[i].data[qksixp, qksiyp] ;qksimax[i] = map1400[387 + i].data[qksixp, qksiyp]
;;calculate contrast value for ribbon pixels on all frames to save time
rbsimax[i] = map1400[i].data[sirbxp, sirbyp]
rbsimax1[i] = map1400[i].data[sirbxp1, sirbyp1]
rbsimax2[i] = map1400[i].data[sirbxp2, sirbyp2]
rbsimax3[i] = map1400[i].data[sirbxp3, sirbyp3]
rbsimax4[i] = map1400[i].data[sirbxp4, sirbyp4]
rbsimax5[i] = map1400[i].data[sirbxp5, sirbyp5]
rbsimax6[i] = map1400[i].data[sirbxp6, sirbyp6]
rbsimax7[i] = map1400[i].data[sirbxp7, sirbyp7]
rbsimax8[i] = map1400[i].data[sirbxp8, sirbyp8]
rbsimax9[i] = map1400[i].data[sirbxp9, sirbyp9]
rbsimax10[i] = map1400[i].data[sirbxp10, sirbyp10]
rbsimax11[i] = map1400[i].data[sirbxp11, sirbyp11]
rbsimax12[i] = map1400[i].data[sirbxp12, sirbyp12]
rbsimax13[i] = map1400[i].data[sirbxp13, sirbyp13]
rbsimax14[i] = map1400[i].data[sirbxp14, sirbyp14]
rbsimax15[i] = map1400[i].data[sirbxp15, sirbyp15]
rbsimax16[i] = map1400[i].data[sirbxp16, sirbyp16]
rbsimax17[i] = map1400[i].data[sirbxp17, sirbyp17]
rbsimax18[i] = map1400[i].data[sirbxp18, sirbyp18]
rbsimax19[i] = map1400[i].data[sirbxp19, sirbyp19] ; original ribbon coords
endfor

;calculate flux and energy
iris_radiometric_calibration, qksimax, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji
iris_radiometric_calibration, rbsimax, wave = 1400., n_pixels = 1,Fsirb, Esirb, /sji
iris_radiometric_calibration, rbsimax1, wave = 2832., n_pixels = 1,Fsirb1, Esirb1, /sji
iris_radiometric_calibration, rbsimax2, wave = 2832., n_pixels = 1,Fsirb2, Esirb2, /sji
iris_radiometric_calibration, rbsimax3, wave = 2832., n_pixels = 1,Fsirb3, Esirb3, /sji
iris_radiometric_calibration, rbsimax4, wave = 2832., n_pixels = 1,Fsirb4, Esirb4, /sji
iris_radiometric_calibration, rbsimax5, wave = 2832., n_pixels = 1,Fsirb5, Esirb5, /sji
iris_radiometric_calibration, rbsimax6, wave = 2832., n_pixels = 1,Fsirb6, Esirb6, /sji
iris_radiometric_calibration, rbsimax7, wave = 2832., n_pixels = 1,Fsirb7, Esirb7, /sji
iris_radiometric_calibration, rbsimax8, wave = 2832., n_pixels = 1,Fsirb8, Esirb8, /sji
iris_radiometric_calibration, rbsimax9, wave = 2832., n_pixels = 1,Fsirb9, Esirb9, /sji
iris_radiometric_calibration, rbsimax10, wave = 2832., n_pixels = 1,Fsirb10, Esirb10, /sji
iris_radiometric_calibration, rbsimax11, wave = 2832., n_pixels = 1,Fsirb11, Esirb11, /sji
iris_radiometric_calibration, rbsimax12, wave = 2832., n_pixels = 1,Fsirb12, Esirb12, /sji
iris_radiometric_calibration, rbsimax13, wave = 2832., n_pixels = 1,Fsirb13, Esirb13, /sji
iris_radiometric_calibration, rbsimax14, wave = 2832., n_pixels = 1,Fsirb14, Esirb14, /sji
iris_radiometric_calibration, rbsimax15, wave = 2832., n_pixels = 1,Fsirb15, Esirb15, /sji
iris_radiometric_calibration, rbsimax16, wave = 2832., n_pixels = 1,Fsirb16, Esirb16, /sji
iris_radiometric_calibration, rbsimax17, wave = 2832., n_pixels = 1,Fsirb17, Esirb17, /sji
iris_radiometric_calibration, rbsimax18, wave = 2832., n_pixels = 1,Fsirb18, Esirb18, /sji
iris_radiometric_calibration, rbsimax19, wave = 2832., n_pixels = 1,Fsirb19, Esirb19, /sji

;	iris_radiometric_calibration, rbsimax1, wave = 1400., n_pixels = 1,Fsirb1, Esirb1, /sji
;	iris_radiometric_calibration, rbsimax2, wave = 1400., n_pixels = 1,Fsirb2, Esirb2, /sji
;	iris_radiometric_calibration, rbsimax3, wave = 1400., n_pixels = 1,Fsirb3, Esirb3, /sji
;	iris_radiometric_calibration, rbsimax4, wave = 1400., n_pixels = 1,Fsirb4, Esirb4, /sji

;;MG II 2796
for i = 0, nmg-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgmax[i] = submg[i].data[qkmgxp, qkmgyp] ;qkmgmax[i] = submg[17 + i].data[qkmgxp, qkmgyp]
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgmax[i] = submg[i].data[mgrbxp, mgrbyp] 
rbmgmax1[i] = submg[i].data[mgrbxp1, mgrbyp1]
rbmgmax2[i] = submg[i].data[mgrbxp2, mgrbyp2]
rbmgmax3[i] = submg[i].data[mgrbxp3, mgrbyp3]
rbmgmax4[i] = submg[i].data[mgrbxp4, mgrbyp4]
rbmgmax5[i] = submg[i].data[mgrbxp5, mgrbyp5]
rbmgmax6[i] = submg[i].data[mgrbxp6, mgrbyp6]
rbmgmax7[i] = submg[i].data[mgrbxp7, mgrbyp7]
rbmgmax8[i] = submg[i].data[mgrbxp8, mgrbyp8]
rbmgmax9[i] = submg[i].data[mgrbxp9, mgrbyp9]
rbmgmax10[i] = submg[i].data[mgrbxp10, mgrbyp10]
rbmgmax11[i] = submg[i].data[mgrbxp11, mgrbyp11]
rbmgmax12[i] = submg[i].data[mgrbxp12, mgrbyp12]
rbmgmax13[i] = submg[i].data[mgrbxp13, mgrbyp13]
rbmgmax14[i] = submg[i].data[mgrbxp14, mgrbyp14]
rbmgmax15[i] = submg[i].data[mgrbxp15, mgrbyp15]
rbmgmax16[i] = submg[i].data[mgrbxp16, mgrbyp16]
rbmgmax17[i] = submg[i].data[mgrbxp17, mgrbyp17]
rbmgmax18[i] = submg[i].data[mgrbxp18, mgrbyp18]
rbmgmax19[i] = submg[i].data[mgrbxp19, mgrbyp19]
endfor

;calculate flux and energy
iris_radiometric_calibration, qkmgmax, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji
iris_radiometric_calibration, rbmgmax, wave = 2976., n_pixels = 1,Fmgrb, Emgrb, /sji
iris_radiometric_calibration, rbmgmax1, wave = 2832., n_pixels = 1,Fmgrb1, Emgrb1, /sji
iris_radiometric_calibration, rbmgmax2, wave = 2832., n_pixels = 1,Fmgrb2, Emgrb2, /sji
iris_radiometric_calibration, rbmgmax3, wave = 2832., n_pixels = 1,Fmgrb3, Emgrb3, /sji
iris_radiometric_calibration, rbmgmax4, wave = 2832., n_pixels = 1,Fmgrb4, Emgrb4, /sji
iris_radiometric_calibration, rbmgmax5, wave = 2832., n_pixels = 1,Fmgrb5, Emgrb5, /sji
iris_radiometric_calibration, rbmgmax6, wave = 2832., n_pixels = 1,Fmgrb6, Emgrb6, /sji
iris_radiometric_calibration, rbmgmax7, wave = 2832., n_pixels = 1,Fmgrb7, Emgrb7, /sji
iris_radiometric_calibration, rbmgmax8, wave = 2832., n_pixels = 1,Fmgrb8, Emgrb8, /sji
iris_radiometric_calibration, rbmgmax9, wave = 2832., n_pixels = 1,Fmgrb9, Emgrb9, /sji
iris_radiometric_calibration, rbmgmax10, wave = 2832., n_pixels = 1,Fmgrb10, Emgrb10, /sji
iris_radiometric_calibration, rbmgmax11, wave = 2832., n_pixels = 1,Fmgrb11, Emgrb11, /sji
iris_radiometric_calibration, rbmgmax12, wave = 2832., n_pixels = 1,Fmgrb12, Emgrb12, /sji
iris_radiometric_calibration, rbmgmax13, wave = 2832., n_pixels = 1,Fmgrb13, Emgrb13, /sji
iris_radiometric_calibration, rbmgmax14, wave = 2832., n_pixels = 1,Fmgrb14, Emgrb14, /sji
iris_radiometric_calibration, rbmgmax15, wave = 2832., n_pixels = 1,Fmgrb15, Emgrb15, /sji
iris_radiometric_calibration, rbmgmax16, wave = 2832., n_pixels = 1,Fmgrb16, Emgrb16, /sji
iris_radiometric_calibration, rbmgmax17, wave = 2832., n_pixels = 1,Fmgrb17, Emgrb17, /sji
iris_radiometric_calibration, rbmgmax18, wave = 2832., n_pixels = 1,Fmgrb18, Emgrb18, /sji
iris_radiometric_calibration, rbmgmax19, wave = 2832., n_pixels = 1,Fmgrb19, Emgrb19, /sji


;;BALMER
;sp quake
for j = 0, 19, do begin
jj = string(j, format = '(I0)')
com = 'slitp = find_iris_slit_pos(hmirbxp'+jj+',sp2826)'
exe = execute(com)
com = 'spyp = find_iris_slit_pos(hmirbxp'+jj+',sp2826, /y, /a2p)'
exe = execute(com)
    for i = 0, nn-1, 1 do begin
    
    slitpos[i] = string(slitp, format = '(I0)')
    spyp[i] = string(spyp, format = '(I0)')

    com = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,'+slitpos+','+spyp+'])/((44-39))'
    exe = execute(com)

    com = 'tsprb[i] = sp2826.'+tagarr[i]+'.time_ccsds['+slitpos+']'
    exe = execute(com)

;    comt = 'tspqk[i] = sp2826.'+tagarr[i]+'.time_ccsds[3]'
;    exet1 = execute(comt)

;    comi = 'spboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,3:4,435])/((44-39)*2)'
;    exet = execute(comi)

;    comt = 'tsprb[0] = sp2826.'+tagarr[i]+'.time_ccsds[0]'
;    exet1 = execute(comt)

;    comi = 'rbboxarr[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
;    exet = execute(comi)

    ;		comi = 'rbboxarr1[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
    ;		exet = execute(comi)

    ;		comi = 'rbboxarr2[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
    ;		exet = execute(comi)

    ;		comi = 'rbboxarr3[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
    ;		exet = execute(comi)

    ;		comi = 'rbboxarr4[i] = total(sp2826.'+tagarr[i]+'.int[39:44,0,485.5])/((44-39))'
    ;		exet = execute(comi)

    endfor
;;calculate flux and energy
wav1 = sp2826.tag00.wvl[39]
wav2 = sp2826.tag00.wvl[44]
w1 = string(wav1, format = '(I0)')
w2 = string(wav2, format = '(I0)')
com = 'iris_radiometric_calibration, rbboxarr, wave = ['+w1+', '+w2+'], n_pixels = 10, Fsprb'+jj+', Esprb'+jj+' ,/sg
exe = execute(com)
endfor
tsp = timearr

;;;calculate flux and energy
;w1 = sp2826.tag00.wvl[39]
;w2 = sp2826.tag00.wvl[44]
;iris_radiometric_calibration, spboxarr, wave = [w1, w2], n_pixels = 10,Fspqk, Espqk ,/sg
;iris_radiometric_calibration, rbboxarr, wave = [w1, w2], n_pixels = 5,Fsprb, Esprb ,/sg



;;MGW 2832
for i = 0, nmgw-1, 1 do begin
;;calculate contrast value for quake pixel on all frames to save time
qkmgwmax[i] = map2832[i].data[qkmgwxp,qkmgwyp ]  ;559, 441
;;calculate contrast value for ribbon pixel on all frames to save time
rbmgwmax[i] = map2832[i].data[mgwrbxp, mgwrbyp]
rbmgwmax1[i] = map2832[i].data[mgwrbxp1, mgwrbyp1]
rbmgwmax2[i] = map2832[i].data[mgwrbxp2, mgwrbyp2]
rbmgwmax3[i] = map2832[i].data[mgwrbxp3, mgwrbyp3]
rbmgwmax4[i] = map2832[i].data[mgwrbxp4, mgwrbyp4]
rbmgwmax5[i] = map2832[i].data[mgwrbxp5, mgwrbyp5]
rbmgwmax6[i] = map2832[i].data[mgwrbxp6, mgwrbyp6]
rbmgwmax7[i] = map2832[i].data[mgwrbxp7, mgwrbyp7]
rbmgwmax8[i] = map2832[i].data[mgwrbxp8, mgwrbyp8]
rbmgwmax9[i] = map2832[i].data[mgwrbxp9, mgwrbyp9]
rbmgwmax10[i] = map2832[i].data[mgwrbxp10, mgwrbyp10]
rbmgwmax11[i] = map2832[i].data[mgwrbxp11, mgwrbyp11]
rbmgwmax12[i] = map2832[i].data[mgwrbxp12, mgwrbyp12]
rbmgwmax13[i] = map2832[i].data[mgwrbxp13, mgwrbyp13]
rbmgwmax14[i] = map2832[i].data[mgwrbxp14, mgwrbyp14]
rbmgwmax15[i] = map2832[i].data[mgwrbxp15, mgwrbyp15]
rbmgwmax16[i] = map2832[i].data[mgwrbxp16, mgwrbyp16]
rbmgwmax17[i] = map2832[i].data[mgwrbxp17, mgwrbyp17]
rbmgwmax18[i] = map2832[i].data[mgwrbxp18, mgwrbyp18]
rbmgwmax19[i] = map2832[i].data[mgwrbxp19, mgwrbyp19]
endfor   

;calculate flux and energy
iris_radiometric_calibration, qkmgwmax, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji
iris_radiometric_calibration, rbmgwmax, wave = 2832., n_pixels = 1,Fmgwrb, Emgwrb, /sji
iris_radiometric_calibration, rbmgwmax1, wave = 2832., n_pixels = 1,Fmgwrb1, Emgwrb1, /sji
iris_radiometric_calibration, rbmgwmax2, wave = 2832., n_pixels = 1,Fmgwrb2, Emgwrb2, /sji
iris_radiometric_calibration, rbmgwmax3, wave = 2832., n_pixels = 1,Fmgwrb3, Emgwrb3, /sji
iris_radiometric_calibration, rbmgwmax4, wave = 2832., n_pixels = 1,Fmgwrb4, Emgwrb4, /sji
iris_radiometric_calibration, rbmgwmax5, wave = 2832., n_pixels = 1,Fmgwrb5, Emgwrb5, /sji
iris_radiometric_calibration, rbmgwmax6, wave = 2832., n_pixels = 1,Fmgwrb6, Emgwrb6, /sji
iris_radiometric_calibration, rbmgwmax7, wave = 2832., n_pixels = 1,Fmgwrb7, Emgwrb7, /sji
iris_radiometric_calibration, rbmgwmax8, wave = 2832., n_pixels = 1,Fmgwrb8, Emgwrb8, /sji
iris_radiometric_calibration, rbmgwmax9, wave = 2832., n_pixels = 1,Fmgwrb9, Emgwrb9, /sji
iris_radiometric_calibration, rbmgwmax10, wave = 2832., n_pixels = 1,Fmgwrb10, Emgwrb10, /sji
iris_radiometric_calibration, rbmgwmax11, wave = 2832., n_pixels = 1,Fmgwrb11, Emgwrb11, /sji
iris_radiometric_calibration, rbmgwmax12, wave = 2832., n_pixels = 1,Fmgwrb12, Emgwrb12, /sji
iris_radiometric_calibration, rbmgwmax13, wave = 2832., n_pixels = 1,Fmgwrb13, Emgwrb13, /sji
iris_radiometric_calibration, rbmgwmax14, wave = 2832., n_pixels = 1,Fmgwrb14, Emgwrb14, /sji
iris_radiometric_calibration, rbmgwmax15, wave = 2832., n_pixels = 1,Fmgwrb15, Emgwrb15, /sji
iris_radiometric_calibration, rbmgwmax16, wave = 2832., n_pixels = 1,Fmgwrb16, Emgwrb16, /sji
iris_radiometric_calibration, rbmgwmax17, wave = 2832., n_pixels = 1,Fmgwrb17, Emgwrb17, /sji
iris_radiometric_calibration, rbmgwmax18, wave = 2832., n_pixels = 1,Fmgwrb18, Emgwrb18, /sji
iris_radiometric_calibration, rbmgwmax19, wave = 2832., n_pixels = 1,Fmgwrb19, Emgwrb19, /sji


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
rbimax15[i] = diff[i].data[hmirbxp15, hmirbyp15]
rbimax16[i] = diff[i].data[hmirbxp16, hmirbyp16]
rbimax17[i] = diff[i].data[hmirbxp17, hmirbyp17]
rbimax18[i] = diff[i].data[hmirbxp18, hmirbyp18]
rbimax19[i] = diff[i].data[hmirbxp19, hmirbyp19] ;original ribbon location

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
hmi_radiometric_calibration,rbimax15,n_pixels = 1,Fhmirb15,Ehmirb15
hmi_radiometric_calibration,rbimax16,n_pixels = 1,Fhmirb16,Ehmirb16
hmi_radiometric_calibration,rbimax17,n_pixels = 1,Fhmirb17,Ehmirb17
hmi_radiometric_calibration,rbimax18,n_pixels = 1,Fhmirb18,Ehmirb18
hmi_radiometric_calibration,rbimax19,n_pixels = 1,Fhmirb19,Ehmirb19


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
Fsirb1, Esirb1, $
Fsirb2, Esirb2, $
Fsirb3, Esirb3, $
Fsirb4, Esirb4, $
Fsirb5, Esirb5, $
Fsirb6, Esirb6, $
Fsirb7, Esirb7, $
Fsirb8, Esirb8, $
Fsirb9, Esirb9, $
Fsirb10, Esirb10, $
Fsirb11, Esirb11, $
Fsirb12, Esirb12, $
Fsirb13, Esirb13, $
Fsirb14, Esirb14, $
Fsirb15, Esirb15, $
Fsirb16, Esirb16, $
Fsirb17, Esirb17, $
Fsirb18, Esirb18, $
Fsirb19, Esirb19, $

;mgii; for time use tmgii
Fmgqk, Emgqk, $
Fmgrb, Emgrb, $
Fmgrb1, Emgrb1, $
Fmgrb2, Emgrb2, $
Fmgrb3, Emgrb3, $
Fmgrb4, Emgrb4, $
Fmgrb5, Emgrb5, $
Fmgrb6, Emgrb6, $
Fmgrb7, Emgrb7, $
Fmgrb8, Emgrb8, $
Fmgrb9, Emgrb9, $
Fmgrb10, Emgrb10, $
Fmgrb11, Emgrb11, $
Fmgrb12, Emgrb12, $
Fmgrb13, Emgrb13, $
Fmgrb14, Emgrb14, $
Fmgrb15, Emgrb15, $
Fmgrb16, Emgrb16, $
Fmgrb17, Emgrb17, $
Fmgrb18, Emgrb18, $
Fmgrb19, Emgrb19, $

;balmer; for time use timearr
Fspqk, Espqk, $
Fsprb, Esprb, $
tslit0, $
tslit3, $

;mgw; for time use tmgw
Fmgwqk, Emgwqk, $
Fmgwrb, Emgwrb, $
Fmgwrb1, Emgwrb1, $
Fmgwrb2, Emgwrb2, $
Fmgwrb3, Emgwrb3, $
Fmgwrb4, Emgwrb4, $
Fmgwrb5, Emgwrb5, $
Fmgwrb6, Emgwrb6, $
Fmgwrb7, Emgwrb7, $
Fmgwrb8, Emgwrb8, $
Fmgwrb9, Emgwrb9, $
Fmgwrb10, Emgwrb10, $
Fmgwrb11, Emgwrb11, $
Fmgwrb12, Emgwrb12, $
Fmgwrb13, Emgwrb13, $
Fmgwrb14, Emgwrb14, $
Fmgwrb15, Emgwrb15, $
Fmgwrb16, Emgwrb16, $
Fmgwrb17, Emgwrb17, $
Fmgwrb18, Emgwrb18, $
Fmgwrb19, Emgwrb19, $

;hmi; for time use thmi
Fhmiqk, Ehmiqk, $
Fhmirb, Ehmirb, $
Fhmirb1, Ehmirb1, $
Fhmirb2, Ehmirb2, $
Fhmirb3, Ehmirb3, $
Fhmirb4, Ehmirb4, $
Fhmirb5, Ehmirb5, $
Fhmirb6, Ehmirb6, $
Fhmirb7, Ehmirb7, $
Fhmirb8, Ehmirb8, $
Fhmirb9, Ehmirb9, $
Fhmirb10, Ehmirb10, $
Fhmirb11, Ehmirb11, $
Fhmirb12, Ehmirb12, $
Fhmirb13, Ehmirb13, $
Fhmirb14, Ehmirb14, $
Fhmirb15, Ehmirb15, $
Fhmirb16, Ehmirb16, $
Fhmirb17, Ehmirb17, $
Fhmirb18, Ehmirb18, $
Fhmirb19, Ehmirb19, $

;quake area
Fqk_9px_area, Eqk_9px_area, $
filename = '29-Mar-2014-energies-for-python-'+date+'.sav'


end
