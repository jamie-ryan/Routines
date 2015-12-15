pro intimpulse3, dd, si, timp, eimp, t_av, e_av
;INPUT:
;   d = [time_frames,column, npt, t]
;OUTPUT:
;   si = data structure 
;   timp = [time_frames, npt] = impulsive phase time for each coord 
;   eimp = [time_frames, npt] = impulsive phase integrated energy for each coord
;   t_av = average impulsive phase time
;   e_av = average impulsive phase integrated energy
;integrate energy curve over duration of impulsive phase of flare

cadence = [26., 19., 72., 75., 45. ] ;si, mg  , balmer  , mgw  , hmi 
time_frames = 2
nrb = 20
npt = 1 + (nrb/time_frames)

;analyse peak slope, function returns flag[0, *] = gradient, flag[1, *] = flag
;flag can have three values, 2 = +ve slope, 1 = -ve slope and 0 = zero slope
;the number of elements in each column contained in flag is based on n_elements(2*array[max:*]) 
timp = fltarr(time_frames, npt)
eimp = fltarr(time_frames, npt)
for j = 0, time_frames - 1 do begin
    for i = 0, npt - 1 do begin
        d = 0
        d = reform(dd[j,3,i,*])
        pkslope, d, cadence[0], f, mxind, t1, t2, dt, e, /hlfpk
        timp[j,i] = dt
        eimp[j,i] = e
        jj = string(j, format = '(I0)')
        ii = string(i, format = '(I0)')
        mx = string(mxind, format = '(I0)')
        jjiimx = jj+''+ii
        ;tag = 'Sidata_'+jjiimx
        nlmt = n_elements(f[0,*])
        nslope = n_elements(d) - nlmt
        com = 'stri = {Sidat:d[nslope:*], Siflag:f, mx:mxind, t1:t1, t2:t2, dt:dt, e:e}'
        exe = execute(com)
        com = 'st = {s'+jjiimx+':stri}
        exe = execute(com)
        if (j eq 0) and (i eq 0) then si = st else  $
        si = create_struct(si, st)
    endfor
endfor
t_av = total(timp)/(time_frames*npt)

;average energy at ribbon locations
e_av = total(eimpmg[*, 0: 9])/20

;e_av = total(eimp)/(time_frames*npt)
end
