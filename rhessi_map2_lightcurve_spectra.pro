outdir = '/unsafe/jsr2/rhessi-spectra-May23-2016/energy-10-to-100/increments-10keV/timg-20sec/PIXON/'
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
restore, outdir+'rhessidata.sav'




;manually looked for higest intensity pixel in the 90 to 100 keV maps
cursor, x, y & print, x, y
;       521.49398       259.59312
x = 521.49398
y = 259.59312
coords = [x,y]
pix = convert_coord_rhessi(hmap90to100[7], coords) 
;plot lightcurve
utplot, hmap90to100.time, hmap90to100.data[pix[0], pix[1]]


;make spectra from rhessidata.sav, which contains
;time_intervals, $
;rhessidata, $ 
;energy_range, $
;increment, $
;timg, $
;algorithm, $


nenergy = n_elements(rhessidata[*,0,0,0])
erng = energy_range[0] + findgen(energy_range[1]/increment)*10
sigma_thresh = 10.
sig = string(sigma_thresh, format = '(I0)')
;nt = n_elements(rhessidata[0,0,0,*]) ; = n_elements(time_intervals[0,*])

;locate high intensity pixels that are common across each energy range
for i = 0, nt -1 do begin
for j = 0, nenergy - 1 do begin
array = reform(rhessidata[j,*,*,i]
ii = string(i, format = '(I0)')
jj = string(j, format = '(I0)')
;returns pixel coordinates containing values
;above the standard deviation threshold set by the user
fil = outdir+'rhessidata['+jj+'-x-y-'+ii+']-'+sig+'sigma-pixel-locations.dat'
pix = sigma_thresh(array, sigma_thresh, \ptf, outfile = fil)
endfor
endfor

;then use: sort rhessidata[*-x-y-constant]....dat | uniq -d >> tmp.dat in bash or csh to cross check files


;plot hxr spectra through time
plot, erng, rhessidata[*, pix[0], pix[1], i]




