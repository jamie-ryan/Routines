pro hmi_process_filter_universal, process = process, directory, submap_range = submap_range, phys_units = phys_units, dopp = dopp, restore_sav = restore_sav, savf = savf, log = log, difffilt = difffilt, bksub = bksub

;process = /process
;savf = savfile location string to be restored
;log = log boxsmooth filter option, default is just box smoothing
;difffilt = difference filtering option, default is non-differenced.
;directory = dir where data fits files are
;....maybe;submap_range = array with [x0, xf, y0, yf] for sub map
;submap_range = array with [x_central, y_central] for sub map

if keyword_set(process) then begin

files = findfile(directory+'hmi.*')

;read_sdo, files, out_ind, out_dat
aia_prep, files,-1, out_ind, out_dat, /despike
;rotate 180 deg
;for i = 0, n_elements(files) - 1 do begin
;a = out_dat[*,*,i]
;b = rotate(a,2)
;out_dat[*,*,i] = b
;a = 0
;b = 0
;endfor

;dat 2 map
index2map, out_ind, out_dat, map

;full disc 2 crop
;sub_map, map, xr=[submap_range[0],submap_range[1]], yr=[submap_range[2],submap_range[3]], mp 
sub_map, map, xr=[submap_range[0] - 50.,submap_range[0] + 50.], yr=[submap_range[1] - 50.,submap_range[1] + 50.], mp 

;make sav file
fnm = directory+'/hmi_mp.sav'
save, mp, filename = fnm
endif

if keyword_set(restore_sav) then begin
restore, savf
endif
filemod = 'hmi'
if keyword_set(bksub) then begin
;background subtract
bk_sample = mp[0].data[80.:90. ,90.:100.]
bk = avg(bk_sample)
mp.data = mp.data - bk
filemod = filemod+'-bksub'
endif

;log smth or smth filter
if keyword_set(log) then begin 
mp.data = alog10(mp.data) - alog10(SMOOTH(mp.data,10)) 
filemod = filemod+'-log-smth'
endif


if not keyword_set(log) and not keyword_set(dopp) then begin
mp.data = mp.data - SMOOTH(mp.data,10)
filemod = filemod+'-smth'
endif

if keyword_set(difffilt) then begin
sub = coreg_map(mp,mp[n_elements(mp)/2])
;diff = diff_map(sub(1),sub(0),/rotate)
hmidiff = diff_map(sub(2),sub(0),/rotate)

for i=1, n_elements(mp) - 1 do begin
    ;;differencing
    diff1=diff_map(sub[i],sub[i-2],/rotate) ;running difference
;    diff1=diff_map(sub[i],sub[0],/rotate)
    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(hmidiff,diff1)    
endfor

;make seperate header and data array for hmidiff.... iris_hmi_energy needs it
map2index, hmidiff, diffind, diffdat
filemod = filemod+'-diff'
endif


if not keyword_set(difffilt) and not keyword_set(dopp) then begin 
hmidiff = mp ;non differenced but named it hmidiff because every other code relies on that variable name :(
map2index, hmidiff, diffind, diffdat
endif

if not keyword_set(dopp) then begin
;add hmi rad cal to calculate flux, energy, power for each pixel in each map.data
hmifep = fltarr(3, n_elements(mp[0].data[*,0]), n_elements(mp[0].data[0,*]), n_elements(mp))
visiblewidth = (7000. - 4800.)*1.0e2
for i = 0, n_elements(mp) - 1 do begin
    hmi_radiometric_calibration, hmidiff[i].data*visiblewidth, n_pixels = 1, f, e, p, ferr, err
    hmifep[0, *,*,i] = f
    hmifep[1, *,*,i] = e
    hmifep[2, *,*,i] = p    
endfor


savff =  directory+'/hmi'+filemod+'.sav'
save, hmifep, hmidiff, diffind, diffdat, filename = savff
endif

if keyword_set(dopp) then begin
hmidopp = mp
map2index, mp, hmidopp_ind, hmidopp_dat
savff = directory+'/hmi-dopp.sav'
save, hmidopp,hmidopp_ind, hmidopp_dat, filename = savff
endif

end
