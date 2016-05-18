pro rhessi_map2spectra, $
energy_range =  energy_range, $
increment, $
outdir
;syntax: rhessi_map2spectra, energy_range =  [10.D, 100.D], 10., '/unsafe/jsr2/rhessi-spectra-May18-2016/energy-10-to-100/PIXON/'

nenergy = energy_range[1]/increment


;restore .sav files
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

;get balmer coords in arcsecs
dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor


;make arrays
spectra = fltarr(nenergy, n_elements(balmercoords[0,*]), n_elements(hmap0to10))
rhessipix = fltarr(2, n_elements(balmercoords[0,*]), n_elements(hmap0to10))

for t = 0, n_elements(hmap0to10) - 1 do begin
;convert coords from arcsec to rhessi pixel location
rhessipix[*,*,t] = convert_coord_rhessi(hmap0to10[t], balmercoords)
    for j = 0, n_elements(balmercoords[0,*]) - 1 do begin
        spectra[0, j, t] = hmap0to10[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[1, j, t] = hmap10to20[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[2, j, t] = hmap20to30[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[3, j, t] = hmap30to40[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[4, j, t] = hmap40to50[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[5, j, t] = hmap50to60[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[6, j, t] = hmap60to70[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[7, j, t] = hmap70to80[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[8, j, t] = hmap80to90[t].data[rhessipix[0, j, t], rhessipix[1, j, t]]  
        spectra[9, j, t] = hmap90to100[t].data[rhessipix[0, j, t], rhessipix[1, j, t]] 
    endfor
endfor        

fff = outdir+'spec-lightcurve-array.sav'
save, rhessipix, spectra, filename = fff
end
