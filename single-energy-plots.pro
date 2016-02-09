dir = '/unsafe/jsr2/'+date+'/'
restore, dir+'29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+date+'.sav'

npix = 8
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
flux = '[erg s!E-1!N cm!E-2!N '+angstrom+'!E-1!N sr!E-1!N]'
energy = '[erg]'



!p.font=0			;use postscript fonts
set_plot, 'ps'
;@symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename='template'+ext, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
device, xsize=8.89, ysize=8.89		;SQUARE one panel, one column figure 
;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
cs=1 	;charcter size



utplot, tsi[*], sidata[3, slitp, *], /nodata, $ 
base, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
outplot, tsi[*], sidata[3, slitp, *]
xyouts, xyx, xyy, charsize = 0.5, 'IRIS SJ 1400 '+angstrom+' Coord: 4', /norm

device,/close
set_plot,'x'
!p.font=-1 


utplot, tmg[612:*], mgdata[3, slitp, 612:*], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
outplot, tmg[612:*], mgdata[3, slitp, 612:*]
xyouts, xyx, xyy, charsize = 0.5, 'IRIS SJ 2796 '+angstrom+' Coord: 4', /norm


utplot, times[slitp, *], balmerdata[3, slitp, *], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
outplot, times[slitp, *], balmerdata[3, slitp, *]


utplot, tmgw[*], mgwdata[3, slitp, *], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
outplot, tmgw[*], mgwdata[3, slitp, *]


utplot, thmi[*], hmidata[3, slitp, *], $
/nodata, $
timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
outplot, thmi[*], hmidata[3, slitp, *]













for i = 0, 7 do begin
!p.font=0			;use postscript fonts
set_plot, 'ps'
;@symbols_ps_kc		;load string symbols and greek letters for Postscript
ii = string(i+1, format= '(I0)')
device, filename='impulsive-phase-all-data-oplot-area-'+ii+'.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
device, xsize=10.89, ysize=8.89		;SQUARE one panel, one column figure 
;device, xsize=18.6267, ysize=8.89		;RECTANGLE two column figure
cs=1 	;charcter size

slitp = i
linecolors
title = 'Impulsive Phase Comparison'
ytitle = 'Normalised Energy'
;dark red dots
plot1 = utplot, tsi, sidata[3,slitp, *]/max(sidata[3,slitp, *]), timerange = '29-Mar-14 '+['17:44:00','17:48:00'], color = 2, linestyle = 0 

;dark pink dashes
outplot, tmg, mgdata[3,slitp, *]/max(mgdata[3,slitp, *]), color = 3, linestyle = 2 

;orange dashes and dots
outplot, times[slitp,*], balmerdata[3,slitp, *]/max(balmerdata[3,slitp, *]), color = 4 , linestyle = 3 

;yellow dashes and 3 dots
outplot, tmgw, mgwdata[3,slitp, *]/max(mgwdata[3,slitp, *]), color = 5, linestyle = 4 

;green long dashes
outplot, thmi, hmidata[3,slitp, *]/max(hmidata[3,slitp, *]), color = 7, linestyle = 5 
device,/close
set_plot,'x'
!p.font=-1 
endfor




















