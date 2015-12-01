pro intimpulse2
;integrate energy curve over duration of impulsive phase of flare


restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Nov30-2015.sav'
cadence = [26., 19., 72., 75., 45. ] ;si, mg  , balmer  , mgw  , hmi 
time_frames = 2
nrb = 20
npt = 1 + (nrb/time_frames)

;analyse peak slope, function returns flag[0, *] = gradient, flag[1, *] = flag
;flag can have three values, 2 = +ve slope, 1 = -ve slope and 0 = zero slope
;the number of elements in each column contained in flag is based on n_elements(2*array[max:*]) 
siflag = pkslope(sidata[0,3,0,*])
mgflag = pkslope(mgdata[0,3,0,*])
balmflag = pkslope(balmerdata[0,3,0,*])
mgwflag = pkslope(mgwdata[0,3,0,*])
hmiflag = pkslope(hmidata[0,3,0,*])











end
