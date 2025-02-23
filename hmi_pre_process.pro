pro hmi_pre_process, file
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
;files2 = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_18*')
;files = [files,files2]

;process sdo hmi data
aia_prep, files,-1, out_ind, out_dat, /despike

;if using read_sdo then rotate images 180 degrees
;for i = 0, n_elements(files) - 1 do begin
;a = hmidata[*,*,i]
;b = rotate(a,2)
;hmidata[*,*,i] = b
;a = 0
;b = 0
;endfor

;make maps
index2map, out_ind, out_dat, map

;full disc 2 crop
sub_map, map, xr=[490,570], yr=[230,300], mp 


;make dir based on date
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr

;make sav file
fnm = '/unsafe/jsr2/'+datstr+'/hmi_preprocess_data.sav'
save, sbhmimap, sbhmiindex, sbhmidat, filename = fnm 
end
