e1 = 9.D ;keV
e2 = 10.D
energy_range = [e1, e2]
increment = 1. ;keV
hrstart = 17
minstart = 46
secst = 0
hrend = 17
minend = 47
secend = 0
timg = 12.


;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm
