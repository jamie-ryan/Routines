function spec_width, wavf, intf
peak =  max(intf, ind)

;;;use max intensity location to find central wavelength
;need to convert to true indices if want to use in full spectral range
centroid = wavf[ind]


;;;define trough (wings) intensities
min1 = min(intf[0:ind], mind1)
min2 = min(intf[ind:*], mind2)

;;;define trough x coordinates
leftmin = mind1
rightmin = mind2 + ind

;;;sanity check
if (min1 ne intf[leftmin]) then  begin
print, 'Dave...my mind is going...I can feel it...I can feel it...my mind is going'
return
end

if (min2 ne intf[rightmin]) then  begin
print, 'Dave...my mind is going...I can feel it...I can feel it...my mind is going'
return
end

;;;define trough wavelengths
lwave = wavf[leftmin]
rwave = wavf[rightmin]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FWHM
;;;find half maximum (hm)
avmin = (min1 + min2)/2
hm = ((peak - avmin)/2) + avmin 
intftmp = abs(intf - hm)

turnpoint1 = min(intftmp[leftmin:ind],tp1)
turnpoint2 = min(intftmp[ind:rightmin],tp2)
tp2 = tp2 + ind
width = fltarr(2)
width[0] = centroid
width[1] = wavf[tp2]-wavf[tp1]

return, width
end


