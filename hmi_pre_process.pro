files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
;files2 = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_18*')
;files = [files,files2]

;process sdo hmi data
read_sdo, files, hmiindex, hmidata
;aia_prep, files,-1, hmiindex, hmidata, /despike ;ok
index2map, hmiindex, hmidata, hmimap ;ok
sub_map, hmimap, xr=[490,560], yr=[220,290], sbhmimap ;something is going wrong here
map2index, sbhmimap, sbhmiind, sbhmidat

fnm = 'hmi_preprocess_data.sav'
save, 
