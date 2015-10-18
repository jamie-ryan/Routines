pro oplot_ribbon_coords, hmicoords, central_coord, box_size

for j = 1,  2 do begin
for i = 0, j*nc-1 do begin
central_coord_x = hmicoords[0,i] 
central_coord_y = hmicoords[1,i]
x0 = central_coord_x - box_size 
xf = central_coord_x + box_size
y0 = central_coord_y - box_size
yf = central_coord_y + box_size
oplot, [x0, xf], [y0, yf] ;bottom left to top right
oplot, [x0, xf], [yf, y0] ;top
oplot, [central_coord_x, central_coord_x], [y0, yf] ;right side
oplot, [x0, xf], [central_coord_y, central_coord_y] ;bottom
endfor
endfor
end





