outdir = '/unsafe/jsr2/rhessi-spectra-May23-2016/energy-10-to-100/increments-10keV/timg-20sec/PIXON/'
restore, outdir+'rhessidata.sav'



;make spectra from rhessidata.sav, which contains
;time_intervals, $
;rhessidata, $ 
;energy_range, $
;increment, $
;timg, $
;algorithm, $

nenergy = n_elements(rhessidata[*,0,0,0])
energy_range = [10.D, 100.D]
increment = 10.
erng = energy_range[0] + findgen(energy_range[1]/increment)*10
sigma_thresh = 4.
sig = string(sigma_thresh, format = '(I0)')
nt = n_elements(rhessidata[0,0,0,*]) ; = n_elements(time_intervals[0,*])

;locate high intensity pixels that are common across each energy range
for i = 0, nt -1 do begin
    for j = 0, nenergy - 1 do begin
        print, 'energy:', j, 'time:',i 
        ;array = reform(rhessidata[j,*,*,i])
        ii = string(i, format = '(I0)')
        jj = string(j, format = '(I0)')
        ;returns pixel coordinates containing values
        ;above the standard deviation threshold set by the user
        fil = outdir+'dat/rhessidata-e-'+jj+'-t-'+ii+'-'+sig+'sigma-pixel-locations.dat'
        pix = sigma_thresh(reform(rhessidata[j,*,*,i]), sigma_thresh, outfile = fil)
        pix = 0
    endfor
endfor

;then use: rhessi-organise-and-pixel-sort.sh 

;by visual inspection of hmap90to100 I know the 7th time step has activity
flnm = outdir+'dat/t7/out.dat'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
pix = fltarr(2, nlin)
readf, lun, pix
free_lun, lun



;plot hxr spectra 
for i = 0, nlin - 1 do begin
    plot, erng, alog10(rhessidata[*, pix[0, i], pix[1, i], 7])
endfor


for j = 0, nenergy - 1 do begin
    for i = 0, nlin - 1 do begin
        ;lightcurves using rhessidata
        utplot, time_intervals[0,*], rhessidata[j, pix[0, i], pix[1, i], *]
    endfor
endfor






;;lightcurves using maps
restore, outdir+'hmap0to10.sav'  
restore, outdir+'hmap10to20.sav'
restore, outdir+'hmap20to30.sav'
restore, outdir+'hmap30to40.sav'
restore, outdir+'hmap40to50.sav'
restore, outdir+'hmap50to60.sav'
restore, outdir+'hmap60to70.sav'
restore, outdir+'hmap70to80.sav'
restore, outdir+'hmap80to90.sav'
restore, outdir+'hmap90to100.sav'

;manually looked for higest intensity pixel in the 90 to 100 keV maps
cursor, x, y & print, x, y
;       521.49398       259.59312
x = 521.49398
y = 259.59312
coords = [x,y]
pix = convert_coord_rhessi(hmap90to100[7], coords) 
;plot lightcurve
utplot, hmap90to100.time, hmap90to100.data[pix[0], pix[1]]

