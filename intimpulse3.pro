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
for j = 0, time_frames - 1 do begin
for i = 0, npt - 1 do begin
d = reform(sidata[j,3,i,*])
pkslope, d, cadence[0], f, mxind, t1, t2, dt, e
jj = string(j, format = '(I0)')
ii = string(i, format = '(I0)')
mx = string(mxind, format = '(I0)')
jjiimx = jj+','+ii+','+mx
com = 'tag = Sidata['+jjiimx+']'
exe = execute(com) 
com = 'stri = {Sidat:d['+mx+'], Siflag:f, mx:mxind, tsi1:t1, tsi2:t2, dtsi:dt, esi:e}'
exe = execute(com)
strt = {tag:stri}
if i eq 0 then strt = {Siflag:f, tsi1:t1, tsi2:t2, dtsi:dt, esi:e} else $
strt = create_struct(strt, stri)
endfor
endfor


mgflag = pkslope(reform(mgdata[0,3,0,*]))
balmflag = pkslope(reform(balmerdata[0,3,0,*]))
mgwflag = pkslope(reform(mgwdata[0,3,0,*]))
hmiflag = pkslope(reform(hmidata[0,3,0,*]))










end
