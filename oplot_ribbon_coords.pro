pro oplot_ribbon_coords, coords, box_size

nrb = 10
for i = 0 ,nrb-1 do begin
    central_coord_x = coords[0,i]
    central_coord_y = coords[1,i]
    x0 = central_coord_x - box_size
    xf = central_coord_x + box_size
    y0 = central_coord_y - box_size
    yf = central_coord_y + box_size
    loadct,40 ;8
    oplot, [x0, xf], [y0, yf], color = 150 ;r 240 ;190 ;bottom left to top right
    oplot, [x0, xf], [yf, y0], color = 150 ;r 240 ;190 ;top
    oplot, [central_coord_x, central_coord_x], [y0, yf], color = 190 ;right side
    oplot, [x0, xf], [central_coord_y, central_coord_y], color = 190 ;bottom
endfor
qkxa = 517.2
qkya = 261.4
central_coord_x = qkxa
central_coord_y = qkya
x0 = central_coord_x - box_size
xf = central_coord_x + box_size
y0 = central_coord_y - box_size
yf = central_coord_y + box_size
loadct, 1
oplot, [x0, xf], [y0, yf], color = 200 ;bottom left to top right
oplot, [x0, xf], [yf, y0], color = 200 ;top
oplot, [central_coord_x, central_coord_x], [y0, yf], color = 200 ;right side
oplot, [x0, xf], [central_coord_y, central_coord_y], color = 200 ;bottom

end
