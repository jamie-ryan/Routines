function sumarea, array, xcp, ycp, radius

;INPUT
;array = map.data...i.e., array[x,y,t]
;xcp = central x pixel
;ycp = central y pixel
;radius = radius from central pixel [in pixels]
;
;OUTPUT
;result = fltarr(t) a 1D array containing summed values from area of user defined area for each time element

;find size info for array: number of dimensions, number of elements in each dimension, type code and elements total
;eg, size(array) ==== [3, xpixels, ypixels, t, type code, total elements]
sz = size(array)

;array for 
result = fltarr(sz[3])

;construct pixel area array based on radius
area = array[xcp - radius : xcp + radius, ycp - radius : ycp + radius, *]

;loop to sum pixels in area for each time element
for i = 0, sz[3] - 1 do begin
    result[i] = total(area[*, *, i])
endfor

return, result
end
