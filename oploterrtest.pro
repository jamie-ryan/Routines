

restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Dec3-2015.sav'
utplot, tsi[447:*], sidata[j, 2, i, 447:*], sierr[j, 0, i, *]
oploterror, sidata[j, 2, i, 447:*], sierr[j, 0, i, *], $
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

