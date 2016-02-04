function find_iris_slit_pos, coord, iris_x_pos, y=y, a2p = a2p, p2a = p2a
;struc = 'sp2826'
fsp = findfile('/disk/solar3/jsr2/Data/IRIS/old/')
;fsp = iris_files(path='/unsafe/jsr2/IRIS/iris/level2/2014/03/30/20140330_140236_3860258481/')
nn = n_elements(fsp)
result = fltarr(nn)
if not keyword_set(y) then begin
;fovx = 8.03
fovx = struc.tag00.hdr.fovx 
tmp = fltarr(8)
    for i = 0, nn-1 do begin
    ii = string(i, format = '(I0)')
    com = 'fovx = struc.tag0'+ii+'.hdr.fovx'
    exe = execute(com) 
    slit_increment = 

    com = 'xc = struc.tag0'+ii+'.xcen'
    exe = execute(com)
        
        ;;;is coord withint the fovx?
        if ((coord gt xc - fovx) && (coord lt xc + fovx)) then begin 
            
            ;;;
            for j = 0, 7 do begin
            jj = string(j, format = '(I0)')
            com = 'tmp['+jj+'] = abs(coord - struc.tag0'+ii+'.solar_x['+jj+'])'
            exe = execute(com)
            endfor
        mn = min(tmp, loc)
        ind = array_indices(tmp, loc)
        result[i] = ind  
        endif
    endfor
endif

;y pixel or arcsec
if keyword_set(y) then begin
npix = 1093.
tmp = fltarr(npix)
    ;arc2pix
    if keyword_set(a2p) then begin
        for i = 0, nn-1 do begin
        ii = string(i, format = '(I0)')
        com = 'tmp = abs(coord - struc.tag0'+ii+'.solar_y)'
        exe = execute(com)
        mn = min(tmp, loc)
        ind = array_indices(tmp, loc)
        result[i] = ind  
        endfor
    endif

    ;pix2arc
    if keyword_set(p2a) then begin
        for i = 0, nn-1 do begin
        ii = string(i, format = '(I0)')
        coordstr = string(coord, format = '(I0)')
        com = 'result['+ii+'] = struc.tag0'+ii+'.solar_y['+coordstr+']'
        exe = execute(com)
        endfor
    endif

endif
return, result
end
