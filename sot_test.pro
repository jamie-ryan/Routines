pro sot_test
restore, '/unsafe/jsr2/red/sotredfullfiltWL.sav'
restore, '/unsafe/jsr2/green/sotgreenfullfiltWL.sav'
restore, '/unsafe/jsr2/blue/sotbluefullfiltWL.sav'

;define sum area constants
;xc = 512.;central x pixel
;yc = 512.;central y pixel
;radius = 500.;radius of box (in pixels)..not including central pixel
;snp = number of pixels
;boxarr61[i] = total(sbhmimap[i].data[h61[0,*],h61[1,*]]) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Red
snp = n_elements(rind[0,*]) 
rfilt[where(rfilt lt 0., /null)] = 0.
nt = n_elements(rfilt[0,0,*])
tmp = fltarr(nt)
for j = 0, nt -1 do begin
    for i = 0, n_elements(rind[0,*]) - 1 do begin
        tmp[j] = tmp[j] + total(rfilt[rind[0,i], rind[1,i], j])
    endfor
endfor
sot_power, tmp, n_pixels = snp, red_p, red_e, /r

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Green
snp = n_elements(gind[0,*])
gfilt[where(gfilt lt 0., /null)] = 0.
nt = n_elements(gfilt[0,0,*])
tmp = fltarr(nt)
for j = 0, nt -1 do begin
    for i = 0, n_elements(gind[0,*]) - 1 do begin
        tmp[j] = tmp[j] + total(gfilt[gind[0,i], gind[1,i], j])
    endfor
endfor
sot_power, tmp, n_pixels = snp, grn_p, grn_e, /g;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Blue
snp = n_elements(bind[0,*])
bfilt[where(bfilt lt 0., /null)] = 0.
nt = n_elements(bfilt[0,0,*])
tmp = fltarr(nt)
for j = 0, nt -1 do begin
    for i = 0, n_elements(bind[0,*]) -1 do begin
        tmp[j] = tmp[j] + total(bfilt[bind[0,i], bind[1,i], j])
    endfor
endfor
sot_power, tmp, n_pixels = snp, blue_p, blue_e, /b


save,red_p, red_e ,grn_p, grn_e,blue_p, blue_e, filename = 'sot_energies.sav'
end
