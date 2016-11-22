pro diff_data, map, diffmap
    sub = coreg_map(map,map[n_elements(map)/2])
    diffmap = diff_map(sub(0),sub(1),/rotate)
    print, 'making diff map'
    for i=1, n_elements(map) - 2 do begin 
        diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
    ;        diff1=diff_map(sub[i],sub[0],/rotate)
        ;;;concatenate arrays to form one difference array
        diffmap=str_concat(temporary(diffmap),diff1)    
    endfor
save, diffmap, filename = 'diffmap.sav'
end
