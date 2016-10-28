fff = '/unsafe/jsr2/project2/20110215/HMI/v/*.fits'
files = findfile(fff)
aia_prep, temporary(files),-1, out_ind, out_dat, /despike
print, min(out_dat)
     -19333.8

index2map, out_ind, out_dat, map
print, min(map.data)
     -19333.8

;from diff_then_remove_positives/2000.log
;DIRECTORY = 20110215
;Doppler transient detected in doppdiff[20]

print, min(map[20].data)
     -19301.5

submap_range = [205.,-222.]
sub_map, temporary(map), xr=[submap_range[0] - 130.,submap_range[0] + 130.], yr=[submap_range[1] - 70.,submap_range[1] + 70.], mp
print, min(mp[20].data)
      2088.47

;check original processed data
xc = 2389.1667
yc = 1677.5000
x0 = convert_coord_hmi(205.-50., out_ind, /x, /a2p) = 2305.8333
xf = convert_coord_hmi(205.+50., out_ind, /x, /a2p) = 2472.5000
y0 = convert_coord_hmi(-222.-50., out_ind, /y, /a2p) = 1594.1667
yf = convert_coord_hmi(-222.+50., out_ind, /y, /a2p) = 1760.8333

plot_image, out_dat[x0:xf, y0:yf, 20]
print, min(out_dat[2305.:2472., 1594.:1760., 20])
      2088.47

sub = coreg_map(mp,mp[n_elements(mp)/2])
;diff = diff_map(sub(1),sub(0),/rotate)
doppdiff = diff_map(sub(2),sub(0),/rotate)

for i=1, n_elements(mp) - 1 do begin
    ;;differencing
    diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
;    diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    doppdiff=str_concat(temporary(doppdiff),diff1)    
endfor
tmp = doppdiff.data
for i = 0, n_elements(hmidopp) - 1 do begin
        tmp[where(tmp gt 0)] = 0
endfor
doppdiff.data = temporary(tmp)

;;;;IC
fff = '/unsafe/jsr2/project2/20110215/HMI/ic/*.fits'
files = findfile(fff)
aia_prep, temporary(files),-1, out_ind, out_dat, /despike
index2map, temporary(out_ind), temporary(out_dat), map
submap_range = [205.,-222.]
sub_map, temporary(map), xr=[submap_range[0] - 130.,submap_range[0] + 130.], yr=[submap_range[1] - 70.,submap_range[1] + 70.], mp
sub = coreg_map(mp,mp[n_elements(mp)/2])
;diff = diff_map(sub(1),sub(0),/rotate)
hmidiff = diff_map(sub(2),sub(0),/rotate)

for i=1, n_elements(mp) - 1 do begin
    ;;differencing
    diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
;    diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(temporary(hmidiff),diff1)    
endfor






