pro hmi_full_disc_map, directory, peak_time

files = findfile(directory+'hmi.*.fits')

aia_prep, temporary(files),-1, out_ind, out_dat, /despike

index2map, temporary(out_ind), temporary(out_dat), map


rmap=drot_map(map[0],time = peak_time)
for i = 1,  n_elements(map) - 1 do begin
    rmp=drot_map(map[i],time = peak_time)
    rmap = str_concat(rmap, rmp)
endfor
map = temporary(rmap)
save, map, filename = directory+'full-disc-map.sav'
end
