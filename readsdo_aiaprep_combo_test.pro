pro hmi_process, process = process, savf = savf, log = log

;process = /process
;savf =
;log =

;make dir based on date
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr


if keyword_set(process) then begin

files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')

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
sub_map, map, xr=[490,570], yr=[230,300], mp 

;make sav file
fnm = '/unsafe/jsr2/'+datstr+'/hmi_mp.sav'
save, mp, filename = fnm
endif

if keyword_set(sav) then begin
restore, savf
endif

;log smth or smth filter
if keyword_set(log) then mp.data = alog10(mp.data) - alog10(SMOOTH(mp.data,10)) else $
mp.data = mp.data - SMOOTH(mp.data,10)

sub = coreg_map(mp,mp[60])
;diff = diff_map(sub(1),sub(0),/rotate)
hmidiff = diff_map(sub(2),sub(0),/rotate)

for i=1, n_elements(mp) - 1 do begin
    ;;differencing
    diff1=diff_map(sub[i],sub[i-2],/rotate)

    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(hmidiff,diff1)    
endfor

savff =  '/unsafe/jsr2/'+datstr+'/hmi_diff.sav'
save, hmidiff, filename = savff
