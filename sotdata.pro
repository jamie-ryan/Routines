

;;;Use Hinode SOT data to sanity check HMI energy code.
;;;Based on the data analysis by Kerr & Fletcher 2014, they used:
;;;SOT Broadband Filter Imager (BFI), 3 continuum channels (RGB)

;;;vso search and download sot data.
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59', instr = 'sot', physical_observable=intensity)
dat = vso_get(srch, /rice, site = 'NSO')

;;;pg 24 of data analysis guide
set_logenv, 'SOT_DATA', '/unsafe/jsr2'
t0 = '15-Feb-2011T01:50:00'
t1 = '15-Feb-2011T01:59:00'
sot_cat, t0, t1, /level10, cat, files
modes = sot_umodes(cat, mcount=mc, info=info)
prstr, modes
;FG (simple)      Ca II H line     1024     1024
;FG (simple)     red cont 6684     1024     1024
;FG (simple)    blue cont 4504     1024     1024
;FG (simple)   green cont 5550     1024     1024
;FG (simple)  TF H I 6563 base      704      704

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;my technique

;;download SOT data sets (put in seperate directories; CaIIH; red; blue; green)
;ca II H
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='3969', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;red
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='6684', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;blue
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='4504', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')

;green
srch = vso_search('2011/02/15 01:50','2011/02/15 01:59',wave='5550', instr = 'sot')
dat = vso_get(srch, /rice, site = 'NSO')


;read in files and process
cfiles = findfile('/unsafe/jsr2/CaIIH/*')
read_sot, cfiles, cind, cdat

rfiles = findfile('/unsafe/jsr2/red/*')
read_sot, rfiles, rind, rdat


bfiles = findfile('/unsafe/jsr2/blue/*')
read_sot, bfiles, bind, bdat


gfiles = findfile('/unsafe/jsr2/green/*')
read_sot, gfiles, gind, gdat


;;;to check wavelength of data
print, cind[0].wave
print, rind[0].wave
print, bind[0].wave
print, gind[0].wave

;;;kerr & fletcher 2014 data processing
;log unsharp filter (ri) 
nx = n_elements(rdat[*,0,0])
ny = n_elements(rdat[0,*,0])
nt = n_elements(rdat[0,0,*])
ri = fltarr(nx, ny, nt)
bi = fltarr(nx, ny, nt)
gi = fltarr(nx, ny, nt)
ri = alog10(rdat) - alog10(SMOOTH(rdat,10))
bi = alog10(rdat) - alog10(SMOOTH(rdat,10))
gi = alog10(rdat) - alog10(SMOOTH(rdat,10))

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
nr = n_elements(rmap)
for i=1, nr-1, 1 do begin
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
mask = cdat gt 900
rfilt = riffdat*mask
bfilt = biffdat*mask
gfilt = giffdat*mask



