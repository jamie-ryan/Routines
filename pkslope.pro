function pkslope, a
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
    r1 = a[amxind - i] - a[amxind - i + 1] ;positive result = negative slope
    ;right of max slope analysis
    r2 = a[amxind + i] - a[amxind + i + 1] ;positive result = negative slope
    ;store slope values
    rflag[0, nlmt - i] = r1
    rflag[0, nlmt + i] = r2
    ;case selects which flag to store in the rflag array
    case 2 of    
        (r1 lt 0.): rflag[1, nlmt - i] = 2 ;positive slope
        (r1 gt 0.): rflag[1, nlmt - i] = 0 ;negative slope
        (r1 eq 0.): rflag[1, nlmt - i] = 1 ;zero slope

        (r2 lt 0.): rflag[1, nlmt + i] = 2 ;positive slope
        (r2 gt 0.): rflag[1, nlmt + i] = 0 ;negative slope
        (r2 eq 0.): rflag[1, nlmt + i] = 1 ;zero slope
    else: print, 'Daisy, Daisy...'
    endcase
endfor
return, rflag
end

