function find_iris_slit_pos, coord, structure
fovx = 8.03
tmp = fltarr(8)
result = fltarr(nn)
for i = 0, nn-1 do begin
ii = string(i, format = '(I0)')
com = 'xc = sp2826.tag0'+ii+'.xcen'
exe = execute(com)

    if ((coord gt xc - fovx) && (coord lt xc + fovx)) then begin 
        
        for j = 0, 7 do begin
        jj = string(j, format = '(I0)')
        com = 'tmp['+jj+'] = abs(coord - sp2826.tag0'+ii+'.solar_x['+jj+'])'
        exe = execute(com)
        endfor
    mn = min(tmp, loc)
    ind = array_indices(tmp, loc)
    result[i] = ind  
    endif
endfor
return, result
end
