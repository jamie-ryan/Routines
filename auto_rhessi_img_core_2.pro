;bsidl.sh Routines/auto_rhessi_img_core_2.pro auto_rhessi_img_core_2.log


e1 = 10.D ;keV
e2 = 30.D
energy_range = [e1, e2]
increment = 3. ;keV
hrstart = 17
minstart = 45
secst = 50
hrend = 17
minend = 48
secend = 50
timg = 16.

;algorithm = 'PIXON'
;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm
