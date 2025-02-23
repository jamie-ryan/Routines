pro spectra_plots
;;;;;;;;;;;;;;SPECTRA PLOTS;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;pih, magdopp[27,*,*], min=-100, max=100, scale=[100, 1.0] 
;pih, magraw[0, 27,*,*], min=-100, max=100, scale=[100, 1.0] 
;pih, magcorr[0, 27,*,*], min=-100, max=100, scale=[100, 1.0] 

;oplot line across a y location
;pih,doppgr[27,*,*], scale=[100, 1.0] 
;oplot, [-50,800], [400,400], linestyle = 2
date = 'Feb12-2016'
restore, '/unsafe/jsr2/'+date+'/balm_data-'+date+'.sav'

ang = STRING("305B)
angstrom = '!3' +ang+ '!x'

!p.thick=4 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis

for t = 0, nfiles - 1 do begin
    tt = times[4,t]
    flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-'+tt+'-IRIS-SG-Balmer-Spectrum.eps'
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename= flnm, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    ;device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size

    loadct, 0
    titl = 'IRIS SG 2825.7 - 2825.8 '+angstrom+' Spectrum'
    xtitl = 'Raster Step'
    ytitl = 'Slit Pixel'
    pih,alldat[*,*, t], scale=[100, 1.0], titel = titl, xtitle = xtitl, ytitle = ytitl 
    nlines = n_elements(balmerdata[0,*,t])
    linecolors
    for i = 0, nlines - 1 do begin
        ;oplot, [-50,800], [balmerdata[1, i, 0],balmerdata[1, i, 29]], linestyle = i, color = 2*i
        oplot, [balmerdata[0, i, 0]*100,balmerdata[0, i, nfiles-1]*100], $
        [balmerdata[1, i, 0]-400, balmerdata[1, i, 29]-400], linestyle = 3, color = 10+i 
    endfor
endfor
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table

;zoom into spectrum roi (sampled coords)
for t = 0, nfiles - 1 do begin
    tt = times[4,t]
    flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-'+tt+'-IRIS-SG-Balmer-Spectrum.eps'
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename= flnm, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    ;device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size
    titl = 'IRIS SG 2825.7 - 2825.8 '+angstrom+' Spectrum'
    xtitl = 'Raster Step'
    ytitl = 'Slit Pixel'
    loadct, 0
    pih,alldat[*,400:500, t], scale=[100, 1.0], titel = titl, xtitle = xtitl, ytitle = ytitl
    nlines = n_elements(balmerdata[0,*,t])
    linecolors
    for i = 0, nlines - 1 do begin
        ;oplot, [-50,800], [balmerdata[1, i, 0],balmerdata[1, i, 29]], linestyle = i, color = 2*i
        oplot, [balmerdata[0, i, 0]*100,balmerdata[0, i, nfiles-1]*100], $
        [balmerdata[1, i, 0]-400, balmerdata[1, i, 29]-400], linestyle = 3, color = 10+i 
    endfor
endfor
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table



;;;;Doppler
for t = 0, nfiles - 1 do begin
    tt = times[4,t]
    flnm = '/unsafe/jsr2/'+date+'/29-Mar-14-'+tt+'-IRIS-SG-2796-Doppler.eps'
    !p.font=0			;use postscript fonts
    set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
    device, filename= flnm, encapsulated=eps, $
    /helvetica,/isolatin1, landscape=0, color=1
    ;device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
   ;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
    cs=1 	;charcter size
    titl = 'IRIS SG 2825.7 - 2825.8 '+angstrom+' Dopplergram'
    ytitl = ''
    xtitle = 'Raster Position'

    loadct, 3 ;need a red-grey-blue colour table
    pih,doppgr[t,*,*], scale=[100, 1.0] , titel = titl, xtitle = xtitl, ytitle = ytitl

endfor
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table

end
