


restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Dec4-2015.sav'         

;doesn't work
utplot, tsi[447:*], sidata[0, 2, 10, 447:*]                              
oploterror,tsi[447:*], sidata[0, 2, 10, 447:*], sierr[0, 0, 10, *]       

;doesnt work
x = tsi[447:*]
y = sidata[0, 2, 10, 447:*]
yerr = sierr[0, 0, 10, *]       
utplot, x,y
oploterror, x, y, yerr, psym=3, /NOHAT 

;
y = sidata[0, 2, 10, 447:*]
yerr = sierr[0, 0, 10, *]  
plot, y
oploterror, y, yerr

[ /NOHAT, $
HATLENGTH= , $
ERRTHICK =, $
ERRSTYLE=, $
ERRCOLOR =, $
/LOBAR, $
/HIBAR, $
NSKIP = , $
NSUM = , $
/ADDCMD, $
;... OPLOT keywords ] 

