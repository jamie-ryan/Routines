pro sotboxdiff
;;;read in files and store
rfiles = findfile('/unsafe/jsr2/red/FG*')
read_sot, rfiles, rind, rdat
bfiles = findfile('/unsafe/jsr2/blue/FG*')
read_sot, bfiles, bind, bdat
gfiles = findfile('/unsafe/jsr2/green/FG*')
read_sot, gfiles, gind, gdat

;;;image processing

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

;make .sav
save, rdiff, riffind, riffdat, filename = '/unsafe/jsr2/red/sotredboxdiff.sav'
save, bdiff, biffind, biffdat, filename = '/unsafe/jsr2/blue/sotblueboxdiff.sav'
save, gdiff, giffind, giffdat, filename = '/unsafe/jsr2/green/sotgreenboxdiff.sav' 

end
