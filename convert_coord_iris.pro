function convert_coord_iris, coord, index, x = x, y = y, p2a = p2a, a2p = a2p

;calculate edge locations in arcseconds
max_xa = ind.crval1+((ind.naxis1/2.)*ind.cdelt1)
min_xa = ind.crval1-((ind.naxis1/2.)*ind.cdelt1)
max_ya = ind.crval2+((ind.naxis2/2.)*ind.cdelt2)
min_ya = ind.crval2-((ind.naxis2/2.)*ind.cdelt2)

;edge locations in pixels
max_xp = ind.naxis1
min_xp = 0.
max_yp = ind.naxis2
min_yp = 0


;arcsec to pixel..coord has to be in arcseconds
if keyword_set(a2p) then begin
    ;x
    if keyword_set(x) then begin
    ;find difference between max_xa and x in arcsecs
    dxa = max_xa - coord

    ;calculate number of pixels away from max_xa
    npix = dax/ind.cdelt1

    ;subtract npix from max_xp
    result = max_xp - npix
    endif

    ;y
    if keyword_set(y) then begin
    ;find difference between max_xa and x in arcsecs
    dya = max_ya - coord

    ;calculate number of pixels away from max_xa
    npix = dya/ind.cdelt2

    ;subtract npix from max_xp
    result = max_yp - npix
    endif
endif

;pixel to arcsec..coord has to be in pixels
if keyword_set(p2a) then begin
    ;x
    if keyword_set(x) then begin
    ;find difference between max_xp and x in pixels
    dxp = max_xp - coord

    ;calculate number of arcseconds away from max_xp
    narc = dxp*ind.cdelt1

    ;subtract narc from max_xa
    result = max_xa - narc   
    endif
    
    ;y
    if keyword_set(y) then begin
    ;find difference between max_yp and y in pixels
    dyp = max_yp - coord

    ;calculate number of arcseconds away from max_yp
    narc = dyp*ind.cdelt2

    ;subtract narc from max_xa
    result = max_ya - narc   
    endif
endif


return, result
end
