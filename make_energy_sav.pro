pro make_energy_sav

tic
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
nrb = 20 ; number of ribbon sample points
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
hmirbxa0 = 517.8
hmirbya0 = 260.5
hmirbxp0 = convert_coord_hmi(hmirbxa0, diffindex[62],  /x, /a2p)
hmirbyp0 = convert_coord_hmi(hmirbya0, diffindex[62],  /y, /a2p)
sirbxp0 = convert_coord_iris(hmirbxa0, sji_1400_hdr[495], /x, /a2p)
sirbyp0 = convert_coord_iris(hmirbya0, sji_1400_hdr[495], /y, /a2p)
mgrbxp0 = convert_coord_iris(hmirbxa0, sji_2796_hdr[661], /x, /a2p)
mgrbyp0 = convert_coord_iris(hmirbya0, sji_2796_hdr[661], /y, /a2p)
mgwrbxp0 = convert_coord_iris(hmirbxa0, sji_2832_hdr[166], /x, /a2p)
mgwrbyp0 = convert_coord_iris(hmirbya0, sji_2832_hdr[166], /y, /a2p)

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

hmirbxa6 = 503.8 
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
qkmg = fltarr(nmg)
qkmgw = fltarr(nmgw)
qksi = fltarr(nsi)
qkbalmer = fltarr(sample*nn)
tspqk = strarr(sample*nn)
qkhmi = fltarr(nnn)


slitpos = strarr(nn)
spypos = strarr(nn)
qkslitpos = strarr(nn)
qkspypos = strarr(nn)

;;multi-ribbon coord max flux and energy
sifmx = fltarr(2,nrb) ;fmx[0,*] = time, fmx[1,*] = max
siemx = fltarr(2,nrb)
sicoords = fltarr(2, nrb)
mgfmx = fltarr(2,nrb) ;fmx[0,*] = time, fmx[1,*] = max
mgemx = fltarr(2,nrb)
mgcoords = fltarr(2, nrb)
balmerfmx = fltarr(2,nrb) ;fmx[0,*] = time, fmx[1,*] = max
balmeremx = fltarr(2,nrb)
balmercoords = fltarr(2, nrb)
mgwfmx = fltarr(2,nrb) ;fmx[0,*] = time, fmx[1,*] = max
mgwemx = fltarr(2,nrb)
mgwcoords = fltarr(2, nrb)
hmifmx = fltarr(2,nrb) ;fmx[0,*] = time, fmx[1,*] = max
hmiemx = fltarr(2,nrb)
hmicoords = fltarr(2, nrb)

;;;make time arrays
tsi = map1400.time
tmg = submg.time
tmgw = map2832.time
thmi = diff.time


for j = 0, nrb-1 do begin
jj = string(j, format = '(I0)')

com = 'rbsi'+jj+' = fltarr(nsi)'
exe = execute(com)
com = 'rbmg'+jj+' = fltarr(nmg)'
exe = execute(com)
com = 'rbbalmer'+jj+' = fltarr(sample*nn)'
exe = execute(com)
com = 'rbmgw'+jj+' = fltarr(nmgw)'
exe = execute(com)
com = 'tsprb'+jj+' = strarr(sample*nn)'
exe = execute(com)
com = 'rbhmi'+jj+' = fltarr(nnn)'
exe = execute(com)

