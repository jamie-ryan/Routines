;pro auto_rhessi_img

;./Scripts/bsidl.sh Routines/auto_rhessi_img.pro auto_rhessi_img.log &

;change these values before running csh2idl.sh 
e1 = 10.D ;keV
e2 = 100.D
e_range = [e1, e2]
increment = 10. ;keV
hrst = 17
minst = 44
secst = 0
hrend = 17
minend = 52
secend = 0
timg = 20.

;algo = 'PIXON'
algo = 'Back Projection'
;algo = 'CLEAN' 
;algo = 'PIXON' 
;algo = 'MEM_NJIT' 
;algo = 'FORWARDFIT'
;algo = 'VIS_FWDFIT' 

rhessi_img, energy_range = e_range, increment, hrst, minst, secst, hrend, minend, secend, timg, algo

;end
