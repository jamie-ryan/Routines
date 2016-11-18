flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun
ddd = 0
print, directories[ddd]
20150311
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'
tmp = hmidopp
sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
doppdiff = diff_map(sub(0),sub(1),/rotate)
print, 'making diff map'
for i=1, n_elements(hmidopp) - 2 do begin 
    diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
;        diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff=str_concat(temporary(doppdiff),diff1)    
endfor

movie_map, doppdiff

;Transients seen on frames
4 through 14
5 = strong
6 = strong



