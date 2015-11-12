pro hmidata

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

;these coords match sarah's maps
;xa0 = 420.713
;xaf = 603.698
;ya0 = 190.625
;yaf = 372.280

;;;make sub map
sub_map, hmimap, xr=[xa0,xaf], yr=[ya0,yaf], sbhmimap

;;;coregister to eliminate rotational effects...i think
sub = coreg_map(sbhmimap,sbhmimap(40))

;;;starting point for differencing
diff=diff_map(sub(1),sub(0),/rotate)

;;;iterate through each submap and perform differencing
iii = n_elements(files)
for i=1, iii-1, 1 do begin
;;differencing
diff1=diff_map(sub(i),sub(i-1),/rotate)

;;;concatenate arrays to form one difference array
diff=str_concat(diff,diff1)
endfor

;;;you probably don't need this bit but it's basically index2map but in reverse 
map2index,diff, diffindex, diffhmi 

;;;make sav file
save, /comm, /variables, filename='hmi-diff.sav'

end
