function spec_width, array, wave1, wave2
;array = spectra array in the format: array[0,*] = wavelength, array[1,*] = intensity
;  
;at some point I could modify this function to be able to take iris/eis rasters and autonomously make the spectral array
;
;
;wave1 and wave2 are wing boundaries

;;;put wavelength data into 1D array
wvarray = array[0,*]

;;;set un-needed parts of array to zero
wvarray[where(wvarray lt wave1)] = 0
wvarray[where(wvarray gt wave2)] = 0

;;;find elements that are not zero
element = where(wvarray gt 0)

;;;find element range
mn = element[0]
mx = max(element)

;;;find max intensity location in spectra array
peak =  max(array[1, mn:mx], ind)

;;;use max intensity location to find central wavelength
;need to convert to true indices
centroid = mn + ind

;;;sanity check; peak should equal qkspectra[1,centroid]
;if it doesn't then print error message and exit function
if (peak ne array[1,centroid]) then  begin
print, 'Dave...my mind is going...I can feel it...I can feel it...my mind is going'
return
end

;;;define centroid wavelength
wave0 = array[0,centroid]



;;;define trough (wings) intensities
min1 = min(array[1, mn:centroid], mind1)
min2 = min(array[1, centroid:mx], mind2)

;;;define trough x coordinates
leftmin = mind1 + mn
rightmin = mind2 + centroid

;;;sanity check
if (min1 ne array[1,leftmin]) then  begin
print, 'Dave...my mind is going...I can feel it...I can feel it...my mind is going'
return
end

if (min2 ne array[1,rightmin]) then  begin
print, 'Dave...my mind is going...I can feel it...I can feel it...my mind is going'
return
end

;;;define trough wavelengths
lwave = array[0,leftmin]
rwave = array[0,rightmin]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;FWHM
;;;find half maximum (hm)
avmin = (min1 + min2)/2
hm = ((peak - avmin)/2) + avmin 




;;;full width at hm
sparray = array[1,*]
sparray[WHERE(sparray lT 0, /NULL)] = 0
sparray[where(sparray[leftmin:rightmin] lt hm)] = 0
sparray[where(sparray[leftmin:rightmin] gt hm)] = 0


 

return,

end
