pro sot_test
restore, '/unsafe/jsr2/red/sotredsmthdiff.sav'
restore, '/unsafe/jsr2/green/sotgreensmthdiff.sav'
restore, '/unsafe/jsr2/blue/sotbluesmthdiff.sav'



;define sum area constants
;xc = ;central x pixel
;yc = ;central y pixel
;radius = ;radius of box (in pixels)..not including central pixel
;snp = ((2*radius)+1)*((2*radius)+1) ;area of sum
snp = (((2*500.)+1)*((2*500.)+1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Red
rbk = sumarea(rdiff.data, 900., 900., 50.)
rbknpix = (((2*50.)+1)*((2*50.)+1))
rbk = rbk/rbknpix ;average bk per pixel
rbk = total(rbk)/n_elements(rbk)
;tmp1 = fltarr(n_elements(rdiff))
;tmp2 = fltarr(n_elements(rdiff))
;tmp3 = fltarr(n_elements(rdiff))
;tmp1 = sumarea(rdiff.data, xc, yc, radius)
;tmp2 = sumarea(rdiff.data, xc, yc, radius)
;tmp3 = sumarea(rdiff.data, xc, yc, radius)
;tmp = tmp1 + tmp2 + tmp3
tmpdat = rdiff[*].data - rbk
tmpdat[where(tmpdat lt 0., /null)] = 0.
tmp = fltarr(n_elements(rdiff))
tmp = sumarea(tmpdat, 512., 512., 500.)
sot_rad_cal, tmp, n_pixels = snp, red_f, red_e, rf_err, re_err, /r

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Green
gbk = sumarea(gdiff.data, 900., 900., 50.)
gbknpix = (((2*50.)+1)*((2*50.)+1))
gbk = gbk/gbknpix ;average bk per pixel
gbk = total(gbk)/n_elements(gbk)
;tmp1 = fltarr(n_elements(gdiff))
;tmp2 = fltarr(n_elements(gdiff))
;tmp3 = fltarr(n_elements(gdiff))
;tmp1 = sumarea(gdiff.data, xc, yc, radius)
;tmp2 = sumarea(gdiff.data, xc, yc, radius)
;tmp3 = sumarea(gdiff.data, xc, yc, radius)
;tmp = tmp1 + tmp2 + tmp3
tmpdat = gdiff[*].data - gbk
tmpdat[where(tmpdat lt 0., /null)] = 0.
tmp = fltarr(n_elements(gdiff))
tmp = sumarea(tmpdat, 512., 512., 500.)
sot_rad_cal, tmp, n_pixels = snp, grn_f, grn_e, gf_err, ge_err, /g;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Blue
bbk = sumarea(bdiff.data, 900., 900., 50.)
bbknpix = (((2*50.)+1)*((2*50.)+1))
bbk = bbk/bbknpix ;average bk per pixel
bbk = total(bbk)/n_elements(bbk)
;tmp1 = fltarr(n_elements(bdiff))
;tmp2 = fltarr(n_elements(bdiff))
;tmp3 = fltarr(n_elements(bdiff))
;tmp1 = sumarea(bdiff.data, xc, yc, radius)
;tmp2 = sumarea(bdiff.data, xc, yc, radius)
;tmp3 = sumarea(bdiff.data, xc, yc, radius)
;tmp = tmp1 + tmp2 + tmp3
tmpdat = bdiff[*].data - bbk
tmpdat[where(tmpdat lt 0., /null)] = 0.
tmp = fltarr(n_elements(bdiff))
tmp = sumarea(tmpdat, 512., 512., 500.)
sot_rad_cal, tmp, n_pixels = snp, blue_f, blue_e, bf_err, be_err, /b

save,red_f, red_e ,grn_f, grn_e,blue_f, blue_e, filename = 'sot_energies_hmi-method.sav'
end
