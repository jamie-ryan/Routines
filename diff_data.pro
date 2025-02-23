pro diff_data, flare=flare, preflare=preflare
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


for ddd = 0, nlin-1 do begin
if keyword_set(flare) then begin
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/hmi-dopp.sav'

;set up and run backwards difference filter
tmp = temporary(hmidopp)
sub = coreg_map(tmp,tmp[n_elements(tmp)/2])
doppdiff = diff_map(sub(0),sub(1),/rotate)
print, 'making diff map'
for i=1, n_elements(tmp) - 2 do begin 
    diff1=diff_map(sub[i],sub[i+1],/rotate) ;backwards difference
;        diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff=str_concat(temporary(doppdiff),diff1)    
endfor
filenm = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/doppdiff.sav'
save, doppdiff, filename = filenm
tmp=0
sub=0
diff1=0
doppdiff = 0
endif

if keyword_set(preflare) then begin
;preflare
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/hmi-dopp.sav'
tmp_pf = temporary(hmidopp)
sub_pf = coreg_map(tmp_pf,tmp_pf[n_elements(tmp_pf)/2])
doppdiff_pf = diff_map(sub_pf(0),sub_pf(1),/rotate)
for i=1, n_elements(tmp_pf) - 2 do begin 
    diff_pf=diff_map(sub_pf[i],sub_pf[i+1],/rotate) ;backwards difference
;        diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff_pf=str_concat(temporary(doppdiff_pf),diff_pf)    
endfor
filenm = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/doppdiff_pf.sav'
save, doppdiff_pf, filename = filenm
tmp_pf=0
sub_pf=0
diff1_pf=0
doppdiff_pf = 0
endif
endfor
end
