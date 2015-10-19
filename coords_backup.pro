sic = coords_array(sicoords)
nc =10         
sic1 = fltarr(2,nc)
sic2 = fltarr(2,nc)
sic1[0,*] = sic[0,0:9]
sic1[1,*] = sic[1,0:9]
sic2[0,*] = sic[0,10:19]
sic2[1,*] = sic[1,10:19]

file = 'sicoords2.txt'
openw, lun, file, /get_lun
printf, lun, sic2
free_lun, lun


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




com = 'f'+dataset[k]+'srb1 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'srb2 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'nrb1 = fltarr(3, '+ncst+')'
exe = execute(com)
com = 'f'+dataset[k]+'nrb2 = fltarr(3, '+ncst+')'
exe = execute(com)
;ind;x_coord;energy
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



file = dataset[k]+'ribbon_coords_x__flux__energy.txt'
openw, lun, file, /get_lun
printf,lun, 'srb = south ribbon, nrb = north ribbon.'
printf,lun, 'These arrays contain; the frame number '
printf,lun, 'containing the maximum energy value; '
printf,lun, 'the ribbon location x_coord; and the  '
printf,lun, 'the associated energy.'
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '**************FLUX*******************'
printf,lun, '*************************************'
printf,lun, '**************quake******************'
printf,lun, '*****frame********x_coord****energy**'
com = 'printf, lun, f'+dataset[k]+'qkmx'   
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '***************srb1******************'
printf,lun, '*****frame********x_coord****energy**'
com = 'printf, lun, f'+dataset[k]+'srb1'
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '***************nrb1******************'
com = 'printf, lun, f'+dataset[k]+'nrb1'
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '***************srb2******************'
com = 'printf, lun, f'+dataset[k]+'srb2'
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '***************nrb2******************'
com = 'printf, lun, f'+dataset[k]+'nrb2'
exe = execute(com)
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '**************ENERGY*****************'
printf,lun, '*************************************'
printf,lun, '*************************************'
printf,lun, '**************quake******************'
printf,lun, '*****frame********x_coord****energy**'
com = 'printf, lun, e'+dataset[k]+'qkmx'   
exe = execute(com)
printf,lun, '************************************'
printf,lun,  '**************srb1******************'
com = 'printf, lun, e'+dataset[k]+'srb1'
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb1******************'
com = 'printf, lun, e'+dataset[k]+'nrb1'
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************srb2******************'
com = 'printf, lun, e'+dataset[k]+'srb2'
exe = execute(com)
printf,lun,  '************************************'
printf,lun,  '**************nrb2******************'
com = 'printf, lun, e'+dataset[k]+'nrb2'
exe = execute(com)
free_lun, lun
endfor


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

