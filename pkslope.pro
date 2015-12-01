pro pkslope, a, cadence, rflag, t1, t2, deltt, e
;This function finds the maximum in array 'a' 
;and analyses the slope either side of the peak, 
;looking for turning points and saddle points. 
;a = 1d array

;analyse slope either side of the maximum. 
amx = max(a, ind)
amxind = array_indices(a, ind)
nlmt = n_elements(a[amxind:*])
rflag = fltarr(2,nlmt + nlmt -1 )
for i = 0, nlmt - 1 do begin
    ;left of max slope analysis
    r1 = a[amxind-1 - i] - a[amxind-1 - i + 1] ;positive result = negative slope
    ;right of max slope analysis
    r2 = a[amxind-1 + i] - a[amxind-1 + i + 1] ;positive result = negative slope
    ;store slope values
    rflag[0, nlmt-1 - i] = r1
    rflag[0, nlmt-1 + i] = r2
    
    if (r1 lt 0.) then rflag[1, nlmt-1 - i] = 2 else $;positive slope
    if (r1 gt 0.) then rflag[1, nlmt-1 - i] = 0 else $;negative slope
    if (r1 eq 0.) then rflag[1, nlmt-1 - i] = 1 $;zero slope
    else print, 'Daisy, Daisy...'

    if (r2 lt 0.) then rflag[1, nlmt-1 + i] = 2 else $;positive slope
    if (r2 gt 0.) then rflag[1, nlmt-1 + i] = 0 else $;negative slope
    if (r2 eq 0.) then rflag[1, nlmt-1 + i] = 1 $;zero slope
    else print, 'Daisy, Daisy...'
endfor

redg = where(rflag[1,nlmt-1:*] eq 0.)
ledg = where(rflag[1,0:nlmt-1] eq 0.)
t1 = ledg[n_elements(ledg)-1]
t2 = nlmt-1+redg[0] 
dt = t2 - t1
t = fltarr(dt+1)
    for i = 0, dt - 1 do begin
        t[i] = i*cadence
    endfor
e = int_tabulated(t, a[t1:t2])
deltt = (t2 - t1)*cadence
end
