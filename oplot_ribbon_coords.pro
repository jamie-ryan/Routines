pro oplot_ribbon_coords, coords, box_size, frame1 = frame1, frame2 = frame2 

nrb = 20
nc = (nrb/2)
;j = 2, nc = 10 
;    : j*nc = 20
;    : -nc/2 = 15
;
;j = 1, nc = 10    
;    : j*nc = 10
;    : -nc/2 = 5

;j = 2, nc = 10 
;    : j*nc = 20
;    : -nc/2 = 15
;
;j = 1, nc = 10    
;    : j*nc = 10
;    : -nc/2 = 5
if keyword_set(frame1) then begin
    start = 1
    stp = 2
endif
if keyword_set(frame2) then begin
    start = 1.5
    stp = 2.5
endif

for j = start,  stp do begin

    for i = (j*nc)-nc, j*nc-(nc/2)-1 do begin
        central_coord_x = hmicoords[0,i] 
        central_coord_y = hmicoords[1,i]
        x0 = central_coord_x - box_size 
        xf = central_coord_x + box_size
        y0 = central_coord_y - box_size
        yf = central_coord_y + box_size
        oplot, [x0, xf], [y0, yf], color = 0 ;bottom left to top right
        oplot, [x0, xf], [yf, y0], color = 0 ;top
        oplot, [central_coord_x, central_coord_x], [y0, yf], color = 0 ;right side
        oplot, [x0, xf], [central_coord_y, central_coord_y], color = 0 ;bottom
    endfor
endfor
end





