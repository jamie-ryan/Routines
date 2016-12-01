pro hmi_process_dopp, $
directory, $
submap_range = submap_range, $
refmap=refmap, $
refdir, $
drot=drot, $
peak_time


files = findfile(directory+'hmi.*.fits')

;read_sdo, files, out_ind, out_dat
aia_prep, temporary(files),-1, out_ind, out_dat, /despike
;rotate 180 deg
;for i = 0, n_elements(files) - 1 do begin
;a = out_dat[*,*,i]
;b = rotate(a,2)
;out_dat[*,*,i] = b
;a = 0
;b = 0
;endfor

;dat 2 map
index2map, temporary(out_ind), temporary(out_dat), map

;drotate map: used to align preflare and flare datasets
if keyword_set(drot) then begin
rmap=drot_map(map[0],time = peak_time)
for i = 1,  n_elements(map) - 1 do begin
    rmp=drot_map(map[i],time = peak_time)
    rmap = str_concat(temporary(rmap), rmp)
endfor
rmp = 0
map = temporary(rmap)
endif


;full disc 2 crop
;
;               REF_MAP = reference map for inferring XRANGE, YRANGE
;               PRESERVE = output dimensions of SMAP same as REF_MAP
;               PIXEL = XRANGE/YRANGE are in pixel units
;               INIT = start all over again
;               DIMENSIONS = [n1,n2] = dimensions of SMAP
if keyword_set(refmap) then begin
restore, refdir+'refmap.sav'
sub_map, map, ref_map = refmap, /preserve, mp 
endif else begin
sub_map, temporary(map), xr=[submap_range[0] - 50.,submap_range[0] + 50.], yr=[submap_range[1] - 50.,submap_range[1] + 50.], mp 
endelse


map2index, mp, hmidopp_ind, hmidopp_dat
hmidopp = temporary(mp)
savff = directory+'/hmi-dopp.sav'
save, hmidopp,hmidopp_ind, hmidopp_dat, filename = savff


end
