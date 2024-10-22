;bsidl.sh Routines/auto_rhessi_img_core_3.pro auto_rhessi_img_core_3.log


e1 = 50.D ;keV
e2 = 70.D
energy_range = [e1, e2]
increment = 5. ;keV
yrst = '2014'
yrend = '2014'
mthst = 'Mar'
mthend = 'Mar'
dyst = '29'
dyend = '29'
hrstart = '17'
minstart = '45'
secst = '42'
hrend = '17'
minend = '48'
secend = '50'
timg = 16.


;algorithm = 'PIXON'
;algorithm = 'Back Projection'
;algorithm = 'CLEAN' 
algorithm = 'PIXON' 
;algorithm = 'MEM_NJIT' 
;algorithm = 'FORWARDFIT'
;algorithm = 'VIS_FWDFIT' 
rhessi_img, energy_range = energy_range, increment, yrst, yrend, mthst, mthend, dyst, dyend,  hrstart, minstart, secst, hrend, minend, secend, timg, algorithm