;;;;;;;;;FILL ARRAYS

    ;;SI IV 1400
    for i = 0, nsi-1, 1 do begin
        if (j eq 19) then begin
        qksi[i] = map1400[i].data[qksixp, qksiyp]
        endif
    com = 'rbsi'+jj+'[i] = map1400[i].data[sirbxp'+jj+', sirbyp'+jj+']'
    exe = execute(com)
    endfor
    ;calculate flux and energy
        if (j eq 19) then begin
        iris_radiometric_calibration, qksi, wave = 1400., n_pixels = 1, Fsiqk, Esiqk, /sji
        endif    
    com = 'iris_radiometric_calibration, rbsi'+jj+', wave = 1400., n_pixels = 1,Fsirb'+jj+', Esirb'+jj+', /sji'
    exe = execute(com)

    ;find maximum flux and energy
    com = 'mxf = max(Fsirb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Fsirb'+jj+', loc)'
    exe = execute(com)

    sifmx[0,j] = ind
    sifmx[1,j] = mxf
    
    com = 'mxe = max(Esirb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Esirb'+jj+', loc)'
    exe = execute(com)

    siemx[0,j] = ind
    siemx[1,j] = mxe

    com = 'sicoords[0,'+jj+'] = hmirbxa'+jj
    exe = execute(com)
    com = 'sicoords[1,'+jj+'] = hmirbya'+jj
    exe = execute(com)

    ;;MG II 2796
    for i = 0, nmg-1, 1 do begin
        if (j eq 19) then begin
        qkmg[i] = submg[i].data[qkmgxp, qkmgyp] ;qkmg[i] = submg[17 + i].data[qkmgxp, qkmgyp]
        endif
    com = 'rbmg'+jj+'[i] = submg[i].data[mgrbxp'+jj+', mgrbyp'+jj+']' 
    exe = execute(com)
    endfor
        if (j eq 19) then begin
        ;calculate flux and energy
        iris_radiometric_calibration, qkmg, wave = 2976., n_pixels = 1,Fmgqk, Emgqk, /sji
        endif
    com = 'iris_radiometric_calibration, rbmg'+jj+', wave = 2976., n_pixels = 1,Fmgrb'+jj+', Emgrb'+jj+', /sji'
    exe = execute(com)

    ;find maximum flux and energy
    com = 'mxf = max(Fmgrb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Fmgrb'+jj+', loc)'
    exe = execute(com)

    mgfmx[0,j] = ind
    mgfmx[1,j] = mxf
    
    com = 'mxe = max(Emgrb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Emgrb'+jj+', loc)'
    exe = execute(com)

    mgemx[0,j] = ind
    mgemx[1,j] = mxe

    com = 'mgcoords[0,'+jj+'] = hmirbxa'+jj
    exe = execute(com)
    com = 'mgcoords[1,'+jj+'] = hmirbya'+jj
    exe = execute(com)





    ;;BALMER
    com = 'slitp = find_iris_slit_pos(hmirbxp'+jj+',sp2826)'
    exe = execute(com)
    com = 'spyp = find_iris_slit_pos(hmirbyp'+jj+',sp2826, /y, /a2p)'
    exe = execute(com)
    if (j eq 19) then begin
    com = 'qkslitp = find_iris_slit_pos(qkxa,sp2826)'
    exe = execute(com)
    com = 'qkspyp = find_iris_slit_pos(qkya,sp2826, /y, /a2p)'
    exe = execute(com)
    endif
        for i = 0, nn-1, 1 do begin  
        slitpos = string(slitp[i], format = '(I0)')
        spypos = string(spyp[i], format = '(I0)')

        com = 'rbbalmer'+jj+'[i] = total(sp2826.'+tagarr[i]+'.int[39:44,'+slitpos+','+spypos+'])/((44-39))'
        exe = execute(com)

        com = 'tsprb'+jj+'[i] = sp2826.'+tagarr[i]+'.time_ccsds['+slitpos+']'
        exe = execute(com)
        
        if (j eq 19) then begin
        qkslitpos = string(qkslitp[i], format = '(I0)')
        qkspypos = string(qkspyp[i], format = '(I0)')

        com = 'qkbalmer[i] = total(sp2826.'+tagarr[i]+'.int[39:44,'+qkslitpos+','+qkspypos+'])/((44-39))'
        exe = execute(com)

        com = 'tspqk[i] = sp2826.'+tagarr[i]+'.time_ccsds['+qkslitpos+']'
        exe = execute(com)
        
        endif
        endfor
    ;;calculate flux and energy
    wav1 = sp2826.tag00.wvl[39]
    wav2 = sp2826.tag00.wvl[44]
    w1 = string(wav1, format = '(I0)')
    w2 = string(wav2, format = '(I0)')
        if (j eq 19) then begin
        iris_radiometric_calibration, qkbalmer, wave = [wav1, wav2], n_pixels = 10, Fqkbalmer, Eqkbalmer, /sg
        endif
    com = 'iris_radiometric_calibration, rbbalmer'+jj+', wave = ['+w1+', '+w2+'], n_pixels = 10, Frbbalmer'+jj+', Erbbalmer'+jj+' ,/sg'
    exe = execute(com)

    ;find maximum flux and energy
    com = 'mxf = max(Frbbalmer'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Frbbalmer'+jj+', loc)'
    exe = execute(com)

    balmerfmx[0, j] = ind
    exe = execute(com)
    balmerfmx[1,j] = mxf
    
    com = 'mxe = max(Erbbalmer'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Erbbalmer'+jj+', loc)'
    exe = execute(com)

    balmeremx[0, j] = ind
    exe = execute(com)
    balmeremx[1,j] = mxe

    com = 'balmercoords[0,'+jj+'] = hmirbxa'+jj
    exe = execute(com)
    com = 'balmercoords[1,'+jj+'] = hmirbya'+jj
    exe = execute(com)




    ;;MGW 2832
    for i = 0, nmgw-1, 1 do begin
        if (j eq 19) then begin
        qkmgw[i] = map2832[i].data[qkmgwxp,qkmgwyp ]  ;559, 441
        endif

    com = 'rbmgw'+jj+'[i] = map2832[i].data[mgwrbxp'+jj+', mgwrbyp'+jj+']'
    exe = execute(com)
    endfor   

    ;calculate flux and energy
        if (j eq 19) then begin
        iris_radiometric_calibration, qkmgw, wave = 2832., n_pixels = 1,Fmgwqk, Emgwqk, /sji
        endif

    com = 'iris_radiometric_calibration, rbmgw'+jj+', wave = 2832., n_pixels = 1,Fmgwrb'+jj+', Emgwrb'+jj+', /sji'
    exe = execute(com)

    ;find maximum flux and energy
    com = 'mxf = max(Fmgwrb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Fmgwrb'+jj+', loc)'
    exe = execute(com)

    mgwfmx[0,j] = ind
    mgwfmx[1,j] = mxf
    
    com = 'mxe = max(Emgwrb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Emgwrb'+jj+', loc)'
    exe = execute(com)

    mgwemx[0,j] = ind
    mgwemx[1,j] = mxe

    com = 'mgwcoords[0,'+jj+'] = hmirbxa'+jj
    exe = execute(com)
    com = 'mgwcoords[1,'+jj+'] = hmirbya'+jj
    exe = execute(com)





    ;HMI single pixel
    for i = 0, nnn-1, 1 do begin
        if (j eq 19) then begin
        qkhmi[i] = diff[i].data[qkxp, qkyp]
        endif
    com = 'rbhmi'+jj+'[i] = diff[i].data[hmirbxp'+jj+', hmirbyp'+jj+']'
    exe = execute(com)
    endfor

    ;calculate flux and energy
        if (j eq 19) then begin
        hmi_radiometric_calibration, qkhmi, n_pixels = 1, Fhmiqk, Ehmiqk
        endif
  
    com = 'hmi_radiometric_calibration, rbhmi'+jj+', n_pixels = 1, Fhmirb'+jj+', Ehmirb'+jj+''
    exe = execute(com)

    ;find maximum flux and energy
    com = 'mxf = max(Fhmirb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Fhmirb'+jj+', loc)'
    exe = execute(com)

    hmifmx[0,j] = ind
    hmifmx[1,j] = mxf
    
    com = 'mxe = max(Ehmirb'+jj+', loc)'
    exe = execute(com)
    com = 'ind = array_indices(Ehmirb'+jj+', loc)'
    exe = execute(com)
    

    hmiemx[0,j] = ind
    hmiemx[1,j] = mxe

    com = 'hmicoords[0,'+jj+'] = hmirbxa'+jj
    exe = execute(com)
    com = 'hmicoords[1,'+jj+'] = hmirbya'+jj
    exe = execute(com)


