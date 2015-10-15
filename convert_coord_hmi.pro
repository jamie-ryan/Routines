function convert_coord_hmi, coord, index, x = x, y = y, p2a = p2a, a2p = a2p

;arcsec to pixel..coord has to be in arcseconds
if keyword_set(a2p) then begin
    ;x
    if keyword_set(x) then begin
    result = (coord/index[0].cdelt1) + index[0].crpix1 - 1
    endif
    
    ;y
    if keyword_set(y) then begin
    result = (coord/index[0].cdelt2) + index[0].crpix2 - 1
    endif
endif

;pixel to arcsec..coord has to be in pixels
if keyword_set(p2a) then begin
    if keyword_set(x) then begin
    result = (coord - index[0].crpix1 + 1)*index[0].cdelt1
    endif

    if keyword_set(y) then begin
    result = (coord - index[0].crpix2 + 1)*index[0].cdelt2
    endif
endif

return, result

end
