function sumarea, array, xcp, ycp, radius, sg = sg

;INPUT
;array = map.data...i.e., array[x,y,t]
;xcp = central x pixel
;ycp = central y pixel
;radius = radius from central pixel [in pixels]..so true radius = radius + half the central pixel..i.e, 2*radius = always odd
;/sg = spectrograph mode
;      i.e, the x component in the area calculation is set to xcp (1 pixel length) to suit sg slit array 
;
;OUTPUT
;result = fltarr(t) a 1D array containing summed values from area of user defined area for each time element


;find size info for array: number of dimensions, number of elements in each dimension, type code and elements total
;eg, size(array) ==== [3, xpixels, ypixels, t, type code, total elements]
sz = size(array)

;if 2d array
if (sz[0] eq 2) then begin
    ;construct pixel area array based on radius
    if keyword_set(sg) then area = array[xcp, ycp - radius : ycp + radius] $
    else area = array[xcp - radius : xcp + radius, ycp - radius : ycp + radius]

    ;removes negative values in array, handy for differenced data
    area[where(area lt 0, /null)] = 0

    ;sum pixels in area
    result = total(area[*, *])
endif

;if 3d datacube
if (sz[0] eq 3) then begin
    ;array for 
    result = fltarr(sz[3])

    ;construct pixel area array based on radius
    if keyword_set(sg) then area = array[xcp, ycp - radius : ycp + radius, *] $
    else area = array[xcp - radius : xcp + radius, ycp - radius : ycp + radius, *]

    ;removes negative values in array, handy for differenced data
    area[where(area lt 0, /null)] = 0

    ;loop to sum pixels in area for each time element
    for i = 0, sz[3] - 1 do begin
        result[i] = total(area[*, *, i])
    endfor
endif
return, result
end
