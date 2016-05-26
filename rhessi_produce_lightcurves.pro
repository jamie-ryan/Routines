pro rhessi_produce_lightcurves
;Input:
;energy_start = starting element in rhessidata[???, 0,0,0]
;energy_step = number of energy increments to be summed in creating the lightcurve, in units of array element.
;eg,set energy_step to 1 for single energies
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
increment = 10.
erng = energy_range[0] + findgen(energy_range[1]/increment)*10
erngst = strarr(n_elements(erng))
titerngst = strarr(n_elements(erng))
for i = 0, n_elements(erng) - 1 do begin
if (i eq 0) then e1 = '1' else e1 = string(erng[i-1],format='(I0)')
e2 = string(erng[i],format='(I0)')
erngst[i] = e1+'to'+e2
titerngst[i] = e1+' to '+e2
endfor
e1 = 0
e2 = 0
e1 = string(erng[0], format = '(I0)')
e2 = string(erng[-1], format = '(I0)')
allerng = e1+'to'+e2
titallest = e1+' to '+e2
timg = 20.
nt = n_elements(rhessidata[0,0,0,*]) ; = n_elements(time_intervals[0,*])
timgst = string(timg, format = '(I0)')
t1 = time_intervals[0,0]
t2 = strmid(time_intervals[1,-1],12)
tt = t1+' to '+t2

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
sumlightcurves = fltarr(n_elements(balmcoords[0,*]), nt)
lightcurves = fltarr(n_elements(rhessidata[*,0,0,0]), n_elements(balmcoords[0,*]), nt)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;energy loop starts at 1 to omit sxrs 1 to 10 kev
;for j = energy_start, nen - 1 do begin
for j = 0, n_elements(rhessidata[*,0,0,0]) - 1 do begin
    for k = 0, nlin - 1 do begin    
        for i = 0, nt - 1 do begin
            ;convert balmercoords into rhessi pixel locations
            pix = convert_coord_rhessi(hmap0to10[i], balmcoords, /a2p)
            ;fill lightcurve array with each energy bin
            lightcurves[j, k, i] = rhessidata[j, pix[0, k], pix[1, k], i]
            if (j eq 0) then begin
            ;fill lightcurve array with the summ of the entire hxr energy range
            sumlightcurves[k, i] = total(rhessidata[1:*, pix[0, k], pix[1, k], i])
            endif
        endfor
        ;plot lightcurve
        tit = 'RHESSI '+titerngst+' keV Lightcurve
        ytit = 'Summed '+titerngst+' keV Counts [DN]'
        bc = string(k, format = '(I0)')
        hcx = string(balmcoords[0, k], format = '(F0.2)')
        hcy = string(balmcoords[1, k], format = '(F0.2)')
        plotst = 'Coords = '+hcx+',' +hcy+'
        flnm = outdir+'/plots/lightcurves/rhessi-'+erngst[j]+'-balmer-coord-'+bc+'-lightcurve.eps'
        rhessi_lightcurve_plot, lightcurves[j, k,*], time_intervals[0,*], $
        titl = tit, ytitl = ytit, plotstr = plotst, outfile = flnm
        if (j eq 0) then begin
        tit = 'RHESSI '+titallest+' keV Lightcurve
        ytit = 'Summed '+titallest+' keV Counts [DN]'
        flnm = outdir+'/plots/lightcurves/rhessi-'+allerng+'-balmer-coord-'+bc+'-lightcurve.eps'
        rhessi_lightcurve_plot, sumlightcurves[ k,*], time_intervals[0,*], $
        titl = tit, ytitl = ytit, plotstr = plotst, outfile = flnm
        endif
    endfor
endfor
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SAVE FILE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
fsav = outdir+'plots/lightcurves/rhessi_balmer_coords_lightcurves.sav'
save, $
lightcurves, $
sumlightcurves, $
pix, $
nenergy, $
energy_range, $
timg, $
nt, $
ytit, $
filename = fsav

end
