pro rhessi_produce_spectra, $
sigma_thresh_pix = sigma_thresh_pix, $
sumcoords = sumcoords, $
balmercoords = balmercoords

outdir = '/unsafe/jsr2/rhessi-spectra-May23-2016/energy-10-to-100/increments-10keV/timg-20sec/PIXON/'
restore, outdir+'rhessidata.sav'
restore, outdir+'hmap0to10.sav'  
spawn, 'mkdir '+outdir+'dat'
spawn, 'mkdir '+outdir+'plots'

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
timg = 20.
erng = energy_range[0] + findgen(energy_range[1]/increment)*10
sigma_thresh = 4.
sig = string(sigma_thresh, format = '(I0)')
nt = n_elements(rhessidata[0,0,0,*]) ; = n_elements(time_intervals[0,*])
timgst = string(timg, format = '(I0)')
xtit = 'Energy keV'
ytit = 'Log Counts collected over '+timgst+' sec interval. log(DN)'
sumpix = fltarr(nenergy)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;SIGMA THRESHOLD HXR PIXEL DETECTION;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(sigma_thresh_pix) then begin
    ;locate high intensity pixels that are common across each energy range
    for i = 0, nt -1 do begin
        for j = 0, nenergy - 1 do begin
            print, 'energy:', j, 'time:',i 
            ;array = reform(rhessidata[j,*,*,i])
            ii = string(i, format = '(I0)')
            jj = string(j, format = '(I0)')
            spawn, 'mkdir '+outdir+'dat/t'+ii
            outdat = outdir+'dat/t'+ii
            fil = outdat+'/rhessidata-e-'+jj+'-t-'+ii+'-'+sig+'sigma-pixel-locations.dat'

            ;returns pixel coordinates containing values
            ;above the standard deviation threshold set by the user
            pix = sigma_thresh(reform(rhessidata[j,*,*,i]), sigma_thresh, outfile = fil)
            pix = 0
        endfor
    endfor
;then use: rhessi-organise-and-pixel-sort.sh to collect common pixels across each energy increment
endif


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;PLOTTING;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
if keyword_set(balmercoords) then begin
    dataset = ['balmer']
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords.txt' ;eg, flnm=hmicoords.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        balmcoords = fltarr(2, nlin)
        readf, lun, balmcoords
        free_lun, lun
    endfor
    spectra = fltarr(n_elements(balmcoords[0,*]), nenergy, nt)
    for i = 0, nt - 1 do begin
        pix = convert_coord_rhessi(hmap0to10[i], balmcoords, /a2p)
        for k = 0, n_elements(pix[0,*]) - 1 do begin    
            for j = 0, nenergy - 1 do begin
                sumpix[j] = rhessidata[j, pix[0, k], pix[1, k], i]
            endfor
            ii = string(i, format = '(I0)')
            bc = string(k, format = '(I0)')
            hcx = string(balmcoords[0, k], format = '(F0.2)')
            hcy = string(balmcoords[1, k], format = '(F0.2)')
            tt = time_intervals[0,i]
            tit = 'RHESSI Image Spectrum '+tt+'
            plotst = 'Coords = '+hcx+',' +hcy+'
            flnm = outdir+'plots/rhessi-t'+ii+'-balmer-coord-'+bc+'-spectrum.eps'
            rhessi_spectra_plot, sumpix, erng, titl = tit, xtitl = xtit, ytitl = ytit, plotstr = plotst, outfile = flnm
            spectra[k,*,i] = sumpix
            outcp = outdir+'dat/t'+ii
            spawn, 'cp '+flnm+' '+outcp
        endfor
    endfor
    fsav = outdir+'plots/rhessi_balmer_coords_spectra.sav'
endif

if keyword_set(sumcoords) then begin
    spectra = fltarr(nenergy, nt)
    ;plot hxr spectra 
    for i = 0, nt - 1 do begin
    ii = string(i, format = '(I0)')

        ;read in file containing pixel locations for high intensity hxr activity.
        ;by visual inspection of hmap90to100 I know the 7th time step has activity
        flnm = outdir+'dat/t'+ii+'/out.dat'
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        pix = fltarr(2, nlin)
        readf, lun, pix
        free_lun, lun
        pixcoords = convert_coord_rhessi(hmap0to10[i], pix, /p2a)
        ;sum pixels shared across each energy increment at a fixed time.
        for j = 0, nenergy - 1 do begin 
            sumpix[j] = total(rhessidata[j, pix[0, *], pix[1, *], i])
        endfor
        hcx = string(avg(pixcoords[0, *]), format = '(F0.2)')
        hcy = string(avg(pixcoords[1, *]), format = '(F0.2)')
        tt = time_intervals[0,i]
        tit = 'RHESSI Image Spectrum '+tt+'
        plotst = 'Central Coords of Summed Region = '+hcx+',' +hcy+'
        flnm = outdir+'plots/rhessi-t'+ii+'-summed-common-coords-spectrum.eps'
        rhessi_spectra_plot, sumpix, erng, titl = tit, xtitl = xtit, ytitl = ytit, plotstr = plotst, outfile = flnm
        spectra[*, i] = sumpix
        outcp = outdir+'dat/t'+ii
        spawn, 'cp '+flnm+' '+outcp
    endfor
    fsav = outdir+'plots/rhessi_summed_common_coords_spectra.sav'
endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;SAVE FILE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
save, spectra, pix, $
nenergy, $
energy_range, $
increment, $
timg, $
erng, $
sigma_thresh, $
nt, $
xtit, $
ytit, $
filename = fsav

end
