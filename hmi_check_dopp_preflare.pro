pro hmi_check_dopp_preflare
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


ddd = 0
restore, restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/hmi-dopp.sav'
tmp_pf = temporary(hmidopp)
sub_pf = coreg_map(tmp_pf,tmp_pf[n_elements(tmp_pf)/2])
doppdiff_pf = diff_map(sub_pf(0),sub_pf(1),/rotate)
for i=1, n_elements(tmp_pf) - 2 do begin 
    diff_pf=diff_map(sub_pf[i],sub_pf[i+1],/rotate) ;backwards difference
;        diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff_pf=str_concat(temporary(doppdiff_pf),diff_pf)    
endfor



end
