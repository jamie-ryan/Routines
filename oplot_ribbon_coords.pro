pro oplot_ribbon_coords, coords, box_size, box = box, cross = cross, set_2 = set_2

nrb = 8
for i = 0 ,nrb-1 do begin
    central_coord_x = coords[0,i]
    central_coord_y = coords[1,i]
    x0 = central_coord_x - box_size
    xf = central_coord_x + box_size
    y0 = central_coord_y - box_size
    yf = central_coord_y + box_size
    loadct,6
    if keyword_set(cross) then begin
        oplot, [x0, xf], [y0, yf], color = 125 ;r 240 ;190 ;bottom left to top right
        oplot, [x0, xf], [yf, y0], color = 125 ;r 240 ;190 ;top
        oplot, [central_coord_x, central_coord_x], [y0, yf], color = 125 ;right side
        oplot, [x0, xf], [central_coord_y, central_coord_y], color = 125 ;bottom
    endif
    if keyword_set(box) then begin
        oplot, [x0, x0], [y0, yf], color = 125 ;left side
        oplot, [x0, xf], [yf, yf], color = 125 ;top
        oplot, [xf, xf], [yf, y0], color = 125 ;right side
        oplot, [x0, xf], [y0, y0], color = 125 ;bottom
    endif
    if keyword_set(set_2) then ii = string(i+11, format = '(I0)') else ii = string(i+1, format = '(I0)')
    XYouts, x0, yf, ii, COLOR=FSC_Color('red'), ALIGN=0.5, CHARSIZE=0.45
endfor
qkxa = 518.5
qkya = 262.0
central_coord_x = qkxa
central_coord_y = qkya
x0 = central_coord_x - box_size
xf = central_coord_x + box_size
y0 = central_coord_y - box_size
yf = central_coord_y + box_size
loadct, 6
if keyword_set(cross) then begin
    oplot, [x0, xf], [y0, yf], color = 200 ;bottom left to top right
    oplot, [x0, xf], [yf, y0], color = 200 ;top
    oplot, [central_coord_x, central_coord_x], [y0, yf], color = 200 ;right side
    oplot, [x0, xf], [central_coord_y, central_coord_y], color = 200 ;bottom
endif
if keyword_set(box) then begin
    oplot, [x0, x0], [y0, yf], color = 150 ;left side
    oplot, [x0, xf], [yf, yf], color = 150 ;top
    oplot, [xf, xf], [yf, y0], color = 190 ;right side
    oplot, [x0, xf], [y0, y0], color = 190 ;bottom
endif
ii = 'SQ'
XYouts, xf/2., yf/2., ii, COLOR=FSC_Color('red'), ALIGN=0.5, CHARSIZE=0.50
end
