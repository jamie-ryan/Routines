hmi_full_filt



;;;kerr & fletcher 2014 data processing
;log unsharp filter (ri) 
nx = n_elements(rdato[*,0,0])
ny = n_elements(rdato[0,*,0])
nt = n_elements(rdato[0,0,*])
ri = fltarr(nx, ny, nt)
bi = fltarr(nx, ny, nt)
gi = fltarr(nx, ny, nt)
;ri = alog10(rdato) - alog10(SMOOTH(rdato,10))
;bi = alog10(bdato) - alog10(SMOOTH(bdato,10))
;gi = alog10(gdato) - alog10(SMOOTH(gdato,10))
ri = rdato - SMOOTH(rdato,10)
bi = bdato - SMOOTH(bdato,10)
gi = gdato - SMOOTH(gdato,10)
index2map, rind, ri, rmap
index2map, bind, bi, bmap
index2map, gind, gi, gmap

;running difference (i-2) applied to unsharp filtered images
rsub = coreg_map(rmap,rmap(15))
rdiff=diff_map(rsub(1),rsub(0),/rotate)

bsub = coreg_map(bmap,bmap(15))
bdiff=diff_map(bsub(1),bsub(0),/rotate)

gsub = coreg_map(gmap,gmap(15))
gdiff=diff_map(gsub(1),gsub(0),/rotate)


;;;iterate through each submap and perform differencing
nc = 0
nc = n_elements(rmap)
for i=1, nc-1, 1 do begin
    ;;differencing
    rdiff1=diff_map(rsub(i),rsub(i-2),/rotate)
    bdiff1=diff_map(bsub(i),bsub(i-2),/rotate)
    gdiff1=diff_map(gsub(i),gsub(i-2),/rotate)

    ;;;concatenate arrays to form one difference array
    rdiff=str_concat(rdiff,rdiff1)
    bdiff=str_concat(bdiff,bdiff1)
    gdiff=str_concat(gdiff,gdiff1)
endfor

map2index,rdiff, riffind, riffdat
map2index,bdiff, biffind, biffdat
map2index,gdiff, giffind, giffdat 

;use Ca II H as a mask (use thresholding to create a binary array)
mask = cdato gt 900
rfilt = riffdat*mask
bfilt = biffdat*mask
gfilt = giffdat*mask

;make .sav
;save, mask, cindo, cdato, cmp, filename = '/unsafe/jsr2/CaIIH/sotcaii_mask.sav'
;save, rdiff, riffind, riffdat, filename = '/unsafe/jsr2/red/sotredsmthdiff.sav'
;save, bdiff, biffind, biffdat, filename = '/unsafe/jsr2/blue/sotbluesmthdiff.sav'
;save, gdiff, giffind, giffdat, filename = '/unsafe/jsr2/green/sotgreensmthdiff.sav'


;make .sav
save, rfilt, filename = '/unsafe/jsr2/red/sotredfullfilt.sav'
save, bfilt, filename = '/unsafe/jsr2/blue/sotbluefullfilt.sav'
save, gfilt, filename = '/unsafe/jsr2/green/sotgreenfullfilt.sav'

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;WL pixel detection from filtered data

;;mean
rfilt[where(rfilt lt 0., /null)] = 0.
gfilt[where(gfilt lt 0., /null)] = 0.
bfilt[where(bfilt lt 0., /null)] = 0.
rav = total(rfilt)/(nx*ny)
gav = total(gfilt)/(nx*ny)
bav = total(bfilt)/(nx*ny)

;;standard deviation (sigma)
rsd = stddev(rfilt)
gsd = stddev(gfilt)
bsd = stddev(bfilt)


;;detection threshold (2*sigma)
rwl = where(rfilt gt 2*rsd, rd)
gwl = where(gfilt gt 2*gsd, gd)
bwl = where(bfilt gt 2*bsd, bd)
rind = array_indices(rfilt, rwl)
gind = array_indices(gfilt, gwl)
bind = array_indices(bfilt, bwl)

;make .sav
save, rfilt, rav, rsd, rind, rwl, filename = '/unsafe/jsr2/red/sotredfullfiltWL.sav'
save, bfilt, bav, bsd, bind, gwl, filename = '/unsafe/jsr2/blue/sotbluefullfiltWL.sav'
save, gfilt, gav, gsd, gind, bwl, filename = '/unsafe/jsr2/green/sotgreenfullfiltWL.sav'
end
