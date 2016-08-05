;bsidl.sh Routines/auto_rhessi_img_core_4.pro auto_rhessi_img_core_4.log


e1 = 90.D ;keV
e2 = 100.D
energy_range = [e1, e2]
increment = 5. ;keV
hrstart = 17
minstart = 44
secst = 0
hrend = 17
minend = 52
secend = 0
timg = 12.

;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm

e1 = 100.D ;keV
e2 = 160.D
energy_range = [e1, e2]
increment = 15. ;keV
hrstart = 17
minstart = 44
secst = 0
hrend = 17
minend = 52
secend = 0
timg = 12.

;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm
