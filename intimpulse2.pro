pro intimpulse2
;integrate energy curve over duration of impulsive phase of flare


restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Nov30-2015.sav'
cadence = [26., 19., 72., 75., 45. ] ;si, mg  , balmer  , mgw  , hmi 
time_frames = 2
nrb = 20
npt = 1 + (nrb/time_frames)

;dave said use this to look for edges of peak
;uu = [indgen(10),10-indgen(10)]
;plot,uu-shift(uu,1),yst=3      

a = reform(deriv(sidata[0,3,0,*]))
shft = fltarr(10, n_elements(a))
result = fltarr(10, n_elements(a))
for i = 0, 9 do begin
shft[i,*] = shift(a,i)
result[i,*] = a - shft[i,*]  
endfor


  

amx = max(a, ind)
amx = array_indices(a, ind)
plot,a
oplot,a-shift(a,1)


b = abs(reform(deriv(mgdata[0,3,0,*]))) - reform(deriv(mgdata[0,3,0,*]))
c = abs(reform(deriv(balmerdata[0,3,0,*])))
d = abs(reform(deriv(mgwdata[0,3,0,*])))
e = abs(reform(deriv(hmidata[0,3,0,*])))













end
