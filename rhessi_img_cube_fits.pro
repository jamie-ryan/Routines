pro rhessi_img_cube_fits
dir1 = '/unsafe/jsr2/rhessi-spectra-May27-2016/energy-3-to-20/increments-1keV/timg-20sec/PIXON/'
;dir2 = '/unsafe/jsr2/rhessi-spectra-May27-2016/energy-20-to-60/increments-3keV/timg-20sec/PIXON/'
;dir3 = '/unsafe/jsr2/rhessi-spectra-May27-2016/energy-60-to-100/increments-5keV/timg-20sec/PIXON/'
outdir = '/unsafe/jsr2/rhessi-spectra-May27-2016/'
restore, dir1+'rhessidata.sav'
rdat1 = rhessidata
rhessidata = 0
;restore, dir2+'rhessidata.sav'
;rdat2 = rhessidata
;rhessidata = 0
;restore, dir3+'rhessidata.sav'
;rdat3 = rhessidata
;rhessidata = 0

;concantate arrays
;rdat = [rdat1, rdat2, rdat3]

;
nenergy1 = n_elements(rdat1[*,0,0,0])
;nenergy2 = n_elements(rdat2[*,0,0,0])
;nenergy3 = n_elements(rdat3[*,0,0,0])
;nenergy_total = nenergy1 + nenergy2 + nenergy3
;common constants
xpix = n_elements(rdat1[0,*,0,0])
ypix = n_elements(rdat1[0,0,*,0])
nt = n_elements(rdat1[0,0,0,*])

imgcube = fltarr(xpix, ypix, nenergy1, nt)

for i = 0, nt - 1 do begin
;    for j = 0, nenergy_total - 1 do begin
    for j = 0, nenergy1 - 1 do begin
        imgcube[*,*, j, i] = rdat1[j, *, *, i]
    endfor
;ii = string(i, format = '(I0)')
;jj = string(j, format = '(I0)')
;timet = strmid(time_intervals[1,i],12)
;datet = strmid(time_intervals[1,i],0,12)
;tt = datet+'-'+timet
;fil = outdir+'rhessi_3to100keV_spectra_imgcube_'+tt+'.fits'
;fil = outdir+'rhessi_3to100keV_spectra_imgcube_'+tt+'.fits'
;hdr = {}
;writefits, fil, imgcube
endfor 
fil = outdir+'rhessi_3to100keV_spectra_imgcube.fits'
;hdr = {}
writefits, fil, imgcube




end
