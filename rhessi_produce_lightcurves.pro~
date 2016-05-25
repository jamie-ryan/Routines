pro rhessi_produce_lightcurves

outdir = '/unsafe/jsr2/rhessi-spectra-May23-2016/energy-10-to-100/increments-10keV/timg-20sec/PIXON/'
restore, outdir+'rhessidata.sav'
restore, outdir+'hmap0to10.sav'  
spawn, 'mkdir '+outdir+'/plots/lightcurves'

;make spectra from rhessidata.sav, which contains
;time_intervals, $
;rhessidata, $ 
;energy_range, $
;increment, $
;timg, $
;algorithm, $

;set a bunch of parameters
nenergy = n_elements(rhessidata[*,0,0,0])
energy_range = [10.D, 100.D]
timg = 20.
nt = n_elements(rhessidata[0,0,0,*]) ; = n_elements(time_intervals[0,*])
timgst = string(timg, format = '(I0)')
t1 = time_intervals[0,0]
t2 = strmid(time_intervals[1,-1],12)
tt = t1+' to '+t2
tit = 'RHESSI 10 - 100 keV Lightcurve '+tt+'
ytit = 'Log Counts collected over '+timgst+' sec interval. log(DN)'

;read in balmercoords from file
dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    balmcoords = fltarr(2, nlin)
    readf, lun, balmcoords
    free_lun, lun
endfor

;lightcurve array
lightcurves = fltarr(n_elements(balmcoords[0,*]), nt)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

for k = 0, nlin - 1 do begin    
    for i = 0, nt - 1 do begin
        ;convert balmercoords into rhessi pixel locations
        pix = convert_coord_rhessi(hmap0to10[i], balmcoords, /a2p)
        ;fill lightcurve array with the summ of the entire hxr energy range
        lightcurves[k, i] = total(rhessidata[1:*, pix[0, k], pix[1, k], i])
    endfor
    ;plot lightcurve
    bc = string(k, format = '(I0)')
    hcx = string(balmcoords[0, k], format = '(F0.2)')
    hcy = string(balmcoords[1, k], format = '(F0.2)')
    plotst = 'Coords = '+hcx+',' +hcy+'
    flnm = outdir+'/plots/lightcurves/rhessi-balmer-coord-'+bc+'-lightcurve.eps'
    rhessi_lightcurve_plot, lightcurves[k,*], time_intervals[0,*], $
    titl = tit, ytitl = ytit, plotstr = plotst, outfile = flnm
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SAVE FILE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fsav = outdir+'plots/lightcurves/rhessi_balmer_coords_lightcurves.sav'
save, lightcurves, pix, $
nenergy, $
energy_range, $
increment, $
timg, $
nt, $
ytit, $
filename = fsav

end
