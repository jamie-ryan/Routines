;bsidl.sh Routines/auto_rhessi_img_core_1.pro auto_rhessi_img_core_1.log


e1 = 3.D ;keV
e2 = 20.D
energy_range = [e1, e2]
increment = 1. ;keV
hrstart = 17
minstart = 45
secst = 0
hrend = 17
minend = 51
secend = 0
timg = 16.


;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm
