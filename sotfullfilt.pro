pro sotfullfilt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Ca II H
;
;read in files and process
cfiles = findfile('/unsafe/jsr2/CaIIH/F*')
mreadfits, cfiles, cin, cda
;read_sot, cfiles, cind, cdat
;;;remove corrupt data
nc = n_elements(cfiles)
percent_zero = dblarr(nc)
for i = 0, nc -1 do percent_zero[i] = $
(n_elements(where(cda[*,*,i] eq 0))/(2048.0*1024)) * 100
ss_good = where(percent_zero lt 5, n_good)
cind = cin[ss_good]
cdat = reform(cda[*,*,ss_good])
;;;co-align all images
fg_rigidalign, cind, cdat, cindo, cdato, dx = 512, dy = 512, x0=10, y0=10
index2map, cindo, cdato, cmp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Red
;
rfiles = findfile('/unsafe/jsr2/red/F*')
mreadfits, rfiles, rin, rda
;read_sot, rfiles, rind, rdat
;;;remove corrupt data
nc = n_elements(rfiles)
percent_zero = dblarr(nc)
for i = 0, nc -1 do percent_zero[i] = $
(n_elements(where(rda[*,*,i] eq 0))/(2048.0*1024)) * 100
ss_good = where(percent_zero lt 5, n_good)
rind = rin[ss_good]
rdat = reform(rda[*,*,ss_good])
;;;co-align all images
fg_rigidalign, rind, rdat, rindo, rdato, dx = 512, dy = 512, x0=10, y0=10
index2map, rindo, rdato, rmp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Blue
;
bfiles = findfile('/unsafe/jsr2/blue/F*')
;read_sot, bfiles, bind, bdat
mreadfits, bfiles, bin, bda
;;;remove corrupt data
nc = n_elements(bfiles)
percent_zero = dblarr(nc)
for i = 0, nc -1 do percent_zero[i] = $
(n_elements(where(bda[*,*,i] eq 0))/(2048.0*1024)) * 100
ss_good = where(percent_zero lt 5, n_good)
bind = bin[ss_good]
bdat = reform(bda[*,*,ss_good])
;;;co-align all images
fg_rigidalign, bind, bdat, bindo, bdato, dx = 512, dy = 512, x0=10, y0=10
index2map, bindo, bdato, bmp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;Green
;
gfiles = findfile('/unsafe/jsr2/green/F*')
;read_sot, gfiles, gind, gdat
mreadfits, gfiles, gin, gda
;;;remove corrupt data
nc = n_elements(gfiles)
percent_zero = dblarr(nc)
for i = 0, nc -1 do percent_zero[i] = $
(n_elements(where(gda[*,*,i] eq 0))/(2048.0*1024)) * 100
ss_good = where(percent_zero lt 5, n_good)
gind = gin[ss_good]
gdat = reform(gda[*,*,ss_good])
;;;co-align all images
fg_rigidalign, gind, gdat, gindo, gdato, dx = 512, dy = 512, x0=10, y0=10
index2map, gindo, gdato, gmp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;subtract background
snp = (((2*500.)+1)*((2*500.)+1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Red
rbk = sumarea(rdato, 900., 900., 50.)
rbknpix = (((2*50.)+1)*((2*50.)+1))
rbk = rbk/rbknpix 
rbk = total(rbk)/n_elements(rbk)
tmp = rdato[*, *, *] - rbk
rdato = tmp
rdato[where(rdato lt 0., /null)] = 0.
tmp = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Green
gbk = sumarea(gdato, 900., 900., 50.)
gbknpix = (((2*50.)+1)*((2*50.)+1))
gbk = gbk/gbknpix
gbk = total(gbk)/n_elements(gbk)
tmp = gdato[*, *, *] - gbk
gdato = tmp
gdato[where(gdato lt 0., /null)] = 0.
tmp = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Blue
bbk = sumarea(bdato, 900., 900., 50.)
bbknpix = (((2*50.)+1)*((2*50.)+1))
bbk = bbk/bbknpix
bbk = total(bbk)/n_elements(bbk)
tmp = bdato[*, *, *] - bbk
bdato = tmp
bdato[where(bdato lt 0., /null)] = 0.
tmp = 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
