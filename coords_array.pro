function coords_array, coords, result 

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
central_coord_x = fltarr(nc)
central_coord_y = fltarr(nc)

start = 1
stop = 2
for j = start,  stp do begin

    for i = (j*nc)-nc, j*nc-(nc/2)-1 do begin
        central_coord_x[i] = coords[0,i] 
        central_coord_y[i] = coords[1,i]
    endfor
endfor

start = 1.5
stop = 2.5
for j = start,  stp do begin

    for i = (j*nc)-nc, j*nc-(nc/2)-1 do begin
        central_coord_x[i] = coords[0,i] 
        central_coord_y[] = coords[1,i]
    endfor
endfor

result = fltarr(2,nc)
result[0,*] = central_coord_x
result[1,*] = central_coord_y

return, result
end
