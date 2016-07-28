;bsidl.sh Routines/auto_rhessi_img_280716.pro auto_rhessi_img_260716.log &

;change these values before running csh2idl.sh 



e1 = 3.D ;keV
e2 = 10.D
energy_range = [e1, e2]
increment = 1. ;keV
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

e1 = 10.D ;keV
e2 = 20.D
energy_range = [e1, e2]
increment = 1. ;keV
hrstart = 17
minstart = 44
secst = 0
hrend = 17
minend = 52
secend = 0
timg = 12.

;algorithm = 'PIXON'
;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm

e1 = 20.D ;keV
e2 = 30.D
energy_range = [e1, e2]
increment = 1. ;keV
hrstart = 17
minstart = 44
secst = 0
hrend = 17
minend = 52
secend = 0
timg = 12.

;algorithm = 'PIXON'
;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 

rhessi_img, energy_range = energy_range, increment, hrstart, minstart, secst, hrend, minend, secend, timg, algorithm



e1 = 30.D ;keV
e2 = 40.D
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

e1 = 40.D ;keV
e2 = 50.D
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

e1 = 50.D ;keV
e2 = 60.D
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


e1 = 60.D ;keV
e2 = 70.D
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

e1 = 70.D ;keV
e2 = 80.D
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


e1 = 80.D ;keV
e2 = 90.D
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

