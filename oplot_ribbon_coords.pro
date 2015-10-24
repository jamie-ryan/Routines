pro oplot_ribbon_coords, coords, box_size

nrb = 10
for i = 0 ,nrb-1 do begin
    central_coord_x = coords[0,i]
    central_coord_y = coords[1,i]
    x0 = central_coord_x - box_size
    xf = central_coord_x + box_size
    y0 = central_coord_y - box_size
    yf = central_coord_y + box_size
    loadct,18
    oplot, [x0, xf], [y0, yf], color = 0+i*20 ;bottom left to top right
    oplot, [x0, xf], [yf, y0], color = 0+i*20 ;top
    oplot, [central_coord_x, central_coord_x], [y0, yf], color = 0+i*20 ;right side
    oplot, [x0, xf], [central_coord_y, central_coord_y], color = 0+i*20 ;bottom
endfor
qkxa = 517.2
qkya = 261.4
central_coord_x = qkxa
central_coord_y = qkya
x0 = central_coord_x - box_size
xf = central_coord_x + box_size
y0 = central_coord_y - box_size
yf = central_coord_y + box_size
loadct, 3
oplot, [x0, xf], [y0, yf], color = 100 ;bottom left to top right
oplot, [x0, xf], [yf, y0], color = 100 ;top
oplot, [central_coord_x, central_coord_x], [y0, yf], color = 0 ;right side
oplot, [x0, xf], [central_coord_y, central_coord_y], color = 0 ;bottom

end
