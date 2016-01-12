pro sot_test
restore, '/unsafe/jsr2/red/sotredfullfiltWL.sav'
restore, '/unsafe/jsr2/green/sotgreenfullfiltWL.sav'
restore, '/unsafe/jsr2/blue/sotbluefullfiltWL.sav'

;define sum area constants
;xc = 512.;central x pixel
;yc = 512.;central y pixel
;radius = 500.;radius of box (in pixels)..not including central pixel
;snp = number of pixels

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Red
snp = n_elements(rind[0,*]) 
rfilt[where(rfilt lt 0., /null)] = 0.
nt = n_elements(rfilt[0,0,*])
tmp = fltarr(nt)
for i = 0, nt -1 do begin
;boxarr61[i] = total(sbhmimap[i].data[h61[0,*],h61[1,*]]) 
    tmp[i] = total(rfilt[rind[0,*], rind[1,*], i])
endfor
sot_power, tmp, n_pixels = snp, red_p, red_e, /r

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Green
snp = n_elements(gind[0,*])
gfilt[where(gfilt lt 0., /null)] = 0.
nt = n_elements(gfilt[0,0,*])
tmp = fltarr(nt)
for i = 0, nt -1 do begin
    tmp[i] =total(gfilt[gind[0,*], gind[1,*], i])
endfor
sot_power, tmp, n_pixels = snp, grn_p, grn_e, /g;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Blue
snp = n_elements(bind[0,*])
bfilt[where(bfilt lt 0., /null)] = 0.
nt = n_elements(bfilt[0,0,*])
tmp = fltarr(nt)
for i = 0, nt -1 do begin
    tmp[i] = total(bfilt[bind[0,*], bind[1,*], i])
endfor
sot_power, tmp, n_pixels = snp, blue_p, blue_e, /b


save,red_p, red_e ,grn_p, grn_e,blue_p, blue_e, filename = 'sot_energies.sav'
end