endfor

dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for k = 0, n_elements(dataset) do begin
nc = n_elements(nrb/4)
ncst = string(nc, format = '(I0)')


com = 'f'+dataset[k]+'srb1 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'srb2 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'nrb1 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'nrb2 = fltarr(3, '+ncst+')'
exe = execute(com)

com = 'f'+dataset[k]+'srb1[0,*] = '+dataset[k]+'FMX[0, 0:nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'srb1[1,*] = '+dataset[k]+'coords[0, 0:nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'srb1[2,*] = '+dataset[k]+'FMX[1, 0:nc-1]'
exe = execute(com)

com = 'f'+dataset[k]+'nrb1[0,*] = '+dataset[k]+'FMX[0, nc:2*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'nrb1[1,*] = '+dataset[k]+'coords[0, nc:2*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'nrb1[2,*] = '+dataset[k]+'FMX[1, nc:2*nc-1]'
exe = execute(com)

com = 'f'+dataset[k]+'srb2[0,*] = '+dataset[k]+'FMX[0, 2*nc:3*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'srb2[1,*] = '+dataset[k]+'coords[0, 2*nc:3*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'srb2[2,*] = '+dataset[k]+'FMX[1, 2*nc:3*nc-1]'
exe = execute(com)

com = 'f'+dataset[k]+'nrb2[0,*] = '+dataset[k]+'FMX[0, 3*nc:4*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'nrb2[1,*] = '+dataset[k]+'coords[0, 3*nc:4*nc-1]'
exe = execute(com)
com = 'f'+dataset[k]+'nrb2[2,*] = '+dataset[k]+'FMX[1, 3*nc:4*nc-1]'
exe = execute(com)


com = 'e'+dataset[k]+'srb1[0,*] = '+dataset[k]+'EMX[0, 0:nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'srb1[1,*] = '+dataset[k]+'coords[0, 0:nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'srb1[2,*] = '+dataset[k]+'EMX[1, 0:nc-1]'
exe = execute(com)

com = 'e'+dataset[k]+'nrb1[0,*] = '+dataset[k]+'EMX[0, nc:2*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'nrb1[1,*] = '+dataset[k]+'coords[0, nc:2*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'nrb1[2,*] = '+dataset[k]+'EMX[1, nc:2*nc-1]'
exe = execute(com)

com = 'e'+dataset[k]+'srb2[0,*] = '+dataset[k]+'EMX[0, 2*nc:3*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'srb2[1,*] = '+dataset[k]+'coords[0, 2*nc:3*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'srb2[2,*] = '+dataset[k]+'EMX[1, 2*nc:3*nc-1]'
exe = execute(com)

com = 'e'+dataset[k]+'nrb2[0,*] = '+dataset[k]+'EMX[0, 3*nc:4*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'nrb2[1,*] = '+dataset[k]+'coords[0, 3*nc:4*nc-1]'
exe = execute(com)
com = 'e'+dataset[k]+'nrb2[2,*] = '+dataset[k]+'EMX[1, 3*nc:4*nc-1]'
exe = execute(com)

file = dataset[k]+'ribbon_coords_x__flux__energy.dat'
openw, lun, file, /get_lun
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '**************FLUX*******************'
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun,  '**************srb1******************'
com = 'printf, lun f'+dataset[k]+'srb1'
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb1******************'
com = 'printf, lun, f'+dataset[k]+'nrb1
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************srb2******************'
com = 'printf, lun, f'+dataset[k]+'srb2
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb2******************'
com = 'printf, lun, f'+dataset[k]+'nrb2
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '**************ENERGY*****************'
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '************************************'
printf,lun,  '**************srb1******************'
com = 'printf, lun, e'+dataset[k]+'srb1
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb1******************'
com = 'printf, lun, e'+dataset[k]+'nrb1
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************srb2******************'
com = 'printf, lun, e'+dataset[k]+'srb2
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb2******************'
com = 'printf, lun, e'+dataset[k]+'nrb2
exe = execute(com)
free_lun, lun
endfor


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



;;;make .sav file
save, $
;iris flare area siiv
F_area_siiv0, E_area_siiv0, $
F_area_siiv1, E_area_siiv1, $
F_area_siiv2, E_area_siiv2, $
F_area_siiv3, E_area_siiv3, $
tsi, $
filename = '29-Mar-2014-energies-iris-siiv-area-'+date+'.sav'

save, $
;iris flare area mgii
F_area_mgii0, E_area_mgii0, $
F_area_mgii1, E_area_mgii1, $
F_area_mgii2, E_area_mgii2, $
F_area_mgii3, E_area_mgii3, $
tmg, $
filename = '29-Mar-2014-energies-iris-mgii-area-'+date+'.sav'

save, $
;iris flare area mgw
F_area_mgiiw0, E_area_mgiiw0, $
F_area_mgiiw1, E_area_mgiiw1, $
F_area_mgiiw2, E_area_mgiiw2, $
F_area_mgiiw3, E_area_mgiiw3, $
tmgw, $
filename = '29-Mar-2014-energies-iris-mgw-area-'+date+'.sav'

save, $
;hmi flare area
F_area_hmi0, E_area_hmi0, $
F_area_hmi1, E_area_hmi1, $
F_area_hmi2, E_area_hmi2, $
F_area_hmi3, E_area_hmi3, $
thmi, $
filename = '29-Mar-2014-energies-hmi-area-'+date+'.sav'

save, $
;siiv; for time use tsi
Fsiqk, Esiqk, $
Fsirb0, Esirb0, $
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
tsi, $
sifmx, $
siemx, $
sicoords

fsisrb1, $
esisrb1, $
fsisrb2, $
esisrb2, $
fsinrb1, $
esinrb1, $
fsinrb2, $
esinrb2, $
filename = '29-Mar-2014-energies-iris-siiv-single-pixel-'+date+'.sav'

save, $
;mgii; for time use tmg
Fmgqk, Emgqk, $
Fmgrb0, Emgrb0, $
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
tmg, $
;mgfmx, $
;mgemx, $
;mgcoords, $
fmgsrb1, $
emgsrb1, $
fmgsrb2, $
emgsrb2, $
fmgnrb1, $
emgnrb1, $
fmgnrb2, $
emgnrb2, $
filename = '29-Mar-2014-energies-iris-mgii-single-pixel-'+date+'.sav'

save, $
;balmer; for time use timearr
Fqkbalmer, Eqkbalmer, $
Frbbalmer0, Erbbalmer0, $
Frbbalmer1, Erbbalmer1, $
Frbbalmer2, Erbbalmer2, $
Frbbalmer3, Erbbalmer3, $
Frbbalmer4, Erbbalmer4, $
Frbbalmer5, Erbbalmer5, $
Frbbalmer6, Erbbalmer6, $
Frbbalmer7, Erbbalmer7, $
Frbbalmer8, Erbbalmer8, $
Frbbalmer9, Erbbalmer9, $
Frbbalmer10, Erbbalmer10, $
Frbbalmer11, Erbbalmer11, $
Frbbalmer12, Erbbalmer12, $
Frbbalmer13, Erbbalmer13, $
Frbbalmer14, Erbbalmer14, $
Frbbalmer15, Erbbalmer15, $
Frbbalmer16, Erbbalmer16, $
Frbbalmer17, Erbbalmer17, $
Frbbalmer18, Erbbalmer18, $
Frbbalmer19, Erbbalmer19, $
tspqk, $
tsprb0, $
tsprb1, $
tsprb2, $
tsprb3, $
tsprb4, $
tsprb5, $
tsprb6, $
tsprb7, $
tsprb8, $
tsprb9, $
tsprb10, $
tsprb11, $
tsprb12, $
tsprb13, $
tsprb14, $
tsprb15, $
tsprb16, $
tsprb17, $
tsprb18, $
tsprb19, $
;balmerfmx, $
;balmeremx, $
;balmercoords, $
fbalmersrb1, $
ebalmersrb1, $
fbalmersrb2, $
ebalmersrb2, $
fbalmernrb1, $
ebalmernrb1, $
fbalmernrb2, $
ebalmernrb2, $
filename = '29-Mar-2014-energies-iris-balmer-single-pixel-'+date+'.sav'

save, $
;mgw; for time use tmgw
Fmgwqk, Emgwqk, $
Fmgwrb0, Emgwrb0, $
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
tmgw, $
;mgwfmx, $
;mgwemx, $
;mgwcoords, $
fmgwsrb1, $
emgwsrb1, $
fmgwsrb2, $
emgwsrb2, $
fmgwnrb1, $
emgwnrb1, $
fmgwnrb2, $
emgwnrb2, $
filename = '29-Mar-2014-energies-iris-mgw-single-pixel-'+date+'.sav'

save, $
;hmi; for time use thmi
Fhmiqk, Ehmiqk, $
Fhmirb0, Ehmirb0, $
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
thmi, $
;hmifmx, $
;hmiemx, $
;hmicoords, $
fhmisrb1, $
ehmisrb1, $
fhmisrb2, $
ehmisrb2, $
fhminrb1, $
ehminrb1, $
fhminrb2, $
ehminrb2, $
filename = '29-Mar-2014-energies-hmi-single-pixel-'+date+'.sav'

save, $
;quake area
Fqk_9px_area, Eqk_9px_area, $
thmi, $
filename = '29-Mar-2014-energies-hmi-qkarea-'+date+'.sav'


toc
end
