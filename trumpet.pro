pro trumpet, helioregion
;;;code to analyse the anglular resolution of intensity enhancement during solar flares.
;;;could this be a tracer of magnetic field morphology?

;From high altitude to low, looks at:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 131 flaring regions 1e7K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.131A*')
aia_prep,files,-1,ind131,dat131,/uncomp_delete,/norm, /despike
index2map, ind131, dat131, map131

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 094 flaring regions 6e6K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.94A*')
aia_prep,files,-1,ind94,dat94,/uncomp_delete,/norm, /despike
index2map, ind94, dat94, map94

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 335 ARs 2.5e6K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.335*')
aia_prep,files,-1,ind335,dat335,/uncomp_delete,/norm, /despike
index2map, ind335, dat335, map335

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 211 ARs 2e6K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.211*')
aia_prep,files,-1,ind211,dat211,/uncomp_delete,/norm, /despike
index2map, ind211, dat211, map211

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 193 Corona/flare plasma 1e6K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.193*')
aia_prep,files,-1,ind193,dat193,/uncomp_delete,/norm, /despike
index2map, ind193, dat193, map193

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 171 Upper TR/quiet Corona 6e5K
files = findfile('/disk/solar3/jsr2/SDO/aia.lev1.171*')
aia_prep,files,-1,ind171,dat171,/uncomp_delete,/norm, /despike
index2map, ind171, dat171, map171

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;RHESSI HXR footpoints Chromosphere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IRIS 1400 TR/Upper Chromosphere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IRIS 2796 Chromosphere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;IRIS 2832 Upper-Photosphere


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/AIA 1700 sunspots/temp min?


;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/HMI 6173 Photosphere
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
files2 = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_18*')
files = [files,files2]
aia_prep, files,-1, hmiindex, hmidata, /despike
index2map, hmiindex, hmidata, hmimap

;;;wider crop, probably better for seeing everything
xp0 = 2856
xpf = 2995
yp0 = 2406
ypf = 2545

;;;convert pixels to arcsecs
xa0 = (xp0-hmiindex[0].crpix1+1)*hmiindex[0].cdelt1
xaf = (xpf-hmiindex[0].crpix1+1)*hmiindex[0].cdelt1
ya0 = (yp0-hmiindex[0].crpix2+1)*hmiindex[0].cdelt2
yaf = (ypf-hmiindex[0].crpix2+1)*hmiindex[0].cdelt2

;;;create cropped maps...HMI, 131, 94, 335, 211, 193, 171
sub_map, hmimap, xr=[xa0,xaf], yr=[ya0,yaf], sbhmimap
sub_map, map131, xr=[xa0,xaf], yr=[ya0,yaf], sbmap131
sub_map, map94, xr=[xa0,xaf], yr=[ya0,yaf], sbmap94
sub_map, map335, xr=[xa0,xaf], yr=[ya0,yaf], sbmap335
sub_map, map211, xr=[xa0,xaf], yr=[ya0,yaf], sbmap211
sub_map, map193, xr=[xa0,xaf], yr=[ya0,yaf], sbmap193
sub_map, map171, xr=[xa0,xaf], yr=[ya0,yaf], sbmap171


;FILTERING
;;hmi differencing
sub = coreg_map(sbhmimap,sbhmimap(40))
diff=diff_map(sub(1),sub(0),/rotate)
iii = n_elements(files)
for i=1, iii-1, 1 do begin
diff1=diff_map(sub(i),sub(i-1),/rotate)
;diff1=diff_map(sub(i),sub(0),/rotate)
diff=str_concat(diff,diff1)
endfor

;;;create array and index for differenced submap
map2index,diff, diffindex, diffhmi 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/HMI Acoustic egression Photosphere


;;;;;;;;;;;;;;;;;;;;;;;;
;SDO/HMI Magnetometer  


;read in data sets and analyse one at a time as to not use too much memory
;maybe only read in images that contain flare event...i.e, 17:44 to 17:47?





end
