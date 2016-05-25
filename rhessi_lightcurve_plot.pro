pro rhessi_lightcurve_plot, $
countsarray, $
timearray, $
titl = titl, $
ytitl = ytitl, $
plotstr = plotstr, $
outfile = outfile


;Plot spectra from summed pixel array
!p.thick=2 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis

!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= outfile, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
cs=1 	;charcter size

linecolors
utplot, timearray, countsarray, $ 
;base, $
;timerange = '29-Mar-14 '+['17:30:00','17:53:00'], $
;        psym = -2, $ 
linestyle = 0, $
ycharsize = 0.70, $
xcharsize = 0.75, $
xstyle = 8, $
title = titl, $
xtitle = xtitl, $
ytitle = ytitl, $
;/nolabel, $
;ytickname=[' '], $
;yticks = 2, $
;XTICKFORMAT="(A1)", $
;/ynozero, $
;/ylog, $
xmargin = [12,3]
xyouts, 0.2, 0.9, charsize = 1.5, plotstr, /norm
device,/close
set_plot,'x'
!p.font=-1 			;go back to default (Vector Hershey fonts)
loadct,0 			;go back to default greyscale color table

end
