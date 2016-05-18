function convert_coord_rhessi, map, coord

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
pix = fltarr(2,n_elements(coord[0,*]))

for i = 0, nc - 1 do begin
;calculate pixel positions
pix[0,i] = (coord[0, i] - x0)/dxx
pix[1,i] = (coord[1, i] - y0)/dyy
endfor

return, pix
end
