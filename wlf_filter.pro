pro wlf_filter, savf = savf, log = log

;savf = string: sav file created by hmi_pre_process, or other like sot
savf = '/unsafe/jsr2/Sep21-2016/hmi_preprocess_data.sav'
restore, savf


nt = n_elements(sbhmimap)
;ri = alog10(rdato) - alog10(SMOOTH(rdato,10))
;bi = alog10(bdato) - alog10(SMOOTH(bdato,10))
;gi = alog10(gdato) - alog10(SMOOTH(gdato,10))


if keyword_set(log) then sbhmimap.data = alog10(sbhmimap.data) - alog10(SMOOTH(sbhmimap.data,10)) else $
sbhmimap.data = sbhmimap.data - SMOOTH(sbhmimap.data,10)

;
sub = coreg_map(sbhmimap,sbhmimap(40))
diff = diff_map(sub(1),sub(0),/rotate)


;;;iterate through each submap and perform differencing
for i=1, nt-1 do begin
    ;;differencing
    diff1=diff_map(sub(i),sub(i-2),/rotate)

    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(diff,diff1)    s
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
sub_map, hmimap, xr=[405,590], yr=[190,372], sbhmimap

;running difference (i-2) applied to unsharp filtered images
rsub = coreg_map(sbhmimap,sbhmimap(40))
hmidiff=diff_map(rsub(1),rsub(0),/rotate)


;;;iterate through each submap and perform differencing
nc = 0
nc = n_elements(sbhmimap)
for i=1, nc-1, 1 do begin
    ;;differencing
    rdiff1=diff_map(rsub(i),rsub(i-2),/rotate)

    ;;;concatenate arrays to form one difference array
    hmidiff=str_concat(hmidiff,rdiff1)
endfor


end
