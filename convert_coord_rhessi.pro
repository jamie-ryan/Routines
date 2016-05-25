function convert_coord_rhessi, map, coord, a2p = a2p, p2a = p2a
;INPUT:
;map = is used for it's header information
;coord = a 2D array conatining either pixel or arcsecond coordintes to be converted
;/a2p = arcsecond to pixel converter mode
;/p2a = pixle to arcsecond converter mode
;OUTPUT:
;converted_coords = convert_coord_rhessi(map, coord, /a2p)

;get map properties
xcc = map.xc
ycc = map.yc
dxx = map.dx
dyy = map.dy
dims = size(map.data)
nx = dims[1]
ny = dims[2]

;find corners in arcseconds
x0 = xcc - (dxx*(nx/2.))
xf = xcc + (dxx*(nx/2.))
y0 = ycc - (dyy*(ny/2.))
yf = ycc + (dyy*(ny/2.))


;how many coord to convert
nc = n_elements(coord[0,*])

;
;pix = fltarr(2,n_elements(coord[0,*]))
result = fltarr(2,n_elements(coord[0,*]))

if keyword_set(a2p) then begin
    for i = 0, nc - 1 do begin
        ;calculate pixel positions from arcsec coords
        result[0,i] = (coord[0, i] - x0)/dxx
        result[1,i] = (coord[1, i] - y0)/dyy
    endfor
endif
if keyword_set(p2a) then begin
    for i = 0, nc - 1 do begin
        ;calculate arcsec positions from pixel coords
        result[0,i] = (coord[0, i]*dxx) + x0
        result[1,i] = (coord[1, i]*dyy) + y0
    endfor
endif


return, result
end
